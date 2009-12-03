----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    14:19:09 10/30/2008 
-- Design Name: 
-- Module Name:    ram2k_8 - Behavioral 
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

entity ram2k_8 is
  port(clk:           in  STD_LOGIC;
       we:            in  STD_LOGIC;
       ra, wa:        in  STD_LOGIC_VECTOR(10 downto 0);
       wd:            in  STD_LOGIC_VECTOR(7 downto 0);
		 rd:            out STD_LOGIC_VECTOR(7 downto 0)
		 );
end ram2k_8;

architecture Behavioral of ram2k_8 is
type ramtype is array (2047 downto 0) of STD_LOGIC_VECTOR(7 downto 0);
  signal mem: ramtype;
begin
  -- three-ported register file
  -- read two ports combinationally
  -- write third port on rising edge of clock
  
  process(clk) begin
    if (clk'event and clk = '1') then
       if we = '1' then mem(CONV_INTEGER(wa)) <= wd;
		end if;
	 end if;
  end process;

  rd <= mem(CONV_INTEGER(ra));  

end Behavioral;

