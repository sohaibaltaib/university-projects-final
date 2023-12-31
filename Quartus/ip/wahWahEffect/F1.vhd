-- -------------------------------------------------------------
-- 
-- File Name: hdl_prj\hdlsrc\wahWahEffect\F1.vhd
-- Created: 2023-04-17 20:14:47
-- 
-- Generated by MATLAB 9.13 and HDL Coder 4.0
-- 
-- -------------------------------------------------------------


-- -------------------------------------------------------------
-- 
-- Module: F1
-- Source Path: wahWahEffect/wahWahEffectSystem/stateVariableFilter/F1
-- Hierarchy Level: 2
-- 
-- -------------------------------------------------------------
LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
USE IEEE.numeric_std.ALL;

ENTITY F1 IS
  PORT( clk                               :   IN    std_logic;
        reset                             :   IN    std_logic;
        enb                               :   IN    std_logic;
        fc                                :   IN    std_logic_vector(33 DOWNTO 0);  -- sfix34_En16
        f1_1                              :   OUT   std_logic_vector(68 DOWNTO 0)  -- sfix69_En48
        );
END F1;


ARCHITECTURE rtl OF F1 IS

  -- Component Declarations
  COMPONENT Sine_HDL_Optimized
    PORT( clk                             :   IN    std_logic;
          reset                           :   IN    std_logic;
          enb                             :   IN    std_logic;
          u                               :   IN    std_logic_vector(65 DOWNTO 0);  -- sfix66_En48
          x                               :   OUT   std_logic_vector(66 DOWNTO 0)  -- sfix67_En48
          );
  END COMPONENT;

  -- Signals
  SIGNAL fc_signed                        : signed(33 DOWNTO 0);  -- sfix34_En16
  SIGNAL Constant_out1                    : unsigned(31 DOWNTO 0);  -- ufix32_En32
  SIGNAL Product1_cast                    : signed(32 DOWNTO 0);  -- sfix33_En32
  SIGNAL Product1_mul_temp                : signed(66 DOWNTO 0);  -- sfix67_En48
  SIGNAL Product1_out1                    : signed(65 DOWNTO 0);  -- sfix66_En48
  SIGNAL Sine                             : std_logic_vector(66 DOWNTO 0);  -- ufix67
  SIGNAL Sine_signed                      : signed(66 DOWNTO 0);  -- sfix67_En48
  SIGNAL Constant1_out1                   : unsigned(1 DOWNTO 0);  -- ufix2
  SIGNAL Product_cast                     : signed(2 DOWNTO 0);  -- sfix3
  SIGNAL Product_mul_temp                 : signed(69 DOWNTO 0);  -- sfix70_En48
  SIGNAL Product_out1                     : signed(68 DOWNTO 0);  -- sfix69_En48

  ATTRIBUTE multstyle : string;

BEGIN
  -- 				
  -- 
  -- 
  -- 			    Tuning Coefficient F1
  -- 
  -- 				F1 = 2sin(π*fc/fs) 

  u_Sine_HDL_Optimized : Sine_HDL_Optimized
    PORT MAP( clk => clk,
              reset => reset,
              enb => enb,
              u => std_logic_vector(Product1_out1),  -- sfix66_En48
              x => Sine  -- sfix67_En48
              );

  fc_signed <= signed(fc);

  Constant_out1 <= to_unsigned(44739, 32);

  Product1_cast <= signed(resize(Constant_out1, 33));
  Product1_mul_temp <= fc_signed * Product1_cast;
  Product1_out1 <= Product1_mul_temp(65 DOWNTO 0);

  Sine_signed <= signed(Sine);

  Constant1_out1 <= to_unsigned(16#2#, 2);

  Product_cast <= signed(resize(Constant1_out1, 3));
  Product_mul_temp <= Sine_signed * Product_cast;
  Product_out1 <= Product_mul_temp(68 DOWNTO 0);

  f1_1 <= std_logic_vector(Product_out1);

END rtl;

