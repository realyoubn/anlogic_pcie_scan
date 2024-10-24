// ===========================================================================
// Copyright (c) 2011-2020 Anlogic Inc., All Right Reserved.
// 
// TEL: 86-21-61633787
// WEB: http://www.anlogic.com/
// ===========================================================================
//
// Designer    : Lintao Wu
// Date        ：2020/05/29
// Discription ：BFM for DBI bus master.
// Email       : Lintao.Wu@Anlogic.com
// 
// ===========================================================================
`timescale 1ns/1ps

module dbi_master_bfm(
    // Input
    clk, 
    drp_lbc_dbi_dout,
    drp_lbc_dbi_ack,
   // Output
    drp_dbi_din,
    drp_dbi_wr,
    drp_dbi_addr,
    drp_dbi_cs,
    drp_dbi_cs2_exp,
    drp_dbi_vfunc_num,
    drp_dbi_vfunc_active,
    drp_dbi_bar_num,
    drp_dbi_rom_access,
    drp_dbi_io_access,
    drp_dbi_func_num,
    drp_app_dbi_ro_wr_disable
   );

    // Input
    input           clk;
    input [31:0]    drp_lbc_dbi_dout;
    input           drp_lbc_dbi_ack;
   // Output
    output [31:0]   drp_dbi_din;
    output [3:0]    drp_dbi_wr;
    output [31:0]   drp_dbi_addr;
    output          drp_dbi_cs;
    output          drp_dbi_cs2_exp;
    output [1:0]    drp_dbi_vfunc_num;
    output          drp_dbi_vfunc_active;
    output [2:0]    drp_dbi_bar_num;
    output          drp_dbi_rom_access;
    output          drp_dbi_io_access;
    output          drp_dbi_func_num;
    output          drp_app_dbi_ro_wr_disable;
// ====================================================================
// Parameter/wire/reg
// ====================================================================
    reg  [31:0]     drp_dbi_din;
    reg  [3:0]      drp_dbi_wr;
    reg  [31:0]     drp_dbi_addr;
    reg             drp_dbi_cs;
    reg             drp_dbi_cs2_exp;
    reg  [1:0]      drp_dbi_vfunc_num;
    reg             drp_dbi_vfunc_active;
    reg  [2:0]      drp_dbi_bar_num;
    reg             drp_dbi_rom_access;
    reg             drp_dbi_io_access;
    reg             drp_dbi_func_num;
    reg             drp_app_dbi_ro_wr_disable;
	
	// Register
	parameter       ADDRESS_MD_SWITCH = 32'h0000_FFF0;
	parameter       ADDRESS_WR_PROT = 32'h0000_08BC;
	parameter       BIT_WR_PROT = 0;
	
	// Function
	`define FUNCTION_NUMBER_PF0 1'b0
	`define FUNCTION_NUMBER_PF1 1'b1
	`define FUNCTION_NUMBER_VF1 2'b00
	`define FUNCTION_NUMBER_VF2 2'b01



// ===========================================================================
// Start of BFM
// ===========================================================================

// Buts Intialization
initial
	begin
    drp_dbi_din          = {32{1'b0}};
    drp_dbi_wr           = 0;
    drp_dbi_addr         = {32{1'b0}};
    drp_dbi_cs           = 0;
    drp_dbi_cs2_exp      = 0;
    drp_dbi_vfunc_num    = `FUNCTION_NUMBER_VF1;
	drp_dbi_vfunc_active = 0;
    drp_dbi_bar_num      = 0;
    drp_dbi_rom_access   = 0;
    drp_dbi_io_access    = 0;
    drp_dbi_func_num     = `FUNCTION_NUMBER_PF0;
    drp_app_dbi_ro_wr_disable = 0;
    #1;
	end


// Open write protection
task open_wr_prot;
	
	reg  [31:0]  temp_data;
	begin
	@(posedge clk);
	#1;
	dbi_rd(ADDRESS_WR_PROT, temp_data);
	dbi_wr(ADDRESS_WR_PROT, {temp_data[31:1], 1'b1});
	@(posedge clk);
	end
endtask

// Set configuration space
task dbi_set_cfg_space;
	input           func_num;
	input  [1:0]    vfunc_num;
	input           vfunc_active;
	
	reg    [3:0]    timer;
	integer         i;
	begin
	@(posedge clk);
	#1;
	drp_dbi_vfunc_num  = `FUNCTION_NUMBER_VF1;
	drp_dbi_func_num   = `FUNCTION_NUMBER_PF0;
	drp_dbi_vfunc_active = vfunc_active;
	`ifdef PRINT_INFO_EN
	$display("DBI set configuration space %h %h %h %h at time %t", cs2, func_num, vfunc_num, vfunc_active, $time);
	`endif
	@(posedge clk);
	end
endtask

// write
task dbi_wr;
	input  [31:0]   address;
	input  [31:0]   data;
	
	begin
	@(posedge clk);
	#1;
	drp_dbi_cs      = 1;
	drp_dbi_din     = data;
	drp_dbi_wr      = 4'hF;
	drp_dbi_addr    = address;
	while(~drp_lbc_dbi_ack) @(posedge clk);
	`ifdef PRINT_INFO_EN
	$display("DBI write address: %h data: %h at time %t", address, data, $time);
	`endif
	#1;
	drp_dbi_wr      = 0;
	drp_dbi_cs      = 0;
	@(posedge clk);
	end
endtask

task dbi_wr_cs2;
	input  [31:0]   address;
	input  [31:0]   data;
	
	begin
	@(posedge clk);
	#1;
	drp_dbi_cs      = 1;
	drp_dbi_cs2_exp = 1;
	drp_dbi_din     = data;
	drp_dbi_wr      = 4'hF;
	drp_dbi_addr    = address;
	while(~drp_lbc_dbi_ack) @(posedge clk);
	`ifdef PRINT_INFO_EN
	$display("DBI write address: %h data: %h at time %t", address, data, $time);
	`endif
	#1;
	drp_dbi_wr      = 0;
	drp_dbi_cs      = 0;
	drp_dbi_cs2_exp = 0;
	@(posedge clk);
	end
endtask

// read
task dbi_rd;
	input  [31:0]   address;
	output [31:0]   data;
	
	begin
	@(posedge clk);
	#1;
	drp_dbi_cs      = 1;
	drp_dbi_wr      = 0;
	drp_dbi_addr    = address;
	while(~drp_lbc_dbi_ack) @(posedge clk);
	`ifdef PRINT_INFO_EN
	$display("DBI read address: %h data: %h at time %t", address, data, $time);
	`endif
	data = drp_lbc_dbi_dout;
	#1;
	drp_dbi_cs      = 0;
	@(posedge clk);
	end
endtask

task dbi_rd_cs2;
	input  [31:0]   address;
	output [31:0]   data;
	
	begin
	@(posedge clk);
	#1;
	drp_dbi_cs      = 1;
	drp_dbi_cs2_exp = 1;
	drp_dbi_wr      = 0;
	drp_dbi_addr    = address;
	while(~drp_lbc_dbi_ack) @(posedge clk);
	`ifdef PRINT_INFO_EN
	$display("DBI read address: %h data: %h at time %t", address, data, $time);
	`endif
	data = drp_lbc_dbi_dout;
	#1;
	drp_dbi_cs      = 0;
	drp_dbi_cs2_exp = 0;
	@(posedge clk);
	end
endtask

// start initialization
task start_init;
	
	begin
	drp_app_dbi_ro_wr_disable = 0;
	end
endtask

// end initialization
task end_init;
	
	begin
	drp_app_dbi_ro_wr_disable = 1;
	end
endtask

endmodule
