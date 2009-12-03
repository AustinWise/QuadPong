----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    08:49:22 10/30/2008 
-- Design Name: 
-- Module Name:    vgaTest - Behavioral 
-- Project Name: 
-- Target Devices: 
-- Tool versions: 
-- Description: 
--
-- Dependencies: 
--
-- Revision: 
-- Revision 0.01 - File Created
-- Additional Comments: 
--
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

---- Uncomment the following library declaration if instantiating
---- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity vgaTest is
  port(clock         : in std_logic;
       R, G				: out std_logic_vector(2 downto 0);
		 B 				: out std_logic_vector(1 downto 0);
		 H, V 			: out std_logic;
		 LD0 				: out std_logic);
end vgaTest;

architecture Behavioral of vgaTest is

 component vgadrive is
  port( clock            : in std_logic;  -- 25.175 Mhz clock
        red, green, blue : in std_logic;  -- input values for RGB signals
        row, column : out std_logic_vector(9 downto 0); -- for current pixel
        Rout, Gout			: out std_logic_vector(2 downto 0);
		  Bout					: out std_logic_vector(1 downto 0);
		  H, V : out std_logic); -- VGA drive signals
end component;		  
  
  signal row, column : std_logic_vector(9 downto 0);
  signal red, green, blue : std_logic;
  signal clk2 : std_logic;
  signal tmp_clkf : std_logic := '0';  

begin

   my_div_fast: process (clock,tmp_clkf)              
      variable div_cnt : integer := 0;   
   begin
      if (rising_edge(clock)) then   
         if (div_cnt = 0) then 
            tmp_clkf <= not tmp_clkf; 
            div_cnt := 0; 
         else
            div_cnt := div_cnt + 1; 
         end if; 
      end if; 
      clk2 <= tmp_clkf; 
   end process my_div_fast;	

LD0 <= clk2;
  -- for debugging: to view the bit order
  VGA : component vgadrive
    port map ( clock => clk2, 
	 red => red, green => green, blue => blue,  -- inputs
    row => row, column => column,  -- input coordinates
    Rout => R, Gout => G, Bout => B, H => H, V => V -- outputs
	 );
 
  -- red square from 0,0 to 360, 350
  -- green square from 0,250 to 360, 640
  -- blue square from 120,150 to 480,500
  RGB : process(row, column)
  begin
   
    if  row < 360 and column < 350  then
      red <= '1';
    else
      red <= '0';
    end if;
    
    if  row < 360 and column > 250 and column < 640  then
      green <= '1';
    else
      green <= '0';
    end if;
    
    if  row > 120 and row < 480 and column > 150 and column < 500  then
      blue <= '1';
    else
      blue <= '0';
    end if;

  end process;


end Behavioral;

