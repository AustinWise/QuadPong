-- Ken Chapman (Xilinx Ltd) October 2002

-- This is the VHDL template file for the KCPSM assembler.

-- Adapted for pBlazIDE by Henk van Kampen, www.mediatronix.com, March 2003

-- It is used to configure a Virtex(E, II) and Spartan-II(E, 3) block RAM to act as 
-- a single port program ROM.

-- This VHDL file is not valid as input directly into a synthesis or simulation tool.
-- The assembler will read this template and insert the data required to complete the 
-- definition of program ROM and write it out to a new '.vhd' file as specified by the
-- '.psm' file being assembled.

-- The assembler identifies all text enclosed by {} characters, and replaces these
-- character strings. All templates should include these {} character strings for 
-- the assembler to work correctly. 

-- The next line is used to determine where the template actually starts and must exist.

{begin template}
library IEEE ;
use IEEE.STD_LOGIC_1164.all ;

package	constants is
	type TPicoType is ( pbtI, pbtII, pbt3, pbtS ) ;
	constant PicoType : TPicoType := {pico} ;
	function ADDRSIZE return natural ;
	function INSTSIZE return natural ;
	function JADDRSIZE return natural ;
	function JDATASIZE return natural ;
end package ;

package body constants is
	function ADDRSIZE return natural is
	begin
		case PicoType is
		when pbtI => return 8 ;
		when pbtII => return 10 ;
		when pbt3 => return 10 ;
		when pbtS => return 10 ;
		end case ;
	end ;
	function INSTSIZE return natural is 
	begin
		case PicoType is
		when pbtI => return 16 ;
		when pbtII => return 18 ;
		when pbt3 => return 18 ;
		when pbtS => return 18 ;
		end case ;
	end ;
	function JADDRSIZE return natural is
	begin
		case PicoType is
		when pbtI => return 9 ;
		when pbtII => return 11 ;
		when pbt3 => return 11 ;
		when pbtS => return 10 ;
		end case ;
	end ;
	function JDATASIZE return natural is
	begin
		case PicoType is
		when pbtI => return 8 ;
		when pbtII => return 9 ;
		when pbt3 => return 9 ;
		when pbtS => return 20 ;
		end case ;
	end ;
end package body ;


library IEEE ;
use IEEE.STD_LOGIC_1164.all ;
use IEEE.STD_LOGIC_ARITH.all ;
use IEEE.STD_LOGIC_UNSIGNED.all ;

library unisim ;
use unisim.vcomponents.all ;

use constants.all;

entity {name} is
    port ( 
        clk : in std_logic ;
        reset : out std_logic ;
        address : in std_logic_vector( ADDRSIZE - 1 downto 0 ) ;
        instruction : out std_logic_vector( INSTSIZE - 1 downto 0 )
    ) ;
end entity {name} ;

architecture mix of {name} is
    component jtag_shifter is
        port ( 
			clk : in std_logic ;
			user1 : out std_logic ;
            write : out std_logic ;
            addr : out std_logic_vector( JADDRSIZE - 1 downto 0 ) ;
            data : out std_logic_vector( JDATASIZE - 1 downto 0 )
        ) ;
    end component ;

    signal jaddr : std_logic_vector( JADDRSIZE - 1 downto 0 ) ;
    signal jdata : std_logic_vector( JDATASIZE - 1 downto 0 ) ;
    signal juser1 : std_logic ;
    signal jwrite : std_logic ;

    attribute INIT_00 : string ;
    attribute INIT_01 : string ;
    attribute INIT_02 : string ;
    attribute INIT_03 : string ;
    attribute INIT_04 : string ;
    attribute INIT_05 : string ;
    attribute INIT_06 : string ;
    attribute INIT_07 : string ;
    attribute INIT_08 : string ;
    attribute INIT_09 : string ;
    attribute INIT_0A : string ;
    attribute INIT_0B : string ;
    attribute INIT_0C : string ;
    attribute INIT_0D : string ;
    attribute INIT_0E : string ;
    attribute INIT_0F : string ;
    attribute INIT_10 : string ;
    attribute INIT_11 : string ;
    attribute INIT_12 : string ;
    attribute INIT_13 : string ;
    attribute INIT_14 : string ;
    attribute INIT_15 : string ;
    attribute INIT_16 : string ;
    attribute INIT_17 : string ;
    attribute INIT_18 : string ;
    attribute INIT_19 : string ;
    attribute INIT_1A : string ;
    attribute INIT_1B : string ;
    attribute INIT_1C : string ;
    attribute INIT_1D : string ;
    attribute INIT_1E : string ;
    attribute INIT_1F : string ;
    attribute INIT_20 : string ;
    attribute INIT_21 : string ;
    attribute INIT_22 : string ;
    attribute INIT_23 : string ;
    attribute INIT_24 : string ;
    attribute INIT_25 : string ;
    attribute INIT_26 : string ;
    attribute INIT_27 : string ;
    attribute INIT_28 : string ;
    attribute INIT_29 : string ;
    attribute INIT_2A : string ;
    attribute INIT_2B : string ;
    attribute INIT_2C : string ;
    attribute INIT_2D : string ;
    attribute INIT_2E : string ;
    attribute INIT_2F : string ;
    attribute INIT_30 : string ;
    attribute INIT_31 : string ;
    attribute INIT_32 : string ;
    attribute INIT_33 : string ;
    attribute INIT_34 : string ;
    attribute INIT_35 : string ;
    attribute INIT_36 : string ;
    attribute INIT_37 : string ;
    attribute INIT_38 : string ;
    attribute INIT_39 : string ;
    attribute INIT_3A : string ;
    attribute INIT_3B : string ;
    attribute INIT_3C : string ;
    attribute INIT_3D : string ;
    attribute INIT_3E : string ;
    attribute INIT_3F : string ;
    attribute INITP_00 : string ;
    attribute INITP_01 : string ;
    attribute INITP_02 : string ;
    attribute INITP_03 : string ;
    attribute INITP_04 : string ;
    attribute INITP_05 : string ;
    attribute INITP_06 : string ;
    attribute INITP_07 : string ;
begin
	I18 : if (PicoType = pbtII) or (PicoType = pbt3) generate
	    attribute INIT_00 of bram : label is "{INIT_00}" ;
	    attribute INIT_01 of bram : label is "{INIT_01}" ;
	    attribute INIT_02 of bram : label is "{INIT_02}" ;
	    attribute INIT_03 of bram : label is "{INIT_03}" ;
	    attribute INIT_04 of bram : label is "{INIT_04}" ;
	    attribute INIT_05 of bram : label is "{INIT_05}" ;
	    attribute INIT_06 of bram : label is "{INIT_06}" ;
	    attribute INIT_07 of bram : label is "{INIT_07}" ;
	    attribute INIT_08 of bram : label is "{INIT_08}" ;
	    attribute INIT_09 of bram : label is "{INIT_09}" ;
	    attribute INIT_0A of bram : label is "{INIT_0A}" ;
	    attribute INIT_0B of bram : label is "{INIT_0B}" ;
	    attribute INIT_0C of bram : label is "{INIT_0C}" ;
	    attribute INIT_0D of bram : label is "{INIT_0D}" ;
	    attribute INIT_0E of bram : label is "{INIT_0E}" ;
	    attribute INIT_0F of bram : label is "{INIT_0F}" ;
	    attribute INIT_10 of bram : label is "{INIT_10}" ;
	    attribute INIT_11 of bram : label is "{INIT_11}" ;
	    attribute INIT_12 of bram : label is "{INIT_12}" ;
	    attribute INIT_13 of bram : label is "{INIT_13}" ;
	    attribute INIT_14 of bram : label is "{INIT_14}" ;
	    attribute INIT_15 of bram : label is "{INIT_15}" ;
	    attribute INIT_16 of bram : label is "{INIT_16}" ;
	    attribute INIT_17 of bram : label is "{INIT_17}" ;
	    attribute INIT_18 of bram : label is "{INIT_18}" ;
	    attribute INIT_19 of bram : label is "{INIT_19}" ;
	    attribute INIT_1A of bram : label is "{INIT_1A}" ;
	    attribute INIT_1B of bram : label is "{INIT_1B}" ;
	    attribute INIT_1C of bram : label is "{INIT_1C}" ;
	    attribute INIT_1D of bram : label is "{INIT_1D}" ;
	    attribute INIT_1E of bram : label is "{INIT_1E}" ;
	    attribute INIT_1F of bram : label is "{INIT_1F}" ;
	    attribute INIT_20 of bram : label is "{INIT_20}" ;
	    attribute INIT_21 of bram : label is "{INIT_21}" ;
	    attribute INIT_22 of bram : label is "{INIT_22}" ;
	    attribute INIT_23 of bram : label is "{INIT_23}" ;
	    attribute INIT_24 of bram : label is "{INIT_24}" ;
	    attribute INIT_25 of bram : label is "{INIT_25}" ;
	    attribute INIT_26 of bram : label is "{INIT_26}" ;
	    attribute INIT_27 of bram : label is "{INIT_27}" ;
	    attribute INIT_28 of bram : label is "{INIT_28}" ;
	    attribute INIT_29 of bram : label is "{INIT_29}" ;
	    attribute INIT_2A of bram : label is "{INIT_2A}" ;
	    attribute INIT_2B of bram : label is "{INIT_2B}" ;
	    attribute INIT_2C of bram : label is "{INIT_2C}" ;
	    attribute INIT_2D of bram : label is "{INIT_2D}" ;
	    attribute INIT_2E of bram : label is "{INIT_2E}" ;
	    attribute INIT_2F of bram : label is "{INIT_2F}" ;
	    attribute INIT_30 of bram : label is "{INIT_30}" ;
	    attribute INIT_31 of bram : label is "{INIT_31}" ;
	    attribute INIT_32 of bram : label is "{INIT_32}" ;
	    attribute INIT_33 of bram : label is "{INIT_33}" ;
	    attribute INIT_34 of bram : label is "{INIT_34}" ;
	    attribute INIT_35 of bram : label is "{INIT_35}" ;
	    attribute INIT_36 of bram : label is "{INIT_36}" ;
	    attribute INIT_37 of bram : label is "{INIT_37}" ;
	    attribute INIT_38 of bram : label is "{INIT_38}" ;
	    attribute INIT_39 of bram : label is "{INIT_39}" ;
	    attribute INIT_3A of bram : label is "{INIT_3A}" ;
	    attribute INIT_3B of bram : label is "{INIT_3B}" ;
	    attribute INIT_3C of bram : label is "{INIT_3C}" ;
	    attribute INIT_3D of bram : label is "{INIT_3D}" ;
	    attribute INIT_3E of bram : label is "{INIT_3E}" ;
	    attribute INIT_3F of bram : label is "{INIT_3F}" ;
	    attribute INITP_00 of bram : label is "{INITP_00}" ;
	    attribute INITP_01 of bram : label is "{INITP_01}" ;
	    attribute INITP_02 of bram : label is "{INITP_02}" ;
	    attribute INITP_03 of bram : label is "{INITP_03}" ;
	    attribute INITP_04 of bram : label is "{INITP_04}" ;
	    attribute INITP_05 of bram : label is "{INITP_05}" ;
	    attribute INITP_06 of bram : label is "{INITP_06}" ;
	    attribute INITP_07 of bram : label is "{INITP_07}" ;
	begin
	    bram : component RAMB16_S9_S18
	        generic map (
	            INIT_00 => X"{INIT_00}",
	            INIT_01 => X"{INIT_01}",
	            INIT_02 => X"{INIT_02}",
	            INIT_03 => X"{INIT_03}",
	            INIT_04 => X"{INIT_04}",
	            INIT_05 => X"{INIT_05}",
	            INIT_06 => X"{INIT_06}",
	            INIT_07 => X"{INIT_07}",
	            INIT_08 => X"{INIT_08}",
	            INIT_09 => X"{INIT_09}",
	            INIT_0A => X"{INIT_0A}",
	            INIT_0B => X"{INIT_0B}",
	            INIT_0C => X"{INIT_0C}",
	            INIT_0D => X"{INIT_0D}",
	            INIT_0E => X"{INIT_0E}",
	            INIT_0F => X"{INIT_0F}",
	            INIT_10 => X"{INIT_10}",
	            INIT_11 => X"{INIT_11}",
	            INIT_12 => X"{INIT_12}",
	            INIT_13 => X"{INIT_13}",
	            INIT_14 => X"{INIT_14}",
	            INIT_15 => X"{INIT_15}",
	            INIT_16 => X"{INIT_16}",
	            INIT_17 => X"{INIT_17}",
	            INIT_18 => X"{INIT_18}",
	            INIT_19 => X"{INIT_19}",
	            INIT_1A => X"{INIT_1A}",
	            INIT_1B => X"{INIT_1B}",
	            INIT_1C => X"{INIT_1C}",
	            INIT_1D => X"{INIT_1D}",
	            INIT_1E => X"{INIT_1E}",
	            INIT_1F => X"{INIT_1F}",
	            INIT_20 => X"{INIT_20}",
	            INIT_21 => X"{INIT_21}",
	            INIT_22 => X"{INIT_22}",
	            INIT_23 => X"{INIT_23}",
	            INIT_24 => X"{INIT_24}",
	            INIT_25 => X"{INIT_25}",
	            INIT_26 => X"{INIT_26}",
	            INIT_27 => X"{INIT_27}",
	            INIT_28 => X"{INIT_28}",
	            INIT_29 => X"{INIT_29}",
	            INIT_2A => X"{INIT_2A}",
	            INIT_2B => X"{INIT_2B}",
	            INIT_2C => X"{INIT_2C}",
	            INIT_2D => X"{INIT_2D}",
	            INIT_2E => X"{INIT_2E}",
	            INIT_2F => X"{INIT_2F}",
	            INIT_30 => X"{INIT_30}",
	            INIT_31 => X"{INIT_31}",
	            INIT_32 => X"{INIT_32}",
	            INIT_33 => X"{INIT_33}",
	            INIT_34 => X"{INIT_34}",
	            INIT_35 => X"{INIT_35}",
	            INIT_36 => X"{INIT_36}",
	            INIT_37 => X"{INIT_37}",
	            INIT_38 => X"{INIT_38}",
	            INIT_39 => X"{INIT_39}",
	            INIT_3A => X"{INIT_3A}",
	            INIT_3B => X"{INIT_3B}",
	            INIT_3C => X"{INIT_3C}",
	            INIT_3D => X"{INIT_3D}",
	            INIT_3E => X"{INIT_3E}",
	            INIT_3F => X"{INIT_3F}",
	            INITP_00 => X"{INITP_00}",
	            INITP_01 => X"{INITP_01}",
	            INITP_02 => X"{INITP_02}",
	            INITP_03 => X"{INITP_03}",
	            INITP_04 => X"{INITP_04}",
	            INITP_05 => X"{INITP_05}",
	            INITP_06 => X"{INITP_06}",
	            INITP_07 => X"{INITP_07}"
	        )
	        port map (
	            DIB => "0000000000000000",
	            DIPB => "00",
	            ENB => '1',
	            WEB => '0',
	            SSRB => '0',
	            CLKB => clk,
	            ADDRB => address,
	            DOB => instruction( INSTSIZE - 3 downto 0 ),
	            DOPB => instruction( INSTSIZE - 1 downto INSTSIZE - 2 ),
	            DIA => jdata( JDATASIZE - 2 downto 0 ),
	            DIPA => jdata( JDATASIZE - 1 downto JDATASIZE - 1 ),
	            ENA => juser1,
	            WEA => jwrite,
	            SSRA => '0',
	            CLKA => clk,
	            ADDRA => jaddr,
	            DOA => open,
	            DOPA => open 
	        ) ;
	end generate ;

	I16 : if PicoType = pbtI generate
		attribute INIT_00 of bram : label is "{INIT_00}" ;
		attribute INIT_01 of bram : label is "{INIT_01}" ;
		attribute INIT_02 of bram : label is "{INIT_02}" ;
		attribute INIT_03 of bram : label is "{INIT_03}" ;
		attribute INIT_04 of bram : label is "{INIT_04}" ;
		attribute INIT_05 of bram : label is "{INIT_05}" ;
		attribute INIT_06 of bram : label is "{INIT_06}" ;
		attribute INIT_07 of bram : label is "{INIT_07}" ;
		attribute INIT_08 of bram : label is "{INIT_08}" ;
		attribute INIT_09 of bram : label is "{INIT_09}" ;
		attribute INIT_0A of bram : label is "{INIT_0A}" ;
		attribute INIT_0B of bram : label is "{INIT_0B}" ;
		attribute INIT_0C of bram : label is "{INIT_0C}" ;
		attribute INIT_0D of bram : label is "{INIT_0D}" ;
		attribute INIT_0E of bram : label is "{INIT_0E}" ;
		attribute INIT_0F of bram : label is "{INIT_0F}" ;
	begin
	    bram : component RAMB4_S8_S16
	        generic map (
	            INIT_00 => X"{INIT_00}",
	            INIT_01 => X"{INIT_01}",
	            INIT_02 => X"{INIT_02}",
	            INIT_03 => X"{INIT_03}",
	            INIT_04 => X"{INIT_04}",
	            INIT_05 => X"{INIT_05}",
	            INIT_06 => X"{INIT_06}",
	            INIT_07 => X"{INIT_07}",
	            INIT_08 => X"{INIT_08}",
	            INIT_09 => X"{INIT_09}",
	            INIT_0A => X"{INIT_0A}",
	            INIT_0B => X"{INIT_0B}",
	            INIT_0C => X"{INIT_0C}",
	            INIT_0D => X"{INIT_0D}",
	            INIT_0E => X"{INIT_0E}",
	            INIT_0F => X"{INIT_0F}"
	        )
			port map (
				DIB => "0000000000000000",  
				ENB => '1', 
				WEB => '0',
				RSTB =>	'0',
				CLKB => clk,
				ADDRB => address,
				DOB => instruction( INSTSIZE - 1 downto 0 ),  
				DIA => jdata( JDATASIZE - 1 downto 0 ),   
				ENA => juser1, 
				WEA => jwrite,
				RSTA => '0',
				CLKA => clk,
				ADDRA => jaddr,
				DOA => open  
			) ; 
	end generate ;

	I20 : if PicoType = pbtS generate
		attribute INIT_00 of ram_1 : label is "{INIT1_0}" ;
		attribute INIT_01 of ram_1 : label is "{INIT1_1}" ;
		attribute INIT_02 of ram_1 : label is "{INIT1_2}" ;
		attribute INIT_03 of ram_1 : label is "{INIT1_3}" ;
		attribute INIT_04 of ram_1 : label is "{INIT1_4}" ;
		attribute INIT_05 of ram_1 : label is "{INIT1_5}" ;
		attribute INIT_06 of ram_1 : label is "{INIT1_6}" ;
		attribute INIT_07 of ram_1 : label is "{INIT1_7}" ;
		attribute INIT_08 of ram_1 : label is "{INIT1_8}" ;
		attribute INIT_09 of ram_1 : label is "{INIT1_9}" ;
		attribute INIT_0A of ram_1 : label is "{INIT1_A}" ;
		attribute INIT_0B of ram_1 : label is "{INIT1_B}" ;
		attribute INIT_0C of ram_1 : label is "{INIT1_C}" ;
		attribute INIT_0D of ram_1 : label is "{INIT1_D}" ;
		attribute INIT_0E of ram_1 : label is "{INIT1_E}" ;
		attribute INIT_0F of ram_1 : label is "{INIT1_F}" ;

		attribute INIT_00 of ram_2 : label is "{INIT2_0}" ;
		attribute INIT_01 of ram_2 : label is "{INIT2_1}" ;
		attribute INIT_02 of ram_2 : label is "{INIT2_2}" ;
		attribute INIT_03 of ram_2 : label is "{INIT2_3}" ;
		attribute INIT_04 of ram_2 : label is "{INIT2_4}" ;
		attribute INIT_05 of ram_2 : label is "{INIT2_5}" ;
		attribute INIT_06 of ram_2 : label is "{INIT2_6}" ;
		attribute INIT_07 of ram_2 : label is "{INIT2_7}" ;
		attribute INIT_08 of ram_2 : label is "{INIT2_8}" ;
		attribute INIT_09 of ram_2 : label is "{INIT2_9}" ;
		attribute INIT_0A of ram_2 : label is "{INIT2_A}" ;
		attribute INIT_0B of ram_2 : label is "{INIT2_B}" ;
		attribute INIT_0C of ram_2 : label is "{INIT2_C}" ;
		attribute INIT_0D of ram_2 : label is "{INIT2_D}" ;
		attribute INIT_0E of ram_2 : label is "{INIT2_E}" ;
		attribute INIT_0F of ram_2 : label is "{INIT2_F}" ;

		attribute INIT_00 of ram_3 : label is "{INIT3_0}" ;
		attribute INIT_01 of ram_3 : label is "{INIT3_1}" ;
		attribute INIT_02 of ram_3 : label is "{INIT3_2}" ;
		attribute INIT_03 of ram_3 : label is "{INIT3_3}" ;
		attribute INIT_04 of ram_3 : label is "{INIT3_4}" ;
		attribute INIT_05 of ram_3 : label is "{INIT3_5}" ;
		attribute INIT_06 of ram_3 : label is "{INIT3_6}" ;
		attribute INIT_07 of ram_3 : label is "{INIT3_7}" ;
		attribute INIT_08 of ram_3 : label is "{INIT3_8}" ;
		attribute INIT_09 of ram_3 : label is "{INIT3_9}" ;
		attribute INIT_0A of ram_3 : label is "{INIT3_A}" ;
		attribute INIT_0B of ram_3 : label is "{INIT3_B}" ;
		attribute INIT_0C of ram_3 : label is "{INIT3_C}" ;
		attribute INIT_0D of ram_3 : label is "{INIT3_D}" ;
		attribute INIT_0E of ram_3 : label is "{INIT3_E}" ;
		attribute INIT_0F of ram_3 : label is "{INIT3_F}" ;

		attribute INIT_00 of ram_4 : label is "{INIT4_0}" ;
		attribute INIT_01 of ram_4 : label is "{INIT4_1}" ;
		attribute INIT_02 of ram_4 : label is "{INIT4_2}" ;
		attribute INIT_03 of ram_4 : label is "{INIT4_3}" ;
		attribute INIT_04 of ram_4 : label is "{INIT4_4}" ;
		attribute INIT_05 of ram_4 : label is "{INIT4_5}" ;
		attribute INIT_06 of ram_4 : label is "{INIT4_6}" ;
		attribute INIT_07 of ram_4 : label is "{INIT4_7}" ;
		attribute INIT_08 of ram_4 : label is "{INIT4_8}" ;
		attribute INIT_09 of ram_4 : label is "{INIT4_9}" ;
		attribute INIT_0A of ram_4 : label is "{INIT4_A}" ;
		attribute INIT_0B of ram_4 : label is "{INIT4_B}" ;
		attribute INIT_0C of ram_4 : label is "{INIT4_C}" ;
		attribute INIT_0D of ram_4 : label is "{INIT4_D}" ;
		attribute INIT_0E of ram_4 : label is "{INIT4_E}" ;
		attribute INIT_0F of ram_4 : label is "{INIT4_F}" ;

		attribute INIT_00 of ram_5 : label is "{INIT5_0}" ;
		attribute INIT_01 of ram_5 : label is "{INIT5_1}" ;
		attribute INIT_02 of ram_5 : label is "{INIT5_2}" ;
		attribute INIT_03 of ram_5 : label is "{INIT5_3}" ;
		attribute INIT_04 of ram_5 : label is "{INIT5_4}" ;
		attribute INIT_05 of ram_5 : label is "{INIT5_5}" ;
		attribute INIT_06 of ram_5 : label is "{INIT5_6}" ;
		attribute INIT_07 of ram_5 : label is "{INIT5_7}" ;
		attribute INIT_08 of ram_5 : label is "{INIT5_8}" ;
		attribute INIT_09 of ram_5 : label is "{INIT5_9}" ;
		attribute INIT_0A of ram_5 : label is "{INIT5_A}" ;
		attribute INIT_0B of ram_5 : label is "{INIT5_B}" ;
		attribute INIT_0C of ram_5 : label is "{INIT5_C}" ;
		attribute INIT_0D of ram_5 : label is "{INIT5_D}" ;
		attribute INIT_0E of ram_5 : label is "{INIT5_E}" ;
		attribute INIT_0F of ram_5 : label is "{INIT5_F}" ;

		signal data_out : std_logic_vector( 3 downto 0 ) ;
	begin
	    ram_1 : component RAMB4_S4_S4
	        generic map (
				INIT_00 => X"{INIT1_0}",
				INIT_01 => X"{INIT1_1}",
				INIT_02 => X"{INIT1_2}",
				INIT_03 => X"{INIT1_3}",
				INIT_04 => X"{INIT1_4}",
				INIT_05 => X"{INIT1_5}",
				INIT_06 => X"{INIT1_6}",
				INIT_07 => X"{INIT1_7}",
				INIT_08 => X"{INIT1_8}",
				INIT_09 => X"{INIT1_9}",
				INIT_0A => X"{INIT1_A}",
				INIT_0B => X"{INIT1_B}",
				INIT_0C => X"{INIT1_C}",
				INIT_0D => X"{INIT1_D}",
				INIT_0E => X"{INIT1_E}",
				INIT_0F => X"{INIT1_F}"
	        )
			port map (
				DIA => "0000",  
				ENA => '1', 
				WEA => '0',
				RSTA =>	'0',
				CLKA => clk,
				ADDRA => address,
				DOA => data_out,  
				DIB => jdata( JDATASIZE - 1 downto 16 ),   
				ENB => juser1, 
				WEB => jwrite,
				RSTB => '0',
				CLKB => clk,
				ADDRB => jaddr,
				DOB => open  
			) ; 
			-- loose top 2 bits
			instruction( 17 downto 16 ) <= data_out( 1 downto 0 ) ;

	    ram_2 : component RAMB4_S4_S4
	        generic map (
				INIT_00 => X"{INIT2_0}",
				INIT_01 => X"{INIT2_1}",
				INIT_02 => X"{INIT2_2}",
				INIT_03 => X"{INIT2_3}",
				INIT_04 => X"{INIT2_4}",
				INIT_05 => X"{INIT2_5}",
				INIT_06 => X"{INIT2_6}",
				INIT_07 => X"{INIT2_7}",
				INIT_08 => X"{INIT2_8}",
				INIT_09 => X"{INIT2_9}",
				INIT_0A => X"{INIT2_A}",
				INIT_0B => X"{INIT2_B}",
				INIT_0C => X"{INIT2_C}",
				INIT_0D => X"{INIT2_D}",
				INIT_0E => X"{INIT2_E}",
				INIT_0F => X"{INIT2_F}"
	        )
			port map (
				DIA => "0000",  
				ENA => '1', 
				WEA => '0',
				RSTA =>	'0',
				CLKA => clk,
				ADDRA => address,
				DOA => instruction( 15 downto 12 ),  
				DIB => jdata( 15 downto 12 ),   
				ENB => juser1, 
				WEB => jwrite,
				RSTB => '0',
				CLKB => clk,
				ADDRB => jaddr,
				DOB => open  
			) ; 

	    ram_3 : component RAMB4_S4_S4
	        generic map (
				INIT_00 => X"{INIT3_0}",
				INIT_01 => X"{INIT3_1}",
				INIT_02 => X"{INIT3_2}",
				INIT_03 => X"{INIT3_3}",
				INIT_04 => X"{INIT3_4}",
				INIT_05 => X"{INIT3_5}",
				INIT_06 => X"{INIT3_6}",
				INIT_07 => X"{INIT3_7}",
				INIT_08 => X"{INIT3_8}",
				INIT_09 => X"{INIT3_9}",
				INIT_0A => X"{INIT3_A}",
				INIT_0B => X"{INIT3_B}",
				INIT_0C => X"{INIT3_C}",
				INIT_0D => X"{INIT3_D}",
				INIT_0E => X"{INIT3_E}",
				INIT_0F => X"{INIT3_F}"
	        )
			port map (
				DIA => "0000",  
				ENA => '1', 
				WEA => '0',
				RSTA =>	'0',
				CLKA => clk,
				ADDRA => address,
				DOA => instruction( 11 downto 8 ),  
				DIB => jdata( 11 downto 8 ),   
				ENB => juser1, 
				WEB => jwrite,
				RSTB => '0',
				CLKB => clk,
				ADDRB => jaddr,
				DOB => open  
			) ; 

	    ram_4 : component RAMB4_S4_S4
	        generic map (
				INIT_00 => X"{INIT4_0}",
				INIT_01 => X"{INIT4_1}",
				INIT_02 => X"{INIT4_2}",
				INIT_03 => X"{INIT4_3}",
				INIT_04 => X"{INIT4_4}",
				INIT_05 => X"{INIT4_5}",
				INIT_06 => X"{INIT4_6}",
				INIT_07 => X"{INIT4_7}",
				INIT_08 => X"{INIT4_8}",
				INIT_09 => X"{INIT4_9}",
				INIT_0A => X"{INIT4_A}",
				INIT_0B => X"{INIT4_B}",
				INIT_0C => X"{INIT4_C}",
				INIT_0D => X"{INIT4_D}",
				INIT_0E => X"{INIT4_E}",
				INIT_0F => X"{INIT4_F}"
	        )
			port map (
				DIA => "0000",  
				ENA => '1', 
				WEA => '0',
				RSTA =>	'0',
				CLKA => clk,
				ADDRA => address,
				DOA => instruction( 7 downto 4 ),  
				DIB => jdata( 7 downto 4 ),   
				ENB => juser1, 
				WEB => jwrite,
				RSTB => '0',
				CLKB => clk,
				ADDRB => jaddr,
				DOB => open  
			) ; 

	    ram_5 : component RAMB4_S4_S4
	        generic map (
				INIT_00 => X"{INIT5_0}",
				INIT_01 => X"{INIT5_1}",
				INIT_02 => X"{INIT5_2}",
				INIT_03 => X"{INIT5_3}",
				INIT_04 => X"{INIT5_4}",
				INIT_05 => X"{INIT5_5}",
				INIT_06 => X"{INIT5_6}",
				INIT_07 => X"{INIT5_7}",
				INIT_08 => X"{INIT5_8}",
				INIT_09 => X"{INIT5_9}",
				INIT_0A => X"{INIT5_A}",
				INIT_0B => X"{INIT5_B}",
				INIT_0C => X"{INIT5_C}",
				INIT_0D => X"{INIT5_D}",
				INIT_0E => X"{INIT5_E}",
				INIT_0F => X"{INIT5_F}"
	        )
			port map (
				DIA => "0000",  
				ENA => '1', 
				WEA => '0',
				RSTA =>	'0',
				CLKA => clk,
				ADDRA => address,
				DOA => instruction( 3 downto 0 ),  
				DIB => jdata( 3 downto 0 ),   
				ENB => juser1, 
				WEB => jwrite,
				RSTB => '0',
				CLKB => clk,
				ADDRB => jaddr,
				DOB => open  
			) ; 
	end generate ;

	jdata <= ( others => '0' ) ;
	jaddr <= ( others => '0' ) ;
	juser1 <= '0' ;
	jwrite <= '0' ;
end architecture mix ;
