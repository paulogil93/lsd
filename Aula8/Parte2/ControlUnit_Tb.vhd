--------------------------------------------
-- Paulo Gil
-- paulogil@ua.pt
-- LSD-2016
--------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.all;

entity ControlUnit_Tb is
end ControlUnit_Tb;

architecture Stimulus of ControlUnit_Tb is

	signal s_clk	: std_logic;
	signal s_reset	: std_logic;
	signal s_Vin	: std_logic;
	signal s_Cin	: std_logic;
	signal s_drink	: std_logic;
	
begin

	uut: entity work.ControlUnit(Behavioral)
		port map(clk	=> s_clk,
					reset	=> s_reset,
					Vin	=> s_Vin,
					Cin	=> s_Cin,
					drink => s_drink);
					
	clk_proc: process
	begin
		s_clk <= '0';
		wait for 10 ns;
		s_clk <= '1';
		wait for 10 ns;
	end process;
	
	stim_proc: process
	begin
		s_Vin <= '0';
		s_Cin <= '0';
		s_reset <= '0';
		wait for 5 ns;
		
		s_Vin <= '1';
		wait for 50 ns;
		
		s_reset <= '1';
		wait for 20 ns;
		
		s_reset <= '0';
		s_Vin	  <= '0';
		wait for 20 ns;
		
		s_Vin <= '1';
		wait for 100 ns;
		
		s_Vin <= '0';
		s_reset <= '1';
		wait for 20 ns;
		
		s_reset <= '0';
		wait for 20 ns;
		
		s_Cin <= '1';
		wait for 50 ns;
		
		s_Cin <= '0';
		wait for 50 ns;
		
		s_reset <= '1';
		wait for 20 ns;
		
		s_reset <= '0';
		wait for 20 ns;
		
		s_Vin <= '1';
		wait for 50 ns;
		
		s_Vin <= '0';
		s_Cin <= '1';
		wait for 50 ns;
		
	end process;
end Stimulus;