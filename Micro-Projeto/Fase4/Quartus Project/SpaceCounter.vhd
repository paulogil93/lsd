--------------------------------------------
-- Paulo Gil - 76361 - paulogil@ua.pt
-- Rui Pires - 76319 - aprm@ua.pt
-- Micro-Projeto-LSD-2016
--------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.NUMERIC_STD.all;

entity SpaceCounter is
	generic(MAX			:		positive := 99);
		port(clk			: in	std_logic;
			  sensorIn	: in	std_logic;
			  sensorOut	: in	std_logic;
			  count		: out	std_logic_vector(7 downto 0));
end SpaceCounter;

architecture Behavioral of SpaceCounter is

	signal s_count: natural;

begin
	
	process(clk)
	begin
		if(rising_edge(clk)) then
			if(sensorIn = '0' and s_count < MAX) then
				s_count <= s_count + 1;
			elsif(sensorOut = '0' and s_count > 0) then
				s_count <= s_count - 1;
			end if;
		end if;
	end process;
	
	--Como não estava a ser possível implementar a contagem a partir valor MAX,
	--decidimos pensar na forma complementar, ou seja a contagem no processo em cima 
	--refere-se ao número de carros no parque. Por sua vez, o count em baixo é igual
	--ao numero máximo de vagas menos o número de veículos no parque.
	count <= std_logic_vector(to_unsigned(MAX,8) - to_unsigned(s_count,8));
	
end Behavioral;
