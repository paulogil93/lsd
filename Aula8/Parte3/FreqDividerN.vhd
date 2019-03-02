--------------------------------------------
-- Paulo Gil
-- paulogil@ua.pt
-- LSD-2016
--------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.NUMERIC_STD.all;

entity FreqDividerN is
	generic(N	  : 	  positive := 25000000);
	   port(enable: in  std_logic;
			  clkIn : in  std_logic;
		     clkOut: out std_logic);
end FreqDividerN;

architecture Behavioral of FreqDividerN is

	signal s_counter: natural;
	signal s_halfWay: natural;
	
begin

	s_halfWay <= N/2 - 1;
	
	process(clkIn)
	begin
		if(enable = '1') then
			if(rising_edge(clkIn)) then
				if(s_counter = N - 1) then
					clkOut <= '0';
					s_counter <= 0;
				else
					if(s_counter = s_halfWay)  then
						clkOut <= '1';
					end if;
					s_counter <= s_counter + 1;
				end if;
			end if;
		end if;
	end process;
	
end Behavioral;