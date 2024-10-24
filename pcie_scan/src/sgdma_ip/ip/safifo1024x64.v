/************************************************************\
 **  Copyright (c) 2011-2022 Anlogic, Inc.
 **  All Right Reserved.\
\************************************************************/
/************************************************************\
 ** Log	:	This file is generated by Anlogic IP Generator.
 ** File	:	/users/bswang/svn/src/sgdma_ip/ip/safifo1024x64.v
 ** Date	:	2022 07 27
 ** TD version	:	5.7.56431
\************************************************************/

`timescale 1ns / 1ps

module safifo1024x64 (
	rst,
	di, re, clk, we,
	dout,
	empty_flag,full_flag,rdusedw,wrusedw
 
);

	input rst;
	input [63:0] di;
	input clk, we;
	input re;

	output [63:0] dout;
	output empty_flag;
	output full_flag;
	output [10:0] rdusedw;
	output [10:0] wrusedw;

PH1_LOGIC_RAMFIFO #(
 	.DATA_WIDTH(64),
	.ADDR_WIDTH(10),
	.SHOWAHEAD(1),
	.IMPLEMENT("20K(FAST)")
)
logic_ramfifo(
	.rst(rst),
	.di(di),
	.clk(clk),
	.we(we),
	.dout(dout),
	.re(re),
	.empty_flag(empty_flag),
	.full_flag(full_flag),
	.rdusedw(rdusedw),
	.wrusedw(wrusedw)
);

endmodule