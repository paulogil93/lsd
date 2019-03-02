--------------------------------------------
-- Paulo Gil
-- paulogil@ua.pt
-- LSD-2016
--------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.all;

entity SeqDetFSM_Tb is
end SeqDetFSM_Tb;

architecture Stimulus of SeqDetFSM_Tb is

	signal s_clk	: std_logic;
	signal s_reset	: std_logic;
	signal s_Xin	: std_logic;
	signal s_Yout	: std_logic;
	
begin

	uut: entity work.SeqDetFSM(MealyArch)
		port map(clk	=> s_clk,
					reset	=> s_reset,
					Xin	=> s_Xin,
					Yout	=> s_Yout);
	
	clk_proc: process
	begin
		s_clk <= '0';
		wait for 10 ns;
		s_clk <= '1';
		wait for 10 ns;
	end process;
	
	stim_proc: process
	begin
		wait for 5 ns;
		
		s_Xin <= '1';
		wait for 10 ns;
		
		s_Xin <= '0';
		wait for 10 ns;
		
		s_Xin <= '1';
		wait for 20 ns;
		
		s_Xin <= '0';
		wait for 20 ns;
		
		s_reset <= '1';
		wait for 10 ns;
		s_reset <= '0';
		wait for 10 ns;
		
		s_Xin <= '1';
		wait for 10 ns;
		
		s_Xin <= '0';
		wait for 20 ns;
		
		s_Xin <= '1';
		wait for 10 ns;
		
		s_Xin <= '0';
		wait for 10 ns;
		
		s_Xin <= '1';
		wait for 10 ns;
		
		s_Xin <= '0';
		wait for 20 ns;
		
		s_Xin <= '1';
		wait for 10 ns;
		
		s_Xin <= '0';
		wait for 10 ns;
	end process;
end Stimulus;