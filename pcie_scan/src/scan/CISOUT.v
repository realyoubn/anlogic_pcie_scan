`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    15:28:54 08/26/2012 
// Design Name: 
// Module Name:    CISOUT 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module CISOUT(
	CISCLK,
	CISSI,
	CISCLK1,
	CISCLK2,
	CISCLK3,
	CISCLK4,
	CISCLK5,
	CISCLK6,
	CISCLK7,
	CISCLK8,
	CISSI1,
	CISSI2,
	CISSI3,
	CISSI4,
	CISSI5,
	CISSI6,
	CISSI7,
	CISSI8,
	CISM1,
	CISM2,
	CISM3,
	CISM4,
	CISM5,
	CISM6,
	CISM7,
	CISM8,
	dpi_mode
    );

input	CISCLK;
input	CISSI;
output	CISCLK1;
output	CISCLK2;
output	CISCLK3;
output	CISCLK4;
output	CISCLK5;
output	CISCLK6;
output	CISCLK7;
output	CISCLK8;
output	CISSI1;
output	CISSI2;
output	CISSI3;
output	CISSI4;
output	CISSI5;
output	CISSI6;
output	CISSI7;
output	CISSI8;
output	CISM1;
output	CISM2;
output	CISM3;
output	CISM4;
output	CISM5;
output	CISM6;
output	CISM7;
output	CISM8;
input   dpi_mode;

assign CISCLK1 = CISCLK;
assign CISCLK2 = CISCLK;
assign CISCLK3 = CISCLK;
assign CISCLK4 = CISCLK;
assign CISCLK5 = CISCLK;
assign CISCLK6 = CISCLK;
assign CISCLK7 = CISCLK;
assign CISCLK8 = CISCLK;

assign CISSI1 = CISSI;
assign CISSI2 = CISSI;
assign CISSI3 = CISSI;
assign CISSI4 = CISSI;
assign CISSI5 = CISSI;
assign CISSI6 = CISSI;
assign CISSI7 = CISSI;
assign CISSI8 = CISSI;

assign CISM1 = dpi_mode ?  1'b0 : 1'b1;
assign CISM2 = dpi_mode ?  1'b0 : 1'b1;
assign CISM3 = dpi_mode ?  1'b0 : 1'b1;
assign CISM4 = dpi_mode ?  1'b0 : 1'b1;
assign CISM5 = dpi_mode ?  1'b0 : 1'b1;
assign CISM6 = dpi_mode ?  1'b0 : 1'b1;
assign CISM7 = dpi_mode ?  1'b0 : 1'b1;
assign CISM8 = dpi_mode ?  1'b0 : 1'b1;
 
endmodule
