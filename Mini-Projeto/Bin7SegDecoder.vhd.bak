--------------------------------------------
-- Paulo Gil - 76361 - paulogil@ua.pt
-- Rui Pires - 76319 - aprm@ua.pt
-- Micro-Projeto-LSD-2016
--------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.all;

entity Bin7SegDecoder is
	port(enable		:	in		std_logic;
		  binInput	:	in		std_logic_vector(3 downto 0);
		  decOutput	:	out	std_logic_vector(6 downto 0));
end Bin7SegDecoder;

architecture Behavioral of Bin7SegDecoder is
begin

	decOutput <= "1000000" when (binInput = "0000" and enable = '0') else	--0
					 "1111001" when (binInput = "0001" and enable = '0') else	--1
					 "0100100" when (binInput = "0010" and enable = '0') else	--2
					 "0110000" when (binInput = "0011" and enable = '0') else	--3
					 "0011001" when (binInput = "0100" and enable = '0') else	--4
					 "0010010" when (binInput = "0101" and enable = '0') else	--5
					 "0000010" when (binInput = "0110" and enable = '0') else	--6
					 "1111000" when (binInput = "0111" and enable = '0') else	--7
					 "0000000" when (binInput = "1000" and enable = '0') else	--8
					 "0010000" when (binInput = "1001" and enable = '0') else	--9
					 --Como os valores acima correspondem ao código BCD, foi decidido
					 --alterar o exercicio feito no guião2, para podermos formar a 
					 --palavra FULL nos displays, bem como o código necessário para
					 --apagar os displays
					 "0001110" when (binInput = "1010" and enable = '0') else	--F
					 "1000001" when (binInput = "1011" and enable = '0') else	--U
					 "1000111" when (binInput = "1100" and enable = '0') else	--L
					 "1111111" when (binInput = "1111" and enable = '0') else	--OFF
					 "1111111";																	--OFF

end Behavioral;