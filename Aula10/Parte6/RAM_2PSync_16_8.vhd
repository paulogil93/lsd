library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.NUMERIC_STD.all;

entity RAM_2PSync_16_8 is
	port(writeClk		: in	std_logic;
		  readClk		: in	std_logic;
		  writeEnable	: in	std_logic;
		  writeAddress	: in	std_logic_vector(3 downto 0);
		  readAddress	: in	std_logic_vector(3 downto 0);
		  writeData		: in	std_logic_vector(7 downto 0);
		  readData		: out std_logic_vector(7 downto 0));
end RAM_2PSync_16_8;

architecture Behavioral of RAM_2PSync_16_8 is

	constant NUM_WORDS: positive := 16;
	subtype TData is std_logic_vector(7 downto 0);
	type TRAM is array(0 to (NUM_WORDS - 1)) of TData;
	signal s_ram: TRAM;
	
begin
	
	process(writeClk)
	begin
		if(rising_edge(writeClk)) then
			if(writeEnable = '1') then
				s_ram(to_integer(unsigned(writeAddress))) <= writeData;
			end if;
		end if;
	end process;
	
	process(readClk)
	begin
		if(rising_edge(readClk)) then
			readData <= s_ram(to_integer(unsigned(readAddress)));
		end if;
	end process;
	
end Behavioral;
		  