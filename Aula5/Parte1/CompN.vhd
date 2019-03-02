--------------------------------------------
-- Paulo Gil
-- paulogil@ua.pt
-- LSD-2016
--------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.NUMERIC_STD.all;

entity CompN is
	generic(N		 :     positive := 8);
		port(input0	 : in  std_logic_vector(N-1 downto 0);
			  input1  : in  std_logic_vector(N-1 downto 0);
			  equal	 : out std_logic;
			  notEqual: out std_logic;
			  ltSigned: out std_logic;
			  ltUnsign: out std_logic);
end CompN;

architecture Behavioral of CompN is
begin

	equal    <= '1' when (input0 = input1) else '0';
	notEqual <= '1' when (input0 /= input1) else '0';
	ltSigned <= '1' when (signed(input0) < signed(input1)) else '0';
	ltUnsign <= '1' when (unsigned(input0) < unsigned(input1)) else '0';
	
end Behavioral;