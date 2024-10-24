// ===========================================================================
// Copyright (c) 2011-2020 Anlogic Inc., All Right Reserved.
// 
// TEL: 86-21-61633787
// WEB: http://www.anlogic.com/
// ===========================================================================
//
// Designer    : Lintao Wu
// Date        ：2020/06/03
// Discription ：BFM for config completion from BYPASS I/F.
// Email       : Lintao.Wu@Anlogic.com
// 
// ===========================================================================
`timescale 1ns/1ps
`include "tlp_fmt_type.vh"
module byps_cpl(
    core_clk, 
	core_rst_n,
	rc_bdf,
	ep_bdf,
	radm_bypass_data,
	radm_bypass_dwen,
	radm_bypass_dv,
	radm_bypass_hv,
	radm_bypass_eot,
	radm_bypass_dllp_abort,
	radm_bypass_tlp_abort,
	radm_bypass_ecrc_err,
	radm_bypass_addr,
	radm_bypass_fmt,
	radm_bypass_tc,
	radm_bypass_attr,
	radm_bypass_reqid,
	radm_bypass_type,
	radm_bypass_tag,
	radm_bypass_func_num,
	radm_bypass_vfunc_num,
	radm_bypass_vfunc_active,
	radm_bypass_td,
	radm_bypass_poisoned,
	radm_bypass_dw_len,
	radm_bypass_rom_in_range,
	radm_bypass_first_be,
	radm_bypass_last_be,
	radm_bypass_io_req_in_range,
	radm_bypass_in_membar_range,
	radm_bypass_cpl_last,
	radm_bypass_cpl_status,
	radm_bypass_st,
	radm_bypass_cmpltr_id,
	radm_bypass_byte_cnt,
	radm_bypass_ats,
	radm_bypass_th,
	radm_bypass_ph,
	radm_bypass_bcm,
	
	cpl_flag,
	cpl_status,
	cpld_flag,
	cpld_status,
	cpld_data,
	cpld_data_vld
	);
	// Input and Output
    input          core_clk;
	input          core_rst_n;
	input  [15:0]  rc_bdf ;
	input  [15:0]  ep_bdf ;
    input  [`DT_WD:0]  radm_bypass_data ;            // 
    input  [3:0]   radm_bypass_dwen ;            // 
    input          radm_bypass_dv ;              // 
    input          radm_bypass_hv ;              // 
    input          radm_bypass_eot ;             // IIT (Ignore it temporarily)
    input          radm_bypass_dllp_abort ;      // IIT
    input          radm_bypass_tlp_abort ;       // IIT
    input          radm_bypass_ecrc_err ;        // IIT
    input  [63:0]  radm_bypass_addr ;            // 
    input  [1:0]   radm_bypass_fmt ;             // 
    input  [2:0]   radm_bypass_tc ;              // IIT
    input  [2:0]   radm_bypass_attr ;            // IIT
    input  [15:0]  radm_bypass_reqid ;           // 
    input  [4:0]   radm_bypass_type ;            // 
    input  [9:0]   radm_bypass_tag ;             // 
    input          radm_bypass_func_num ;        // 
    input  [1:0]   radm_bypass_vfunc_num ;       // IIT
    input          radm_bypass_vfunc_active ;    // IIT
    input          radm_bypass_td ;              // IIT
    input          radm_bypass_poisoned ;        // IIT
    input  [9:0]   radm_bypass_dw_len ;          // 
    input          radm_bypass_rom_in_range ;    // IIT
    input  [3:0]   radm_bypass_first_be ;        // 
    input  [3:0]   radm_bypass_last_be ;         // 
    input          radm_bypass_io_req_in_range ; // 
    input  [2:0]   radm_bypass_in_membar_range ; // 
    input          radm_bypass_cpl_last ;        // 
    input  [2:0]   radm_bypass_cpl_status ;      // 
    input  [7:0]   radm_bypass_st ;              // IIT
    input  [15:0]  radm_bypass_cmpltr_id ;       // 
    input  [11:0]  radm_bypass_byte_cnt ;        // 
    input  [1:0]   radm_bypass_ats ;             // IIT
    input          radm_bypass_th ;              // IIT
    input  [1:0]   radm_bypass_ph ;              // IIT
    input          radm_bypass_bcm ;             // IIT

	output         cpl_flag;
	output         cpl_status;
	output         cpld_flag;
	output         cpld_status;
	output [`DT_WD:0]  cpld_data;
	output [1:0]   cpld_data_vld;

// ====================================================================
// Parameter/wire/reg
// ====================================================================

	
	reg    [`DT_WD:0]  radm_bypass_data_ff ;
    reg    [3:0]   radm_bypass_dwen_ff ;
    reg            radm_bypass_dv_ff ;
    reg            radm_bypass_hv_ff ;
    reg            radm_bypass_eot_ff ;
    reg            radm_bypass_dllp_abort_ff ;
    reg            radm_bypass_tlp_abort_ff ;
    reg            radm_bypass_ecrc_err_ff ;
    reg    [63:0]  radm_bypass_addr_ff ;
    reg    [1:0]   radm_bypass_fmt_ff ;
    reg    [2:0]   radm_bypass_tc_ff ;
    reg    [2:0]   radm_bypass_attr_ff ;
    reg    [15:0]  radm_bypass_reqid_ff ;
    reg    [4:0]   radm_bypass_type_ff ;
    reg    [9:0]   radm_bypass_tag_ff ;
    reg            radm_bypass_func_num_ff ;
    reg    [1:0]   radm_bypass_vfunc_num_ff ;
    reg            radm_bypass_vfunc_active_ff ;
    reg            radm_bypass_td_ff ;
    reg            radm_bypass_poisoned_ff ;
    reg    [9:0]   radm_bypass_dw_len_ff ;
    reg            radm_bypass_rom_in_range_ff ;
    reg    [3:0]   radm_bypass_first_be_ff ;
    reg    [3:0]   radm_bypass_last_be_ff ;
    reg            radm_bypass_io_req_in_range_ff ;
    reg    [2:0]   radm_bypass_in_membar_range_ff ;
    reg            radm_bypass_cpl_last_ff ;
    reg    [2:0]   radm_bypass_cpl_status_ff ;
    reg    [7:0]   radm_bypass_st_ff ;
    reg    [15:0]  radm_bypass_cmpltr_id_ff ;
    reg    [11:0]  radm_bypass_byte_cnt_ff ;
    reg    [1:0]   radm_bypass_ats_ff ;
    reg            radm_bypass_th_ff ;
    reg    [1:0]   radm_bypass_ph_ff ;
    reg            radm_bypass_bcm_ff ;
	
    reg            radm_bypass_hv_2ff ;
    reg            radm_bypass_dv_2ff ;
	reg            radm_bypass_eot_2ff;
	reg    [`DT_WD:0]  radm_bypass_data_2ff ;
	reg            req_cpl_id_match;
	reg            cpl_wo_data;
	reg            cpl_w_data;
	reg            cpl_good;
	reg            cpl_flag;
	reg            cpl_status;
	reg            cpld_flag;
	reg            cpld_status;
	reg    [`DT_WD:0]  cpld_data;
	reg    [1:0]   cpld_data_vld;
	

// ===========================================================================
// Start of BFM
// ===========================================================================
// Pipe line
always@(posedge core_clk or negedge core_rst_n)
	begin
	if (!core_rst_n)
		begin
		radm_bypass_data_ff            <= 0 ;
		radm_bypass_dwen_ff            <= 0 ;
		radm_bypass_dv_ff              <= 0 ;
		radm_bypass_hv_ff              <= 0 ;
		radm_bypass_eot_ff             <= 0 ;
		radm_bypass_dllp_abort_ff      <= 0 ;
		radm_bypass_tlp_abort_ff       <= 0 ;
		radm_bypass_ecrc_err_ff        <= 0 ;
		radm_bypass_addr_ff            <= 0 ;
		radm_bypass_fmt_ff             <= 0 ;
		radm_bypass_tc_ff              <= 0 ;
		radm_bypass_attr_ff            <= 0 ;
		radm_bypass_reqid_ff           <= 0 ;
		radm_bypass_type_ff            <= 0 ;
		radm_bypass_tag_ff             <= 0 ;
		radm_bypass_func_num_ff        <= 0 ;
		radm_bypass_vfunc_num_ff       <= 0 ;
		radm_bypass_vfunc_active_ff    <= 0 ;
		radm_bypass_td_ff              <= 0 ;
		radm_bypass_poisoned_ff        <= 0 ;
		radm_bypass_dw_len_ff          <= 0 ;
		radm_bypass_rom_in_range_ff    <= 0 ;
		radm_bypass_first_be_ff        <= 0 ;
		radm_bypass_last_be_ff         <= 0 ;
		radm_bypass_io_req_in_range_ff <= 0 ;
		radm_bypass_in_membar_range_ff <= 0 ;
		radm_bypass_cpl_last_ff        <= 0 ;
		radm_bypass_cpl_status_ff      <= 0 ;
		radm_bypass_st_ff              <= 0 ;
		radm_bypass_cmpltr_id_ff       <= 0 ;
		radm_bypass_byte_cnt_ff        <= 0 ;
		radm_bypass_ats_ff             <= 0 ;
		radm_bypass_th_ff              <= 0 ;
		radm_bypass_ph_ff              <= 0 ;
		radm_bypass_bcm_ff             <= 0 ;
		radm_bypass_hv_2ff             <= 0 ;
		radm_bypass_dv_2ff             <= 0 ;
		radm_bypass_eot_2ff            <= 0 ;
		radm_bypass_data_2ff           <= 0 ;
		end
	else
		begin
		radm_bypass_hv_ff              <= radm_bypass_hv ;
		radm_bypass_hv_2ff             <= radm_bypass_hv_ff ;
		radm_bypass_dv_ff              <= radm_bypass_dv ;
		radm_bypass_dv_2ff             <= radm_bypass_dv_ff ;
		radm_bypass_eot_ff             <= radm_bypass_eot ;
		radm_bypass_eot_2ff            <= radm_bypass_eot_ff ;
		if (radm_bypass_hv)
			begin
			radm_bypass_addr_ff            <= radm_bypass_addr ;
			radm_bypass_fmt_ff             <= radm_bypass_fmt ;
			radm_bypass_tc_ff              <= radm_bypass_tc ;
			radm_bypass_attr_ff            <= radm_bypass_attr ;
			radm_bypass_reqid_ff           <= radm_bypass_reqid ;
			radm_bypass_type_ff            <= radm_bypass_type ;
			radm_bypass_tag_ff             <= radm_bypass_tag ;
			radm_bypass_func_num_ff        <= radm_bypass_func_num ;
			radm_bypass_vfunc_num_ff       <= radm_bypass_vfunc_num ;
			radm_bypass_vfunc_active_ff    <= radm_bypass_vfunc_active ;
			radm_bypass_td_ff              <= radm_bypass_td ;
			radm_bypass_dw_len_ff          <= radm_bypass_dw_len ;
			radm_bypass_rom_in_range_ff    <= radm_bypass_rom_in_range ;
			radm_bypass_first_be_ff        <= radm_bypass_first_be ;
			radm_bypass_last_be_ff         <= radm_bypass_last_be ;
			radm_bypass_io_req_in_range_ff <= radm_bypass_io_req_in_range ;
			radm_bypass_in_membar_range_ff <= radm_bypass_in_membar_range ;
			radm_bypass_st_ff              <= radm_bypass_st ;
			radm_bypass_cmpltr_id_ff       <= radm_bypass_cmpltr_id ;
			radm_bypass_byte_cnt_ff        <= radm_bypass_byte_cnt ;
			radm_bypass_ats_ff             <= radm_bypass_ats ;
			radm_bypass_th_ff              <= radm_bypass_th ;
			radm_bypass_ph_ff              <= radm_bypass_ph ;
			radm_bypass_bcm_ff             <= radm_bypass_bcm ;
			radm_bypass_poisoned_ff        <= radm_bypass_poisoned ;
			radm_bypass_cpl_last_ff        <= radm_bypass_cpl_last ;
			radm_bypass_cpl_status_ff      <= radm_bypass_cpl_status ;
			end
		if (radm_bypass_eot)
			begin
			radm_bypass_dwen_ff            <= radm_bypass_dwen ;
			radm_bypass_dllp_abort_ff      <= radm_bypass_dllp_abort ;
			radm_bypass_ecrc_err_ff        <= radm_bypass_ecrc_err ;
			end
		if (radm_bypass_hv | radm_bypass_eot)
			radm_bypass_tlp_abort_ff       <= radm_bypass_tlp_abort ;
		radm_bypass_data_ff            <= radm_bypass_data ;
		radm_bypass_data_2ff           <= radm_bypass_data_ff ;
		end
	end

// CPL/CPLD fields
always@(posedge core_clk or negedge core_rst_n)
	begin
	if (!core_rst_n)
		begin
		req_cpl_id_match <= 0;
		cpl_wo_data <= 0;
		cpl_w_data <= 0;
		cpl_good <= 0;
		end
	else
		begin
		req_cpl_id_match <= (radm_bypass_cmpltr_id_ff == ep_bdf) ? 1 : 0;
		cpl_wo_data <= (radm_bypass_fmt_ff == `CPL_FMT & radm_bypass_type_ff == `CPL_TYPE) ? 1 : 0;
		cpl_w_data <= (radm_bypass_fmt_ff == `CPLD_FMT & radm_bypass_type_ff == `CPLD_TYPE) ? 1 : 0;
		cpl_good <= (radm_bypass_cpl_last_ff & radm_bypass_cpl_status_ff == 2'b00 & ~radm_bypass_tlp_abort_ff) ? 1 : 0;
		end
	end

// --------------------------------------------------------------------
// CPL
// --------------------------------------------------------------------
always@(posedge core_clk or negedge core_rst_n)
	begin
	if (!core_rst_n)
		begin
		cpl_flag <= 0;
		cpl_status <= 0;
		end
	else
		begin
		if (radm_bypass_hv_2ff & radm_bypass_eot_2ff)
			begin
			cpl_flag <= cpl_wo_data;
			//cpl_status <= cpl_wo_data & req_cpl_id_match & cpl_good;
			cpl_status <= cpl_wo_data & cpl_good;
			end
		else
			begin
			cpl_flag <= 0;
			cpl_status <= 0;
			end
		end
	end

// --------------------------------------------------------------------
// CPLD
// --------------------------------------------------------------------
always@(posedge core_clk or negedge core_rst_n)
	begin
	if (!core_rst_n)
		begin
		cpld_flag <= 0;
		cpld_status <= 0;
		cpld_data <= 0;
		cpld_data_vld <= 0;
		end
	else
		begin
		if (radm_bypass_hv_2ff)
			begin
			cpld_flag <= cpl_w_data;
			//cpld_status <= cpl_w_data & req_cpl_id_match & cpl_good;
			cpld_status <= cpl_w_data & cpl_good;
			end
		else
			begin
			cpld_flag <= 0;
			cpld_status <= 0;
			end
		if (radm_bypass_eot_2ff)
			cpld_data_vld <= radm_bypass_dwen_ff;
		else
			cpld_data_vld <= {radm_bypass_dv_2ff, radm_bypass_dv_2ff};
		cpld_data <= radm_bypass_data_2ff;
		end
	end


endmodule
