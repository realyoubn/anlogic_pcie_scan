// ===========================================================================
// Copyright (c) 2011-2020 Anlogic Inc., All Right Reserved.
// 
// TEL: 86-21-61633787
// WEB: http://www.anlogic.com/
// ===========================================================================
//
// Designer    : Lintao Wu
// Date        ：2020/06/11
// Discription ：The module demonstrates how to receive identify MSI (Memory write) from TRGT I/F.
// Email       : Lintao.Wu@Anlogic.com
// 
// ===========================================================================
`timescale 1ns/1ps
`include "tlp_fmt_type.vh"
`include "dt_para.vh"
module msi_int_bfm(
    core_clk, 
	core_rst_n,
	// TRGT I/F
    trgt1_radm_halt,
    trgt1_radm_pkt_halt,
    radm_trgt1_dv,
    radm_trgt1_hv,
    radm_trgt1_eot,
    radm_trgt1_tlp_abort,
    radm_trgt1_dllp_abort,
    radm_trgt1_ecrc_err,
    radm_trgt1_dwen,
    radm_trgt1_fmt,
    radm_trgt1_attr,
    radm_trgt1_func_num,
    radm_trgt1_type,
    radm_trgt1_tc,
    radm_trgt1_reqid,
    radm_trgt1_data,
    radm_trgt1_first_be,
    radm_trgt1_last_be,
    radm_trgt1_addr,
    radm_trgt1_vfunc_num,
    radm_trgt1_vfunc_active,
    radm_trgt1_td,
    radm_trgt1_poisoned,
    radm_trgt1_hdr_uppr_bytes_valid,
    radm_trgt1_rom_in_range,
    radm_trgt1_io_req_in_range,
    radm_trgt1_hdr_uppr_bytes,
    radm_trgt1_in_membar_range,
    radm_trgt1_cpl_status,
    radm_trgt1_ats,
    radm_trgt1_tag,
    radm_trgt1_dw_len,
    radm_trgt1_nw,
    radm_trgt1_th,
    radm_trgt1_ph,
    radm_trgt1_st,
    radm_trgt1_byte_cnt,
    radm_trgt1_bcm,
    radm_trgt1_vc,
    radm_trgt1_cmpltr_id,
    radm_trgt1_cpl_last,
    radm_grant_tlp_type,
    radm_trgt1_atu_sloc_match,
    radm_trgt1_atu_cbuf_err,
	// control signals from MSI_CAP\MSI_CTRL_...
//	MSI_CTRL_ADDR,//.
//	msi_ctrl_int_0_en_off,
//	msi_ctrl_int_0_mask_off,
	// To inform normal memory write process
	msi_detected,
	int_odt
	// from processor
//	msi_ctrl_clear,
	// Remote Interrupt
//	msi_ctrl_int,
//	msi_ctrl_int_vec
	);
	`include "bdf.vh"
	localparam INT_NUM_WD = $clog2(`INT_NUM+1);


	// Input and Output
    input           core_clk;
	input           core_rst_n;
	
    output          trgt1_radm_halt ;
    output [2:0]    trgt1_radm_pkt_halt ;
    input           radm_trgt1_dv ;
    input           radm_trgt1_hv ;
    input           radm_trgt1_eot ;
    input           radm_trgt1_tlp_abort ;
    input           radm_trgt1_dllp_abort ;
    input           radm_trgt1_ecrc_err ;
    input  [1:0]    radm_trgt1_dwen ;
    input  [1:0]    radm_trgt1_fmt ;
    input  [2:0]    radm_trgt1_attr ;
    input           radm_trgt1_func_num ;
    input  [4:0]    radm_trgt1_type ;
    input  [2:0]    radm_trgt1_tc ;
    input  [15:0]   radm_trgt1_reqid ;
    input  [63:0]   radm_trgt1_data ;
    input  [3:0]    radm_trgt1_first_be ;
    input  [3:0]    radm_trgt1_last_be ;
    input  [63:0]   radm_trgt1_addr ;
    input  [1:0]    radm_trgt1_vfunc_num ;
    input           radm_trgt1_vfunc_active ;
    input           radm_trgt1_td ;
    input           radm_trgt1_poisoned ;
    input           radm_trgt1_hdr_uppr_bytes_valid ;
    input           radm_trgt1_rom_in_range ;
    input           radm_trgt1_io_req_in_range ;
    input  [63:0]   radm_trgt1_hdr_uppr_bytes ;
    input  [2:0]    radm_trgt1_in_membar_range ;
    input  [2:0]    radm_trgt1_cpl_status ;
    input  [1:0]    radm_trgt1_ats ;
    input  [9:0]    radm_trgt1_tag ;
    input  [9:0]    radm_trgt1_dw_len ;
    input           radm_trgt1_nw ;
    input           radm_trgt1_th ;
    input  [1:0]    radm_trgt1_ph ;
    input  [7:0]    radm_trgt1_st ;
    input  [11:0]   radm_trgt1_byte_cnt ;
    input           radm_trgt1_bcm ;
    input  [2:0]    radm_trgt1_vc ;
    input  [15:0]   radm_trgt1_cmpltr_id ;
    input           radm_trgt1_cpl_last ;
    input  [2:0]    radm_grant_tlp_type ;
    input  [1:0]    radm_trgt1_atu_sloc_match ;
    input  [1:0]    radm_trgt1_atu_cbuf_err ;
	
	// control signals from MSI_CAP\MSI_CTRL_...
//	input  [63:0]   MSI_CTRL_ADDR ;
//	input  [31:0]   msi_ctrl_int_0_en_off ;
//	input  [31:0]   msi_ctrl_int_0_mask_off ;
	// To inform normal memory write process
	output          msi_detected ;
	output [32*`INT_NUM-1:0]   int_odt;
	// from processor
//	input  [31:0]   msi_ctrl_clear;
	// Remote Interrupt
//	output          msi_ctrl_int ;
//	output [31:0]   msi_ctrl_int_vec ;

// ====================================================================
// Parameter/wire/reg
// ====================================================================

	
    reg             radm_trgt1_dv_ff ;                   //synthesis keep
    reg             radm_trgt1_hv_ff ;                   //synthesis keep
    reg             radm_trgt1_eot_ff ;                  //synthesis keep
    reg             radm_trgt1_tlp_abort_ff ;            //synthesis keep
    reg             radm_trgt1_dllp_abort_ff ;           //synthesis keep
    reg             radm_trgt1_ecrc_err_ff ;             //synthesis keep
    reg    [1:0]    radm_trgt1_dwen_ff ;                 //synthesis keep
    reg    [1:0]    radm_trgt1_fmt_ff ;                  //synthesis keep
    reg    [2:0]    radm_trgt1_attr_ff ;                 //synthesis keep
    reg             radm_trgt1_func_num_ff ;             //synthesis keep
    reg    [4:0]    radm_trgt1_type_ff ;                 //synthesis keep
    reg    [2:0]    radm_trgt1_tc_ff ;                   //synthesis keep
    reg    [15:0]   radm_trgt1_reqid_ff ;                //synthesis keep
    reg    [63:0]   radm_trgt1_data_ff ;                 //synthesis keep
    reg    [3:0]    radm_trgt1_first_be_ff ;             //synthesis keep
    reg    [3:0]    radm_trgt1_last_be_ff ;              //synthesis keep
    reg    [63:0]   radm_trgt1_addr_ff ;                 //synthesis keep
    reg    [1:0]    radm_trgt1_vfunc_num_ff ;            //synthesis keep
    reg             radm_trgt1_vfunc_active_ff ;         //synthesis keep
    reg             radm_trgt1_td_ff ;                   //synthesis keep
    reg             radm_trgt1_poisoned_ff ;             //synthesis keep
    reg             radm_trgt1_hdr_uppr_bytes_valid_ff ; //synthesis keep
    reg             radm_trgt1_rom_in_range_ff ;         //synthesis keep
    reg             radm_trgt1_io_req_in_range_ff ;      //synthesis keep
    reg    [63:0]   radm_trgt1_hdr_uppr_bytes_ff ;       //synthesis keep
    reg    [2:0]    radm_trgt1_in_membar_range_ff ;      //synthesis keep
    reg    [2:0]    radm_trgt1_cpl_status_ff ;           //synthesis keep
    reg    [1:0]    radm_trgt1_ats_ff ;                  //synthesis keep
    reg    [9:0]    radm_trgt1_tag_ff ;                  //synthesis keep
    reg    [9:0]    radm_trgt1_dw_len_ff ;               //synthesis keep
    reg             radm_trgt1_nw_ff ;                   //synthesis keep
    reg             radm_trgt1_th_ff ;                   //synthesis keep
    reg    [1:0]    radm_trgt1_ph_ff ;                   //synthesis keep
    reg    [7:0]    radm_trgt1_st_ff ;                   //synthesis keep
    reg    [11:0]   radm_trgt1_byte_cnt_ff ;             //synthesis keep
    reg             radm_trgt1_bcm_ff ;                  //synthesis keep
    reg    [2:0]    radm_trgt1_vc_ff ;                   //synthesis keep
    reg    [15:0]   radm_trgt1_cmpltr_id_ff ;            //synthesis keep
    reg             radm_trgt1_cpl_last_ff ;             //synthesis keep
    reg    [2:0]    radm_grant_tlp_type_ff ;             //synthesis keep
    reg    [1:0]    radm_trgt1_atu_sloc_match_ff ;       //synthesis keep
    reg    [1:0]    radm_trgt1_atu_cbuf_err_ff ;         //synthesis keep
	
	wire            type_mw;
	wire            fmt_mw;
	wire            len_1dw;
	reg             mwr_req;                             //synthesis keep
	reg    [31:0]   mwr_addr;                            //synthesis keep
	reg    [31:0]   mwr_data;                            //synthesis keep

// ===========================================================================
// Start of Code
// ===========================================================================
// pipeline
always@(posedge core_clk or negedge core_rst_n)
	begin
	if (!core_rst_n)
		begin
		radm_trgt1_dv_ff <= 0;
		radm_trgt1_hv_ff <= 0;
//		radm_trgt1_hv_2ff <= 0;
		radm_trgt1_eot_ff <= 0;
		radm_trgt1_tlp_abort_ff <= 0;
		radm_trgt1_dllp_abort_ff <= 0;
		radm_trgt1_ecrc_err_ff <= 0;
		radm_trgt1_dwen_ff <= 0;
		radm_trgt1_fmt_ff <= 0;
		radm_trgt1_attr_ff <= 0;
		radm_trgt1_func_num_ff <= 0;
		radm_trgt1_type_ff <= 0;
		radm_trgt1_tc_ff <= 0;
		radm_trgt1_reqid_ff <= 0;
		radm_trgt1_data_ff <= 0;
		radm_trgt1_first_be_ff <= 0;
		radm_trgt1_last_be_ff <= 0;
		radm_trgt1_addr_ff <= 0;
		radm_trgt1_vfunc_num_ff <= 0;
		radm_trgt1_vfunc_active_ff <= 0;
		radm_trgt1_td_ff <= 0;
		radm_trgt1_poisoned_ff <= 0;
		radm_trgt1_hdr_uppr_bytes_valid_ff <= 0;
		radm_trgt1_rom_in_range_ff <= 0;
		radm_trgt1_io_req_in_range_ff <= 0;
		radm_trgt1_hdr_uppr_bytes_ff <= 0;
		radm_trgt1_in_membar_range_ff <= 0;
		radm_trgt1_cpl_status_ff <= 0;
		radm_trgt1_ats_ff <= 0;
		radm_trgt1_tag_ff <= 0;
		radm_trgt1_dw_len_ff <= 0;
		radm_trgt1_nw_ff <= 0;
		radm_trgt1_th_ff <= 0;
		radm_trgt1_ph_ff <= 0;
		radm_trgt1_st_ff <= 0;
		radm_trgt1_byte_cnt_ff <= 0;
		radm_trgt1_bcm_ff <= 0;
		radm_trgt1_vc_ff <= 0;
		radm_trgt1_cmpltr_id_ff <= 0;
		radm_trgt1_cpl_last_ff <= 0;
		radm_grant_tlp_type_ff <= 0;
		radm_trgt1_atu_sloc_match_ff <= 0;
		radm_trgt1_atu_cbuf_err_ff <= 0;
		end
	else
		begin
		radm_trgt1_dv_ff <= radm_trgt1_dv;
		radm_trgt1_hv_ff <= radm_trgt1_hv;
//		radm_trgt1_hv_2ff <= radm_trgt1_hv_ff;
		radm_trgt1_eot_ff <= radm_trgt1_eot;
		if (radm_trgt1_hv)
			begin
			radm_trgt1_dwen_ff <= radm_trgt1_dwen;
			radm_trgt1_fmt_ff <= radm_trgt1_fmt;
			radm_trgt1_attr_ff <= radm_trgt1_attr;
			radm_trgt1_func_num_ff <= radm_trgt1_func_num;
			radm_trgt1_type_ff <= radm_trgt1_type;
			radm_trgt1_tc_ff <= radm_trgt1_tc;
			radm_trgt1_reqid_ff <= radm_trgt1_reqid;
			radm_trgt1_first_be_ff <= radm_trgt1_first_be;
			radm_trgt1_last_be_ff <= radm_trgt1_last_be;
			radm_trgt1_addr_ff <= radm_trgt1_addr;
			radm_trgt1_vfunc_num_ff <= radm_trgt1_vfunc_num;
			radm_trgt1_vfunc_active_ff <= radm_trgt1_vfunc_active;
			radm_trgt1_td_ff <= radm_trgt1_td;
			radm_trgt1_poisoned_ff <= radm_trgt1_poisoned;
			radm_trgt1_hdr_uppr_bytes_valid_ff <= radm_trgt1_hdr_uppr_bytes_valid;
			radm_trgt1_rom_in_range_ff <= radm_trgt1_rom_in_range;
			radm_trgt1_io_req_in_range_ff <= radm_trgt1_io_req_in_range;
			radm_trgt1_hdr_uppr_bytes_ff <= radm_trgt1_hdr_uppr_bytes;
			radm_trgt1_in_membar_range_ff <= radm_trgt1_in_membar_range;
			radm_trgt1_cpl_status_ff <= radm_trgt1_cpl_status;
			radm_trgt1_ats_ff <= radm_trgt1_ats;
			radm_trgt1_tag_ff <= radm_trgt1_tag;
			radm_trgt1_dw_len_ff <= radm_trgt1_dw_len;
			radm_trgt1_nw_ff <= radm_trgt1_nw;
			radm_trgt1_th_ff <= radm_trgt1_th;
			radm_trgt1_ph_ff <= radm_trgt1_ph;
			radm_trgt1_st_ff <= radm_trgt1_st;
			radm_trgt1_byte_cnt_ff <= radm_trgt1_byte_cnt;
			radm_trgt1_bcm_ff <= radm_trgt1_bcm;
			radm_trgt1_vc_ff <= radm_trgt1_vc;
			radm_trgt1_cmpltr_id_ff <= radm_trgt1_cmpltr_id;
			radm_trgt1_cpl_last_ff <= radm_trgt1_cpl_last;
			radm_grant_tlp_type_ff <= radm_grant_tlp_type;
			radm_trgt1_atu_sloc_match_ff <= radm_trgt1_atu_sloc_match;
			radm_trgt1_atu_cbuf_err_ff <= radm_trgt1_atu_cbuf_err;
			end
		if (radm_trgt1_dv)
			begin
			radm_trgt1_data_ff <= radm_trgt1_data;
			end
		if (radm_trgt1_eot)
			begin
			radm_trgt1_dllp_abort_ff <= radm_trgt1_dllp_abort;
			radm_trgt1_ecrc_err_ff <= radm_trgt1_ecrc_err;
			end
		if (radm_trgt1_hv | radm_trgt1_eot)
			begin
			radm_trgt1_tlp_abort_ff <= radm_trgt1_tlp_abort;
			end
		end
	end

assign trgt1_radm_halt = 0;
assign trgt1_radm_pkt_halt = 3'd0; //Halt posted TLPs for VC0

// -----------------------------------------------------------------
// identify MSI
// -----------------------------------------------------------------
// Memory Write with 1 DWord data
assign type_mw = (radm_trgt1_type_ff == `MWR_TYPE) ? 1 : 0;
assign fmt_mw = ({1'b0,radm_trgt1_fmt_ff} == `FMT_3DW_DATA) ? 1 : 0;
assign len_1dw = (radm_trgt1_dw_len_ff == 10'd1) ? 1 :0;

always@(posedge core_clk or negedge core_rst_n)
begin
	if (!core_rst_n) begin
		mwr_req <= 0;
		mwr_addr <= 0;
		mwr_data <= 0;
	end
	else begin
		if(radm_trgt1_hv_ff) begin
			if (type_mw & fmt_mw & len_1dw)
				mwr_req <= 1;
			else
				mwr_req <= 0;
		end
		else
			mwr_req <= 0;
			mwr_addr <= radm_trgt1_addr_ff;
			mwr_data <= radm_trgt1_data_ff[31:0];
		end
end

wire   msi_wr_reqv; 
reg    msi_wr_reqv_d1;
reg    [INT_NUM_WD-1:0]   cnt_dt;
reg    [31:0]   int_odt_x[`INT_NUM-1:0];
assign msi_wr_reqv = (mwr_req==1'b1 && mwr_addr[31:0]==MSI_CTRL_ADDR[31:0]) ? 1'b1 : 1'b0;
always@(posedge core_clk or negedge core_rst_n)
begin
	if (!core_rst_n) 
		msi_wr_reqv_d1 <= 1'b0;
	else 
		msi_wr_reqv_d1 <= msi_wr_reqv;
end
assign msi_detected = (~msi_wr_reqv_d1) & msi_wr_reqv;
integer i;
always@(posedge core_clk or negedge core_rst_n)
begin
	if(!core_rst_n) begin
		cnt_dt <= {INT_NUM_WD{1'b0}};
		for (i=0;i<`INT_NUM;i=i+1)
		begin
			int_odt_x[i] <= 32'd0;
		end
	end
	else if(msi_detected) begin
		cnt_dt <= cnt_dt + 'd1;
		int_odt_x[cnt_dt] <= mwr_data;
	end
	else ;
end

generate 
	genvar nint;
	for(nint=0;nint<`INT_NUM;nint=nint+1) 
	begin:INT_PACK
		assign int_odt[nint*32+31:nint*32] = int_odt_x[nint];
	end
endgenerate


endmodule
