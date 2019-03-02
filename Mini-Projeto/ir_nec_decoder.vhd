--
-- LSD.TOS, May 2014, February 2016
--
-- infrared remote command decoder (NEC protocol)
--
-- the terasIC infrared remote control unit sends the following codes:
--
--  +----------------+----------------+----------------+----------------+
--  | <A>            | <B>            | <C>            | <power>        |
--  | X"F0_0F_6B_86" | X"EC_13_6B_86" | X"EF_10_6B_86" | X"ED_12_6B_86" |
--  +----------------+----------------+----------------+----------------+
--  | <1>            | <2>            | <3>            | <channel up>   |
--  | X"FE_01_6B_86" | X"FD_02_6B_86" | X"FC_03_6B_86" | X"E5_1A_6B_86" |
--  +----------------+----------------+----------------+----------------+
--  | <4>            | <5>            | <6>            | <channel down> |
--  | X"FB_04_6B_86" | X"FA_05_6B_86" | X"F9_06_6B_86" | X"E1_1E_6B_86" |
--  +----------------+----------------+----------------+----------------+
--  | <7>            | <8>            | <9>            | <volume up>    |
--  | X"F8_07_6B_86" | X"F7_08_6B_86" | X"F6_09_6B_86" | X"E4_16_6B_86" |
--  +----------------+----------------+----------------+----------------+
--  | <menu>         | <0>            | <return>       | <volume down>  |
--  | X"EE_11_6B_86" | X"FF_00_6B_86" | X"E8_17_6B_86" | X"E0_1F_6B_86" |
--  +----------------+----------------+----------------+----------------+
--  | <play>         | <adjust left>  | <adjust right> | <mute>         |
--  | X"E9_16_6B_86" | X"EB_14_6B_86" | X"E7_18_6B_86" | X"F3_0C_6B_86" |
--  +----------------+----------------+----------------+----------------+
--
-- NEC format --- 8+8(inverted) custom code bits + 8+8(inverted) data code bits
--            --- 107.9ms between transmissions
--   idle ------- high (!!! logic levels for the DE2-115 board !!!)
--   start ------ 8.99ms low followed by 4.64ms high
--   0 bit ------ 0.56ms low followed by 0.60ms high
--   1 bit ------ 0.56ms low followed by 1.76ms high
--   repeat ----- 8.99ms low followed by 2.32ms high followed by 0.60ms low [NOT DECODED]
--

library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.NUMERIC_STD.all;

entity ir_nec_decoder is
  generic
  (
    clk_freq : real range 1.0e6 to 1.0e9 := 50.0e6 -- the frequency of the clk signal (default is 50 MHz)
  );
  port
  (
    clk   : in  std_logic;                    -- clock
    ir_rx : in  std_logic;                    -- received infrared signal
    valid : out std_logic;                    -- cmd valid pulse (asserted only during one cycle of the clk clock)
    cmd   : out std_logic_vector(31 downto 0) -- decoded command (keeps the last valid value)
                                              --   bit 0 is the first bit received
                                              --   bits  7 downto  0 : address low
                                              --   bits 15 downto  8 : address high
                                              --   bits 23 downto 16 : command
                                              --   bits 31 downto 24 : not command
  );
end ir_nec_decoder;

architecture v1 of ir_nec_decoder is
  --
  -- 10 kHz pulse
  --
  constant max_pulse_cnt : natural := integer(clk_freq/1.0e4)-1; -- maximum value of the pulse_cnt counter
  signal   pulse_cnt     : natural range 0 to max_pulse_cnt;     -- counter used to generate the 10 kHz pulse
  signal   pulse         : std_logic;                            -- 10 kHz pulse (0.1ms period)
  --
  -- state machine
  --
  signal ir_data,last_ir_data         : std_logic;                     -- registered in_rx value, and its previous value
  signal n_bits,new_n_bits,old_n_bits : natural range 0 to 33;         -- number of bits already decoded
  signal data,new_data                : std_logic_vector(31 downto 0); -- decoded data
  signal count,new_count              : natural range 0 to 120;        -- number or 0.1ms pulses with ir_data at the same value
begin
  --
  -- 10 kHz pulse
  --
  pulse <= '1' when pulse_cnt = 0 else '0';
  process(clk) is
  begin
    if rising_edge(clk) then
      if pulse_cnt = max_pulse_cnt then
        pulse_cnt <= 0;
      else
        pulse_cnt <= pulse_cnt+1;
      end if;
    end if;
  end process;
  --
  -- state machine memory
  --   updated every 0.1ms
  --   no need to debounce ir_rx
  --   the counter has a small number of bits
  --
  process(clk,pulse) is
  begin
    if rising_edge(clk) and pulse = '1' then
      ir_data      <= ir_rx; -- pass all external FPGA input signals through registers
      last_ir_data <= ir_data;
      n_bits       <= new_n_bits;
      data         <= new_data;
      count        <= new_count;
    end if;
  end process;
  --
  -- compute next state (combinational logic)
  --
  process(ir_data,last_ir_data,count,n_bits,data) is
  begin
    if ir_data = last_ir_data then
      -- no change of logic level
      if count < 120 then
        -- normal operation (counting the duration of a '0' or a '1' pulse)
        new_n_bits <= n_bits;
        new_data <= data;
        new_count <= count+1;
      else
        -- pulse too long, reset state machine
        new_n_bits <= 0;
        new_data <= (others => '0');
        new_count <= 0;
      end if;
    else
      -- change of logic level
      if (n_bits  = 0 and last_ir_data = '0' and (count < 70 or count > 110)) or   -- start bit,  low state (7.0ms <= T <= 11.0ms)
         (n_bits  = 0 and last_ir_data = '1' and (count < 25 or count >  65)) or   -- start bit, high state (2.5ms <= T <=  6.5ms)
         (n_bits /= 0 and last_ir_data = '0' and (count <  3 or count >  10)) or   -- data  bit,  low state (0.3ms <= T <=  1.0ms)
         (n_bits /= 0 and last_ir_data = '1' and (count <  3 or count >  22)) then -- data  bit, high state (0.3ms <= T <=  2.2ms)
        -- pulse too short or too long, reset state machine
        new_n_bits <= 0;
        new_data <= (others => '0');
        new_count <= 0;
      elsif last_ir_data = '0' then
        -- ok, no information here, just reset counter
        new_n_bits <= n_bits;
        new_data <= data;
        new_count <= 0;
      else
        -- ok, new bit
        new_n_bits <= n_bits+1;
        if count < 12 then
          new_data <= '0' & data(31 downto 1);
        else
          new_data <= '1' & data(31 downto 1);
        end if;
        if n_bits < 32 then
          new_count <= 0;
        else
          new_count <= 120; -- force a state machine reset on the next 10 kHz pulse (the stop bit is ignored)
        end if;
      end if;
    end if;
  end process;
  --
  -- generate output signals (fast clock)
  --
  process(clk) is
  begin
    if rising_edge(clk) then
      old_n_bits <= n_bits;
      if n_bits = 33 and old_n_bits = 32 then
        valid <= '1';
        cmd <= data(31 downto 0);
      else
        valid <= '0';
      end if;
    end if;
  end process;
end v1;
