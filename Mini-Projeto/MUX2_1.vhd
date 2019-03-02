--------------------------------------------
-- Paulo Gil
-- 76361
-- paulogil@ua.pt
-- Mini-Projecto
-- LSD-2016
--------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.all;

entity MUX2_1 is
	port(input0 : in	std_logic;
		  input1 : in  std_logic;
		  sel		: in  std_logic;
		  muxOut	: out std_logic);
end MUX2_1;

architecture Behavioral of MUX2_1 is
begin

	muxOut <= input0 when (sel = '0') else
				 input1 when (sel = '1');

end Behavioral;