library IEEE;
use IEEE.STD_LOGIC_1164.all;

entity DisplayDriver is
	port(bcdIn   : in		std_logic_vector(7 downto 0);
		  display0: out	std_logic_vector(3 downto 0);
		  display1: out	std_logic_vector(3 downto 0);
		  display2: out	std_logic_vector(3 downto 0);
		  display3:	out	std_logic_vector(3 downto 0);
		  enableBlink:	out	std_logic);
end DisplayDriver;

architecture Behavioral of DisplayDriver is
begin

	process(bcdIn)
	begin
		if(bcdIn = "00000000") then
			display0 	<= "1100";
			display1 	<= "1100";
			display2 	<= "1011";
			display3 	<= "1010";
			enableBlink	<= '1';
		else
			display0 	<= bcdIn(3 downto 0);
			display1 	<= bcdIn(7 downto 4);
			display2 	<= "1111";
			display3 	<= "1111";
			enableBlink <= '0';
		end if;
	end process;
	
end Behavioral;
	
					
					

		