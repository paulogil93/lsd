--------------------------------------------
-- Paulo Gil
-- paulogil@ua.pt
-- LSD-2016
--------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.all;

entity NAND2Gate is
		port(portIn0 : in std_logic;
			  portIn1 : in std_logic;
			  portOut : out std_logic);
end NAND2Gate;

architecture Structural of NAND2Gate is

	signal s_andOut : std_logic;

begin
	and_gate: entity work.AND2Gate(Behavioral)
			port map(port_in_0 => portIn0,
						port_in_1 => portIn1,
						port_out  => s_andOut);
						
	not_gate: entity work.NOTGate(Behavioral)
			port map(portIn => s_andOut,
						port_out => portOut);
						
end Structural;