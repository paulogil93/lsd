--------------------------------------------
-- Paulo Gil
-- 76361
-- paulogil@ua.pt
-- Mini-Projecto
-- LSD-2016
--------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.all;

entity IRDecoder is
	generic(clock_freq: real := 50.0e6);
		port(clk			: in	std_logic;
			  irda		: in	std_logic;		
			  pulse		: out	std_logic;
			  startBtn	: out std_logic;
			  rstBtn		: out std_logic;
			  stopBtn	: out std_logic;
			  contBtn	: out	std_logic);
end IRDecoder;

architecture Structural of IRDecoder is

	constant max_counter : natural := integer(clock_freq); -- maximum value of the counter signal
	signal   counter     : natural range 0 to (max_counter);    -- count down counter used to turn the green led on during 1 second
	signal   valid       : std_logic;                         -- the valid pulse signal
	signal   cmd         : std_logic_vector(31 downto 0);

begin

	process(clk)
	begin
		if(rising_edge(clk)) then
			if(valid = '1' and cmd(31 downto 24) = not cmd(23 downto 16)) then
				counter <= max_counter/4;
			elsif(counter > 0) then
				counter <= counter-1;
			end if;
		end if;
  end process;
  
  decoder: entity work.ir_nec_decoder(v1)
		generic map(clk_freq => clock_freq)
         port map(clk 		=> clk,
						ir_rx 	=> irda,
						valid 	=> valid,
						cmd 		=> cmd);
						
	pulse 	<= '0' when counter = 0 else '1';
	startBtn <= '1' when (cmd = X"F00F6B86" and counter /= 0) else '0'; --A
	rstBtn	<= '1' when (cmd = X"EC136B86" and counter /= 0) else '0'; --B
	stopBtn	<= '1' when (cmd = X"EF106B86" and counter /= 0) else '0'; --C
	contBtn	<= '1' when (cmd = X"ED126B86" and counter /= 0) else '0'; --POWER
						
end Structural;