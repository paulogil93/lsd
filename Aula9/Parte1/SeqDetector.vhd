--------------------------------------------
-- Paulo Gil
-- paulogil@ua.pt
-- LSD-2016
--------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.all;

entity SeqDetector is
	port(CLOCK_50	: in	std_logic;
		  SW			: in	std_logic_vector(1 downto 0);
		  KEY			: in	std_logic_vector(0 downto 0);
		  LEDR		: out std_logic_vector(0 downto 0);
		  LEDG		: out std_logic_vector(0 downto 0));
end SeqDetector;

architecture Shell of SeqDetector is

	signal s_clk: std_logic;

begin

	freq_divider: entity work.FreqDividerN(Behavioral)
		generic map(N			=> 250000000)
			port map(clkIn		=> CLOCK_50,
						enable	=> SW(0),
						clkOut	=> s_clk);
						
	system_core: entity work.SeqDetFSM(MealyArch)
			port map(clk		=> s_clk,
						reset		=> KEY(0),
						Xin		=> SW(1),
						Yout		=> LEDR(0));
						
	LEDG(0) <= s_clk;
	
end Shell;
						