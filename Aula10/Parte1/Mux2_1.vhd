--------------------------------------------
-- Paulo Gil
-- paulogil@ua.pt
-- LSD-2016
--------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.all;

entity Mux2_1 is
	port(input0	: in	std_logic;
		  input1 : in	std_logic;
		  sel		: in	std_logic;
		  outData: out std_logic);
end Mux2_1;

architecture Behavioral of Mux2_1 is
begin
	outData <= input0 when (sel = '0') else input1;
end Behavioral;