--------------------------------------------
-- Paulo Gil
-- 76361
-- paulogil@ua.pt
-- Mini-Projecto
-- LSD-2016
--------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.all;

entity PEnc4_2 is
	port(portIn	: in	std_logic_vector(3 downto 0);
		  portOut: out std_logic_vector(1 downto 0);
		  idle	: out std_logic); --Lógica negativa
end PEnc4_2;

architecture Behavioral of PEnc4_2 is
begin

	portOut <= "11" when (portIn(3) = '1') else
				  "10" when (portIn(3 downto 2) = "01") else
				  "01" when (portIn(3 downto 1) = "001") else
				  "00" when (portIn(3 downto 0) = "0001") else
				  "11";
	
				  
	idle <= '0' when (portIn = "0000") else '1';
	
end Behavioral;
		  