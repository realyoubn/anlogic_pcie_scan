--------------------------------------------------------------
 --     Copyright (c) 2012-2023 Anlogic Inc.
 --  All Right Reserved.
--------------------------------------------------------------
 -- Log	:	This file is generated by Anlogic IP Generator.
 -- File	:	E:/PCIE/scan/mjh_515/PCIE_ANLOGIC_SCAN_515/al_ip/pll2.vhd
 -- Date	:	2024 06 06
 -- TD version	:	5.6.71036
--------------------------------------------------------------

-------------------------------------------------------------------------------
--	Input frequency:             50.000MHz
--	Clock multiplication factor: 2
--	Clock division factor:       1
--	Clock information:
--		Clock name	| Frequency 	| Phase shift
--		C0        	| 100.000000MHZ	| 0  DEG     
--		C1        	| 48.000000 MHZ	| 0  DEG     
-------------------------------------------------------------------------------

LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;
USE ieee.std_logic_unsigned.ALL;
USE ieee.std_logic_arith.ALL;
LIBRARY ph1_macro;
USE ph1_macro.PH1_COMPONENTS.ALL;

ENTITY pll2 IS
  PORT (
    refclk : IN STD_LOGIC;
    reset : IN STD_LOGIC;
    lock : OUT STD_LOGIC;
    clk0_out : OUT STD_LOGIC;
    clk1_out : OUT STD_LOGIC 
  );
END pll2;

ARCHITECTURE rtl OF pll2 IS
  SIGNAL clk0_buf :  STD_LOGIC;
  SIGNAL fbk_wire :  STD_LOGIC;
  SIGNAL clkc_en_wire :  STD_LOGIC_VECTOR (7 DOWNTO 0);
  SIGNAL clkc_wire :  STD_LOGIC_VECTOR (7 DOWNTO 0);
  SIGNAL clkcb_wire :  STD_LOGIC_VECTOR (7 DOWNTO 0);
BEGIN
  bufg_feedback : PH1_LOGIC_BUFG
  PORT MAP (
    i => clk0_buf,
    o => fbk_wire 
  );

  pll_inst : PH1_PHY_PLL
  GENERIC MAP (
    DYN_PHASE_PATH_SEL => "DISABLE",
    DYN_FPHASE_EN => "DISABLE",
    MPHASE_ENABLE => "DISABLE",
    FIN => "50.000",
    FEEDBK_MODE => "NORMAL",
    FBKCLK => "CLKC0_EXT",
    PLL_FEED_TYPE => "EXTERNAL",
    PLL_USR_RST => "ENABLE",
    GMC_GAIN => 2,
    ICP_CUR => 12,
    LPF_CAP => 2,
    LPF_RES => 2,
    REFCLK_DIV => 1,
    FBCLK_DIV => 2,
    CLKC0_ENABLE => "ENABLE",
    CLKC0_DIV => 12,
    CLKC0_CPHASE => 11,
    CLKC0_FPHASE => 0,
    CLKC0_FPHASE_RSTSEL => 0,
    CLKC0_DUTY_INT => 6,
    CLKC0_DUTY50 => "ENABLE",
    CLKC1_ENABLE => "ENABLE",
    CLKC1_DIV => 25,
    CLKC1_CPHASE => 24,
    CLKC1_FPHASE => 0,
    CLKC1_FPHASE_RSTSEL => 0,
    CLKC1_DUTY_INT => 13,
    CLKC1_DUTY50 => "ENABLE",
    INTPI => 1,
    HIGH_SPEED_EN => "DISABLE",
    SSC_ENABLE => "DISABLE",
    SSC_MODE => "CENTER",
    SSC_AMP => 0.0000,
    SSC_FREQ_DIV => 0,
    SSC_RNGE => 0,
    FRAC_ENABLE => "DISABLE",
    DITHER_ENABLE => "DISABLE",
    SDM_FRAC => 0 
  )
  PORT MAP (
    refclk => refclk,
    pllreset => reset,
    lock => lock,
    pllpd => '0',
    refclk_rst => '0',
    wakeup => '0',
    psclk => '0',
    psdown => '0',
    psstep => '0',
    psclksel => b"000",
    cps_step => b"00",
    drp_clk => '0',
    drp_rstn => '1',
    drp_sel => '0',
    drp_rd => '0',
    drp_wr => '0',
    drp_addr => b"00000000",
    drp_wdata => b"00000000",
    fbclk => fbk_wire,
    clkc => clkc_wire,
    clkcb => clkcb_wire,
    clkc_en => clkc_en_wire,
    clkc_rst => b"00",
    ext_freq_mod_clk => '0',
    ext_freq_mod_en => '0',
    ext_freq_mod_val => b"00000000000000000",
    ssc_en => '0' 
  );

  clk0_out <= fbk_wire;
  clkc_en_wire <= b"00000011";
  clk1_out <= clkc_wire(1);
  clk0_buf <= clkc_wire(0);

END rtl;

