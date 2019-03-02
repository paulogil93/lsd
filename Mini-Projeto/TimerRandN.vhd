--------------------------------------------
-- Paulo Gil
-- 76361
-- paulogil@ua.pt
-- Mini-Projecto
-- LSD-2016
--------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.NUMERIC_STD.all;

entity TimerRandN is
	generic(SIZE:     positive := 16);
	port(clk		: in	std_logic;
		  reset	: in	std_logic;
		  enable	: in	std_logic;
		  randIn	: in	std_logic_vector((SIZE-1) downto 0);
		  setOut	: out std_logic;
		  ready	: out std_logic);
end TimerRandN;

architecture Behavioral of TimerRandN is

	signal s_count: unsigned((SIZE-1) downto 0);
	signal s_rand: unsigned((SIZE-1) downto 0);
	
begin
	s_rand <= unsigned(randIn);
	
	process(clk)
	begin
		if(reset = '1') then
			s_count <= (others => '0');
		elsif(enable = '1') then
			if(s_count < s_rand) then
				if(rising_edge(clk)) then
					s_count <= s_count + 1;
				end if;
				ready <= '0';
			elsif(s_count = s_rand) then
				ready <= '1';
			end if;
		else
			ready <= '0';
		end if;
	end process;
	
	setOut <= enable;
		
end Behavioral;