--------------------------------------------
-- Paulo Gil - 76361 - paulogil@ua.pt
-- Rui Pires - 76319 - aprm@ua.pt
-- Micro-Projeto-LSD-2016
--------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.NUMERIC_STD.all;

entity GateTimerN is
	generic(N	    :		 positive := 10);
	port	 (clk     : in	 std_logic;
			  gateIn  : in	 std_logic;
			  gateOut0: out std_logic;
			  gateOut1: out std_logic;
			  gateOut2: out std_logic);
end GateTimerN;

architecture Behavioral of GateTimerN is

	signal s_counter: natural;

begin

	process(clk)
	begin
	
		if(rising_edge(clk)) then
			if(gateIn = '0' and s_counter = 0) then
				s_counter <= s_counter + 1;
				gateOut0 <= '1';
				gateOut1 <= '1';
			elsif(s_counter > 0 and s_counter < N - 2) then
				s_counter <= s_counter + 1;
				gateOut0 <= '0';
				gateOut1 <= '1';
			elsif(s_counter >= N - 2 and s_counter < N) then
				s_counter <= s_counter + 1;
				gateOut1 <= '1';
				gateOut2 <= '1';
			elsif(s_counter = N) then
				s_counter <= 0;
				gateOut0 <= '0';
				gateOut1 <= '0';
				gateOut2 <= '0';
			end if;
		end if;
	end process;

end Behavioral;