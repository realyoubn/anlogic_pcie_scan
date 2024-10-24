/************************************************************\
 **  Copyright (c) 2011-2022 Anlogic, Inc.
 **  All Right Reserved.\
\************************************************************/
/************************************************************\
 ** Log	:	This file is generated by Anlogic IP Generator.
 ** File	:	/users/bswang/PCIe_SGDMA_MM/tb/ip/sfifo512x32.v
 ** Date	:	2022 12 03
 ** TD version	:	5.7.64597
\************************************************************/

`timescale 1ns / 1ps

module sfifo512x32(dout, empty_flag, full_flag, fifo_wrpointer, fifo_rdpointer,
	wrst, rrst, di, clk, we, re);

    input                         wrst;
    input                         rrst;
    input        [31:0]           di;
    input                         clk;
    input                         we;
    input                         re;
    output       [31:0]           dout;
    output                        empty_flag;
    output                        full_flag;
    output        [8:0]           fifo_wrpointer;
    output        [8:0]           fifo_rdpointer;
    PH1_LOGIC_FIFO #(
        .DATA_WIDTH(32),
        .ADDR_WIDTH(9),
        .REGMODE_R("NOREG"),
        .FIRSTWRITE_RD("DISABLE"),
        .ASYNC_RESET_RELEASE("SYNC"),
        .CLKMODE("SYNC"),
        .SSROVERCE("DISABLE"),
        .ECC_ENCODE("DISABLE"),
        .ECC_DECODE("DISABLE"))
    fifo_inst (
		.wrst(wrst),
		.rrst(rrst),
		.di(di),
		.clkw(clk),
		.we(we),
		.csw(3'b111),
		.dout(dout),
		.clkr(clk),
		.re(re),
		.csr(3'b111),
		.empty_flag(empty_flag),
		.aempty_flag(),
		.full_flag(full_flag),
		.afull_flag(),
		.ecc_sbiterr(),
		.ecc_dbiterr(),
		.fifo_wrpointer(fifo_wrpointer),
		.fifo_rdpointer(fifo_rdpointer)
		);
endmodule
