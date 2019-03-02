--------------------------------------------
-- Paulo Gil
-- paulogil@ua.pt
-- LSD-2016
--------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.all;

entity DrinksMachine is
	port(CLOCK_50	: in	std_logic;
		  KEY			: in	std_logic_vector(0 downto 0);
		  SW			: in	std_logic_vector(1 downto 0);
		  LEDG		: out std_logic_vector(0 downto 0));
end DrinksMachine;

architecture Shell of DrinksMachine is

	signal s_clk: std_logic;
	signal s_Vin: std_logic;
	signal s_Cin: std_logic;
	signal s_coinV: std_logic;
	signal s_coinC: std_logic;

begin

	coin_sensor: entity work.CoinSensor(Behavioral)
		port map(coinInV	=> SW(0),
					coinInC	=> SW(1),
					coinOutV => s_coinV,
					coinOutC => s_coinC);

	debounce_unit_Vin: entity work.DebounceUnit(Behavioral)
		port map(refClk		=> CLOCK_50,
					dirtyIn		=> s_coinV,
					pulsedOut	=> s_Vin);
	
	debounce_unit_Cin: entity work.DebounceUnit(Behavioral)
		port map(refClk		=> CLOCK_50,
					dirtyIn		=> s_coinC,
					pulsedOut	=> s_Cin);

	freq_divider: entity work.FreqDividerN(Behavioral)
		generic map(N			=> 25000000)
			port map(enable	=> '1',
						clkIn		=> CLOCK_50,
						clkOut	=> s_clk);

	system_core: entity work.ControlUnit(Behavioral)
		port map(clk	=> s_clk,
					reset => KEY(0),
					Vin	=> s_Vin,
					Cin	=> s_Cin,
					drink => LEDG(0));
					end Shell;
					