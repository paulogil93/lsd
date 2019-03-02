--------------------------------------------
-- Paulo Gil
-- paulogil@ua.pt
-- LSD-2016
--------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.all;

entity AND2Gate is
	port(port_in_0 : in std_logic;
		  port_in_1 : in std_logic;
		  port_out  : out std_logic);
end AND2Gate;

architecture Behavioral of AND2Gate is
begin
		port_out <= port_in_0 and port_in_1;
end Behavioral;