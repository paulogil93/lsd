--------------------------------------------
-- Paulo Gil
-- paulogil@ua.pt
-- LSD-2016
--------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.NUMERIC_STD.all;

entity ALU16_Tb is
end ALU16_Tb;

architecture Stimulus of ALU16_Tb is

	--Entradas da UUT
	signal s_op		: std_logic_vector(2 downto 0);
	signal s_op0	: std_logic_vector(15 downto 0);
	signal s_op1	: std_logic_vector(15 downto 0);
	
	--Saídas da UUT
	signal s_res	: std_logic_vector(15 downto 0);
	signal s_mHi	: std_logic_vector(15 downto 0);

begin

	uut: entity work.ALU16(structure)
		port map(op		=> s_op,
					op0	=> s_op0,
					op1	=> s_op1,
					res	=> s_res,
					mHi	=> s_mHi);
	
	--Process stim
	stim_proc: process
	begin
		s_op0 <= x"FEDC";
		s_op1 <= x"0123";
		s_op	<= "000";
		wait for 100 ns;
		
		s_op <= "001";
		wait for 100 ns;
		
		s_op <= "010";
		wait for 100 ns;
		
		s_op <= "011";
		wait for 100 ns;
		
		s_op <= "100";
		wait for 100 ns;
		
		s_op0 <= x"F30C";
		s_op1 <= x"F50A";
		s_op  <= "101";
		wait for 100 ns;
		
		s_op <= "110";
		wait for 100 ns;
		
		s_op <= "111";
		wait for 100 ns;
		
		--wait;
		
	end process;
	
end Stimulus;
		