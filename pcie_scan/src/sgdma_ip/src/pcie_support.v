//////////////////////////////////////////////////////////////
//  Copyright(c) 2011-2022 Anlogic, Inc.
//  All Right Reserved.
//////////////////////////////////////////////////////////////
//  Company       : Anlogic
//  Filename      : pcie_support.v
//  Author        : Dexin - dexin.guo@anlogic.com
//  Last Modified : 2023-07-26 11:12:21
//  Create        : 2023-06-16 14:58:25
//  Description   :
//
///////////////////////////////////////////////////////////////

`timescale 1ns/1ns

`define XALI0_SIG_EN
`define XALI1_SIG_EN
`define TRGT1_SIG_EN
`define BYPASS_SIG_EN
`define ELBI_SIG_EN
`define DBI_SIG_EN

`include "../param_pcie_ep_case0.v"

module pcie_support(

    input   wire                refclk_p                        ,
    input   wire                refclk_n                        ,
    output  wire    [3:0]       txp                             ,
    output  wire    [3:0]       txn                             ,
    input   wire    [3:0]       rxp                             ,
    input   wire    [3:0]       rxn                             ,

    // client0 user interface

    input   wire    [127:0]     client0_tlp_data                ,
    input   wire    [63:0]      client0_tlp_addr                ,
    input   wire    [15:0]      client0_remote_req_id           ,
    input   wire    [7:0]       client0_tlp_byte_en             ,
    input   wire    [11:0]      client0_cpl_byte_cnt            ,
    input   wire                client0_addr_align_en           ,
    input   wire    [2:0]       client0_tlp_tc                  ,
    input   wire    [2:0]       client0_tlp_attr                ,
    input   wire    [2:0]       client0_cpl_status              ,
    input   wire                client0_cpl_bcm                 ,
    input   wire                client0_tlp_dv                  ,
    input   wire                client0_tlp_eot                 ,
    input   wire                client0_tlp_bad_eot             ,
    input   wire                client0_tlp_hv                  ,
    input   wire    [4:0]       client0_tlp_type                ,
    input   wire    [1:0]       client0_tlp_fmt                 ,
    input   wire                client0_tlp_td                  ,
    input   wire    [12:0]      client0_tlp_byte_len            ,
    input   wire    [9:0]       client0_tlp_tid                 ,
    input   wire                client0_tlp_ep                  ,
    input   wire                client0_tlp_func_num            ,
    input   wire    [1:0]       client0_tlp_vfunc_num           ,
    input   wire    [1:0]       client0_tlp_ats                 ,
    input   wire    [7:0]       client0_tlp_st                  ,
    input   wire                client0_tlp_vfunc_active        ,
    input   wire                client0_tlp_nw                  ,
    input   wire                client0_tlp_th                  ,
    input   wire    [1:0]       client0_tlp_ph                  ,
    input   wire                client0_tlp_atu_bypass          ,
    input   wire    [9:0]       client0_cpl_lookup_id           ,
    output  wire                xadm_client0_halt               ,

    // client1 user interface

    input   wire    [127:0]     client1_tlp_data                ,
    input   wire    [63:0]      client1_tlp_addr                ,
    input   wire    [15:0]      client1_remote_req_id           ,
    input   wire    [7:0]       client1_tlp_byte_en             ,
    input   wire    [11:0]      client1_cpl_byte_cnt            ,
    input   wire                client1_addr_align_en           ,
    input   wire    [2:0]       client1_tlp_tc                  ,
    input   wire    [2:0]       client1_tlp_attr                ,
    input   wire    [2:0]       client1_cpl_status              ,
    input   wire                client1_cpl_bcm                 ,
    input   wire                client1_tlp_dv                  ,
    input   wire                client1_tlp_eot                 ,
    input   wire                client1_tlp_bad_eot             ,
    input   wire                client1_tlp_hv                  ,
    input   wire    [4:0]       client1_tlp_type                ,
    input   wire    [1:0]       client1_tlp_fmt                 ,
    input   wire                client1_tlp_td                  ,
    input   wire    [12:0]      client1_tlp_byte_len            ,
    input   wire    [9:0]       client1_tlp_tid                 ,
    input   wire                client1_tlp_ep                  ,
    input   wire                client1_tlp_func_num            ,
    input   wire    [1:0]       client1_tlp_vfunc_num           ,
    input   wire    [1:0]       client1_tlp_ats                 ,
    input   wire    [7:0]       client1_tlp_st                  ,
    input   wire                client1_tlp_vfunc_active        ,
    input   wire                client1_tlp_nw                  ,
    input   wire                client1_tlp_th                  ,
    input   wire    [1:0]       client1_tlp_ph                  ,
    input   wire                client1_tlp_atu_bypass          ,
    input   wire    [9:0]       client1_cpl_lookup_id           ,
    output  wire                xadm_client1_halt               ,
    // trgt user interface
    output  wire                radm_trgt1_dv                   ,
    output  wire                radm_trgt1_hv                   ,
    output  wire                radm_trgt1_eot                  ,
    output  wire                radm_trgt1_tlp_abort            ,
    output  wire                radm_trgt1_dllp_abort           ,
    output  wire                radm_trgt1_ecrc_err             ,
    output  wire    [3:0]       radm_trgt1_dwen                 ,
    output  wire    [1:0]       radm_trgt1_fmt                  ,
    output  wire    [2:0]       radm_trgt1_attr                 ,
    output  wire                radm_trgt1_func_num             ,
    output  wire    [4:0]       radm_trgt1_type                 ,
    output  wire    [2:0]       radm_trgt1_tc                   ,
    output  wire    [15:0]      radm_trgt1_reqid                ,
    output  wire    [127:0]     radm_trgt1_data                 ,
    output  wire    [3:0]       radm_trgt1_first_be             ,
    output  wire    [3:0]       radm_trgt1_last_be              ,
    output  wire    [63:0]      radm_trgt1_addr                 ,
    output  wire    [1:0]       radm_trgt1_vfunc_num            ,
    output  wire                radm_trgt1_vfunc_active         ,
    output  wire                radm_trgt1_td                   ,
    output  wire                radm_trgt1_poisoned             ,
    output  wire                radm_trgt1_hdr_uppr_bytes_valid ,
    output  wire                radm_trgt1_rom_in_range         ,
    output  wire                radm_trgt1_io_req_in_range      ,
    output  wire    [63:0]      radm_trgt1_hdr_uppr_bytes       ,
    output  wire    [2:0]       radm_trgt1_in_membar_range      ,
    output  wire    [2:0]       radm_trgt1_cpl_status           ,
    output  wire    [1:0]       radm_trgt1_ats                  ,
    output  wire    [9:0]       radm_trgt1_tag                  ,
    output  wire    [9:0]       radm_trgt1_dw_len               ,
    output  wire                radm_trgt1_nw                   ,
    output  wire                radm_trgt1_th                   ,
    output  wire    [1:0]       radm_trgt1_ph                   ,
    output  wire    [7:0]       radm_trgt1_st                   ,
    output  wire    [11:0]      radm_trgt1_byte_cnt             ,
    output  wire                radm_trgt1_bcm                  ,
    output  wire    [2:0]       radm_trgt1_vc                   ,
    output  wire    [15:0]      radm_trgt1_cmpltr_id            ,
    output  wire                radm_trgt1_cpl_last             ,
    output  wire    [2:0]       radm_grant_tlp_type             ,
    output  wire    [1:0]       radm_trgt1_atu_sloc_match       ,
    output  wire    [1:0]       radm_trgt1_atu_cbuf_err         ,
    output  wire    [9:0]       trgt_lookup_id                  ,
    output  wire                trgt_lookup_empty               ,
    input   wire                trgt1_radm_halt                 ,
    input   wire    [2:0]       trgt1_radm_pkt_halt             ,
    
    // radm_bypass user interface
    output  wire    [127:0]     radm_bypass_data                ,
    output  wire    [3:0]       radm_bypass_dwen                ,
    output  wire                radm_bypass_dv                  ,
    output  wire                radm_bypass_hv                  ,
    output  wire                radm_bypass_eot                 ,
    output  wire                radm_bypass_dllp_abort          ,
    output  wire                radm_bypass_tlp_abort           ,
    output  wire                radm_bypass_ecrc_err            ,
    output  wire    [63:0]      radm_bypass_addr                ,
    output  wire    [1:0]       radm_bypass_fmt                 ,
    output  wire    [2:0]       radm_bypass_tc                  ,
    output  wire    [2:0]       radm_bypass_attr                ,
    output  wire    [15:0]      radm_bypass_reqid               ,
    output  wire    [4:0]       radm_bypass_type                ,
    output  wire    [9:0]       radm_bypass_tag                 ,
    output  wire                radm_bypass_func_num            ,
    output  wire    [1:0]       radm_bypass_vfunc_num           ,
    output  wire                radm_bypass_vfunc_active        ,
    output  wire                radm_bypass_td                  ,
    output  wire                radm_bypass_poisoned            ,
    output  wire    [9:0]       radm_bypass_dw_len              ,
    output  wire                radm_bypass_rom_in_range        ,
    output  wire    [3:0]       radm_bypass_first_be            ,
    output  wire    [3:0]       radm_bypass_last_be             ,
    output  wire                radm_bypass_io_req_in_range     ,
    output  wire    [2:0]       radm_bypass_in_membar_range     ,
    output  wire                radm_bypass_cpl_last            ,
    output  wire    [2:0]       radm_bypass_cpl_status          ,
    output  wire    [7:0]       radm_bypass_st                  ,
    output  wire    [15:0]      radm_bypass_cmpltr_id           ,
    output  wire    [11:0]      radm_bypass_byte_cnt            ,
    output  wire    [1:0]       radm_bypass_ats                 ,
    output  wire                radm_bypass_th                  ,
    output  wire    [1:0]       radm_bypass_ph                  ,
    output  wire                radm_bypass_bcm                 ,

    // elbi user interface
    output  wire    [31:0]      lbc_ext_addr                    ,
    output  wire    [1:0]       lbc_ext_cs                      ,
    output  wire    [3:0]       lbc_ext_wr                      ,
    output  wire                lbc_ext_rom_access              ,
    output  wire                lbc_ext_io_access               ,
    output  wire    [31:0]      lbc_ext_dout                    ,
    output  wire    [2:0]       lbc_ext_bar_num                 ,
    output  wire                lbc_ext_vfunc_active            ,
    output  wire    [1:0]       lbc_ext_vfunc_num               ,
    input   wire    [63:0]      ext_lbc_din                     ,
    input   wire    [1:0]       ext_lbc_ack                     ,

    // ext drp interface
    input   wire    [31:0]      ext_drp_dbi_din                 ,
    input   wire    [3:0]       ext_drp_dbi_wr                  ,
    input   wire    [31:0]      ext_drp_dbi_addr                ,
    input   wire                ext_drp_dbi_cs                  ,
    input   wire                ext_drp_dbi_cs2_exp             ,
    input   wire    [1:0]       ext_drp_dbi_vfunc_num           ,
    input   wire                ext_drp_dbi_vfunc_active        ,
    input   wire    [2:0]       ext_drp_dbi_bar_num             ,
    input   wire                ext_drp_dbi_rom_access          ,
    input   wire                ext_drp_dbi_io_access           ,
    input   wire                ext_drp_dbi_func_num            ,
    input   wire                ext_drp_app_dbi_ro_wr_disable   ,
    output  wire    [31:0]      ext_drp_lbc_dbi_dout            ,
    output  wire                ext_drp_lbc_dbi_ack             ,

    // msi interface
    output  wire                ven_msi_grant                   ,
    input   wire                ven_msi_req                     ,
    input   wire                ven_msi_func_num                ,
    input   wire    [63:0]      cfg_msi_pending                 ,
    input   wire    [1:0]       ven_msi_vfunc_num               ,
    input   wire                ven_msi_vfunc_active            ,
    input   wire    [2:0]       ven_msi_tc                      ,
    input   wire    [4:0]       ven_msi_vector                  ,
    output  wire    [1:0]       cfg_msi_en                      ,
    output  wire    [63:0]      cfg_msi_mask                    ,

    // system interface
    input   wire                app_power_up_rst_n              ,
    input   wire                app_auxclk                      ,
    output  wire                user_clk                        ,
    output  wire                core_clk                        ,
    output  wire                user_link

);

// ====================================================================
// Parameter/wire/reg
// ====================================================================

    //wire              core_clk                        ;
    wire                core_rst_n                      ;
    wire                app_perst_n             =1'b1   ;
    wire                app_button_rst_n        =1'b1   ;
    wire                app_app_ltssm_enable            ;
    wire                rdlh_link_up                    ;

    wire                gen1_ready                      ;
    wire                dbi_done                        ;
    wire    [5:0]       smlh_ltssm_state                ;

    // Clinet0
    wire    [127:0]     client0_tlp_data_core           ;
    wire    [63:0]      client0_tlp_addr_core           ;
    wire    [15:0]      client0_remote_req_id_core      ;
    wire    [7:0]       client0_tlp_byte_en_core        ;
    wire    [11:0]      client0_cpl_byte_cnt_core       ;
    wire                client0_addr_align_en_core      ;
    wire    [2:0]       client0_tlp_tc_core             ;
    wire    [2:0]       client0_tlp_attr_core           ;
    wire    [2:0]       client0_cpl_status_core         ;
    wire                client0_cpl_bcm_core            ;
    wire                client0_tlp_dv_core             ;
    wire                client0_tlp_eot_core            ;
    wire                client0_tlp_bad_eot_core        ;
    wire                client0_tlp_hv_core             ;
    wire    [4:0]       client0_tlp_type_core           ;
    wire    [1:0]       client0_tlp_fmt_core            ;
    wire                client0_tlp_td_core             ;
    wire    [12:0]      client0_tlp_byte_len_core       ;
    wire    [9:0]       client0_tlp_tid_core            ;
    wire                client0_tlp_ep_core             ;
    wire                client0_tlp_func_num_core       ;
    wire    [1:0]       client0_tlp_vfunc_num_core      ;
    wire    [1:0]       client0_tlp_ats_core            ;
    wire    [7:0]       client0_tlp_st_core             ;
    wire                client0_tlp_vfunc_active_core   ;
    wire                client0_tlp_nw_core             ;
    wire                client0_tlp_th_core             ;
    wire    [1:0]       client0_tlp_ph_core             ;
    wire                client0_tlp_atu_bypass_core     ;
    wire    [9:0]       client0_cpl_lookup_id_core      ;
    wire                xadm_client0_halt_core          ;
    
    // Clinet1
    wire    [127:0]     client1_tlp_data_core           ;
    wire    [63:0]      client1_tlp_addr_core           ;
    wire    [15:0]      client1_remote_req_id_core      ;
    wire    [7:0]       client1_tlp_byte_en_core        ;
    wire    [11:0]      client1_cpl_byte_cnt_core       ;
    wire                client1_addr_align_en_core      ;
    wire    [2:0]       client1_tlp_tc_core             ;
    wire    [2:0]       client1_tlp_attr_core           ;
    wire    [2:0]       client1_cpl_status_core         ;
    wire                client1_cpl_bcm_core            ;
    wire                client1_tlp_dv_core             ;
    wire                client1_tlp_eot_core            ;
    wire                client1_tlp_bad_eot_core        ;
    wire                client1_tlp_hv_core             ;
    wire    [4:0]       client1_tlp_type_core           ;
    wire    [1:0]       client1_tlp_fmt_core            ;
    wire                client1_tlp_td_core             ;
    wire    [12:0]      client1_tlp_byte_len_core       ;
    wire    [9:0]       client1_tlp_tid_core            ;
    wire                client1_tlp_ep_core             ;
    wire                client1_tlp_func_num_core       ;
    wire    [1:0]       client1_tlp_vfunc_num_core      ;
    wire    [1:0]       client1_tlp_ats_core            ;
    wire    [7:0]       client1_tlp_st_core             ;
    wire                client1_tlp_vfunc_active_core   ;
    wire                client1_tlp_nw_core             ;
    wire                client1_tlp_th_core             ;
    wire    [1:0]       client1_tlp_ph_core             ;
    wire                client1_tlp_atu_bypass_core     ;
    wire    [9:0]       client1_cpl_lookup_id_core      ;
    wire                xadm_client1_halt_core          ;
    // radm trgt1
    wire                radm_trgt1_dv_core                   ;
    wire                radm_trgt1_hv_core                   ;
    wire                radm_trgt1_eot_core                  ;
    wire                radm_trgt1_tlp_abort_core            ;
    wire                radm_trgt1_dllp_abort_core           ;
    wire                radm_trgt1_ecrc_err_core             ;
    wire    [3:0]       radm_trgt1_dwen_core                 ;
    wire    [1:0]       radm_trgt1_fmt_core                  ;
    wire    [2:0]       radm_trgt1_attr_core                 ;
    wire                radm_trgt1_func_num_core             ;
    wire    [4:0]       radm_trgt1_type_core                 ;
    wire    [2:0]       radm_trgt1_tc_core                   ;
    wire    [15:0]      radm_trgt1_reqid_core                ;
    wire    [127:0]     radm_trgt1_data_core                 ;
    wire    [3:0]       radm_trgt1_first_be_core             ;
    wire    [3:0]       radm_trgt1_last_be_core              ;
    wire    [63:0]      radm_trgt1_addr_core                 ;
    wire    [1:0]       radm_trgt1_vfunc_num_core            ;
    wire                radm_trgt1_vfunc_active_core         ;
    wire                radm_trgt1_td_core                   ;
    wire                radm_trgt1_poisoned_core             ;
    wire                radm_trgt1_hdr_uppr_bytes_valid_core ;
    wire                radm_trgt1_rom_in_range_core         ;
    wire                radm_trgt1_io_req_in_range_core      ;
    wire    [63:0]      radm_trgt1_hdr_uppr_bytes_core       ;
    wire    [2:0]       radm_trgt1_in_membar_range_core      ;
    wire    [2:0]       radm_trgt1_cpl_status_core           ;
    wire    [1:0]       radm_trgt1_ats_core                  ;
    wire    [9:0]       radm_trgt1_tag_core                  ;
    wire    [9:0]       radm_trgt1_dw_len_core               ;
    wire                radm_trgt1_nw_core                   ;
    wire                radm_trgt1_th_core                   ;
    wire    [1:0]       radm_trgt1_ph_core                   ;
    wire    [7:0]       radm_trgt1_st_core                   ;
    wire    [11:0]      radm_trgt1_byte_cnt_core             ;
    wire                radm_trgt1_bcm_core                  ;
    wire    [2:0]       radm_trgt1_vc_core                   ;
    wire    [15:0]      radm_trgt1_cmpltr_id_core            ;
    wire                radm_trgt1_cpl_last_core             ;
    wire    [2:0]       radm_grant_tlp_type_core             ;
    wire    [1:0]       radm_trgt1_atu_sloc_match_core       ;
    wire    [1:0]       radm_trgt1_atu_cbuf_err_core         ;
    wire    [9:0]       trgt_lookup_id_core                  ;
    wire                trgt_lookup_empty_core               ;
    wire                trgt1_radm_halt_core                 ;
    wire    [2:0]       trgt1_radm_pkt_halt_core             ;

    // radm bypass 
    wire    [127:0]     radm_bypass_data_core                ;
    wire    [3:0]       radm_bypass_dwen_core                ;
    wire                radm_bypass_dv_core                  ;
    wire                radm_bypass_hv_core                  ;
    wire                radm_bypass_eot_core                 ;
    wire                radm_bypass_dllp_abort_core          ;
    wire                radm_bypass_tlp_abort_core           ;
    wire                radm_bypass_ecrc_err_core            ;
    wire    [63:0]      radm_bypass_addr_core                ;
    wire    [1:0]       radm_bypass_fmt_core                 ;
    wire    [2:0]       radm_bypass_tc_core                  ;
    wire    [2:0]       radm_bypass_attr_core                ;
    wire    [15:0]      radm_bypass_reqid_core               ;
    wire    [4:0]       radm_bypass_type_core                ;
    wire    [9:0]       radm_bypass_tag_core                 ;
    wire                radm_bypass_func_num_core            ;
    wire    [1:0]       radm_bypass_vfunc_num_core           ;
    wire                radm_bypass_vfunc_active_core        ;
    wire                radm_bypass_td_core                  ;
    wire                radm_bypass_poisoned_core            ;
    wire    [9:0]       radm_bypass_dw_len_core              ;
    wire                radm_bypass_rom_in_range_core        ;
    wire    [3:0]       radm_bypass_first_be_core            ;
    wire    [3:0]       radm_bypass_last_be_core             ;
    wire                radm_bypass_io_req_in_range_core     ;
    wire    [2:0]       radm_bypass_in_membar_range_core     ;
    wire                radm_bypass_cpl_last_core            ;
    wire    [2:0]       radm_bypass_cpl_status_core          ;
    wire    [7:0]       radm_bypass_st_core                  ;
    wire    [15:0]      radm_bypass_cmpltr_id_core           ;
    wire    [11:0]      radm_bypass_byte_cnt_core            ;
    wire    [1:0]       radm_bypass_ats_core                 ;
    wire                radm_bypass_th_core                  ;
    wire    [1:0]       radm_bypass_ph_core                  ;
    wire                radm_bypass_bcm_core                 ;

    // elbi
    wire    [31:0]      lbc_ext_addr_core                    ;
    wire    [1:0]       lbc_ext_cs_core                      ;
    wire    [3:0]       lbc_ext_wr_core                      ;
    wire                lbc_ext_rom_access_core              ;
    wire                lbc_ext_io_access_core               ;
    wire    [31:0]      lbc_ext_dout_core                    ;
    wire    [2:0]       lbc_ext_bar_num_core                 ;
    wire                lbc_ext_vfunc_active_core            ;
    wire    [1:0]       lbc_ext_vfunc_num_core               ;
    wire    [63:0]      ext_lbc_din_core                     ;
    wire    [1:0]       ext_lbc_ack_core                     ;

    // drp dbi
    wire    [31:0]      drp_dbi_din_user                     ;
    wire    [3:0]       drp_dbi_wr_user                      ;
    wire    [31:0]      drp_dbi_addr_user                    ;
    wire                drp_dbi_cs_user                      ;
    wire                drp_dbi_cs2_exp_user                 ;
    wire    [1:0]       drp_dbi_vfunc_num_user               ;
    wire                drp_dbi_vfunc_active_user            ;
    wire    [2:0]       drp_dbi_bar_num_user                 ;
    wire                drp_dbi_rom_access_user              ;
    wire                drp_dbi_io_access_user               ;
    wire                drp_dbi_func_num_user                ;
    wire                drp_app_dbi_ro_wr_disable_user       ;
    wire    [31:0]      drp_lbc_dbi_dout_user                ;
    wire                drp_lbc_dbi_ack_user                 ;


    wire    [31:0]      drp_dbi_din_core                     ;
    wire    [3:0]       drp_dbi_wr_core                      ;
    wire    [31:0]      drp_dbi_addr_core                    ;
    wire                drp_dbi_cs_core                      ;
    wire                drp_dbi_cs2_exp_core                 ;
    wire    [1:0]       drp_dbi_vfunc_num_core               ;
    wire                drp_dbi_vfunc_active_core            ;
    wire    [2:0]       drp_dbi_bar_num_core                 ;
    wire                drp_dbi_rom_access_core              ;
    wire                drp_dbi_io_access_core               ;
    wire                drp_dbi_func_num_core                ;
    wire                drp_app_dbi_ro_wr_disable_core       ;
    wire    [31:0]      drp_lbc_dbi_dout_core                ;
    wire                drp_lbc_dbi_ack_core                 ;

    wire                app_app_ltssm_enable_user            ;              
    wire                app_app_ltssm_enable_core            ;              

// ====================================================================
// Main Code
// ====================================================================

ph1_pcie_ctrl#(
    .AUX_FREQ                       (25_000_000                        ),
    .PHASE_CNT                      (16                                )
)u_ph1_pcie_ctrl(

    .core_clk                       (core_clk                          ),
    .aux_clk                        (app_auxclk                        ),

    .core_rst_n                     (core_rst_n                        ),
    .rdlh_link_up                   (rdlh_link_up                      ),

    .gen1_ready                     (gen1_ready                        ),
    .dbi_done                       (dbi_done                          ),

  //.phase_vld                      (phase_vld                         ),
  //.phase_data                     (phase_data                        ),

    .user_clk                       (user_clk                          ),
    .user_link                      (user_link                         )
 );
 
 
dbi_init_mux u_dbi_init_mux(

    .core_clk                       (user_clk                          ),
    .pcie_rst_n                     (gen1_ready                        ),
    .dbi_init_disable               (1'b0                              ),
    .dbi_init_done                  (dbi_done                          ),

    .ext_drp_dbi_din                (ext_drp_dbi_din                   ),
    .ext_drp_dbi_wr                 (ext_drp_dbi_wr                    ),
    .ext_drp_dbi_addr               (ext_drp_dbi_addr                  ),
    .ext_drp_dbi_cs                 (ext_drp_dbi_cs                    ),
    .ext_drp_dbi_cs2_exp            (ext_drp_dbi_cs2_exp               ),
    .ext_drp_dbi_vfunc_num          (ext_drp_dbi_vfunc_num             ),
    .ext_drp_dbi_vfunc_active       (ext_drp_dbi_vfunc_active          ),
    .ext_drp_dbi_bar_num            (ext_drp_dbi_bar_num               ),
    .ext_drp_dbi_rom_access         (ext_drp_dbi_rom_access            ),
    .ext_drp_dbi_io_access          (ext_drp_dbi_io_access             ),
    .ext_drp_dbi_func_num           (ext_drp_dbi_func_num              ),
    .ext_drp_app_dbi_ro_wr_disable  (ext_drp_app_dbi_ro_wr_disable     ),
    .ext_drp_lbc_dbi_ack            (ext_drp_lbc_dbi_ack               ),
    .ext_drp_lbc_dbi_dout           (ext_drp_lbc_dbi_dout              ),

    .drp_dbi_din                    (drp_dbi_din_user                  ),
    .drp_dbi_wr                     (drp_dbi_wr_user                   ),
    .drp_dbi_addr                   (drp_dbi_addr_user                 ),
    .drp_dbi_cs                     (drp_dbi_cs_user                   ),
    .drp_dbi_cs2_exp                (drp_dbi_cs2_exp_user              ),
    .drp_dbi_vfunc_num              (drp_dbi_vfunc_num_user            ),
    .drp_dbi_vfunc_active           (drp_dbi_vfunc_active_user         ),
    .drp_dbi_bar_num                (drp_dbi_bar_num_user              ),
    .drp_dbi_rom_access             (drp_dbi_rom_access_user           ),
    .drp_dbi_io_access              (drp_dbi_io_access_user            ),
    .drp_dbi_func_num               (drp_dbi_func_num_user             ),
    .drp_app_dbi_ro_wr_disable      (drp_app_dbi_ro_wr_disable_user    ),
    .drp_lbc_dbi_ack                (drp_lbc_dbi_ack_user              ),
    .drp_lbc_dbi_dout               (drp_lbc_dbi_dout_user             ),

    .app_app_ltssm_enable           (app_app_ltssm_enable_user         )
);

//--------------------------------------------
// pcie ip inst
//--------------------------------------------  

pcie_ep u_pcie_ep (
        .refclk_p                          (refclk_p                          ),
        .refclk_n                          (refclk_n                          ),
        .txp                               (txp                               ),
        .txn                               (txn                               ),
        .rxp                               (rxp                               ),
        .rxn                               (rxn                               ),
        .client0_tlp_data                  (client0_tlp_data_core             ),
        .client0_tlp_addr                  (client0_tlp_addr_core             ),
        .client0_remote_req_id             (client0_remote_req_id_core        ),
        .client0_tlp_byte_en               (client0_tlp_byte_en_core          ),
        .client0_cpl_byte_cnt              (client0_cpl_byte_cnt_core         ),
        .client0_addr_align_en             (client0_addr_align_en_core        ),
        .client0_tlp_tc                    (client0_tlp_tc_core               ),
        .client0_tlp_attr                  (client0_tlp_attr_core             ),
        .client0_cpl_status                (client0_cpl_status_core           ),
        .client0_cpl_bcm                   (client0_cpl_bcm_core              ),
        .client0_tlp_dv                    (client0_tlp_dv_core               ),
        .client0_tlp_eot                   (client0_tlp_eot_core              ),
        .client0_tlp_bad_eot               (client0_tlp_bad_eot_core          ),
        .client0_tlp_hv                    (client0_tlp_hv_core               ),
        .client0_tlp_type                  (client0_tlp_type_core             ),
        .client0_tlp_fmt                   (client0_tlp_fmt_core              ),
        .client0_tlp_td                    (client0_tlp_td_core               ),
        .client0_tlp_byte_len              (client0_tlp_byte_len_core         ),
        .client0_tlp_tid                   (client0_tlp_tid_core              ),
        .client0_tlp_ep                    (client0_tlp_ep_core               ),
        .client0_tlp_func_num              (client0_tlp_func_num_core         ),
        .client0_tlp_vfunc_num             (client0_tlp_vfunc_num_core        ),
        .client0_tlp_ats                   (client0_tlp_ats_core              ),
        .client0_tlp_st                    (client0_tlp_st_core               ),
        .client0_tlp_vfunc_active          (client0_tlp_vfunc_active_core     ),
        .client0_tlp_nw                    (client0_tlp_nw_core               ),
        .client0_tlp_th                    (client0_tlp_th_core               ),
        .client0_tlp_ph                    (client0_tlp_ph_core               ),
        .client0_tlp_atu_bypass            (client0_tlp_atu_bypass_core       ),
        .client1_tlp_data                  (client1_tlp_data_core             ),
        .client1_tlp_addr                  (client1_tlp_addr_core             ),
        .client1_remote_req_id             (client1_remote_req_id_core        ),
        .client1_tlp_byte_en               (client1_tlp_byte_en_core          ),
        .client1_cpl_byte_cnt              (client1_cpl_byte_cnt_core         ),
        .client1_addr_align_en             (client1_addr_align_en_core        ),
        .client1_tlp_tc                    (client1_tlp_tc_core               ),
        .client1_tlp_attr                  (client1_tlp_attr_core             ),
        .client1_cpl_status                (client1_cpl_status_core           ),
        .client1_cpl_bcm                   (client1_cpl_bcm_core              ),
        .client1_tlp_dv                    (client1_tlp_dv_core               ),
        .client1_tlp_eot                   (client1_tlp_eot_core              ),
        .client1_tlp_bad_eot               (client1_tlp_bad_eot_core          ),
        .client1_tlp_hv                    (client1_tlp_hv_core               ),
        .client1_tlp_type                  (client1_tlp_type_core             ),
        .client1_tlp_fmt                   (client1_tlp_fmt_core              ),
        .client1_tlp_td                    (client1_tlp_td_core               ),
        .client1_tlp_byte_len              (client1_tlp_byte_len_core         ),
        .client1_tlp_tid                   (client1_tlp_tid_core              ),
        .client1_tlp_ep                    (client1_tlp_ep_core               ),
        .client1_tlp_func_num              (client1_tlp_func_num_core         ),
        .client1_tlp_vfunc_num             (client1_tlp_vfunc_num_core        ),
        .client1_tlp_ats                   (client1_tlp_ats_core              ),
        .client1_tlp_st                    (client1_tlp_st_core               ),
        .client1_tlp_vfunc_active          (client1_tlp_vfunc_active_core     ),
        .client1_tlp_nw                    (client1_tlp_nw_core               ),
        .client1_tlp_th                    (client1_tlp_th_core               ),
        .client1_tlp_ph                    (client1_tlp_ph_core               ),
        .client1_tlp_atu_bypass            (client1_tlp_atu_bypass_core       ),
        .trgt1_radm_halt                   (trgt1_radm_halt_core              ),
        .trgt1_radm_pkt_halt               (trgt1_radm_pkt_halt_core          ),
        .ext_lbc_din                       (ext_lbc_din_core                  ),
        .ext_lbc_ack                       (ext_lbc_ack_core                  ),
        .sys_atten_button_pressed          (2'b0                              ),
        .sys_pre_det_state                 (2'b0                              ),
        .sys_mrl_sensor_state              (2'b0                              ),
        .sys_pwr_fault_det                 (2'b0                              ),
        .sys_mrl_sensor_chged              (2'b0                              ),
        .sys_pre_det_chged                 (2'b0                              ),
        .sys_cmd_cpled_int                 (2'b0                              ),
        .sys_eml_interlock_engaged         (2'b0                              ),
        .rx_lane_flip_en                   (1'b0                              ),
        .tx_lane_flip_en                   (1'b0                              ),
        .app_req_retry_en                  (1'b0                              ),
        .app_sris_mode                     (1'b0                              ),
        .app_vf_req_retry_en               (4'b0                              ),
        .app_pf_req_retry_en               (2'b0                              ),
        .app_unlock_msg                    (1'b0                              ),
        .app_hdr_log                       (128'b0                            ),
        .app_err_bus                       (13'b0                             ),
        .app_err_advisory                  (1'b0                              ),
        .app_err_func_num                  (1'b0                              ),
        .app_err_vfunc_active              (1'b0                              ),
        .app_hdr_valid                     (1'b0                              ),
        .app_err_vfunc_num                 (2'b0                              ),
        .client0_cpl_lookup_id             (client0_cpl_lookup_id_core        ),
        .app_perst_n                       (app_perst_n                       ),
        .app_power_up_rst_n                (app_power_up_rst_n                ),
        .app_button_rst_n                  (app_button_rst_n                  ),
        .app_app_ltssm_enable              (app_app_ltssm_enable              ),
        .app_auxclk                        (app_auxclk                        ),
        .drp_dbi_din                       (drp_dbi_din_core                  ),
        .drp_dbi_wr                        (drp_dbi_wr_core                   ),
        .drp_dbi_addr                      (drp_dbi_addr_core                 ),
        .drp_dbi_cs                        (drp_dbi_cs_core                   ),
        .drp_dbi_cs2_exp                   (drp_dbi_cs2_exp_core              ),
        .drp_dbi_vfunc_num                 (drp_dbi_vfunc_num_core            ),
        .drp_dbi_vfunc_active              (drp_dbi_vfunc_active_core         ),
        .drp_dbi_bar_num                   (drp_dbi_bar_num_core              ),
        .drp_dbi_rom_access                (drp_dbi_rom_access_core           ),
        .drp_dbi_io_access                 (drp_dbi_io_access_core            ),
        .drp_dbi_func_num                  (drp_dbi_func_num_core             ),
        .drp_app_dbi_ro_wr_disable         (drp_app_dbi_ro_wr_disable_core    ),
        .phy_cr_para_clk                   (app_auxclk                        ),
        .xadm_client0_halt                 (xadm_client0_halt_core            ),
        .radm_bypass_data                  (radm_bypass_data_core             ),
        .radm_bypass_dwen                  (radm_bypass_dwen_core             ),
        .radm_bypass_dv                    (radm_bypass_dv_core               ),
        .radm_bypass_hv                    (radm_bypass_hv_core               ),
        .radm_bypass_eot                   (radm_bypass_eot_core              ),
        .radm_bypass_dllp_abort            (radm_bypass_dllp_abort_core       ),
        .radm_bypass_tlp_abort             (radm_bypass_tlp_abort_core        ),
        .radm_bypass_ecrc_err              (radm_bypass_ecrc_err_core         ),
        .radm_bypass_addr                  (radm_bypass_addr_core             ),
        .radm_bypass_fmt                   (radm_bypass_fmt_core              ),
        .radm_bypass_tc                    (radm_bypass_tc_core               ),
        .radm_bypass_attr                  (radm_bypass_attr_core             ),
        .radm_bypass_reqid                 (radm_bypass_reqid_core            ),
        .radm_bypass_type                  (radm_bypass_type_core             ),
        .radm_bypass_tag                   (radm_bypass_tag_core              ),
        .radm_bypass_func_num              (radm_bypass_func_num_core         ),
        .radm_bypass_vfunc_num             (radm_bypass_vfunc_num_core        ),
        .radm_bypass_vfunc_active          (radm_bypass_vfunc_active_core     ),
        .radm_bypass_td                    (radm_bypass_td_core               ),
        .radm_bypass_poisoned              (radm_bypass_poisoned_core         ),
        .radm_bypass_dw_len                (radm_bypass_dw_len_core           ),
        .radm_bypass_rom_in_range          (radm_bypass_rom_in_range_core     ),
        .radm_bypass_first_be              (radm_bypass_first_be_core         ),
        .radm_bypass_last_be               (radm_bypass_last_be_core          ),
        .radm_bypass_io_req_in_range       (radm_bypass_io_req_in_range_core  ),
        .radm_bypass_in_membar_range       (radm_bypass_in_membar_range_core  ),
        .radm_bypass_cpl_last              (radm_bypass_cpl_last_core         ),
        .radm_bypass_cpl_status            (radm_bypass_cpl_status_core       ),
        .radm_bypass_st                    (radm_bypass_st_core               ),
        .radm_bypass_cmpltr_id             (radm_bypass_cmpltr_id_core        ),
        .radm_bypass_byte_cnt              (radm_bypass_byte_cnt_core         ),
        .radm_bypass_ats                   (radm_bypass_ats_core              ),
        .radm_bypass_th                    (radm_bypass_th_core               ),
        .radm_bypass_ph                    (radm_bypass_ph_core               ),
        .radm_bypass_bcm                   (radm_bypass_bcm_core              ),
        .radm_trgt1_dv                     (radm_trgt1_dv_core                ),
        .radm_trgt1_hv                     (radm_trgt1_hv_core                ),
        .radm_trgt1_eot                    (radm_trgt1_eot_core               ),
        .radm_trgt1_tlp_abort              (radm_trgt1_tlp_abort_core         ),
        .radm_trgt1_dllp_abort             (radm_trgt1_dllp_abort_core        ),
        .radm_trgt1_ecrc_err               (radm_trgt1_ecrc_err_core          ),
        .radm_trgt1_dwen                   (radm_trgt1_dwen_core              ),
        .radm_trgt1_fmt                    (radm_trgt1_fmt_core               ),
        .radm_trgt1_attr                   (radm_trgt1_attr_core              ),
        .radm_trgt1_func_num               (radm_trgt1_func_num_core          ),
        .radm_trgt1_type                   (radm_trgt1_type_core              ),
        .radm_trgt1_tc                     (radm_trgt1_tc_core                ),
        .radm_trgt1_reqid                  (radm_trgt1_reqid_core             ),
        .radm_trgt1_data                   (radm_trgt1_data_core              ),
        .radm_trgt1_first_be               (radm_trgt1_first_be_core          ),
        .radm_trgt1_last_be                (radm_trgt1_last_be_core           ),
        .radm_trgt1_addr                   (radm_trgt1_addr_core              ),
        .radm_trgt1_vfunc_num              (radm_trgt1_vfunc_num_core         ),
        .radm_trgt1_vfunc_active           (radm_trgt1_vfunc_active_core      ),
        .radm_trgt1_td                     (radm_trgt1_td_core                ),
        .radm_trgt1_poisoned               (radm_trgt1_poisoned_core          ),
        .radm_trgt1_hdr_uppr_bytes_valid   (radm_trgt1_hdr_uppr_bytes_valid_core),
        .radm_trgt1_rom_in_range           (radm_trgt1_rom_in_range_core      ),
        .radm_trgt1_io_req_in_range        (radm_trgt1_io_req_in_range_core   ),
        .radm_trgt1_hdr_uppr_bytes         (radm_trgt1_hdr_uppr_bytes_core    ),
        .radm_trgt1_in_membar_range        (radm_trgt1_in_membar_range_core   ),
        .radm_trgt1_cpl_status             (radm_trgt1_cpl_status_core        ),
        .radm_trgt1_ats                    (radm_trgt1_ats_core               ),
        .radm_trgt1_tag                    (radm_trgt1_tag_core               ),
        .radm_trgt1_dw_len                 (radm_trgt1_dw_len_core            ),
        .radm_trgt1_nw                     (radm_trgt1_nw_core                ),
        .radm_trgt1_th                     (radm_trgt1_th_core                ),
        .radm_trgt1_ph                     (radm_trgt1_ph_core                ),
        .radm_trgt1_st                     (radm_trgt1_st_core                ),
        .radm_trgt1_byte_cnt               (radm_trgt1_byte_cnt_core          ),
        .radm_trgt1_bcm                    (radm_trgt1_bcm_core               ),
        .radm_trgt1_vc                     (radm_trgt1_vc_core                ),
        .radm_trgt1_cmpltr_id              (radm_trgt1_cmpltr_id_core         ),
        .radm_trgt1_cpl_last               (radm_trgt1_cpl_last_core          ),
        .radm_grant_tlp_type               (radm_grant_tlp_type_core          ),
        .radm_trgt1_atu_sloc_match         (radm_trgt1_atu_sloc_match_core    ),
        .radm_trgt1_atu_cbuf_err           (radm_trgt1_atu_cbuf_err_core      ),
        .training_rst_n                    (),
        .lbc_ext_addr                      (lbc_ext_addr_core                 ),
        .lbc_ext_cs                        (lbc_ext_cs_core                   ),
        .lbc_ext_wr                        (lbc_ext_wr_core                   ),
        .lbc_ext_rom_access                (lbc_ext_rom_access_core           ),
        .lbc_ext_io_access                 (lbc_ext_io_access_core            ),
        .lbc_ext_dout                      (lbc_ext_dout_core                 ),
        .lbc_ext_bar_num                   (lbc_ext_bar_num_core              ),
        .lbc_ext_vfunc_active              (lbc_ext_vfunc_active_core         ),
        .lbc_ext_vfunc_num                 (lbc_ext_vfunc_num_core            ),
        .rdlh_link_up                      (rdlh_link_up                      ),
        .cfg_vf_bme                        (),
        .radm_vendor_msg                   (),
        .radm_msg_payload                  (),
        .radm_msg_req_id                   (),
        .cfg_send_cor_err                  (),
        .cfg_send_nf_err                   (),
        .cfg_send_f_err                    (),
        .cfg_link_eq_req_int               (),
        .smlh_req_rst_not                  (),
        .link_req_rst_not                  (),
        .radm_msg_unlock                   (),
        .smlh_ltssm_state                  (smlh_ltssm_state                  ),
        .radm_cpl_timeout                  (),
        .radm_timeout_func_num             (),
        .radm_timeout_vfunc_num            (),
        .radm_timeout_vfunc_active         (),
        .radm_timeout_cpl_tc               (),
        .radm_timeout_cpl_attr             (),
        .radm_timeout_cpl_tag              (),
        .radm_timeout_cpl_len              (),
        .pm_xtlh_block_tlp                 (),
        .cfg_phy_control                   (),
        .cfg_hw_auto_sp_dis                (),
        .smlh_ltssm_state_rcvry_eq         (),
        .trgt_cpl_timeout                  (),
        .trgt_timeout_cpl_func_num         (),
        .trgt_timeout_cpl_vfunc_num        (),
        .trgt_timeout_cpl_vfunc_active     (),
        .trgt_timeout_cpl_tc               (),
        .trgt_timeout_cpl_attr             (),
        .trgt_timeout_cpl_len              (),
        .trgt_timeout_lookup_id            (),
        .trgt_lookup_id                    (trgt_lookup_id_core                    ),
        .trgt_lookup_empty                 (trgt_lookup_empty_core                 ),
        .cfg_reg_serren                    (),
        .cfg_cor_err_rpt_en                (),
        .cfg_nf_err_rpt_en                 (),
        .cfg_f_err_rpt_en                  (),
        .cfg_uncor_internal_err_sts        (),
        .cfg_rcvr_overflow_err_sts         (),
        .cfg_fc_protocol_err_sts           (),
        .cfg_mlf_tlp_err_sts               (),
        .cfg_surprise_down_er_sts          (),
        .cfg_dl_protocol_err_sts           (),
        .cfg_ecrc_err_sts                  (),
        .cfg_corrected_internal_err_sts    (),
        .cfg_replay_number_rollover_err_sts(),
        .cfg_replay_timer_timeout_err_sts  (),
        .cfg_bad_dllp_err_sts              (),
        .cfg_bad_tlp_err_sts               (),
        .cfg_rcvr_err_sts                  (),
        .ven_msi_grant                     (ven_msi_grant                     ),
        .ven_msi_req                       (ven_msi_req                       ),
        .ven_msi_func_num                  (ven_msi_func_num                  ),
        .cfg_msi_pending                   (cfg_msi_pending                   ),
        .ven_msi_vfunc_num                 (ven_msi_vfunc_num                 ),
        .ven_msi_vfunc_active              (ven_msi_vfunc_active              ),
        .ven_msi_tc                        (ven_msi_tc                        ),
        .ven_msi_vector                    (ven_msi_vector                    ),
        .cfg_msi_en                        (cfg_msi_en                        ),
        .cfg_msi_mask                      (cfg_msi_mask                      ),
        .core_rst_n                        (core_rst_n                        ),
        .drp_lbc_dbi_dout                  (drp_lbc_dbi_dout_core             ),
        .drp_lbc_dbi_ack                   (drp_lbc_dbi_ack_core              ),
        .core_clk                          (core_clk                          ),
        .muxd_aux_clk                      (),
        .muxd_aux_clk_g                    ()
) ;

pcie_basic_top u_pcie_basic_top(

    `ifdef XALI0_SIG_EN
        .client0_tlp_data_user                (client0_tlp_data                     ),
        .client0_tlp_addr_user                (client0_tlp_addr                     ),
        .client0_remote_req_id_user           (client0_remote_req_id                ),
        .client0_tlp_byte_en_user             (client0_tlp_byte_en                  ),
        .client0_cpl_byte_cnt_user            (client0_cpl_byte_cnt                 ),
        .client0_addr_align_en_user           (client0_addr_align_en                ),
        .client0_tlp_tc_user                  (client0_tlp_tc                       ),
        .client0_tlp_attr_user                (client0_tlp_attr                     ),
        .client0_cpl_status_user              (client0_cpl_status                   ),
        .client0_cpl_bcm_user                 (client0_cpl_bcm                      ),
        .client0_tlp_dv_user                  (client0_tlp_dv                       ),
        .client0_tlp_eot_user                 (client0_tlp_eot                      ),
        .client0_tlp_bad_eot_user             (client0_tlp_bad_eot                  ),
        .client0_tlp_hv_user                  (client0_tlp_hv                       ),
        .client0_tlp_type_user                (client0_tlp_type                     ),
        .client0_tlp_fmt_user                 (client0_tlp_fmt                      ),
        .client0_tlp_td_user                  (client0_tlp_td                       ),
        .client0_tlp_byte_len_user            (client0_tlp_byte_len                 ),
        .client0_tlp_tid_user                 (client0_tlp_tid                      ),
        .client0_tlp_ep_user                  (client0_tlp_ep                       ),
        .client0_tlp_func_num_user            (client0_tlp_func_num                 ),
        .client0_tlp_vfunc_num_user           (client0_tlp_vfunc_num                ),
        .client0_tlp_ats_user                 (client0_tlp_ats                      ),
        .client0_tlp_st_user                  (client0_tlp_st                       ),
        .client0_tlp_vfunc_active_user        (client0_tlp_vfunc_active             ),
        .client0_tlp_nw_user                  (client0_tlp_nw                       ),
        .client0_tlp_th_user                  (client0_tlp_th                       ),
        .client0_tlp_ph_user                  (client0_tlp_ph                       ),
        .client0_tlp_atu_bypass_user          (client0_tlp_atu_bypass               ),
        .client0_cpl_lookup_id_user           (client0_cpl_lookup_id                ),
        .xadm_client0_halt_user               (xadm_client0_halt                    ),
                                                                                    
        .client0_tlp_data_core                (client0_tlp_data_core                ),
        .client0_tlp_addr_core                (client0_tlp_addr_core                ),
        .client0_remote_req_id_core           (client0_remote_req_id_core           ),
        .client0_tlp_byte_en_core             (client0_tlp_byte_en_core             ),
        .client0_cpl_byte_cnt_core            (client0_cpl_byte_cnt_core            ),
        .client0_addr_align_en_core           (client0_addr_align_en_core           ),
        .client0_tlp_tc_core                  (client0_tlp_tc_core                  ),
        .client0_tlp_attr_core                (client0_tlp_attr_core                ),
        .client0_cpl_status_core              (client0_cpl_status_core              ),
        .client0_cpl_bcm_core                 (client0_cpl_bcm_core                 ),
        .client0_tlp_dv_core                  (client0_tlp_dv_core                  ),
        .client0_tlp_eot_core                 (client0_tlp_eot_core                 ),
        .client0_tlp_bad_eot_core             (client0_tlp_bad_eot_core             ),
        .client0_tlp_hv_core                  (client0_tlp_hv_core                  ),
        .client0_tlp_type_core                (client0_tlp_type_core                ),
        .client0_tlp_fmt_core                 (client0_tlp_fmt_core                 ),
        .client0_tlp_td_core                  (client0_tlp_td_core                  ),
        .client0_tlp_byte_len_core            (client0_tlp_byte_len_core            ),
        .client0_tlp_tid_core                 (client0_tlp_tid_core                 ),
        .client0_tlp_ep_core                  (client0_tlp_ep_core                  ),
        .client0_tlp_func_num_core            (client0_tlp_func_num_core            ),
        .client0_tlp_vfunc_num_core           (client0_tlp_vfunc_num_core           ),
        .client0_tlp_ats_core                 (client0_tlp_ats_core                 ),
        .client0_tlp_st_core                  (client0_tlp_st_core                  ),
        .client0_tlp_vfunc_active_core        (client0_tlp_vfunc_active_core        ),
        .client0_tlp_nw_core                  (client0_tlp_nw_core                  ),
        .client0_tlp_th_core                  (client0_tlp_th_core                  ),
        .client0_tlp_ph_core                  (client0_tlp_ph_core                  ),
        .client0_tlp_atu_bypass_core          (client0_tlp_atu_bypass_core          ),
        .client0_cpl_lookup_id_core           (client0_cpl_lookup_id_core           ),
        .xadm_client0_halt_core               (xadm_client0_halt_core               ),
    `endif

    `ifdef XALI1_SIG_EN
        .client1_tlp_data_user                (client1_tlp_data                     ),
        .client1_tlp_addr_user                (client1_tlp_addr                     ),
        .client1_remote_req_id_user           (client1_remote_req_id                ),
        .client1_tlp_byte_en_user             (client1_tlp_byte_en                  ),
        .client1_cpl_byte_cnt_user            (client1_cpl_byte_cnt                 ),
        .client1_addr_align_en_user           (client1_addr_align_en                ),
        .client1_tlp_tc_user                  (client1_tlp_tc                       ),
        .client1_tlp_attr_user                (client1_tlp_attr                     ),
        .client1_cpl_status_user              (client1_cpl_status                   ),
        .client1_cpl_bcm_user                 (client1_cpl_bcm                      ),
        .client1_tlp_dv_user                  (client1_tlp_dv                       ),
        .client1_tlp_eot_user                 (client1_tlp_eot                      ),
        .client1_tlp_bad_eot_user             (client1_tlp_bad_eot                  ),
        .client1_tlp_hv_user                  (client1_tlp_hv                       ),
        .client1_tlp_type_user                (client1_tlp_type                     ),
        .client1_tlp_fmt_user                 (client1_tlp_fmt                      ),
        .client1_tlp_td_user                  (client1_tlp_td                       ),
        .client1_tlp_byte_len_user            (client1_tlp_byte_len                 ),
        .client1_tlp_tid_user                 (client1_tlp_tid                      ),
        .client1_tlp_ep_user                  (client1_tlp_ep                       ),
        .client1_tlp_func_num_user            (client1_tlp_func_num                 ),
        .client1_tlp_vfunc_num_user           (client1_tlp_vfunc_num                ),
        .client1_tlp_ats_user                 (client1_tlp_ats                      ),
        .client1_tlp_st_user                  (client1_tlp_st                       ),
        .client1_tlp_vfunc_active_user        (client1_tlp_vfunc_active             ),
        .client1_tlp_nw_user                  (client1_tlp_nw                       ),
        .client1_tlp_th_user                  (client1_tlp_th                       ),
        .client1_tlp_ph_user                  (client1_tlp_ph                       ),
        .client1_tlp_atu_bypass_user          (client1_tlp_atu_bypass               ),
        .client1_cpl_lookup_id_user           (client1_cpl_lookup_id                ),
        .xadm_client1_halt_user               (xadm_client1_halt                    ),
                                                                                    
        .client1_tlp_data_core                (client1_tlp_data_core                ),
        .client1_tlp_addr_core                (client1_tlp_addr_core                ),
        .client1_remote_req_id_core           (client1_remote_req_id_core           ),
        .client1_tlp_byte_en_core             (client1_tlp_byte_en_core             ),
        .client1_cpl_byte_cnt_core            (client1_cpl_byte_cnt_core            ),
        .client1_addr_align_en_core           (client1_addr_align_en_core           ),
        .client1_tlp_tc_core                  (client1_tlp_tc_core                  ),
        .client1_tlp_attr_core                (client1_tlp_attr_core                ),
        .client1_cpl_status_core              (client1_cpl_status_core              ),
        .client1_cpl_bcm_core                 (client1_cpl_bcm_core                 ),
        .client1_tlp_dv_core                  (client1_tlp_dv_core                  ),
        .client1_tlp_eot_core                 (client1_tlp_eot_core                 ),
        .client1_tlp_bad_eot_core             (client1_tlp_bad_eot_core             ),
        .client1_tlp_hv_core                  (client1_tlp_hv_core                  ),
        .client1_tlp_type_core                (client1_tlp_type_core                ),
        .client1_tlp_fmt_core                 (client1_tlp_fmt_core                 ),
        .client1_tlp_td_core                  (client1_tlp_td_core                  ),
        .client1_tlp_byte_len_core            (client1_tlp_byte_len_core            ),
        .client1_tlp_tid_core                 (client1_tlp_tid_core                 ),
        .client1_tlp_ep_core                  (client1_tlp_ep_core                  ),
        .client1_tlp_func_num_core            (client1_tlp_func_num_core            ),
        .client1_tlp_vfunc_num_core           (client1_tlp_vfunc_num_core           ),
        .client1_tlp_ats_core                 (client1_tlp_ats_core                 ),
        .client1_tlp_st_core                  (client1_tlp_st_core                  ),
        .client1_tlp_vfunc_active_core        (client1_tlp_vfunc_active_core        ),
        .client1_tlp_nw_core                  (client1_tlp_nw_core                  ),
        .client1_tlp_th_core                  (client1_tlp_th_core                  ),
        .client1_tlp_ph_core                  (client1_tlp_ph_core                  ),
        .client1_tlp_atu_bypass_core          (client1_tlp_atu_bypass_core          ),
        .client1_cpl_lookup_id_core           (client1_cpl_lookup_id_core           ),
        .xadm_client1_halt_core               (xadm_client1_halt_core               ),
    `endif

    `ifdef TRGT1_SIG_EN
        .radm_trgt1_dv_user                   (radm_trgt1_dv                        ),
        .radm_trgt1_hv_user                   (radm_trgt1_hv                        ),
        .radm_trgt1_eot_user                  (radm_trgt1_eot                       ),
        .radm_trgt1_tlp_abort_user            (radm_trgt1_tlp_abort                 ),
        .radm_trgt1_dllp_abort_user           (radm_trgt1_dllp_abort                ),
        .radm_trgt1_ecrc_err_user             (radm_trgt1_ecrc_err                  ),
        .radm_trgt1_dwen_user                 (radm_trgt1_dwen                      ),
        .radm_trgt1_fmt_user                  (radm_trgt1_fmt                       ),
        .radm_trgt1_attr_user                 (radm_trgt1_attr                      ),
        .radm_trgt1_func_num_user             (radm_trgt1_func_num                  ),
        .radm_trgt1_type_user                 (radm_trgt1_type                      ),
        .radm_trgt1_tc_user                   (radm_trgt1_tc                        ),
        .radm_trgt1_reqid_user                (radm_trgt1_reqid                     ),
        .radm_trgt1_data_user                 (radm_trgt1_data                      ),
        .radm_trgt1_first_be_user             (radm_trgt1_first_be                  ),
        .radm_trgt1_last_be_user              (radm_trgt1_last_be                   ),
        .radm_trgt1_addr_user                 (radm_trgt1_addr                      ),
        .radm_trgt1_vfunc_num_user            (radm_trgt1_vfunc_num                 ),
        .radm_trgt1_vfunc_active_user         (radm_trgt1_vfunc_active              ),
        .radm_trgt1_td_user                   (radm_trgt1_td                        ),
        .radm_trgt1_poisoned_user             (radm_trgt1_poisoned                  ),
        .radm_trgt1_hdr_uppr_bytes_valid_user (radm_trgt1_hdr_uppr_bytes_valid      ),
        .radm_trgt1_rom_in_range_user         (radm_trgt1_rom_in_range              ),
        .radm_trgt1_io_req_in_range_user      (radm_trgt1_io_req_in_range           ),
        .radm_trgt1_hdr_uppr_bytes_user       (radm_trgt1_hdr_uppr_bytes            ),
        .radm_trgt1_in_membar_range_user      (radm_trgt1_in_membar_range           ),
        .radm_trgt1_cpl_status_user           (radm_trgt1_cpl_status                ),
        .radm_trgt1_ats_user                  (radm_trgt1_ats                       ),
        .radm_trgt1_tag_user                  (radm_trgt1_tag                       ),
        .radm_trgt1_dw_len_user               (radm_trgt1_dw_len                    ),
        .radm_trgt1_nw_user                   (radm_trgt1_nw                        ),
        .radm_trgt1_th_user                   (radm_trgt1_th                        ),
        .radm_trgt1_ph_user                   (radm_trgt1_ph                        ),
        .radm_trgt1_st_user                   (radm_trgt1_st                        ),
        .radm_trgt1_byte_cnt_user             (radm_trgt1_byte_cnt                  ),
        .radm_trgt1_bcm_user                  (radm_trgt1_bcm                       ),
        .radm_trgt1_vc_user                   (radm_trgt1_vc                        ),
        .radm_trgt1_cmpltr_id_user            (radm_trgt1_cmpltr_id                 ),
        .radm_trgt1_cpl_last_user             (radm_trgt1_cpl_last                  ),
        .radm_grant_tlp_type_user             (radm_grant_tlp_type                  ),
        .radm_trgt1_atu_sloc_match_user       (radm_trgt1_atu_sloc_match            ),
        .radm_trgt1_atu_cbuf_err_user         (radm_trgt1_atu_cbuf_err              ),
        .trgt_lookup_id_user                  (trgt_lookup_id                       ),
        .trgt_lookup_empty_user               (trgt_lookup_empty                    ),
        .trgt1_radm_halt_user                 (trgt1_radm_halt                      ),
        .trgt1_radm_pkt_halt_user             (trgt1_radm_pkt_halt                  ),

        .radm_trgt1_dv_core                   (radm_trgt1_dv_core                   ),
        .radm_trgt1_hv_core                   (radm_trgt1_hv_core                   ),
        .radm_trgt1_eot_core                  (radm_trgt1_eot_core                  ),
        .radm_trgt1_tlp_abort_core            (radm_trgt1_tlp_abort_core            ),
        .radm_trgt1_dllp_abort_core           (radm_trgt1_dllp_abort_core           ),
        .radm_trgt1_ecrc_err_core             (radm_trgt1_ecrc_err_core             ),
        .radm_trgt1_dwen_core                 (radm_trgt1_dwen_core                 ),
        .radm_trgt1_fmt_core                  (radm_trgt1_fmt_core                  ),
        .radm_trgt1_attr_core                 (radm_trgt1_attr_core                 ),
        .radm_trgt1_func_num_core             (radm_trgt1_func_num_core             ),
        .radm_trgt1_type_core                 (radm_trgt1_type_core                 ),
        .radm_trgt1_tc_core                   (radm_trgt1_tc_core                   ),
        .radm_trgt1_reqid_core                (radm_trgt1_reqid_core                ),
        .radm_trgt1_data_core                 (radm_trgt1_data_core                 ),
        .radm_trgt1_first_be_core             (radm_trgt1_first_be_core             ),
        .radm_trgt1_last_be_core              (radm_trgt1_last_be_core              ),
        .radm_trgt1_addr_core                 (radm_trgt1_addr_core                 ),
        .radm_trgt1_vfunc_num_core            (radm_trgt1_vfunc_num_core            ),
        .radm_trgt1_vfunc_active_core         (radm_trgt1_vfunc_active_core         ),
        .radm_trgt1_td_core                   (radm_trgt1_td_core                   ),
        .radm_trgt1_poisoned_core             (radm_trgt1_poisoned_core             ),
        .radm_trgt1_hdr_uppr_bytes_valid_core (radm_trgt1_hdr_uppr_bytes_valid_core ),
        .radm_trgt1_rom_in_range_core         (radm_trgt1_rom_in_range_core         ),
        .radm_trgt1_io_req_in_range_core      (radm_trgt1_io_req_in_range_core      ),
        .radm_trgt1_hdr_uppr_bytes_core       (radm_trgt1_hdr_uppr_bytes_core       ),
        .radm_trgt1_in_membar_range_core      (radm_trgt1_in_membar_range_core      ),
        .radm_trgt1_cpl_status_core           (radm_trgt1_cpl_status_core           ),
        .radm_trgt1_ats_core                  (radm_trgt1_ats_core                  ),
        .radm_trgt1_tag_core                  (radm_trgt1_tag_core                  ),
        .radm_trgt1_dw_len_core               (radm_trgt1_dw_len_core               ),
        .radm_trgt1_nw_core                   (radm_trgt1_nw_core                   ),
        .radm_trgt1_th_core                   (radm_trgt1_th_core                   ),
        .radm_trgt1_ph_core                   (radm_trgt1_ph_core                   ),
        .radm_trgt1_st_core                   (radm_trgt1_st_core                   ),
        .radm_trgt1_byte_cnt_core             (radm_trgt1_byte_cnt_core             ),
        .radm_trgt1_bcm_core                  (radm_trgt1_bcm_core                  ),
        .radm_trgt1_vc_core                   (radm_trgt1_vc_core                   ),
        .radm_trgt1_cmpltr_id_core            (radm_trgt1_cmpltr_id_core            ),
        .radm_trgt1_cpl_last_core             (radm_trgt1_cpl_last_core             ),
        .radm_grant_tlp_type_core             (radm_grant_tlp_type_core             ),
        .radm_trgt1_atu_sloc_match_core       (radm_trgt1_atu_sloc_match_core       ),
        .radm_trgt1_atu_cbuf_err_core         (radm_trgt1_atu_cbuf_err_core         ),
        .trgt_lookup_id_core                  (trgt_lookup_id_core                  ),
        .trgt_lookup_empty_core               (trgt_lookup_empty_core               ),
        .trgt1_radm_halt_core                 (trgt1_radm_halt_core                 ),
        .trgt1_radm_pkt_halt_core             (trgt1_radm_pkt_halt_core             ),
    `endif

    `ifdef BYPASS_SIG_EN
        .radm_bypass_data_user                (radm_bypass_data                     ),
        .radm_bypass_dwen_user                (radm_bypass_dwen                     ),
        .radm_bypass_dv_user                  (radm_bypass_dv                       ),
        .radm_bypass_hv_user                  (radm_bypass_hv                       ),
        .radm_bypass_eot_user                 (radm_bypass_eot                      ),
        .radm_bypass_dllp_abort_user          (radm_bypass_dllp_abort               ),
        .radm_bypass_tlp_abort_user           (radm_bypass_tlp_abort                ),
        .radm_bypass_ecrc_err_user            (radm_bypass_ecrc_err                 ),
        .radm_bypass_addr_user                (radm_bypass_addr                     ),
        .radm_bypass_fmt_user                 (radm_bypass_fmt                      ),
        .radm_bypass_tc_user                  (radm_bypass_tc                       ),
        .radm_bypass_attr_user                (radm_bypass_attr                     ),
        .radm_bypass_reqid_user               (radm_bypass_reqid                    ),
        .radm_bypass_type_user                (radm_bypass_type                     ),
        .radm_bypass_tag_user                 (radm_bypass_tag                      ),
        .radm_bypass_func_num_user            (radm_bypass_func_num                 ),
        .radm_bypass_vfunc_num_user           (radm_bypass_vfunc_num                ),
        .radm_bypass_vfunc_active_user        (radm_bypass_vfunc_active             ),
        .radm_bypass_td_user                  (radm_bypass_td                       ),
        .radm_bypass_poisoned_user            (radm_bypass_poisoned                 ),
        .radm_bypass_dw_len_user              (radm_bypass_dw_len                   ),
        .radm_bypass_rom_in_range_user        (radm_bypass_rom_in_range             ),
        .radm_bypass_first_be_user            (radm_bypass_first_be                 ),
        .radm_bypass_last_be_user             (radm_bypass_last_be                  ),
        .radm_bypass_io_req_in_range_user     (radm_bypass_io_req_in_range          ),
        .radm_bypass_in_membar_range_user     (radm_bypass_in_membar_range          ),
        .radm_bypass_cpl_last_user            (radm_bypass_cpl_last                 ),
        .radm_bypass_cpl_status_user          (radm_bypass_cpl_status               ),
        .radm_bypass_st_user                  (radm_bypass_st                       ),
        .radm_bypass_cmpltr_id_user           (radm_bypass_cmpltr_id                ),
        .radm_bypass_byte_cnt_user            (radm_bypass_byte_cnt                 ),
        .radm_bypass_ats_user                 (radm_bypass_ats                      ),
        .radm_bypass_th_user                  (radm_bypass_th                       ),
        .radm_bypass_ph_user                  (radm_bypass_ph                       ),
        .radm_bypass_bcm_user                 (radm_bypass_bcm                      ),
                                                                                    
        .radm_bypass_data_core                (radm_bypass_data_core                ),
        .radm_bypass_dwen_core                (radm_bypass_dwen_core                ),
        .radm_bypass_dv_core                  (radm_bypass_dv_core                  ),
        .radm_bypass_hv_core                  (radm_bypass_hv_core                  ),
        .radm_bypass_eot_core                 (radm_bypass_eot_core                 ),
        .radm_bypass_dllp_abort_core          (radm_bypass_dllp_abort_core          ),
        .radm_bypass_tlp_abort_core           (radm_bypass_tlp_abort_core           ),
        .radm_bypass_ecrc_err_core            (radm_bypass_ecrc_err_core            ),
        .radm_bypass_addr_core                (radm_bypass_addr_core                ),
        .radm_bypass_fmt_core                 (radm_bypass_fmt_core                 ),
        .radm_bypass_tc_core                  (radm_bypass_tc_core                  ),
        .radm_bypass_attr_core                (radm_bypass_attr_core                ),
        .radm_bypass_reqid_core               (radm_bypass_reqid_core               ),
        .radm_bypass_type_core                (radm_bypass_type_core                ),
        .radm_bypass_tag_core                 (radm_bypass_tag_core                 ),
        .radm_bypass_func_num_core            (radm_bypass_func_num_core            ),
        .radm_bypass_vfunc_num_core           (radm_bypass_vfunc_num_core           ),
        .radm_bypass_vfunc_active_core        (radm_bypass_vfunc_active_core        ),
        .radm_bypass_td_core                  (radm_bypass_td_core                  ),
        .radm_bypass_poisoned_core            (radm_bypass_poisoned_core            ),
        .radm_bypass_dw_len_core              (radm_bypass_dw_len_core              ),
        .radm_bypass_rom_in_range_core        (radm_bypass_rom_in_range_core        ),
        .radm_bypass_first_be_core            (radm_bypass_first_be_core            ),
        .radm_bypass_last_be_core             (radm_bypass_last_be_core             ),
        .radm_bypass_io_req_in_range_core     (radm_bypass_io_req_in_range_core     ),
        .radm_bypass_in_membar_range_core     (radm_bypass_in_membar_range_core     ),
        .radm_bypass_cpl_last_core            (radm_bypass_cpl_last_core            ),
        .radm_bypass_cpl_status_core          (radm_bypass_cpl_status_core          ),
        .radm_bypass_st_core                  (radm_bypass_st_core                  ),
        .radm_bypass_cmpltr_id_core           (radm_bypass_cmpltr_id_core           ),
        .radm_bypass_byte_cnt_core            (radm_bypass_byte_cnt_core            ),
        .radm_bypass_ats_core                 (radm_bypass_ats_core                 ),
        .radm_bypass_th_core                  (radm_bypass_th_core                  ),
        .radm_bypass_ph_core                  (radm_bypass_ph_core                  ),
        .radm_bypass_bcm_core                 (radm_bypass_bcm_core                 ),
    `endif

    `ifdef ELBI_SIG_EN
        .lbc_ext_addr_user                    (lbc_ext_addr                         ),
        .lbc_ext_cs_user                      (lbc_ext_cs                           ),
        .lbc_ext_wr_user                      (lbc_ext_wr                           ),
        .lbc_ext_rom_access_user              (lbc_ext_rom_access                   ),
        .lbc_ext_io_access_user               (lbc_ext_io_access                    ),
        .lbc_ext_dout_user                    (lbc_ext_dout                         ),
        .lbc_ext_bar_num_user                 (lbc_ext_bar_num                      ),
        .lbc_ext_vfunc_active_user            (lbc_ext_vfunc_active                 ),
        .lbc_ext_vfunc_num_user               (lbc_ext_vfunc_num                    ),
        .ext_lbc_din_user                     (ext_lbc_din                          ),
        .ext_lbc_ack_user                     (ext_lbc_ack                          ),
                                                                                    
        .lbc_ext_addr_core                    (lbc_ext_addr_core                    ),
        .lbc_ext_cs_core                      (lbc_ext_cs_core                      ),
        .lbc_ext_wr_core                      (lbc_ext_wr_core                      ),
        .lbc_ext_rom_access_core              (lbc_ext_rom_access_core              ),
        .lbc_ext_io_access_core               (lbc_ext_io_access_core               ),
        .lbc_ext_dout_core                    (lbc_ext_dout_core                    ),
        .lbc_ext_bar_num_core                 (lbc_ext_bar_num_core                 ),
        .lbc_ext_vfunc_active_core            (lbc_ext_vfunc_active_core            ),
        .lbc_ext_vfunc_num_core               (lbc_ext_vfunc_num_core               ),
        .ext_lbc_din_core                     (ext_lbc_din_core                     ),
        .ext_lbc_ack_core                     (ext_lbc_ack_core                     ),
    `endif

    `ifdef DBI_SIG_EN
        .drp_dbi_din_user                     (drp_dbi_din_user                     ),
        .drp_dbi_wr_user                      (drp_dbi_wr_user                      ),
        .drp_dbi_addr_user                    (drp_dbi_addr_user                    ),
        .drp_dbi_cs_user                      (drp_dbi_cs_user                      ),
        .drp_dbi_cs2_exp_user                 (drp_dbi_cs2_exp_user                 ),
        .drp_dbi_vfunc_num_user               (drp_dbi_vfunc_num_user               ),
        .drp_dbi_vfunc_active_user            (drp_dbi_vfunc_active_user            ),
        .drp_dbi_bar_num_user                 (drp_dbi_bar_num_user                 ),
        .drp_dbi_rom_access_user              (drp_dbi_rom_access_user              ),
        .drp_dbi_io_access_user               (drp_dbi_io_access_user               ),
        .drp_dbi_func_num_user                (drp_dbi_func_num_user                ),
        .drp_app_dbi_ro_wr_disable_user       (drp_app_dbi_ro_wr_disable_user       ),
        .drp_lbc_dbi_dout_user                (drp_lbc_dbi_dout_user                ),
        .drp_lbc_dbi_ack_user                 (drp_lbc_dbi_ack_user                 ),
                                                                                    
        .drp_dbi_din_core                     (drp_dbi_din_core                     ),
        .drp_dbi_wr_core                      (drp_dbi_wr_core                      ),
        .drp_dbi_addr_core                    (drp_dbi_addr_core                    ),
        .drp_dbi_cs_core                      (drp_dbi_cs_core                      ),
        .drp_dbi_cs2_exp_core                 (drp_dbi_cs2_exp_core                 ),
        .drp_dbi_vfunc_num_core               (drp_dbi_vfunc_num_core               ),
        .drp_dbi_vfunc_active_core            (drp_dbi_vfunc_active_core            ),
        .drp_dbi_bar_num_core                 (drp_dbi_bar_num_core                 ),
        .drp_dbi_rom_access_core              (drp_dbi_rom_access_core              ),
        .drp_dbi_io_access_core               (drp_dbi_io_access_core               ),
        .drp_dbi_func_num_core                (drp_dbi_func_num_core                ),
        .drp_app_dbi_ro_wr_disable_core       (drp_app_dbi_ro_wr_disable_core       ),
        .drp_lbc_dbi_dout_core                (drp_lbc_dbi_dout_core                ),
        .drp_lbc_dbi_ack_core                 (drp_lbc_dbi_ack_core                 ),
    `endif


        .app_app_ltssm_enable_user            (app_app_ltssm_enable_user            ),
        .app_app_ltssm_enable                 (app_app_ltssm_enable                 ),

        .user_clk                             (user_clk                             ),
        .core_rst_n                           (core_rst_n                           ),
        .user_link_up                         (user_link                            )

);



endmodule
