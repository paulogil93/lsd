--------------------------------------------
-- Paulo Gil
-- paulogil@ua.pt
-- LSD-2016
--------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.all;

entity FullAdder is
	port(a,b,Cin : in  std_logic;
		  s, Cout : out std_logic);
end FullAdder;

architecture Behavioral of FullAdder is
begin
	
	s <= (a xor b) xor Cin;
	Cout <= (a and b) or ((a xor b) and Cin);
	
end Behavioral;