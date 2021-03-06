--------------------------------------------
-- Paulo Gil
-- paulogil@ua.pt
-- LSD-2016
--------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.NUMERIC_STD.all;

entity RAM_1P_16_8 is
	port(clk			: in	std_logic;
		  wrEnable	: in	std_logic;
		  wrData		: in	std_logic_vector(7 downto 0);
		  address	: in	std_logic_vector(3 downto 0);
		  readData	: out std_logic_vector(7 downto 0));
end RAM_1P_16_8;

architecture Behavioral of RAM_1P_16_8 is

	constant NUM_WORDS: integer := 16;
	subtype TData is std_logic_vector(7 downto 0);
	type TRAM is array(0 to (NUM_WORDS - 1)) of TData;
	signal s_ram: TRAM;
	
begin

	process(clk)
	begin
		if(rising_edge(clk)) then
			if(wrEnable = '1') then
				s_ram(to_integer(unsigned(address))) <= wrData;
			end if;
		end if;
	end process;
	
	readData <= s_ram(to_integer(unsigned(address)));
	
end Behavioral;	  