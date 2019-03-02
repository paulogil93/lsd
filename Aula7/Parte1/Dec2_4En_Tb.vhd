--------------------------------------------
-- Paulo Gil
-- paulogil@ua.pt
-- LSD-2016
--------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.all;

--Entidade sem portas
entity Dec2_4En_Tb is
end Dec2_4En_Tb;

architecture Stimulus of Dec2_4En_Tb is

	--Sinais para as entradas da UUT
	signal s_enable: std_logic;
	signal s_inputs: std_logic_vector(1 downto 0);
	
	--Sinal para a saída da UUT
	signal s_outputs: std_logic_vector(3 downto 0);
	
begin

	--Instanciação da UUT(Unit Under Test)
	uut: entity work.Dec2_4En(Behavioral)
		port map(enable	=> s_enable,
					inputs	=> s_inputs,
					outputs	=> s_outputs);
					
	--Process stim
	stim_proc: process
	begin
		wait for 100 ns;
		s_enable <= '0';
		wait for 100 ns;
		s_enable <= '1';
		wait for 100 ns;
		s_inputs <= "00";
		wait for 100 ns;
		s_inputs <= "10";
		wait for 100 ns;
		s_inputs <= "01";
		wait for 100 ns;
		s_inputs <= "11";
		wait for 100 ns;
	end process;

end Stimulus;