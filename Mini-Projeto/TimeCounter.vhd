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

entity TimeCounter is
	generic(SIZE	:		positive := 16);
	port(clk			: in	std_logic;
		  enable 	: in	std_logic;
		  reset		: in	std_logic;
		  userInput : in	std_logic;
		  validTime	: out	std_logic;
		  BCDOut		: out std_logic_vector((SIZE-1) downto 0);
		  BinOut		: out std_logic_vector((SIZE-1) downto 0));
end TimeCounter;

architecture Behavioral of TimeCounter is
	
	signal s_bin		: unsigned((SIZE-1) downto 0) := (others => '0');
	signal s_stop		: std_logic := '0';
	signal s_valid		: std_logic := '0';
	signal x, y, w, z	: unsigned(3 downto 0) := "0000";
	signal s_bcd		: unsigned(15 downto 0);
	
begin
	
	process(clk, userInput)
	begin
		if(reset = '1') then
			x <= (others => '0');
			y <= (others => '0');
			w <= (others => '0');
			z <= (others => '0');
			s_bin <= (others => '0');
			s_stop <= '0';
			s_valid <= '0';
		elsif(userInput = '1') then
			if(enable = '1' and s_stop = '0') then
				s_valid <= '1';
				s_stop <= '1';
			elsif(enable = '0' and s_stop = '0') then
				s_valid <= '0';
				s_stop <= '1';
			end if;
		elsif(enable = '1') then
			if(s_stop = '0') then
				if(rising_edge(clk)) then
					s_bin <= s_bin + 1;
					if(x < "1001") then
						x <= x + 1;
					elsif(x = "1001") then
						x <= "0000";
						if(y < "1001") then
							y <= y + 1;
						elsif(y = "1001") then
							y <= "0000";
							if(w < "1001") then
								w <= w + 1;
							elsif(w = "1001") then
								w <= "0000";
								if(z < "0001") then
									z <= z + 1;
								elsif(z = "0001") then
									z <= "0010";
									s_stop <= '1';
									s_valid <= '0';
								end if;
							end if;
						end if;
					end if;
				end if;
			end if;
		end if;
	end process;
	
	s_bcd(15 downto 12) <= z;
	s_bcd(11 downto 8) <= w;
	s_bcd(7 downto 4) <= y;
	s_bcd(3 downto 0) <= x;
	BCDOut <= std_logic_vector(s_bcd);
	BinOut <= std_logic_vector(s_bin);
	validTime <= std_logic(s_valid);
	
end Behavioral;