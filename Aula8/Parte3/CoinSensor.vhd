--------------------------------------------
-- Paulo Gil
-- paulogil@ua.pt
-- LSD-2016
--------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.all;

entity CoinSensor is
	port(coinInV	: in	std_logic;
		  coinInC	: in	std_logic;
		  coinOutV	: out std_logic;
		  coinOutC	: out std_logic);
end CoinSensor;

architecture Behavioral of CoinSensor is
begin
	
	coinOutV <= '1' when (coinInV = '1' and coinInC = '0') else '0';
	coinOutC <= '1' when (coinInV = '0' and coinInC = '1') else '0';
	
end Behavioral;
		  