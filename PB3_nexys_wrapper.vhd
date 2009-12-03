----------------------------------------------------------------
-- PB3_nexys_wrapper.vhd - Provides an interface of the 
--            PicoBlaze3 processor to the Digilent Nexys board. 
--            The Nexys board contains a Spartan3 FPGA. 
--
-- Copyright 2007 bryan mealy 
----------------------------------------------------------------
-- Nexys I/O: The Nexys I/O devices are listed below with 
--            their assigned hardware mappings
--
--            device           mode        port
--	         ----------------------------------------------
--	        	  LEDs :           output      0x0C
--		        disp enables     output      0x04
--		        disp segments    output      0x08
--		
--		        buttons          input       0x20
--		        swithces         input       0x24
--
--	 Other things to note: 
--
--  Interrupt: the interrupt is connected to button 3 on the
--             Nexys board. This means that there are only 
--             three usable buttons for other designs: btn(2:0)
--
--  Reset: the reset pin has been permanently disabled
--  Interrupt_ACK: this pin is not connected
--
-------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity PB3_Nexys_wrapper is
	port(                  clk : in std_logic;
	                     reset : in std_logic;
	                 interrupt : in std_logic;
	                   buttons : in std_logic_vector(2 downto 0);
	                  switches : in std_logic_vector(7 downto 0);
	                      leds : out std_logic_vector(7 downto 0);
	              sseg_display : out std_logic_vector(7 downto 0);
	           sseg_display_en : out std_logic_vector(3 downto 0);
				  Rout	: out std_logic_vector(2 downto 0);
				  Gout	: out std_logic_vector(2 downto 0);
				  Bout	: out std_logic_vector(1 downto 0);
				  HS		: out std_logic;
				  VS		: out std_logic;
				  
					ps2d, ps2c: inout  std_logic
				  	  );
end PB3_Nexys_wrapper;

architecture PB3_Nexys_wrapper of PB3_Nexys_wrapper is

	-- Declare the PicoBlaze processor macro:
	component embedded_kcpsm3
		port(        port_id : out std_logic_vector(7 downto 0);
		        write_strobe : out std_logic;
		         read_strobe : out std_logic;
		            out_port : out std_logic_vector(7 downto 0);
		             in_port : in std_logic_vector(7 downto 0);
		           interrupt : in std_logic;
	          interrupt_ack : out std_logic;
		               reset : in std_logic;
		                 clk : in std_logic);
	end component;
	

	-- Declare in the interrupt state machine:
	component one_shot
		port(     clk : in std_logic;
		      trigger : in std_logic;
		        pulse : out std_logic);
	end component;

	-- Declare VGA driver:
	component VGAdrive is
	
	  port( clock            	: in std_logic;  -- 25.175 Mhz clock
			  red, green         : in std_logic_vector(2 downto 0);
			  blue 					: in std_logic_vector(1 downto 0);
			  row, column 			: out std_logic_vector(9 downto 0); -- for current pixel
			  Rout, Gout			: out std_logic_vector(2 downto 0);
			  Bout					: out std_logic_vector(1 downto 0);
			  H, V : out std_logic); -- VGA drive signals
	end component;

	component ram2k_8 is
	  port(clk:           in  STD_LOGIC;
			 we:            in  STD_LOGIC;
			 ra, wa:        in  STD_LOGIC_VECTOR(10 downto 0);
			 wd:            in  STD_LOGIC_VECTOR(7 downto 0);
			 rd:            out STD_LOGIC_VECTOR(7 downto 0));
	end component;	

	component reg8b is
		port ( LD,CLK : in std_logic;
		D_IN : in std_logic_vector (7 downto 0);
		D_OUT : out std_logic_vector (7 downto 0));
	end component;
	
	component db_fsm is
		port(
			clk, reset: in std_logic;
			sw: in std_logic;
			db: out std_logic
		);
	end component;
	
	component ps2_rxtx is
		port (
			clk, reset: in std_logic;
			wr_ps2: std_logic;
			din: in std_logic_vector(7 downto 0);
			dout: out std_logic_vector(7 downto 0);
			rx_done_tick: out  std_logic;
			tx_done_tick: out std_logic;
			ps2d, ps2c: inout std_logic
		);
	end component;
	
	-- Internal signals for PicoBlaze connections:
	signal red, green       : std_logic_vector(2 downto 0);
	signal blue             : std_logic_vector(1 downto 0);
	signal port_id          : std_logic_vector(7 downto 0);
	signal write_strobe     : std_logic;
	signal read_strobe      : std_logic;
	signal out_port         : std_logic_vector(7 downto 0);
	signal in_port          : std_logic_vector(7 downto 0);
	signal interrupt_pulse  : std_logic;
   signal interrupt_db     : std_logic;
	signal tmp_clkf, clk2	: std_logic;
   signal we_fb            : std_logic;
	signal ld_low, ld_high  : std_logic;
   signal wd, rd, t_addr   : std_logic_vector(7 downto 0);
   signal ra, wa, wa_t     : std_logic_vector(10 downto 0);	
   signal row, column      : std_logic_vector(9 downto 0);	
	signal t_addr2          : std_logic_vector(7 downto 0);
	
	--keybaord signals
   signal key_data: std_logic_vector(7 downto 0);
begin

	-- Connect the PicoBlaze to our internal signals:
 	processor: embedded_kcpsm3
	port map(       port_id => port_id,
	           write_strobe => write_strobe,
	            read_strobe => read_strobe,
	               out_port => out_port,
	                in_port => in_port,
	              interrupt => interrupt_pulse,
				 interrupt_ack => open,
	                  reset => '0',
	                    clk => clk);

	-- Connect the one_shot state machine to our interrupt input:
	interrupt_filter: one_shot
	port map(     clk => clk,
	          trigger => interrupt_db,
	            pulse => interrupt_pulse);


--	debouncer:  db_fsm 
--	port map (
--			clk => clk, 
--			reset => '0',
--			sw => interrupt,
--			db => interrupt_db
--		);
		
	--keyboard
   ps2_rxtx_unit: ps2_rxtx
      port map(clk=>clk, reset=>'0', wr_ps2=>'0',
               din=>"00000000", dout=>key_data, ps2d=>ps2d, ps2c=>ps2c,
               rx_done_tick=>interrupt_db, tx_done_tick=>open);
	
	-- Handle input requests:
	process(read_strobe)
	begin
		if (read_strobe = '1') then 
			if (port_id = X"20") then 
				in_port <= ("00000" & buttons);
			elsif (port_id = X"24") then
				in_port <= switches;
			elsif (port_id = X"28") then
				in_port <= key_data;
			end if; 
 	   else
		   in_port <= X"00";
		end if;
	end process;

	-- Handle output requests: -------------------------------
	process(write_strobe)
	begin
		if (rising_edge(write_strobe)) then 
			if (port_id = X"0C") then 
				leds <= out_port; 
			elsif (port_id = X"08") then 
				sseg_display <= out_port; 
			elsif (port_id = X"04") then 
				sseg_display_en <= out_port(3 downto 0); 
			elsif (port_id = X"0A") then 
				 wa_t(7 downto 0) <= out_port;
				 ld_low <= '1';
				we_fb <= '0';								 				 
			elsif (port_id = X"0B") then 
				 t_addr <= "00000" & out_port(2 downto 0);
				 ld_high <= '1';
				we_fb <= '0';								 
			elsif (port_id = X"0D") then 
				wd <= out_port;
				we_fb <= '1';				
			end if; 
		end if;
	end process;

  -- divide clock for VGA driver
   my_div_fast: process (clk,tmp_clkf)              
      variable div_cnt : integer := 0;   
   begin
      if (rising_edge(clk)) then   
         if (div_cnt = 0) then 
            tmp_clkf <= not tmp_clkf; 
            div_cnt := 0; 
         else
            div_cnt := div_cnt + 1; 
         end if; 
      end if; 
      clk2 <= tmp_clkf; 
   end process my_div_fast;
	
	-- connect VGA driver to internal signals

 -- frame buffer
 fb1: ram2k_8 port map (
		clk => clk,
		we => we_fb,
		ra => ra, 
		wa => wa,
		rd => rd,
		wd => wd);

	vga_out : VGAdrive port map (
		clock => clk2,
		red => red,
		green => green,
		blue => blue,
		row => row,
		column => column,
		Rout => Rout,
		Gout => Gout,
		Bout => Bout,
		H => HS,
		V => VS		);

 -- read from fb
   ra <= row (8 downto 4) & column(9 downto 4); 
   red <= rd(7 downto 5);		
   green <= rd(4 downto 2);
   blue <= rd(1 downto 0);		

lower_add : reg8b	port map (clk => clk, LD => ld_low, 
									D_IN => wa_t(7 downto 0), 
									D_OUT => wa(7 downto 0));

high_add : reg8b	port map (clk => clk, LD => ld_high, 
									D_IN => t_addr, 
									D_OUT => t_addr2);
wa(10 downto 8) <= t_addr2(2 downto 0);									
	
	
end PB3_Nexys_wrapper;

