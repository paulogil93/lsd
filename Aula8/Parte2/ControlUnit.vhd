--------------------------------------------
-- Paulo Gil
-- paulogil@ua.pt
-- LSD-2016
--------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.all;

entity ControlUnit is
	port(clk		: in	std_logic;
		  reset	: in	std_logic;
		  Vin		: in	std_logic;
		  Cin		: in	std_logic;
		  drink	: out std_logic);
end ControlUnit;

architecture Behavioral of ControlUnit is

	type TState is (S0, S1, S2, S3, S4, S5);
	signal NState, PState: TState;
	
begin

	sync_proc: process(clk, reset)
	begin
		if(reset = '1') then
			PState <= S0;
		elsif(rising_edge(clk)) then
			PState <= NState;
		end if;
	end process;
	
	comb_proc: process(PState, Vin, Cin)
	begin
		case PState is
			when S0 =>
				drink <= '0';
				if(Vin = '1') then
					NState <= S1;
				elsif(Cin = '1') then
					NState <= S3;
				end if;
			when S1 =>
				drink <= '0';
				if(Vin = '1') then
					NState <= S2;
				elsif(Cin = '1') then
					NState <= S4;
				end if;
			when S2 =>
				drink <= '0';
				if(Vin = '1') then
					NState <= S3;
				elsif(Cin = '1') then
					NState <= S5;
				end if;
			when S3 =>
				drink <= '0';
				if(Vin = '1') then
					NState <= S4;
				elsif(Cin = '1') then
					NState <= S5;
				end if;
			when S4 =>
				drink <= '0';
				if(Vin = '1' or Cin = '1') then
					NState <= S5;
				end if;
			when S5 =>
				drink <= '1';
				NState <= S0;
			when others =>
				NState <= S0;
		end case;
	end process;
end Behavioral;