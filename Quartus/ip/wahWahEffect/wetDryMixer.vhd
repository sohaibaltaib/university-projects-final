-- -------------------------------------------------------------
-- 
-- File Name: hdl_prj\hdlsrc\wahWahEffect\wetDryMixer.vhd
-- Created: 2023-04-17 20:14:47
-- 
-- Generated by MATLAB 9.13 and HDL Coder 4.0
-- 
-- -------------------------------------------------------------


-- -------------------------------------------------------------
-- 
-- Module: wetDryMixer
-- Source Path: wahWahEffect/wahWahEffectSystem/wetDryMixer
-- Hierarchy Level: 1
-- 
-- -------------------------------------------------------------
LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
USE IEEE.numeric_std.ALL;

ENTITY wetDryMixer IS
  PORT( clk                               :   IN    std_logic;
        reset                             :   IN    std_logic;
        enb                               :   IN    std_logic;
        dryAudio                          :   IN    std_logic_vector(23 DOWNTO 0);  -- sfix24_En23
        wetAudio                          :   IN    std_logic_vector(23 DOWNTO 0);  -- sfix24_En23
        wetDryMix                         :   IN    std_logic_vector(15 DOWNTO 0);  -- ufix16_En16
        audioOut                          :   OUT   std_logic_vector(42 DOWNTO 0);  -- sfix43_En39
        dryOut                            :   OUT   std_logic_vector(23 DOWNTO 0)  -- sfix24_En23
        );
END wetDryMixer;


ARCHITECTURE rtl OF wetDryMixer IS

  -- Signals
  SIGNAL dryAudio_signed                  : signed(23 DOWNTO 0);  -- sfix24_En23
  SIGNAL Constant_out1                    : std_logic;  -- ufix1
  SIGNAL wetDryMix_unsigned               : unsigned(15 DOWNTO 0);  -- ufix16_En16
  SIGNAL Subtract_sub_cast                : signed(17 DOWNTO 0);  -- sfix18_En16
  SIGNAL Subtract_sub_cast_1              : signed(17 DOWNTO 0);  -- sfix18_En16
  SIGNAL Subtract_out1                    : signed(17 DOWNTO 0);  -- sfix18_En16
  SIGNAL Product1_out1                    : signed(41 DOWNTO 0);  -- sfix42_En39
  SIGNAL wetDryMix_1                      : unsigned(15 DOWNTO 0);  -- ufix16_En16
  SIGNAL Product1_out1_1                  : signed(41 DOWNTO 0);  -- sfix42_En39
  SIGNAL wetAudio_signed                  : signed(23 DOWNTO 0);  -- sfix24_En23
  SIGNAL Product2_cast                    : signed(16 DOWNTO 0);  -- sfix17_En16
  SIGNAL Product2_mul_temp                : signed(40 DOWNTO 0);  -- sfix41_En39
  SIGNAL Product2_out1                    : signed(39 DOWNTO 0);  -- sfix40_En39
  SIGNAL Add1_add_cast                    : signed(42 DOWNTO 0);  -- sfix43_En39
  SIGNAL Add1_add_cast_1                  : signed(42 DOWNTO 0);  -- sfix43_En39
  SIGNAL Add1_out1                        : signed(42 DOWNTO 0);  -- sfix43_En39

  ATTRIBUTE multstyle : string;

BEGIN
  -- wet signal mix
  -- dry signal mix

  dryAudio_signed <= signed(dryAudio);

  Constant_out1 <= '1';

  wetDryMix_unsigned <= unsigned(wetDryMix);

  Subtract_sub_cast <= signed(resize(unsigned'(Constant_out1 & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0'), 18));
  Subtract_sub_cast_1 <= signed(resize(wetDryMix_unsigned, 18));
  Subtract_out1 <= Subtract_sub_cast - Subtract_sub_cast_1;

  Product1_out1 <= dryAudio_signed * Subtract_out1;

  delayMatch_process : PROCESS (clk, reset)
  BEGIN
    IF reset = '1' THEN
      wetDryMix_1 <= to_unsigned(16#0000#, 16);
    ELSIF clk'EVENT AND clk = '1' THEN
      IF enb = '1' THEN
        wetDryMix_1 <= wetDryMix_unsigned;
      END IF;
    END IF;
  END PROCESS delayMatch_process;


  delayMatch1_process : PROCESS (clk, reset)
  BEGIN
    IF reset = '1' THEN
      Product1_out1_1 <= to_signed(0, 42);
    ELSIF clk'EVENT AND clk = '1' THEN
      IF enb = '1' THEN
        Product1_out1_1 <= Product1_out1;
      END IF;
    END IF;
  END PROCESS delayMatch1_process;


  wetAudio_signed <= signed(wetAudio);

  Product2_cast <= signed(resize(wetDryMix_1, 17));
  Product2_mul_temp <= Product2_cast * wetAudio_signed;
  Product2_out1 <= Product2_mul_temp(39 DOWNTO 0);

  Add1_add_cast <= resize(Product1_out1_1, 43);
  Add1_add_cast_1 <= resize(Product2_out1, 43);
  Add1_out1 <= Add1_add_cast + Add1_add_cast_1;

  audioOut <= std_logic_vector(Add1_out1);

  dryOut <= dryAudio;

END rtl;

