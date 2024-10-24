// Verilog netlist created by Tang Dynasty v5.7.64597
// Sat Dec  3 14:52:10 2022

`timescale 1ns / 1ps
module sfifo512x32  // sfifo512x32.v(14)
  (
  clk,
  di,
  re,
  rrst,
  we,
  wrst,
  dout,
  empty_flag,
  fifo_rdpointer,
  fifo_wrpointer,
  full_flag
  );

  input clk;  // sfifo512x32.v(20)
  input [31:0] di;  // sfifo512x32.v(19)
  input re;  // sfifo512x32.v(22)
  input rrst;  // sfifo512x32.v(18)
  input we;  // sfifo512x32.v(21)
  input wrst;  // sfifo512x32.v(17)
  output [31:0] dout;  // sfifo512x32.v(23)
  output empty_flag;  // sfifo512x32.v(24)
  output [8:0] fifo_rdpointer;  // sfifo512x32.v(27)
  output [8:0] fifo_wrpointer;  // sfifo512x32.v(26)
  output full_flag;  // sfifo512x32.v(25)

  wire [13:0] fifo_inst_syn_17;
  wire [13:0] fifo_inst_syn_3;
  wire fifo_inst_syn_31;  // sfifo512x32.v(38)
  wire fifo_inst_syn_32;  // sfifo512x32.v(38)
  wire fifo_inst_syn_33;  // sfifo512x32.v(38)
  wire fifo_inst_syn_34;  // sfifo512x32.v(38)

  PH1_PHY_CONFIG_V2 #(
    .JTAG_PERSISTN("DISABLE"),
    .SPIX4_PERSISTN("ENABLE"))
    config_inst ();
  PH1_PHY_FIFOCTRL #(
    //.MACRO("fifo_inst_syn_1"),
    //.R_POSITION("X0Y0Z0"),
    .FIFO_AE(14'b00110000000000),
    .FIFO_AF(14'b11001111100000),
    .FIFO_ASYNC_RESET_RELEASE("SYNC"),
    .FIFO_DATA_WIDTH("40"),
    .FIFO_FIRSTWRITE_RD("DISABLE"),
    .FIFO_SYNC("SYNC"))
    fifo_inst_syn_1 (
    .fifo_rclk(clk),
    .fifo_re(re),
    .fifo_rrst(rrst),
    .fifo_wclk(clk),
    .fifo_we(we),
    .fifo_wrst(wrst),
    .fifo_empty(empty_flag),
    .fifo_full(full_flag),
    .fifo_ore(fifo_inst_syn_34),
    .fifo_owe(fifo_inst_syn_33),
    .fifo_rdpointer({open_n201,fifo_rdpointer,open_n202,open_n203,open_n204,open_n205,open_n206}),
    .fifo_wrpointer({open_n207,fifo_wrpointer,open_n208,open_n209,open_n210,open_n211,open_n212}),
    .fifoctrl_raddr(fifo_inst_syn_17),
    .fifoctrl_re(fifo_inst_syn_32),
    .fifoctrl_waddr(fifo_inst_syn_3),
    .fifoctrl_we(fifo_inst_syn_31));  // sfifo512x32.v(38)
  PH1_PHY_ERAM #(
    //.MACRO("fifo_inst_syn_1"),
    //.R_POSITION("X0Y0Z0"),
    .CLKMODE("SYNC"),
    .CSA0("1"),
    .CSA1("1"),
    .CSB0("1"),
    .CSB1("1"),
    .DATA_WIDTH_A("40"),
    .DATA_WIDTH_B("40"),
    .ECC_DECODE("DISABLE"),
    .ECC_ENCODE("DISABLE"),
    .FIFOMODE("ENABLE"),
    .HADDRCAS_A("FIFO"),
    .HADDRCAS_B("FIFO"),
    .LADDRCAS_A("FIFO"),
    .LADDRCAS_B("FIFO"),
    .MODE("FIFO20K"),
    .OCEAMUX("1"),
    .OCEBMUX("1"),
    .REGMODE_A("NOREG"),
    .REGMODE_B("NOREG"),
    .RSTAMUX("0"),
    .RSTBMUX("0"),
    .SSROVERCE("DISABLE"),
    .WEAMUX("1"),
    .WEBMUX("0"))
    fifo_inst_syn_2 (
    .clka(clk),
    .clkb(clk),
    .csa({fifo_inst_syn_33,open_n269,open_n270}),
    .csb({fifo_inst_syn_34,open_n271,open_n272}),
    .dia(di[15:0]),
    .dia_extra(di[19:16]),
    .dib({open_n273,open_n274,open_n275,open_n276,di[31:20]}),
    .fifoctrl_raddr(fifo_inst_syn_17),
    .fifoctrl_re(fifo_inst_syn_32),
    .fifoctrl_waddr(fifo_inst_syn_3),
    .fifoctrl_we(fifo_inst_syn_31),
    .doa(dout[15:0]),
    .doa_extra(dout[19:16]),
    .dob({open_n317,open_n318,open_n319,open_n320,dout[31:20]}));  // sfifo512x32.v(38)

  // synthesis translate_off
  glbl glbl();
  always @(*) begin
    glbl.gsr <= PH1_PHY_GSR.gsr;
    glbl.gsrn <= PH1_PHY_GSR.gsrn;
    glbl.done_gwe <= PH1_PHY_GSR.done_gwe;
    glbl.usr_gsrn_en <= PH1_PHY_GSR.usr_gsrn_en;
  end
  // synthesis translate_on

endmodule 

