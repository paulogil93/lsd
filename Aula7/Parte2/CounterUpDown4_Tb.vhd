--------------------------------------------
-- Paulo Gil
-- paulogil@ua.pt
-- LSD-2016
--------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.all;

entity CounterUpDown4_Tb is
end CounterUpDown4_Tb;

architecture RTL of CounterUpDown4_Tb is

	--Entradas
	signal s_clk: std_logic;
	signal s_reset: std_logic;
	signal s_upDown: std_logic;
	
	--Saídas
	signal s_count: std_logic_vector(3 downto 0);
	
begin

	uut: entity work.CounterUpDown4(Behavioral)
		port map(clk	 => s_clk,
					reset	 => s_reset,
					upDown => s_upDown,
					count  => s_count);
					
	clk_proc: process
	begin
		s_clk <= '0';
		wait for 50 ns;
		s_clk <= '1';
		wait for 50 ns;
	end process;
	
	stim_proc: process
	begin
		s_reset 	<= '0';
		wait for 500 ns;
		wait for 100 ns;
		
		s_upDown <= '1';
		wait for 500 ns;
		
		s_reset <= '1';
		wait for 100 ns;
	end process;
	
end RTL;
					