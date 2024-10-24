// Verilog netlist created by Tang Dynasty v5.7.56276
// Mon Jul 25 11:19:00 2022

`timescale 1ns / 1ps
module sfifo512x128  // sfifo512x128.v(14)
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

  input clk;  // sfifo512x128.v(20)
  input [127:0] di;  // sfifo512x128.v(19)
  input re;  // sfifo512x128.v(22)
  input rrst;  // sfifo512x128.v(18)
  input we;  // sfifo512x128.v(21)
  input wrst;  // sfifo512x128.v(17)
  output [127:0] dout;  // sfifo512x128.v(23)
  output empty_flag;  // sfifo512x128.v(24)
  output [8:0] fifo_rdpointer;  // sfifo512x128.v(27)
  output [8:0] fifo_wrpointer;  // sfifo512x128.v(26)
  output full_flag;  // sfifo512x128.v(25)

  wire [13:0] fifo_inst_syn_17;
  wire [13:0] fifo_inst_syn_3;
  wire [13:0] fifo_inst_syn_37;
  wire [13:0] fifo_inst_syn_51;
  wire [13:0] fifo_inst_syn_66;
  wire [13:0] fifo_inst_syn_80;
  wire fifo_inst_syn_31;  // sfifo512x128.v(38)
  wire fifo_inst_syn_32;  // sfifo512x128.v(38)
  wire fifo_inst_syn_33;  // sfifo512x128.v(38)
  wire fifo_inst_syn_34;  // sfifo512x128.v(38)

  PH1_PHY_CONFIG #(
    .DONE_PERSISTN("DISABLE"),
    .INITN_PERSISTN("DISABLE"),
    .JTAG_PERSISTN("DISABLE"),
    .PROGRAMN_PERSISTN("DISABLE"),
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
    .fifo_rdpointer({open_n147,fifo_rdpointer,open_n148,open_n149,open_n150,open_n151,open_n152}),
    .fifo_wrpointer({open_n153,fifo_wrpointer,open_n154,open_n155,open_n156,open_n157,open_n158}),
    .fifoctrl_raddr(fifo_inst_syn_17),
    .fifoctrl_re(fifo_inst_syn_32),
    .fifoctrl_waddr(fifo_inst_syn_3),
    .fifoctrl_we(fifo_inst_syn_31));  // sfifo512x128.v(38)
  PH1_PHY_ERAM #(
    //.ADDRCASENA("ENABLE"),
    //.ADDRCASENB("ENABLE"),
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
    .csa({fifo_inst_syn_33,open_n215,open_n216}),
    .csb({fifo_inst_syn_34,open_n217,open_n218}),
    .dia(di[15:0]),
    .dia_extra(di[19:16]),
    .dib(di[35:20]),
    .dib_extra(di[39:36]),
    .fifoctrl_raddr(fifo_inst_syn_17),
    .fifoctrl_re(fifo_inst_syn_32),
    .fifoctrl_waddr(fifo_inst_syn_3),
    .fifoctrl_we(fifo_inst_syn_31),
    .doa(dout[15:0]),
    .doa_extra(dout[19:16]),
    .dob(dout[35:20]),
    .dob_extra(dout[39:36]));  // sfifo512x128.v(38)
  PH1_PHY_ERAM #(
    //.ADDRCASENA("ENABLE"),
    //.ADDRCASENB("ENABLE"),
    //.MACRO("fifo_inst_syn_1"),
    //.R_POSITION("X0Y0Z1"),
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
    fifo_inst_syn_35 (
    .clka(clk),
    .clkb(clk),
    .csa({fifo_inst_syn_33,open_n313,open_n314}),
    .csb({fifo_inst_syn_34,open_n315,open_n316}),
    .dia(di[55:40]),
    .dia_extra(di[59:56]),
    .dib(di[75:60]),
    .dib_extra(di[79:76]),
    .fifoctrl_raddr(fifo_inst_syn_17),
    .fifoctrl_re(fifo_inst_syn_32),
    .fifoctrl_waddr(fifo_inst_syn_3),
    .fifoctrl_we(fifo_inst_syn_31),
    .addra_casout(fifo_inst_syn_37),
    .addrb_casout(fifo_inst_syn_51),
    .doa(dout[55:40]),
    .doa_extra(dout[59:56]),
    .dob(dout[75:60]),
    .dob_extra(dout[79:76]));  // sfifo512x128.v(38)
  PH1_PHY_ERAM #(
    //.ADDRCASENA("ENABLE"),
    //.ADDRCASENB("ENABLE"),
    //.MACRO("fifo_inst_syn_1"),
    //.R_POSITION("X0Y4Z0"),
    .CLKMODE("SYNC"),
    .CSA0("1"),
    .CSB0("1"),
    .DATA_WIDTH_A("40"),
    .DATA_WIDTH_B("40"),
    .ECC_DECODE("DISABLE"),
    .ECC_ENCODE("DISABLE"),
    .HADDRCAS_A("CASFB"),
    .HADDRCAS_B("CASFB"),
    .LADDRCAS_A("CASFB"),
    .LADDRCAS_B("CASFB"),
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
    fifo_inst_syn_36 (
    .addra_casin(fifo_inst_syn_37),
    .addrb_casin(fifo_inst_syn_51),
    .clka(clk),
    .clkb(clk),
    .csa({fifo_inst_syn_33,fifo_inst_syn_31,open_n355}),
    .csb({fifo_inst_syn_34,fifo_inst_syn_32,open_n356}),
    .dia(di[95:80]),
    .dia_extra(di[99:96]),
    .dib(di[115:100]),
    .dib_extra(di[119:116]),
    .addra_casout(fifo_inst_syn_66),
    .addrb_casout(fifo_inst_syn_80),
    .doa(dout[95:80]),
    .doa_extra(dout[99:96]),
    .dob(dout[115:100]),
    .dob_extra(dout[119:116]));  // sfifo512x128.v(38)
  PH1_PHY_ERAM #(
    //.ADDRCASENA("ENABLE"),
    //.ADDRCASENB("ENABLE"),
    //.MACRO("fifo_inst_syn_1"),
    //.R_POSITION("X0Y4Z1"),
    .CLKMODE("SYNC"),
    .CSA0("1"),
    .CSB0("1"),
    .DATA_WIDTH_A("40"),
    .DATA_WIDTH_B("40"),
    .ECC_DECODE("DISABLE"),
    .ECC_ENCODE("DISABLE"),
    .HADDRCAS_A("CASFB"),
    .HADDRCAS_B("CASFB"),
    .LADDRCAS_A("CASFB"),
    .LADDRCAS_B("CASFB"),
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
    fifo_inst_syn_65 (
    .addra_casin(fifo_inst_syn_66),
    .addrb_casin(fifo_inst_syn_80),
    .clka(clk),
    .clkb(clk),
    .csa({fifo_inst_syn_33,fifo_inst_syn_31,open_n425}),
    .csb({fifo_inst_syn_34,fifo_inst_syn_32,open_n426}),
    .dia({open_n427,open_n428,open_n429,open_n430,open_n431,open_n432,open_n433,open_n434,di[127:120]}),
    .doa({open_n525,open_n526,open_n527,open_n528,open_n529,open_n530,open_n531,open_n532,dout[127:120]}));  // sfifo512x128.v(38)

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

