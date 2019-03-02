--------------------------------------------
-- Paulo Gil - 76361 - paulogil@ua.pt
-- Rui Pires - 76319 - aprm@ua.pt
-- Micro-Projeto-LSD-2016
--------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.all;

entity CardReader is
	generic(N		:		positive := 10);
	port(clk			: in	std_logic;
		  cardInput	: in	std_logic;
		  cardOutput: out	std_logic);
end CardReader;

architecture Behavioral of CardReader is

	signal s_count: natural;
	
	--Sinal para o inicio da abertura da cancela--
	--Com este sinal a contagem não entra num loop
	--infinito, assim espera por um sinal active high
	--vindo do cardInput, e só termina ao fim de 10s
	signal s_start: std_logic;

begin

	process(clk)
	begin
	
		if(rising_edge(clk)) then
			if(cardInput = '0') then
				s_count <= s_count + 1;
				cardOutput <= '1';
				s_start <= '1';
			elsif(s_count < N and s_start = '1') then
				s_count <= s_count + 1;
				cardOutput <= '1';
			elsif(s_count = N) then
				s_count <= 0;
				s_start <= '0';
				cardOutput <= '0';
			end if;
		end if;
				
	end process;

end Behavioral;
	
			
		  