library IEEE;
use IEEE.STD_LOGIC_1164.all;

entity RAM_1P_16_8_Tb is
end RAM_1P_16_8_Tb;

architecture Stimulus of RAM_1P_16_8_Tb is
	signal s_clk		: std_logic;
	signal s_wrEnable : std_logic;
	signal s_wrData	: std_logic_vector(7 downto 0);
	signal s_address	: std_logic_vector(3 downto 0);
	signal s_readData : std_logic_vector(7 downto 0);
	
begin
	
	uut: entity work.RAM_1P_16_8(Behavioral)
		port map(clk		=> s_clk,
					wrEnable => s_wrEnable,
					wrData	=> s_wrData,
					address	=> s_address,
					readData => s_readData);
	
	clk_proc: process
	begin
		s_clk <= '0';
		wait for 20 ns;
		s_clk <= '1';
		wait for 20 ns;
	end process;
	
	stim_proc: process
	begin
		s_wrEnable <= '0';
		s_wrdata <= x"AA";
		s_address <= "0100";
		wait for 100 ns;
		
		s_wrEnable <= '1';
		wait for 100 ns;
		
		s_wrEnable <= '0';
		wait for 100 ns;
		
		s_address <= "1111";
		wait for 100 ns;
		
		s_address <= "0110";
		s_wrEnable <= '1';
		wait for 100 ns;
		
		s_wrEnable <= '0';
		wait for 100 ns;
		
		s_address <= "1110";
		wait for 100 ns;
		
		s_address <= "0111";
		wait for 100 ns;
		
		s_address <= "1001";
		s_wrdata <= x"FF";
		s_wrEnable <= '1';
		wait for 100 ns;
		
		s_wrEnable <= '0';
		wait for 100 ns;
		
		s_address <= "0011";
		wait for 100 ns;
		
		s_address <= "0001";
		wait for 100 ns;
		
	end process;
end Stimulus;
	
	