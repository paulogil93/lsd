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

entity RandValidator is
	generic(startIndex		: positive := 1000;
			  endIndex			: positive := 10000;
			  n_bits				: positive := 16);
	port(randIn			: in	std_logic_vector((n_bits-1) downto 0);
		  reset			: in	std_logic;
		  randOut		: out std_logic_vector((n_bits-1) downto 0);
		  validRand		: out std_logic);
end RandValidator;

architecture Behavioral of RandValidator is

	signal s_rand: unsigned((n_bits-1) downto 0);

begin
	s_rand <= unsigned(randIn);

	process(s_rand)
	begin
		if(reset = '1') then
			randOut <= (others => '0');
			validRand <= '0';
		elsif(s_rand >= startIndex and s_rand <= endIndex) then
			validRand <= '1';
			randOut <= std_logic_vector(s_rand);
		else
			validRand <= '0';
			randOut <= (others => '0');
		end if;
	end process;
	
end Behavioral;