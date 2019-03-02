--------------------------------------------
-- Paulo Gil
-- paulogil@ua.pt
-- LSD-2016
--------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.NUMERIC_STD.all;

entity CombShiftUnit is
	port(clk		: in	std_logic;
		  siLeft : in	std_logic;
		  siRight: in	std_logic;
		  loadEn : in	std_logic;
		  rotate : in	std_logic;
		  dirLeft: in	std_logic;
		  shArith: in	std_logic;
		  dataIn	: in	std_logic_vector(7 downto 0);
		  dataOut: out	std_logic_vector(7 downto 0));
end CombShiftUnit;

architecture Behavioral of CombShiftUnit is

	signal s_shiftReg: std_logic_vector(7 downto 0);
	
begin

	process(clk)
	begin
	
	if(falling_edge(clk)) then
		if(loadEn = '1') then
			s_shiftReg <= dataIn;
		elsif(rotate = '1') then
			if(dirLeft = '1') then
				s_shiftReg <= std_logic_vector(ROTATE_LEFT(unsigned(s_shiftReg), 1));
			else
				s_shiftReg <= std_logic_vector(ROTATE_RIGHT(unsigned(s_shiftReg), 1));
			end if;
		elsif(shArith = '1') then
			if(dirLeft = '1') then
				s_shiftReg <= std_logic_vector(SHIFT_LEFT(unsigned(s_shiftReg), 1));
			else
				s_shiftReg <= std_logic_vector(SHIFT_RIGHT(unsigned(s_shiftReg), 1));
			end if;
		end if;
	end if;
	
	end process;
	
	dataOut <= std_logic_vector(s_shiftReg);

end Behavioral;