library IEEE;
use IEEE.STD_LOGIC_1164.all;

entity ParityDetector is
	port(clear	: in	std_logic;
		  clk		: in	std_logic;
		  dataIn	: in	std_logic;
		  parityOut	: out	std_logic);
end ParityDetector;

architecture Behavioral of ParityDetector is
	
	type TState is (S0, S1);
	signal pState, nState: TState;
	
begin

	sync_proc: process(clk, clear)
	begin
		if(clear = '1') then
			pState <= S0;
		elsif(rising_edge(clk)) then
			pState <= nState;
		end if;
	end process;
	
	comb_proc: process(pState, dataIn)
	begin
		case pState is
			when S0 =>
				parityOut <= '0';
				if(dataIn = '1') then
					nstate <= S1;
				else
					nState <= S0;
				end if;
			when S1 =>
				parityOut <= '1';
				if(dataIn = '1') then
					nState <= S0;
				else
					nState <= S1;
				end if;
			when others =>
				parityOut <= '0';
				nState <= S0;
		end case;
	end process;
	
end Behavioral;