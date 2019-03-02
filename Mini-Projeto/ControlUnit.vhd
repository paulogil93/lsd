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

entity ControlUnit is
	generic(SIZE		:		positive := 16);
	port(clk				: in	std_logic;
		  start			: in	std_logic;
		  reset			: in	std_logic;
		  validTime		: in	std_logic;
		  continue		: in	std_logic;
		  rstSignal		: out std_logic;
		  startSignal	: out std_logic;
		  calcEnable	: out std_logic;
		  writeAddress	: out std_logic_vector(3 downto 0);
		  count			: out std_logic_vector(3 downto 0));
end ControlUnit;

architecture Behavioral of ControlUnit is

	type TState is (RST, CLEAR, HOLD, M1, M2, M3, M4, M5, DISPLAY);
	signal PState, NState: TState;
	signal s_clear: std_logic;
	signal s_count: unsigned(3 downto 0) := "0000";
	signal s_address: unsigned(3 downto 0);
	signal s_value: std_logic_vector((SIZE-1) downto 0);
	
	
begin
	
	sync_proc: process(clk)
	begin
		if(rising_edge(clk)) then
			if(reset = '1') then
				PState <= RST;
			else
				PState <= NState;
			end if;
		end if;
	end process;
	
	comb_proc: process(PState, validTime, start, continue)
	begin
		calcEnable <= '0';
		s_clear <= '0';
		
		case PState is
			when RST =>
				s_count <= "0000";
				s_address <= "0000";
				s_clear <= '1';
				startSignal <= '0';
				NState <= HOLD;
			
			when CLEAR =>
				s_clear <= '1';
				NState <= HOLD;
				
			when HOLD =>
				startSignal <= '0';
				s_clear <= '0';
				
				if(s_count = "0101") then
					NState <= DISPLAY;
				elsif(start = '1') then
					startSignal <= '1';
					if(s_count = "0000") then
						NState <= M1;
						s_address <= s_count;
					elsif(s_count = "0001") then
						NState <= M2;
						s_address <= s_count;
					elsif(s_count = "0010") then
						NState <= M3;
						s_address <= s_count;
					elsif(s_count = "0011") then
						NState <= M4;
						s_address <= s_count;
					elsif(s_count = "0100") then
						NState <= M5;
						s_address <= s_count;
					end if;
				else
					NState <= HOLD;
				end if;

			when M1 =>
				startSignal <= '0';
				if(continue = '1' and validTime = '1') then
					if(s_count = "0000") then
						s_count <= "0001";
					end if;
					NState <= CLEAR;
				elsif(continue = '1' and validTime = '0') then
					NState <= CLEAR;
				else
					NState <= M1;
				end if;
			
			when M2 =>
				startSignal <= '0';
				if(continue = '1' and validTime = '1') then
					if(s_count = "0001") then
						s_count <= "0010";
					end if;
					NState <= CLEAR;
				elsif(continue = '1' and validTime = '0') then
					NState <= CLEAR;
				else
					NState <= M2;
				end if;
			
			when M3 =>
				startSignal <= '0';
				if(continue = '1' and validTime = '1') then
					if(s_count = "0010") then
						s_count <= "0011";
					end if;
					NState <= CLEAR;
				elsif(continue = '1' and validTime = '0') then
					NState <= CLEAR;
				else
					NState <= M3;
				end if;
				
			when M4 =>
				startSignal <= '0';
				if(continue = '1' and validTime = '1') then
					if(s_count = "0011") then
						s_count <= "0100";
					end if;
					NState <= CLEAR;
				elsif(continue = '1' and validTime = '0') then
					NState <= CLEAR;
				else
					NState <= M4;
				end if;
			
			when M5 =>
				startSignal <= '0';
				if(continue = '1' and validTime = '1') then
					if(s_count = "0100") then
						s_count <= "0101";
					end if;
					NState <= CLEAR;
				elsif(continue = '1' and validTime = '0') then
					NState <= CLEAR;
				else
					NState <= M5;
				end if;
				
			when DISPLAY =>
				calcEnable <= '1';
				if(start = '1') then
					NState <= HOLD;
				else
					NState <= DISPLAY;
				end if;
				
			when others =>
				NState <= RST;
		
		end case;
	end process;
	
	rstSignal <= s_clear;
	count <= std_logic_vector(s_count);
	writeAddress <= std_logic_vector(s_address);
end Behavioral;
				