
`timescale 1 ns / 100 fs

module sys_pll (
  refclk,
  reset,
  lock,
  clk0_out,
  clk1_out 
);

  input refclk;
  input reset;
  output lock;
  output clk0_out;
  output clk1_out;

  wire clk0_buf;

  PH1_LOGIC_BUFG bufg_feedback (
    .i(clk0_buf),
    .o(clk0_out) 
  );

  PH1_PHY_PLL #(
    .DYN_PHASE_PATH_SEL("DISABLE"),
    .DYN_FPHASE_EN("DISABLE"),
    .MPHASE_ENABLE("DISABLE"),
    .FIN("125.000"),
    .FEEDBK_MODE("NORMAL"),
    .FBKCLK("CLKC0_EXT"),
    .PLL_FEED_TYPE("EXTERNAL"),
    .PLL_USR_RST("ENABLE"),
    .GMC_GAIN(3),
    .ICP_CUR(13),
    .LPF_CAP(2),
    .LPF_RES(1),
    .REFCLK_DIV(1),
    .FBCLK_DIV(1),
    .CLKC0_ENABLE("ENABLE"),
    .CLKC0_DIV(8),
    .CLKC0_CPHASE(7),
    .CLKC0_FPHASE(0),
    .CLKC0_FPHASE_RSTSEL(0),
    .CLKC0_DUTY_INT(4),
    .CLKC0_DUTY50("ENABLE"),
    .CLKC1_ENABLE("ENABLE"),
    .CLKC1_DIV(8),
    .CLKC1_CPHASE(7),
    .CLKC1_FPHASE(0),
    .CLKC1_FPHASE_RSTSEL(0),
    .CLKC1_DUTY_INT(4),
    .CLKC1_DUTY50("ENABLE"),
    .INTPI(0),
    .HIGH_SPEED_EN("DISABLE"),
    .SSC_ENABLE("DISABLE"),
    .SSC_MODE("CENTER"),
    .SSC_AMP(0.0000),
    .SSC_FREQ_DIV(0),
    .SSC_RNGE(0),
    .FRAC_ENABLE("DISABLE"),
    .DITHER_ENABLE("DISABLE"),
    .SDM_FRAC(0) 
  ) pll_inst (
    .refclk(refclk),
    .pllreset(reset),
    .lock(lock),
    .pllpd(1'b0),
    .refclk_rst(1'b0),
    .wakeup(1'b0),
    .psclk(1'b0),
    .psdown(1'b0),
    .psstep(1'b0),
    .psclksel(3'b000),
    .psdone(open),
    .cps_step(2'b00),
    .drp_clk(1'b0),
    .drp_rstn(1'b1),
    .drp_sel(1'b0),
    .drp_rd(1'b0),
    .drp_wr(1'b0),
    .drp_addr(8'b00000000),
    .drp_wdata(8'b00000000),
    .drp_err(open),
    .drp_rdy(open),
    .drp_rdata({open, open, open, open, open, open, open, open}),
    .fbclk(clk0_out),
    .clkc({open, open, open, open, open, open, clk1_out, clk0_buf}),
    .clkcb({open, open, open, open, open, open, open, open}),
    .clkc_en({8'b00000011}),
    .clkc_rst(2'b00),
    .ext_freq_mod_clk(1'b0),
    .ext_freq_mod_en(1'b0),
    .ext_freq_mod_val(17'b00000000000000000),
    .ssc_en(1'b0) 
  );

endmodule

