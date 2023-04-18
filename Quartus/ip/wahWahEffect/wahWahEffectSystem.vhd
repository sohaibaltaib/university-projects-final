-- -------------------------------------------------------------
-- 
-- File Name: hdl_prj\hdlsrc\wahWahEffect\wahWahEffectSystem.vhd
-- Created: 2023-04-17 20:14:47
-- 
-- Generated by MATLAB 9.13 and HDL Coder 4.0
-- 
-- 
-- -------------------------------------------------------------
-- Rate and Clocking Details
-- -------------------------------------------------------------
-- Model base rate: 1.01725e-08
-- Target subsystem base rate: 1.01725e-08
-- Explicit user oversample request: 2048x
-- 
-- 
-- Clock Enable  Sample Time
-- -------------------------------------------------------------
-- ce_out        2.08333e-05
-- -------------------------------------------------------------
-- 
-- 
-- Output Signal                 Clock Enable  Sample Time
-- -------------------------------------------------------------
-- audioOut                      ce_out        2.08333e-05
-- -------------------------------------------------------------
-- 
-- -------------------------------------------------------------


-- -------------------------------------------------------------
-- 
-- Module: wahWahEffectSystem
-- Source Path: wahWahEffect/wahWahEffectSystem
-- Hierarchy Level: 0
-- 
-- -------------------------------------------------------------
LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
USE IEEE.numeric_std.ALL;

ENTITY wahWahEffectSystem IS
  PORT( clk                               :   IN    std_logic;
        reset                             :   IN    std_logic;
        clk_enable                        :   IN    std_logic;
        audioIn                           :   IN    std_logic_vector(23 DOWNTO 0);  -- sfix24_En23
        enable                            :   IN    std_logic;  -- ufix1
        volume                            :   IN    std_logic_vector(15 DOWNTO 0);  -- ufix16_En16
        damp                              :   IN    std_logic_vector(15 DOWNTO 0);  -- ufix16_En16
        minf                              :   IN    std_logic_vector(15 DOWNTO 0);  -- uint16
        maxf                              :   IN    std_logic_vector(15 DOWNTO 0);  -- uint16
        delta                             :   IN    std_logic_vector(15 DOWNTO 0);  -- ufix16_En16
        wetDry                            :   IN    std_logic_vector(15 DOWNTO 0);  -- ufix16_En16
        ce_out                            :   OUT   std_logic;
        audioOut                          :   OUT   std_logic_vector(23 DOWNTO 0)  -- sfix24_En23
        );
END wahWahEffectSystem;


ARCHITECTURE rtl OF wahWahEffectSystem IS

  ATTRIBUTE multstyle : string;

  -- Component Declarations
  COMPONENT wahWahEffectSystem_tc
    PORT( clk                             :   IN    std_logic;
          reset                           :   IN    std_logic;
          clk_enable                      :   IN    std_logic;
          enb                             :   OUT   std_logic;
          enb_1_2048_0                    :   OUT   std_logic;
          enb_1_2048_1                    :   OUT   std_logic
          );
  END COMPONENT;

  COMPONENT stateVariableFilter
    PORT( clk                             :   IN    std_logic;
          reset                           :   IN    std_logic;
          enb                             :   IN    std_logic;
          enb_1_2048_1                    :   IN    std_logic;
          enb_1_2048_0                    :   IN    std_logic;
          audioIn                         :   IN    std_logic_vector(23 DOWNTO 0);  -- sfix24_En23
          damp                            :   IN    std_logic_vector(15 DOWNTO 0);  -- ufix16_En16
          minf                            :   IN    std_logic_vector(15 DOWNTO 0);  -- uint16
          maxf                            :   IN    std_logic_vector(15 DOWNTO 0);  -- uint16
          delta                           :   IN    std_logic_vector(15 DOWNTO 0);  -- ufix16_En16
          yb                              :   OUT   std_logic_vector(69 DOWNTO 0)  -- sfix70_En48
          );
  END COMPONENT;

  COMPONENT wetDryMixer
    PORT( clk                             :   IN    std_logic;
          reset                           :   IN    std_logic;
          enb                             :   IN    std_logic;
          dryAudio                        :   IN    std_logic_vector(23 DOWNTO 0);  -- sfix24_En23
          wetAudio                        :   IN    std_logic_vector(23 DOWNTO 0);  -- sfix24_En23
          wetDryMix                       :   IN    std_logic_vector(15 DOWNTO 0);  -- ufix16_En16
          audioOut                        :   OUT   std_logic_vector(42 DOWNTO 0);  -- sfix43_En39
          dryOut                          :   OUT   std_logic_vector(23 DOWNTO 0)  -- sfix24_En23
          );
  END COMPONENT;

  -- Signals
  SIGNAL enb                              : std_logic;
  SIGNAL enb_1_2048_1                     : std_logic;
  SIGNAL enb_1_2048_0                     : std_logic;
  SIGNAL enable_1                         : std_logic;  -- ufix1
  SIGNAL stateVariableFilter_out1         : std_logic_vector(69 DOWNTO 0);  -- ufix70
  SIGNAL stateVariableFilter_out1_signed  : signed(69 DOWNTO 0);  -- sfix70_En48
  SIGNAL audioIn_1                        : std_logic_vector(23 DOWNTO 0);  -- ufix24
  SIGNAL Constant_out1                    : unsigned(15 DOWNTO 0);  -- ufix16_En16
  SIGNAL Product_cast                     : signed(16 DOWNTO 0);  -- sfix17_En16
  SIGNAL Product_mul_temp                 : signed(86 DOWNTO 0);  -- sfix87_En64
  SIGNAL Product_cast_1                   : signed(85 DOWNTO 0);  -- sfix86_En64
  SIGNAL Product_out1                     : signed(23 DOWNTO 0);  -- sfix24_En23
  SIGNAL wetDry_1                         : std_logic_vector(15 DOWNTO 0);  -- ufix16
  SIGNAL wetDryMixer_out1                 : std_logic_vector(42 DOWNTO 0);  -- ufix43
  SIGNAL wetDryMixer_out2                 : std_logic_vector(23 DOWNTO 0);  -- ufix24
  SIGNAL wetDryMixer_out2_signed          : signed(23 DOWNTO 0);  -- sfix24_En23
  SIGNAL enable_2                         : std_logic;  -- ufix1
  SIGNAL wetDryMixer_out2_1               : signed(23 DOWNTO 0);  -- sfix24_En23
  SIGNAL wetDryMixer_out2_dtc             : signed(42 DOWNTO 0);  -- sfix43_En39
  SIGNAL wetDryMixer_out1_signed          : signed(42 DOWNTO 0);  -- sfix43_En39
  SIGNAL Switch1_out1                     : signed(42 DOWNTO 0);  -- sfix43_En39
  SIGNAL volume_1                         : unsigned(15 DOWNTO 0);  -- ufix16_En16
  SIGNAL volume_2                         : unsigned(15 DOWNTO 0);  -- ufix16_En16
  SIGNAL Product1_cast                    : signed(16 DOWNTO 0);  -- sfix17_En16
  SIGNAL Product1_mul_temp                : signed(59 DOWNTO 0);  -- sfix60_En55
  SIGNAL Product1_cast_1                  : signed(58 DOWNTO 0);  -- sfix59_En55
  SIGNAL Product1_out1                    : signed(23 DOWNTO 0);  -- sfix24_En23
  SIGNAL t_bypass_reg                     : signed(23 DOWNTO 0);  -- sfix24
  SIGNAL Product1_out1_1                  : signed(23 DOWNTO 0);  -- sfix24_En23

BEGIN
  u_wahWahEffectSystem_tc : wahWahEffectSystem_tc
    PORT MAP( clk => clk,
              reset => reset,
              clk_enable => clk_enable,
              enb => enb,
              enb_1_2048_0 => enb_1_2048_0,
              enb_1_2048_1 => enb_1_2048_1
              );

  u_stateVariableFilter : stateVariableFilter
    PORT MAP( clk => clk,
              reset => reset,
              enb => enb,
              enb_1_2048_1 => enb_1_2048_1,
              enb_1_2048_0 => enb_1_2048_0,
              audioIn => audioIn,  -- sfix24_En23
              damp => damp,  -- ufix16_En16
              minf => minf,  -- uint16
              maxf => maxf,  -- uint16
              delta => delta,  -- ufix16_En16
              yb => stateVariableFilter_out1  -- sfix70_En48
              );

  u_wetDryMixer : wetDryMixer
    PORT MAP( clk => clk,
              reset => reset,
              enb => enb,
              dryAudio => audioIn_1,  -- sfix24_En23
              wetAudio => std_logic_vector(Product_out1),  -- sfix24_En23
              wetDryMix => wetDry_1,  -- ufix16_En16
              audioOut => wetDryMixer_out1,  -- sfix43_En39
              dryOut => wetDryMixer_out2  -- sfix24_En23
              );

  enable_1 <= enable;

  stateVariableFilter_out1_signed <= signed(stateVariableFilter_out1);

  audioIn_1 <= std_logic_vector(signed(audioIn));

  Constant_out1 <= to_unsigned(16#4CCD#, 16);

  Product_cast <= signed(resize(Constant_out1, 17));
  Product_mul_temp <= stateVariableFilter_out1_signed * Product_cast;
  Product_cast_1 <= Product_mul_temp(85 DOWNTO 0);
  Product_out1 <= Product_cast_1(64 DOWNTO 41);

  wetDry_1 <= std_logic_vector(unsigned(wetDry));

  wetDryMixer_out2_signed <= signed(wetDryMixer_out2);

  delayMatch_process : PROCESS (clk, reset)
  BEGIN
    IF reset = '1' THEN
      enable_2 <= '0';
    ELSIF clk'EVENT AND clk = '1' THEN
      IF enb = '1' THEN
        enable_2 <= enable_1;
      END IF;
    END IF;
  END PROCESS delayMatch_process;


  delayMatch1_process : PROCESS (clk, reset)
  BEGIN
    IF reset = '1' THEN
      wetDryMixer_out2_1 <= to_signed(16#000000#, 24);
    ELSIF clk'EVENT AND clk = '1' THEN
      IF enb = '1' THEN
        wetDryMixer_out2_1 <= wetDryMixer_out2_signed;
      END IF;
    END IF;
  END PROCESS delayMatch1_process;


  wetDryMixer_out2_dtc <= resize(wetDryMixer_out2_1 & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0', 43);

  wetDryMixer_out1_signed <= signed(wetDryMixer_out1);

  
  Switch1_out1 <= wetDryMixer_out2_dtc WHEN enable_2 = '0' ELSE
      wetDryMixer_out1_signed;

  volume_1 <= unsigned(volume);

  delayMatch2_process : PROCESS (clk, reset)
  BEGIN
    IF reset = '1' THEN
      volume_2 <= to_unsigned(16#0000#, 16);
    ELSIF clk'EVENT AND clk = '1' THEN
      IF enb = '1' THEN
        volume_2 <= volume_1;
      END IF;
    END IF;
  END PROCESS delayMatch2_process;


  Product1_cast <= signed(resize(volume_2, 17));
  Product1_mul_temp <= Switch1_out1 * Product1_cast;
  Product1_cast_1 <= Product1_mul_temp(58 DOWNTO 0);
  Product1_out1 <= Product1_cast_1(55 DOWNTO 32);

  t_bypass_process : PROCESS (clk, reset)
  BEGIN
    IF reset = '1' THEN
      t_bypass_reg <= to_signed(16#000000#, 24);
    ELSIF clk'EVENT AND clk = '1' THEN
      IF enb_1_2048_1 = '1' THEN
        t_bypass_reg <= Product1_out1;
      END IF;
    END IF;
  END PROCESS t_bypass_process;

  
  Product1_out1_1 <= Product1_out1 WHEN enb_1_2048_1 = '1' ELSE
      t_bypass_reg;

  audioOut <= std_logic_vector(Product1_out1_1);

  ce_out <= enb_1_2048_1;

END rtl;
