--------------------------------------------
-- Paulo Gil
-- 76361
-- paulogil@ua.pt
-- Mini-Projecto
-- LSD-2016
--------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.all;

entity OPto7Seg is
	port(opIN	: in	std_logic_vector(1 downto 0);
		  opOUT	: out std_logic_vector(3 downto 0));
end OPto7Seg;

architecture Behavioral of OPto7Seg is
begin

	opOUT <= "11" & opIN;
	
end Behavioral;