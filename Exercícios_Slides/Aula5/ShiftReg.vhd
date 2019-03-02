library IEEE;
use IEEE.STD_LOGIC_1164.all;

entity ShiftReg is
	port(clk	   : in	std_logic;
		  loadEn : in	std_logic;
		  dirLeft: in	std_logic;
		  dataIn : in	std_logic_vector(7 downto 0);
		  dataOut: out std_logic_vector(7 downto 0));
end ShiftReg;

architecture Behavioral of ShiftReg is

	signal s_ShiftReg: std_logic_vector(7 downto 0);

begin

	process(clk)
	begin
	
		if(rising_edge(clk)) then
			if(loadEn = '1') then
				s_ShiftReg <= dataIn;
			elsif(dirLeft = '1') then
				s_ShiftReg <= s_ShiftReg(6 downto 0) & '0';
			else
				s_ShiftReg <= '0' & s_ShiftReg(7 downto 1);
			end if;
		end if;
	
	end process;
	
	dataOut <= s_ShiftReg;
	
end Behavioral;