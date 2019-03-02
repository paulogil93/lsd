--------------------------------------------
-- Paulo Gil
-- paulogil@ua.pt
-- LSD-2016
--------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.all;

entity NOTGate is
	port(portIn : in std_logic;
		  port_out : out std_logic);
end NOTGate;

architecture Behavioral of NOTGate is
begin
		port_out <= not portIn;
end Behavioral;