--------------------------------------------
-- Paulo Gil - 76361 - paulogil@ua.pt
-- Rui Pires - 76319 - aprm@ua.pt
-- Micro-Projeto-LSD-2016
--------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.NUMERIC_STD.all;

entity Bin2BCD is
	port(binIn	: in	std_logic_vector(7 downto 0);
		  BCDOut : out std_logic_vector(7 downto 0);
		  blink	: out	std_logic);
end Bin2BCD;

architecture Behavioral of Bin2BCD is
	--Sinal para converter a entrada em binário num
	--integer, para efeitos de comparação
	signal s_int: integer;
	
	--Sinal para subtrair as dezenas ao númer binário
	--para obter as unidades
	signal s_sub: unsigned(7 downto 0);
	
	--Unidades em BCD-8bits resultantes da subtração
	--do número binário inicial pelas suas dezenas
	signal s_bcd: unsigned(7 downto 0);
	
begin

	s_int <= to_integer(unsigned(binIn));
	
	process(binIn)
	begin
		if(binIn = "00000000") then
			BCDOut <= "00000000";
			blink <= '1';
		elsif(s_int > 0 and s_int < 10) then
			BCDOut <= "0000" & binIn(3 downto 0);
			blink <= '0';
		elsif(s_int >= 10 and s_int < 20) then   --Verifica se o número está entre 10(inclusivé)
			s_sub <= to_unsigned(10,8);			  -- e 20; se estiver, subtrai-se 10 ao número para
			s_bcd <= unsigned(binIn) - s_sub;     --se obter as unidades
			BCDOut <= std_logic_vector("0001" & s_bcd(3 downto 0));
			blink <= '0';
		elsif(s_int >= 20 and s_int < 30) then
			s_sub <= to_unsigned(20,8);
			s_bcd <= unsigned(binIn) - s_sub;
			BCDOut <= std_logic_vector("0010" & s_bcd(3 downto 0));
			blink <= '0';
		elsif(s_int >= 30 and s_int < 40) then
			s_sub <= to_unsigned(30,8);
			s_bcd <= unsigned(binIn) - s_sub;
			BCDOut <= std_logic_vector("0011" & s_bcd(3 downto 0));
			blink <= '0';
		elsif(s_int >= 40 and s_int < 50) then
			s_sub <= to_unsigned(40,8);
			s_bcd <= unsigned(binIn) - s_sub;
			BCDOut <= std_logic_vector("0100" & s_bcd(3 downto 0));
			blink <= '0';
		elsif(s_int >= 50 and s_int < 60) then
			s_sub <= to_unsigned(50,8);
			s_bcd <= unsigned(binIn) - s_sub;
			BCDOut <= std_logic_vector("0101" & s_bcd(3 downto 0));
			blink <= '0';
		elsif(s_int >= 60 and s_int < 70) then
			s_sub <= to_unsigned(60,8);
			s_bcd <= unsigned(binIn) - s_sub;
			BCDOut <= std_logic_vector("0110" & s_bcd(3 downto 0));
			blink <= '0';
		elsif(s_int >= 70 and s_int < 80) then
			s_sub <= to_unsigned(70,8);
			s_bcd <= unsigned(binIn) - s_sub;
			BCDOut <= std_logic_vector("0111" & s_bcd(3 downto 0));
			blink <= '0';
		elsif(s_int >= 80 and s_int < 90) then
			s_sub <= to_unsigned(80,8);
			s_bcd <= unsigned(binIn) - s_sub;
			BCDOut <= std_logic_vector("1000" & s_bcd(3 downto 0));
			blink <= '0';
		elsif(s_int >= 90 and s_int < 100) then
			s_sub <= to_unsigned(90,8);
			s_bcd <= unsigned(binIn) - s_sub;
			BCDOut <= std_logic_vector("1001" & s_bcd(3 downto 0));
			blink <= '0';
		end if;
	end process;
end Behavioral;