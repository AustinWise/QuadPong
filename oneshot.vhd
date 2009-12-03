
----------------------------------------------------------------
--
-- one_shot - A simple one-shot state machine. When the input
--	goes high, the output becomes high for the next two clock
--	cycles.
--
-- Inputs:
--	clk - Clock
--	trigger - The one-shot event trigger
--
-- Outputs:
--	pulse - The one-shot output
--
----------------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity one_shot is
	port(      clk : in std_logic;
	       trigger : in std_logic;
	         pulse : out std_logic);
end one_shot;

architecture one_shot of one_shot is
	-- Machine states:
	type state_type is (s1, s2, s3, s4);

	-- Signals:
	signal trigger_sync  : std_logic;
	signal ps            : state_type;
	signal ns            : state_type;
begin

	-- Synchronous process:
	process(clk)
	begin
		if (rising_edge(clk)) then 
			trigger_sync <= trigger;
			ps <= ns;
		end if; 
	end process;

	-- Combinational process:
	process(trigger_sync, ps, clk)
	begin
		case ps is 
		when s1 =>
			pulse <= '0'; 
			if (trigger_sync = '1') then 
				ns <= s2; 
			else 
				ns <= s1;
			end if; 
		when s2 => 
			pulse <= '1'; 
			ns <= s3; 
		when s3 =>
			pulse <= '1';
			ns <= s4; 
		when s4 =>
			pulse <= '0'; 
			if (trigger_sync = '1') then 
				ns <= s4; 
			else 
				ns <= s1; 
			end if; 
		end case;
	end process; 
end one_shot;
