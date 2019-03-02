--------------------------------------------
-- Paulo Gil
-- paulogil@ua.pt
-- LSD-2016
--------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.NUMERIC_STD.all;

entity DisplayControl is
	port(BCDin		: in	std_logic_vector(3 downto 0);
		  display0	: out std_logic_vector(3 downto 0);
		  display1	: out	std_logic_vector(3 downto 0);
		  display2	: out std_logic_vector(3 downto 0));
end DisplayControl;

architecture Behavioral of DisplayControl is

	signal s_bcd: unsigned(3 downto 0);
	signal s_units: unsigned(3 downto 0);

begin
	s_bcd <= unsigned(BCDin);
	
	process(s_bcd)
	begin
		if(s_bcd < 10) then
			display0 <= "0000";
			display1 <= std_logic_vector(s_bcd);
			display2 <= "1111";
		else
			display0 <= "0000";
			display2 <= "0001";
			s_units <= s_bcd - 10;
			display1 <= std_logic_vector(s_units);
		end if;
	end process;
	
end Behavioral;