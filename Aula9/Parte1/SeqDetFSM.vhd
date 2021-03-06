--------------------------------------------
-- Paulo Gil
-- paulogil@ua.pt
-- LSD-2016
--------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.all;

entity SeqDetFSM is
	port(clk		: in	std_logic;
		  reset	: in	std_logic;
		  Xin		: in	std_logic;
		  Yout	: out std_logic);
end SeqDetFSM;

architecture MealyArch of SeqDetFSM is

	type TState is (A, B, C, D);
	signal NS, PS: TState;
	
begin

	sync_proc: process(clk, reset)
	begin
		if(reset = '1') then
			PS <= A;
		elsif(rising_edge(clk)) then
			PS <= NS;
		end if;
	end process;
	
	comb_proc: process(PS, Xin)
	begin
		Yout <= '0';
		
		case PS is
			when A =>
				if(Xin = '1') then NS <= B;
				else NS <= A;
				end if;
			when B =>
				if(Xin = '0') then NS <= C;
				else NS <= A;
				end if;
			when C =>
				if(Xin = '0') then NS <= D;
				else NS <= A;
				end if;
			when D =>
				if(Xin = '1') then
					NS <= B;
					Yout <= '1';
				else
					NS <= A;
				end if;
			when others =>
				NS <= A;
		end case;
		
	end process;
	
end MealyArch;
		