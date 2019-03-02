--------------------------------------------
-- Paulo Gil
-- paulogil@ua.pt
-- LSD-2016
--------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.all;

entity ShiftRegister_Demo is
	port(CLOCK_50:	in	 std_logic;
		  SW		 : in	 std_logic_vector(0 downto 0);
		  KEY		 : in	 std_logic_vector(0 downto 0);
		  LEDR	 :	out std_logic_vector(7 downto 0));
end ShiftRegister_Demo;

architecture Shell of ShiftRegister_Demo is
	
	signal s_1Hz: std_logic;
	
begin

	fd: entity work.FreqDividerN(Behavioral)
		generic map(N		 =>	50000000)
			port map(enable => SW(0),
						clkIn	 => CLOCK_50,
						clkOut => s_1Hz);
						
	sr: entity work.ShiftRegisterN(Behavioral)
		generic map(size	 => 8)
			port map(clk	 => s_1Hz,
						sin	 => KEY(0),
						dataOut=> LEDR(7 downto 0));
						
end Shell;
						