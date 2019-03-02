--------------------------------------------
-- Paulo Gil
-- 76361
-- paulogil@ua.pt
-- Mini-Projecto
-- LSD-2016
--------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.NUMERIC_STD.all;

entity Bin2BCD is
	port(bin		: in	std_logic_vector(15 downto 0);
		  bcd		: out	std_logic_vector(15 downto 0));
end Bin2BCD;

architecture Behavioral of Bin2BCD is

	signal s_bin		: integer;
	signal s_thousands: integer;
	signal s_hundreds	: integer;
	signal s_tens		: integer;
	signal s_units		: integer;

begin

	s_bin <= to_integer(unsigned(bin));
	
	s_thousands <= s_bin / 1000;
	s_hundreds	<= (s_bin / 100) mod 10;
	s_tens		<= (s_bin / 10) mod 10;
	s_units		<= s_bin mod 10;
	
	bcd(15 downto 12) <= std_logic_vector(to_unsigned(s_thousands, 4));
	bcd(11 downto 8)  <= std_logic_vector(to_unsigned(s_hundreds, 4));
	bcd(7 downto 4) 	<= std_logic_vector(to_unsigned(s_tens, 4));
	bcd(3 downto 0) <= std_logic_vector(to_unsigned(s_units, 4));

end Behavioral;	