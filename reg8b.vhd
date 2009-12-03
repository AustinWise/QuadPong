----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    09:37:24 11/02/2008 
-- Design Name: 
-- Module Name:    reg8b - Behavioral 
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

entity reg8b is
	port ( LD,CLK : in std_logic;
	D_IN : in std_logic_vector (7 downto 0);
	D_OUT : out std_logic_vector (7 downto 0));
end reg8b;

architecture Behavioral of reg8b is
begin
	process (CLK,LD)
		begin
			if (LD = '1' and rising_edge(CLK)) then
				D_OUT <= D_IN;
			end if;
	end process;
end Behavioral;

