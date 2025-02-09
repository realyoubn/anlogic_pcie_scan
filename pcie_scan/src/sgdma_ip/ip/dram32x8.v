/************************************************************\
 **  Copyright (c) 2011-2022 Anlogic, Inc.
 **  All Right Reserved.\
\************************************************************/
/************************************************************\
 ** Log	:	This file is generated by Anlogic IP Generator.
 ** File	:	/users/bswang/svn/src/sgdma_ip/ip/dram32x8.v
 ** Date	:	2022 07 25
 ** TD version	:	5.7.56276
\************************************************************/

`timescale 1ns / 1ps

module dram32x8 ( di, waddr, we, wclk, rdo, raddr );

	parameter DATA_WIDTH_W = 8; 
	parameter ADDR_WIDTH_W = 5;
	parameter DATA_DEPTH_W = 32;
	parameter DATA_WIDTH_R = 8;
	parameter ADDR_WIDTH_R = 5;
	parameter DATA_DEPTH_R = 32;

	input  [DATA_WIDTH_W-1:0] di;
	input  [ADDR_WIDTH_W-1:0] waddr;
	input  [ADDR_WIDTH_R-1:0] raddr;
	input  wclk,we;

	output [DATA_WIDTH_R-1:0] rdo;



	PH1_LOGIC_DRAM #(
 			.INIT_FILE("NONE"),
			.READREG("DISABLE"),
			.DATA_WIDTH_W(DATA_WIDTH_W),
			.ADDR_WIDTH_W(ADDR_WIDTH_W),
			.DATA_DEPTH_W(DATA_DEPTH_W),
			.DATA_WIDTH_R(DATA_WIDTH_R),
			.ADDR_WIDTH_R(ADDR_WIDTH_R),
			.DATA_DEPTH_R(DATA_DEPTH_R))
		dram(
			.di(di),
			.waddr(waddr),
			.wclk(wclk),
			.we(we),
			.rclk(1'b0),
			.rrst(1'b0),
			.rce(1'b0),
			.rdoq(),
			.rdo(rdo),
			.raddr(raddr));

endmodule