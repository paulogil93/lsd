--------------------------------------------
-- Paulo Gil
-- 76361
-- paulogil@ua.pt
-- Mini-Projecto
-- LSD-2016
--------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.all;

entity RandGenerator is
	generic(START_INDEX	:		positive := 1000;  --Tempo em milisegundos
			  END_INDEX		:		positive := 10000;
			  SIZE			: 		positive := 16);	 
		port(clkIn			: in	std_logic;
			  start			: in	std_logic;
			  reset			: in	std_logic;
			  enable			: in	std_logic;
			  randomOut 	: out std_logic_vector((SIZE-1) downto 0);
			  validRandom	: out std_logic);
end RandGenerator;

architecture Structural of RandGenerator is

	signal s_random		: std_logic_vector((SIZE-1) downto 0);
	signal s_valid			: std_logic := '0';
	signal s_input0		: std_logic;
	signal s_requestRand	: std_logic := '0'; 
	signal s_mux			: std_logic := '0';
	signal s_start			: std_logic;
	signal s_reset			: std_logic;

begin

	process(reset, start)
	begin
		if(reset = '1') then
			s_start <= '0';
			s_reset <= '1';
		elsif(start = '1') then
			s_start <= '1';
			s_reset <= '0';
		end if;
	end process;
		
	s_mux <= start and enable;
	s_input0	<= s_start and (not s_valid);

	mux: entity work.MUX2_1(Behavioral)
			port map(input0 => s_input0,
						input1 => s_mux,
						sel	 => s_mux,
						muxOut => s_requestRand);

	generator: entity work.pseudo_random_generator(v1)
		generic map(n_bits => SIZE,
						version => 0,
						seed => X"1357_0246_FEDC_89AB")
			port map(clk => clkIn,
						enable => s_requestRand,
						rnd => s_random);
	
	validator: entity work.RandValidator(Behavioral)
		generic map(startIndex	=> START_INDEX,
						endIndex		=> END_INDEX,
						n_bits		=> SIZE)
			port map(randIn		=> s_random,
						reset			=> s_reset,
						randOut		=> randomOut,
						validRand   => s_valid);
	
	validRandom <= std_logic(s_valid);
	
end Structural;