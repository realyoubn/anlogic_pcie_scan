//////////////////////////////////////////////////////////////
//  Copyright(c) 2011-2022 Anlogic, Inc.
//  All Right Reserved.
//////////////////////////////////////////////////////////////
//  Company       : Anlogic
//  Filename      : pcie_basic_top.v
//  Author        : Dexin - dexin.guo@anlogic.com
//  Last Modified : 2023-07-12 13:34:16
//  Create        : 2023-07-03 09:28:06
//  Description   :
//
///////////////////////////////////////////////////////////////

`define XALI0_SIG_EN
`define XALI1_SIG_EN
`define TRGT1_SIG_EN
`define BYPASS_SIG_EN
`define ELBI_SIG_EN
`define DBI_SIG_EN

module pcie_basic_top(


    `ifdef XALI0_SIG_EN

        input   wire    [127:0]     client0_tlp_data_user                ,
        input   wire    [63:0]      client0_tlp_addr_user                ,
        input   wire    [15:0]      client0_remote_req_id_user           ,
        input   wire    [7:0]       client0_tlp_byte_en_user             ,
        input   wire    [11:0]      client0_cpl_byte_cnt_user            ,
        input   wire                client0_addr_align_en_user           ,
        input   wire    [2:0]       client0_tlp_tc_user                  ,
        input   wire    [2:0]       client0_tlp_attr_user                ,
        input   wire    [2:0]       client0_cpl_status_user              ,
        input   wire                client0_cpl_bcm_user                 ,
        input   wire                client0_tlp_dv_user                  ,
        input   wire                client0_tlp_eot_user                 ,
        input   wire                client0_tlp_bad_eot_user             ,
        input   wire                client0_tlp_hv_user                  ,
        input   wire    [4:0]       client0_tlp_type_user                ,
        input   wire    [1:0]       client0_tlp_fmt_user                 ,
        input   wire                client0_tlp_td_user                  ,
        input   wire    [12:0]      client0_tlp_byte_len_user            ,
        input   wire    [9:0]       client0_tlp_tid_user                 ,
        input   wire                client0_tlp_ep_user                  ,
        input   wire                client0_tlp_func_num_user            ,
        input   wire    [1:0]       client0_tlp_vfunc_num_user           ,
        input   wire    [1:0]       client0_tlp_ats_user                 ,
        input   wire    [7:0]       client0_tlp_st_user                  ,
        input   wire                client0_tlp_vfunc_active_user        ,
        input   wire                client0_tlp_nw_user                  ,
        input   wire                client0_tlp_th_user                  ,
        input   wire    [1:0]       client0_tlp_ph_user                  ,
        input   wire                client0_tlp_atu_bypass_user          ,
        input   wire    [9:0]       client0_cpl_lookup_id_user           ,
        output  wire                xadm_client0_halt_user               ,

        output  wire    [127:0]     client0_tlp_data_core                ,
        output  wire    [63:0]      client0_tlp_addr_core                ,
        output  wire    [15:0]      client0_remote_req_id_core           ,
        output  wire    [7:0]       client0_tlp_byte_en_core             ,
        output  wire    [11:0]      client0_cpl_byte_cnt_core            ,
        output  wire                client0_addr_align_en_core           ,
        output  wire    [2:0]       client0_tlp_tc_core                  ,
        output  wire    [2:0]       client0_tlp_attr_core                ,
        output  wire    [2:0]       client0_cpl_status_core              ,
        output  wire                client0_cpl_bcm_core                 ,
        output  wire                client0_tlp_dv_core                  ,
        output  wire                client0_tlp_eot_core                 ,
        output  wire                client0_tlp_bad_eot_core             ,
        output  wire                client0_tlp_hv_core                  ,
        output  wire    [4:0]       client0_tlp_type_core                ,
        output  wire    [1:0]       client0_tlp_fmt_core                 ,
        output  wire                client0_tlp_td_core                  ,
        output  wire    [12:0]      client0_tlp_byte_len_core            ,
        output  wire    [9:0]       client0_tlp_tid_core                 ,
        output  wire                client0_tlp_ep_core                  ,
        output  wire                client0_tlp_func_num_core            ,
        output  wire    [1:0]       client0_tlp_vfunc_num_core           ,
        output  wire    [1:0]       client0_tlp_ats_core                 ,
        output  wire    [7:0]       client0_tlp_st_core                  ,
        output  wire                client0_tlp_vfunc_active_core        ,
        output  wire                client0_tlp_nw_core                  ,
        output  wire                client0_tlp_th_core                  ,
        output  wire    [1:0]       client0_tlp_ph_core                  ,
        output  wire                client0_tlp_atu_bypass_core          ,
        output  wire    [9:0]       client0_cpl_lookup_id_core           ,
        input   wire                xadm_client0_halt_core               ,
    `endif

    `ifdef XALI1_SIG_EN

        input   wire    [127:0]     client1_tlp_data_user                ,
        input   wire    [63:0]      client1_tlp_addr_user                ,
        input   wire    [15:0]      client1_remote_req_id_user           ,
        input   wire    [7:0]       client1_tlp_byte_en_user             ,
        input   wire    [11:0]      client1_cpl_byte_cnt_user            ,
        input   wire                client1_addr_align_en_user           ,
        input   wire    [2:0]       client1_tlp_tc_user                  ,
        input   wire    [2:0]       client1_tlp_attr_user                ,
        input   wire    [2:0]       client1_cpl_status_user              ,
        input   wire                client1_cpl_bcm_user                 ,
        input   wire                client1_tlp_dv_user                  ,
        input   wire                client1_tlp_eot_user                 ,
        input   wire                client1_tlp_bad_eot_user             ,
        input   wire                client1_tlp_hv_user                  ,
        input   wire    [4:0]       client1_tlp_type_user                ,
        input   wire    [1:0]       client1_tlp_fmt_user                 ,
        input   wire                client1_tlp_td_user                  ,
        input   wire    [12:0]      client1_tlp_byte_len_user            ,
        input   wire    [9:0]       client1_tlp_tid_user                 ,
        input   wire                client1_tlp_ep_user                  ,
        input   wire                client1_tlp_func_num_user            ,
        input   wire    [1:0]       client1_tlp_vfunc_num_user           ,
        input   wire    [1:0]       client1_tlp_ats_user                 ,
        input   wire    [7:0]       client1_tlp_st_user                  ,
        input   wire                client1_tlp_vfunc_active_user        ,
        input   wire                client1_tlp_nw_user                  ,
        input   wire                client1_tlp_th_user                  ,
        input   wire    [1:0]       client1_tlp_ph_user                  ,
        input   wire                client1_tlp_atu_bypass_user          ,
        input   wire    [9:0]       client1_cpl_lookup_id_user           ,
        output  wire                xadm_client1_halt_user               ,

        output  wire    [127:0]     client1_tlp_data_core                ,
        output  wire    [63:0]      client1_tlp_addr_core                ,
        output  wire    [15:0]      client1_remote_req_id_core           ,
        output  wire    [7:0]       client1_tlp_byte_en_core             ,
        output  wire    [11:0]      client1_cpl_byte_cnt_core            ,
        output  wire                client1_addr_align_en_core           ,
        output  wire    [2:0]       client1_tlp_tc_core                  ,
        output  wire    [2:0]       client1_tlp_attr_core                ,
        output  wire    [2:0]       client1_cpl_status_core              ,
        output  wire                client1_cpl_bcm_core                 ,
        output  wire                client1_tlp_dv_core                  ,
        output  wire                client1_tlp_eot_core                 ,
        output  wire                client1_tlp_bad_eot_core             ,
        output  wire                client1_tlp_hv_core                  ,
        output  wire    [4:0]       client1_tlp_type_core                ,
        output  wire    [1:0]       client1_tlp_fmt_core                 ,
        output  wire                client1_tlp_td_core                  ,
        output  wire    [12:0]      client1_tlp_byte_len_core            ,
        output  wire    [9:0]       client1_tlp_tid_core                 ,
        output  wire                client1_tlp_ep_core                  ,
        output  wire                client1_tlp_func_num_core            ,
        output  wire    [1:0]       client1_tlp_vfunc_num_core           ,
        output  wire    [1:0]       client1_tlp_ats_core                 ,
        output  wire    [7:0]       client1_tlp_st_core                  ,
        output  wire                client1_tlp_vfunc_active_core        ,
        output  wire                client1_tlp_nw_core                  ,
        output  wire                client1_tlp_th_core                  ,
        output  wire    [1:0]       client1_tlp_ph_core                  ,
        output  wire                client1_tlp_atu_bypass_core          ,
        output  wire    [9:0]       client1_cpl_lookup_id_core           ,
        input   wire                xadm_client1_halt_core               ,
    `endif

    `ifdef TRGT1_SIG_EN
        output  wire                radm_trgt1_dv_user                   ,
        output  wire                radm_trgt1_hv_user                   ,
        output  wire                radm_trgt1_eot_user                  ,
        output  wire                radm_trgt1_tlp_abort_user            ,
        output  wire                radm_trgt1_dllp_abort_user           ,
        output  wire                radm_trgt1_ecrc_err_user             ,
        output  wire    [3:0]       radm_trgt1_dwen_user                 ,
        output  wire    [1:0]       radm_trgt1_fmt_user                  ,
        output  wire    [2:0]       radm_trgt1_attr_user                 ,
        output  wire                radm_trgt1_func_num_user             ,
        output  wire    [4:0]       radm_trgt1_type_user                 ,
        output  wire    [2:0]       radm_trgt1_tc_user                   ,
        output  wire    [15:0]      radm_trgt1_reqid_user                ,
        output  wire    [127:0]     radm_trgt1_data_user                 ,
        output  wire    [3:0]       radm_trgt1_first_be_user             ,
        output  wire    [3:0]       radm_trgt1_last_be_user              ,
        output  wire    [63:0]      radm_trgt1_addr_user                 ,
        output  wire    [1:0]       radm_trgt1_vfunc_num_user            ,
        output  wire                radm_trgt1_vfunc_active_user         ,
        output  wire                radm_trgt1_td_user                   ,
        output  wire                radm_trgt1_poisoned_user             ,
        output  wire                radm_trgt1_hdr_uppr_bytes_valid_user ,
        output  wire                radm_trgt1_rom_in_range_user         ,
        output  wire                radm_trgt1_io_req_in_range_user      ,
        output  wire    [63:0]      radm_trgt1_hdr_uppr_bytes_user       ,
        output  wire    [2:0]       radm_trgt1_in_membar_range_user      ,
        output  wire    [2:0]       radm_trgt1_cpl_status_user           ,
        output  wire    [1:0]       radm_trgt1_ats_user                  ,
        output  wire    [9:0]       radm_trgt1_tag_user                  ,
        output  wire    [9:0]       radm_trgt1_dw_len_user               ,
        output  wire                radm_trgt1_nw_user                   ,
        output  wire                radm_trgt1_th_user                   ,
        output  wire    [1:0]       radm_trgt1_ph_user                   ,
        output  wire    [7:0]       radm_trgt1_st_user                   ,
        output  wire    [11:0]      radm_trgt1_byte_cnt_user             ,
        output  wire                radm_trgt1_bcm_user                  ,
        output  wire    [2:0]       radm_trgt1_vc_user                   ,
        output  wire    [15:0]      radm_trgt1_cmpltr_id_user            ,
        output  wire                radm_trgt1_cpl_last_user             ,
        output  wire    [2:0]       radm_grant_tlp_type_user             ,
        output  wire    [1:0]       radm_trgt1_atu_sloc_match_user       ,
        output  wire    [1:0]       radm_trgt1_atu_cbuf_err_user         ,
        output  wire    [9:0]       trgt_lookup_id_user                  ,
        output  wire                trgt_lookup_empty_user               ,
        input   wire                trgt1_radm_halt_user                 ,
        input   wire    [2:0]       trgt1_radm_pkt_halt_user             ,

        input   wire                radm_trgt1_dv_core                   ,
        input   wire                radm_trgt1_hv_core                   ,
        input   wire                radm_trgt1_eot_core                  ,
        input   wire                radm_trgt1_tlp_abort_core            ,
        input   wire                radm_trgt1_dllp_abort_core           ,
        input   wire                radm_trgt1_ecrc_err_core             ,
        input   wire    [3:0]       radm_trgt1_dwen_core                 ,
        input   wire    [1:0]       radm_trgt1_fmt_core                  ,
        input   wire    [2:0]       radm_trgt1_attr_core                 ,
        input   wire                radm_trgt1_func_num_core             ,
        input   wire    [4:0]       radm_trgt1_type_core                 ,
        input   wire    [2:0]       radm_trgt1_tc_core                   ,
        input   wire    [15:0]      radm_trgt1_reqid_core                ,
        input   wire    [127:0]     radm_trgt1_data_core                 ,
        input   wire    [3:0]       radm_trgt1_first_be_core             ,
        input   wire    [3:0]       radm_trgt1_last_be_core              ,
        input   wire    [63:0]      radm_trgt1_addr_core                 ,
        input   wire    [1:0]       radm_trgt1_vfunc_num_core            ,
        input   wire                radm_trgt1_vfunc_active_core         ,
        input   wire                radm_trgt1_td_core                   ,
        input   wire                radm_trgt1_poisoned_core             ,
        input   wire                radm_trgt1_hdr_uppr_bytes_valid_core ,
        input   wire                radm_trgt1_rom_in_range_core         ,
        input   wire                radm_trgt1_io_req_in_range_core      ,
        input   wire    [63:0]      radm_trgt1_hdr_uppr_bytes_core       ,
        input   wire    [2:0]       radm_trgt1_in_membar_range_core      ,
        input   wire    [2:0]       radm_trgt1_cpl_status_core           ,
        input   wire    [1:0]       radm_trgt1_ats_core                  ,
        input   wire    [9:0]       radm_trgt1_tag_core                  ,
        input   wire    [9:0]       radm_trgt1_dw_len_core               ,
        input   wire                radm_trgt1_nw_core                   ,
        input   wire                radm_trgt1_th_core                   ,
        input   wire    [1:0]       radm_trgt1_ph_core                   ,
        input   wire    [7:0]       radm_trgt1_st_core                   ,
        input   wire    [11:0]      radm_trgt1_byte_cnt_core             ,
        input   wire                radm_trgt1_bcm_core                  ,
        input   wire    [2:0]       radm_trgt1_vc_core                   ,
        input   wire    [15:0]      radm_trgt1_cmpltr_id_core            ,
        input   wire                radm_trgt1_cpl_last_core             ,
        input   wire    [2:0]       radm_grant_tlp_type_core             ,
        input   wire    [1:0]       radm_trgt1_atu_sloc_match_core       ,
        input   wire    [1:0]       radm_trgt1_atu_cbuf_err_core         ,
        input   wire    [9:0]       trgt_lookup_id_core                  ,
        input   wire                trgt_lookup_empty_core               ,
        output  wire                trgt1_radm_halt_core                 ,
        output  wire    [2:0]       trgt1_radm_pkt_halt_core             ,
    `endif

    `ifdef BYPASS_SIG_EN
        output  wire    [127:0]     radm_bypass_data_user                ,
        output  wire    [3:0]       radm_bypass_dwen_user                ,
        output  wire                radm_bypass_dv_user                  ,
        output  wire                radm_bypass_hv_user                  ,
        output  wire                radm_bypass_eot_user                 ,
        output  wire                radm_bypass_dllp_abort_user          ,
        output  wire                radm_bypass_tlp_abort_user           ,
        output  wire                radm_bypass_ecrc_err_user            ,
        output  wire    [63:0]      radm_bypass_addr_user                ,
        output  wire    [1:0]       radm_bypass_fmt_user                 ,
        output  wire    [2:0]       radm_bypass_tc_user                  ,
        output  wire    [2:0]       radm_bypass_attr_user                ,
        output  wire    [15:0]      radm_bypass_reqid_user               ,
        output  wire    [4:0]       radm_bypass_type_user                ,
        output  wire    [9:0]       radm_bypass_tag_user                 ,
        output  wire                radm_bypass_func_num_user            ,
        output  wire    [1:0]       radm_bypass_vfunc_num_user           ,
        output  wire                radm_bypass_vfunc_active_user        ,
        output  wire                radm_bypass_td_user                  ,
        output  wire                radm_bypass_poisoned_user            ,
        output  wire    [9:0]       radm_bypass_dw_len_user              ,
        output  wire                radm_bypass_rom_in_range_user        ,
        output  wire    [3:0]       radm_bypass_first_be_user            ,
        output  wire    [3:0]       radm_bypass_last_be_user             ,
        output  wire                radm_bypass_io_req_in_range_user     ,
        output  wire    [2:0]       radm_bypass_in_membar_range_user     ,
        output  wire                radm_bypass_cpl_last_user            ,
        output  wire    [2:0]       radm_bypass_cpl_status_user          ,
        output  wire    [7:0]       radm_bypass_st_user                  ,
        output  wire    [15:0]      radm_bypass_cmpltr_id_user           ,
        output  wire    [11:0]      radm_bypass_byte_cnt_user            ,
        output  wire    [1:0]       radm_bypass_ats_user                 ,
        output  wire                radm_bypass_th_user                  ,
        output  wire    [1:0]       radm_bypass_ph_user                  ,
        output  wire                radm_bypass_bcm_user                 ,

        input   wire    [127:0]     radm_bypass_data_core                ,
        input   wire    [3:0]       radm_bypass_dwen_core                ,
        input   wire                radm_bypass_dv_core                  ,
        input   wire                radm_bypass_hv_core                  ,
        input   wire                radm_bypass_eot_core                 ,
        input   wire                radm_bypass_dllp_abort_core          ,
        input   wire                radm_bypass_tlp_abort_core           ,
        input   wire                radm_bypass_ecrc_err_core            ,
        input   wire    [63:0]      radm_bypass_addr_core                ,
        input   wire    [1:0]       radm_bypass_fmt_core                 ,
        input   wire    [2:0]       radm_bypass_tc_core                  ,
        input   wire    [2:0]       radm_bypass_attr_core                ,
        input   wire    [15:0]      radm_bypass_reqid_core               ,
        input   wire    [4:0]       radm_bypass_type_core                ,
        input   wire    [9:0]       radm_bypass_tag_core                 ,
        input   wire                radm_bypass_func_num_core            ,
        input   wire    [1:0]       radm_bypass_vfunc_num_core           ,
        input   wire                radm_bypass_vfunc_active_core        ,
        input   wire                radm_bypass_td_core                  ,
        input   wire                radm_bypass_poisoned_core            ,
        input   wire    [9:0]       radm_bypass_dw_len_core              ,
        input   wire                radm_bypass_rom_in_range_core        ,
        input   wire    [3:0]       radm_bypass_first_be_core            ,
        input   wire    [3:0]       radm_bypass_last_be_core             ,
        input   wire                radm_bypass_io_req_in_range_core     ,
        input   wire    [2:0]       radm_bypass_in_membar_range_core     ,
        input   wire                radm_bypass_cpl_last_core            ,
        input   wire    [2:0]       radm_bypass_cpl_status_core          ,
        input   wire    [7:0]       radm_bypass_st_core                  ,
        input   wire    [15:0]      radm_bypass_cmpltr_id_core           ,
        input   wire    [11:0]      radm_bypass_byte_cnt_core            ,
        input   wire    [1:0]       radm_bypass_ats_core                 ,
        input   wire                radm_bypass_th_core                  ,
        input   wire    [1:0]       radm_bypass_ph_core                  ,
        input   wire                radm_bypass_bcm_core                 ,
    `endif

    `ifdef ELBI_SIG_EN
        output  wire    [31:0]      lbc_ext_addr_user                    ,
        output  wire    [1:0]       lbc_ext_cs_user                      ,
        output  wire    [3:0]       lbc_ext_wr_user                      ,
        output  wire                lbc_ext_rom_access_user              ,
        output  wire                lbc_ext_io_access_user               ,
        output  wire    [31:0]      lbc_ext_dout_user                    ,
        output  wire    [2:0]       lbc_ext_bar_num_user                 ,
        output  wire                lbc_ext_vfunc_active_user            ,
        output  wire    [1:0]       lbc_ext_vfunc_num_user               ,
        input   wire    [63:0]      ext_lbc_din_user                     ,
        input   wire    [1:0]       ext_lbc_ack_user                     ,

        input   wire    [31:0]      lbc_ext_addr_core                    ,
        input   wire    [1:0]       lbc_ext_cs_core                      ,
        input   wire    [3:0]       lbc_ext_wr_core                      ,
        input   wire                lbc_ext_rom_access_core              ,
        input   wire                lbc_ext_io_access_core               ,
        input   wire    [31:0]      lbc_ext_dout_core                    ,
        input   wire    [2:0]       lbc_ext_bar_num_core                 ,
        input   wire                lbc_ext_vfunc_active_core            ,
        input   wire    [1:0]       lbc_ext_vfunc_num_core               ,
        output  wire    [63:0]      ext_lbc_din_core                     ,
        output  wire    [1:0]       ext_lbc_ack_core                     ,
    `endif

    `ifdef DBI_SIG_EN
        input   wire    [31:0]      drp_dbi_din_user                     ,
        input   wire    [3:0]       drp_dbi_wr_user                      ,
        input   wire    [31:0]      drp_dbi_addr_user                    ,
        input   wire                drp_dbi_cs_user                      ,
        input   wire                drp_dbi_cs2_exp_user                 ,
        input   wire    [1:0]       drp_dbi_vfunc_num_user               ,
        input   wire                drp_dbi_vfunc_active_user            ,
        input   wire    [2:0]       drp_dbi_bar_num_user                 ,
        input   wire                drp_dbi_rom_access_user              ,
        input   wire                drp_dbi_io_access_user               ,
        input   wire                drp_dbi_func_num_user                ,
        input   wire                drp_app_dbi_ro_wr_disable_user       ,
        output  wire   [31:0]       drp_lbc_dbi_dout_user                ,
        output  wire                drp_lbc_dbi_ack_user                 ,

        output  wire    [31:0]      drp_dbi_din_core                     ,
        output  wire    [3:0]       drp_dbi_wr_core                      ,
        output  wire    [31:0]      drp_dbi_addr_core                    ,
        output  wire                drp_dbi_cs_core                      ,
        output  wire                drp_dbi_cs2_exp_core                 ,
        output  wire    [1:0]       drp_dbi_vfunc_num_core               ,
        output  wire                drp_dbi_vfunc_active_core            ,
        output  wire    [2:0]       drp_dbi_bar_num_core                 ,
        output  wire                drp_dbi_rom_access_core              ,
        output  wire                drp_dbi_io_access_core               ,
        output  wire                drp_dbi_func_num_core                ,
        output  wire                drp_app_dbi_ro_wr_disable_core       ,
        input   wire   [31:0]       drp_lbc_dbi_dout_core                ,
        input   wire                drp_lbc_dbi_ack_core                 ,

    `endif

        input   wire                 app_app_ltssm_enable_user           ,
        output  reg                  app_app_ltssm_enable                ,

        input   wire                 user_clk                            ,
        input   wire                 core_rst_n                          ,
        input   wire                 user_link_up

);


always@(posedge user_clk or negedge core_rst_n ) begin
    if( !core_rst_n )
        app_app_ltssm_enable <= 1'b0;                
    else
        app_app_ltssm_enable <= app_app_ltssm_enable_user;                
end

`ifdef XALI0_SIG_EN
clinet_pipeline u_clinet0_pipeline(

    .user_clk                             (user_clk                             ),
    .user_link_up                         (user_link_up                         ),
    .client0_tlp_data_user                (client0_tlp_data_user                ),
    .client0_tlp_addr_user                (client0_tlp_addr_user                ),
    .client0_remote_req_id_user           (client0_remote_req_id_user           ),
    .client0_tlp_byte_en_user             (client0_tlp_byte_en_user             ),
    .client0_cpl_byte_cnt_user            (client0_cpl_byte_cnt_user            ),
    .client0_addr_align_en_user           (client0_addr_align_en_user           ),
    .client0_tlp_tc_user                  (client0_tlp_tc_user                  ),
    .client0_tlp_attr_user                (client0_tlp_attr_user                ),
    .client0_cpl_status_user              (client0_cpl_status_user              ),
    .client0_cpl_bcm_user                 (client0_cpl_bcm_user                 ),
    .client0_tlp_dv_user                  (client0_tlp_dv_user                  ),
    .client0_tlp_eot_user                 (client0_tlp_eot_user                 ),
    .client0_tlp_bad_eot_user             (client0_tlp_bad_eot_user             ),
    .client0_tlp_hv_user                  (client0_tlp_hv_user                  ),
    .client0_tlp_type_user                (client0_tlp_type_user                ),
    .client0_tlp_fmt_user                 (client0_tlp_fmt_user                 ),
    .client0_tlp_td_user                  (client0_tlp_td_user                  ),
    .client0_tlp_byte_len_user            (client0_tlp_byte_len_user            ),
    .client0_tlp_tid_user                 (client0_tlp_tid_user                 ),
    .client0_tlp_ep_user                  (client0_tlp_ep_user                  ),
    .client0_tlp_func_num_user            (client0_tlp_func_num_user            ),
    .client0_tlp_vfunc_num_user           (client0_tlp_vfunc_num_user           ),
    .client0_tlp_ats_user                 (client0_tlp_ats_user                 ),
    .client0_tlp_st_user                  (client0_tlp_st_user                  ),
    .client0_tlp_vfunc_active_user        (client0_tlp_vfunc_active_user        ),
    .client0_tlp_nw_user                  (client0_tlp_nw_user                  ),
    .client0_tlp_th_user                  (client0_tlp_th_user                  ),
    .client0_tlp_ph_user                  (client0_tlp_ph_user                  ),
    .client0_tlp_atu_bypass_user          (client0_tlp_atu_bypass_user          ),
    .client0_cpl_lookup_id_user           (client0_cpl_lookup_id_user           ),
    .xadm_client0_halt_user               (xadm_client0_halt_user               ),
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
    .xadm_client0_halt_core               (xadm_client0_halt_core               )
);
`endif

`ifdef XALI1_SIG_EN
clinet_pipeline u_clinet1_pipeline(
    .user_clk                             (user_clk                             ),
    .user_link_up                         (user_link_up                         ),
    .client0_tlp_data_user                (client1_tlp_data_user                ),
    .client0_tlp_addr_user                (client1_tlp_addr_user                ),
    .client0_remote_req_id_user           (client1_remote_req_id_user           ),
    .client0_tlp_byte_en_user             (client1_tlp_byte_en_user             ),
    .client0_cpl_byte_cnt_user            (client1_cpl_byte_cnt_user            ),
    .client0_addr_align_en_user           (client1_addr_align_en_user           ),
    .client0_tlp_tc_user                  (client1_tlp_tc_user                  ),
    .client0_tlp_attr_user                (client1_tlp_attr_user                ),
    .client0_cpl_status_user              (client1_cpl_status_user              ),
    .client0_cpl_bcm_user                 (client1_cpl_bcm_user                 ),
    .client0_tlp_dv_user                  (client1_tlp_dv_user                  ),
    .client0_tlp_eot_user                 (client1_tlp_eot_user                 ),
    .client0_tlp_bad_eot_user             (client1_tlp_bad_eot_user             ),
    .client0_tlp_hv_user                  (client1_tlp_hv_user                  ),
    .client0_tlp_type_user                (client1_tlp_type_user                ),
    .client0_tlp_fmt_user                 (client1_tlp_fmt_user                 ),
    .client0_tlp_td_user                  (client1_tlp_td_user                  ),
    .client0_tlp_byte_len_user            (client1_tlp_byte_len_user            ),
    .client0_tlp_tid_user                 (client1_tlp_tid_user                 ),
    .client0_tlp_ep_user                  (client1_tlp_ep_user                  ),
    .client0_tlp_func_num_user            (client1_tlp_func_num_user            ),
    .client0_tlp_vfunc_num_user           (client1_tlp_vfunc_num_user           ),
    .client0_tlp_ats_user                 (client1_tlp_ats_user                 ),
    .client0_tlp_st_user                  (client1_tlp_st_user                  ),
    .client0_tlp_vfunc_active_user        (client1_tlp_vfunc_active_user        ),
    .client0_tlp_nw_user                  (client1_tlp_nw_user                  ),
    .client0_tlp_th_user                  (client1_tlp_th_user                  ),
    .client0_tlp_ph_user                  (client1_tlp_ph_user                  ),
    .client0_tlp_atu_bypass_user          (client1_tlp_atu_bypass_user          ),
    .client0_cpl_lookup_id_user           (client1_cpl_lookup_id_user           ),
    .xadm_client0_halt_user               (xadm_client1_halt_user               ),
    .client0_tlp_data_core                (client1_tlp_data_core                ),
    .client0_tlp_addr_core                (client1_tlp_addr_core                ),
    .client0_remote_req_id_core           (client1_remote_req_id_core           ),
    .client0_tlp_byte_en_core             (client1_tlp_byte_en_core             ),
    .client0_cpl_byte_cnt_core            (client1_cpl_byte_cnt_core            ),
    .client0_addr_align_en_core           (client1_addr_align_en_core           ),
    .client0_tlp_tc_core                  (client1_tlp_tc_core                  ),
    .client0_tlp_attr_core                (client1_tlp_attr_core                ),
    .client0_cpl_status_core              (client1_cpl_status_core              ),
    .client0_cpl_bcm_core                 (client1_cpl_bcm_core                 ),
    .client0_tlp_dv_core                  (client1_tlp_dv_core                  ),
    .client0_tlp_eot_core                 (client1_tlp_eot_core                 ),
    .client0_tlp_bad_eot_core             (client1_tlp_bad_eot_core             ),
    .client0_tlp_hv_core                  (client1_tlp_hv_core                  ),
    .client0_tlp_type_core                (client1_tlp_type_core                ),
    .client0_tlp_fmt_core                 (client1_tlp_fmt_core                 ),
    .client0_tlp_td_core                  (client1_tlp_td_core                  ),
    .client0_tlp_byte_len_core            (client1_tlp_byte_len_core            ),
    .client0_tlp_tid_core                 (client1_tlp_tid_core                 ),
    .client0_tlp_ep_core                  (client1_tlp_ep_core                  ),
    .client0_tlp_func_num_core            (client1_tlp_func_num_core            ),
    .client0_tlp_vfunc_num_core           (client1_tlp_vfunc_num_core           ),
    .client0_tlp_ats_core                 (client1_tlp_ats_core                 ),
    .client0_tlp_st_core                  (client1_tlp_st_core                  ),
    .client0_tlp_vfunc_active_core        (client1_tlp_vfunc_active_core        ),
    .client0_tlp_nw_core                  (client1_tlp_nw_core                  ),
    .client0_tlp_th_core                  (client1_tlp_th_core                  ),
    .client0_tlp_ph_core                  (client1_tlp_ph_core                  ),
    .client0_tlp_atu_bypass_core          (client1_tlp_atu_bypass_core          ),
    .client0_cpl_lookup_id_core           (client1_cpl_lookup_id_core           ),
    .xadm_client0_halt_core               (xadm_client1_halt_core               )
);
`endif

`ifdef TRGT1_SIG_EN
radm_trgt_pipeline u_radm_trgt_pipeline(

    .user_clk                             (user_clk                             ),
    .user_link_up                         (user_link_up                         ),
                                                                                
    .radm_trgt1_dv_user                   (radm_trgt1_dv_user                   ),
    .radm_trgt1_hv_user                   (radm_trgt1_hv_user                   ),
    .radm_trgt1_eot_user                  (radm_trgt1_eot_user                  ),
    .radm_trgt1_tlp_abort_user            (radm_trgt1_tlp_abort_user            ),
    .radm_trgt1_dllp_abort_user           (radm_trgt1_dllp_abort_user           ),
    .radm_trgt1_ecrc_err_user             (radm_trgt1_ecrc_err_user             ),
    .radm_trgt1_dwen_user                 (radm_trgt1_dwen_user                 ),
    .radm_trgt1_fmt_user                  (radm_trgt1_fmt_user                  ),
    .radm_trgt1_attr_user                 (radm_trgt1_attr_user                 ),
    .radm_trgt1_func_num_user             (radm_trgt1_func_num_user             ),
    .radm_trgt1_type_user                 (radm_trgt1_type_user                 ),
    .radm_trgt1_tc_user                   (radm_trgt1_tc_user                   ),
    .radm_trgt1_reqid_user                (radm_trgt1_reqid_user                ),
    .radm_trgt1_data_user                 (radm_trgt1_data_user                 ),
    .radm_trgt1_first_be_user             (radm_trgt1_first_be_user             ),
    .radm_trgt1_last_be_user              (radm_trgt1_last_be_user              ),
    .radm_trgt1_addr_user                 (radm_trgt1_addr_user                 ),
    .radm_trgt1_vfunc_num_user            (radm_trgt1_vfunc_num_user            ),
    .radm_trgt1_vfunc_active_user         (radm_trgt1_vfunc_active_user         ),
    .radm_trgt1_td_user                   (radm_trgt1_td_user                   ),
    .radm_trgt1_poisoned_user             (radm_trgt1_poisoned_user             ),
    .radm_trgt1_hdr_uppr_bytes_valid_user (radm_trgt1_hdr_uppr_bytes_valid_user ),
    .radm_trgt1_rom_in_range_user         (radm_trgt1_rom_in_range_user         ),
    .radm_trgt1_io_req_in_range_user      (radm_trgt1_io_req_in_range_user      ),
    .radm_trgt1_hdr_uppr_bytes_user       (radm_trgt1_hdr_uppr_bytes_user       ),
    .radm_trgt1_in_membar_range_user      (radm_trgt1_in_membar_range_user      ),
    .radm_trgt1_cpl_status_user           (radm_trgt1_cpl_status_user           ),
    .radm_trgt1_ats_user                  (radm_trgt1_ats_user                  ),
    .radm_trgt1_tag_user                  (radm_trgt1_tag_user                  ),
    .radm_trgt1_dw_len_user               (radm_trgt1_dw_len_user               ),
    .radm_trgt1_nw_user                   (radm_trgt1_nw_user                   ),
    .radm_trgt1_th_user                   (radm_trgt1_th_user                   ),
    .radm_trgt1_ph_user                   (radm_trgt1_ph_user                   ),
    .radm_trgt1_st_user                   (radm_trgt1_st_user                   ),
    .radm_trgt1_byte_cnt_user             (radm_trgt1_byte_cnt_user             ),
    .radm_trgt1_bcm_user                  (radm_trgt1_bcm_user                  ),
    .radm_trgt1_vc_user                   (radm_trgt1_vc_user                   ),
    .radm_trgt1_cmpltr_id_user            (radm_trgt1_cmpltr_id_user            ),
    .radm_trgt1_cpl_last_user             (radm_trgt1_cpl_last_user             ),
    .radm_grant_tlp_type_user             (radm_grant_tlp_type_user             ),
    .radm_trgt1_atu_sloc_match_user       (radm_trgt1_atu_sloc_match_user       ),
    .radm_trgt1_atu_cbuf_err_user         (radm_trgt1_atu_cbuf_err_user         ),
    .trgt_lookup_id_user                  (trgt_lookup_id_user                  ),
    .trgt_lookup_empty_user               (trgt_lookup_empty_user               ),
    .trgt1_radm_halt_user                 (trgt1_radm_halt_user                 ),
    .trgt1_radm_pkt_halt_user             (trgt1_radm_pkt_halt_user             ),
                                                                                
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
    .trgt1_radm_pkt_halt_core             (trgt1_radm_pkt_halt_core             ) 
);



`endif

`ifdef BYPASS_SIG_EN
bypass_pipeline u_bypass_pipeline (
    .user_clk                             (user_clk                             ),
    .user_link_up                         (user_link_up                         ),
    .radm_bypass_data_user                (radm_bypass_data_user                ),
    .radm_bypass_dwen_user                (radm_bypass_dwen_user                ),
    .radm_bypass_dv_user                  (radm_bypass_dv_user                  ),
    .radm_bypass_hv_user                  (radm_bypass_hv_user                  ),
    .radm_bypass_eot_user                 (radm_bypass_eot_user                 ),
    .radm_bypass_dllp_abort_user          (radm_bypass_dllp_abort_user          ),
    .radm_bypass_tlp_abort_user           (radm_bypass_tlp_abort_user           ),
    .radm_bypass_ecrc_err_user            (radm_bypass_ecrc_err_user            ),
    .radm_bypass_addr_user                (radm_bypass_addr_user                ),
    .radm_bypass_fmt_user                 (radm_bypass_fmt_user                 ),
    .radm_bypass_tc_user                  (radm_bypass_tc_user                  ),
    .radm_bypass_attr_user                (radm_bypass_attr_user                ),
    .radm_bypass_reqid_user               (radm_bypass_reqid_user               ),
    .radm_bypass_type_user                (radm_bypass_type_user                ),
    .radm_bypass_tag_user                 (radm_bypass_tag_user                 ),
    .radm_bypass_func_num_user            (radm_bypass_func_num_user            ),
    .radm_bypass_vfunc_num_user           (radm_bypass_vfunc_num_user           ),
    .radm_bypass_vfunc_active_user        (radm_bypass_vfunc_active_user        ),
    .radm_bypass_td_user                  (radm_bypass_td_user                  ),
    .radm_bypass_poisoned_user            (radm_bypass_poisoned_user            ),
    .radm_bypass_dw_len_user              (radm_bypass_dw_len_user              ),
    .radm_bypass_rom_in_range_user        (radm_bypass_rom_in_range_user        ),
    .radm_bypass_first_be_user            (radm_bypass_first_be_user            ),
    .radm_bypass_last_be_user             (radm_bypass_last_be_user             ),
    .radm_bypass_io_req_in_range_user     (radm_bypass_io_req_in_range_user     ),
    .radm_bypass_in_membar_range_user     (radm_bypass_in_membar_range_user     ),
    .radm_bypass_cpl_last_user            (radm_bypass_cpl_last_user            ),
    .radm_bypass_cpl_status_user          (radm_bypass_cpl_status_user          ),
    .radm_bypass_st_user                  (radm_bypass_st_user                  ),
    .radm_bypass_cmpltr_id_user           (radm_bypass_cmpltr_id_user           ),
    .radm_bypass_byte_cnt_user            (radm_bypass_byte_cnt_user            ),
    .radm_bypass_ats_user                 (radm_bypass_ats_user                 ),
    .radm_bypass_th_user                  (radm_bypass_th_user                  ),
    .radm_bypass_ph_user                  (radm_bypass_ph_user                  ),
    .radm_bypass_bcm_user                 (radm_bypass_bcm_user                 ),
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
    .radm_bypass_bcm_core                 (radm_bypass_bcm_core                 )
);
`endif

`ifdef ELBI_SIG_EN
elbi_pipeline u_elbi_pipeline(

    .user_clk                             (user_clk                             ),
    .user_link_up                         (user_link_up                         ),

    .lbc_ext_addr_user                    (lbc_ext_addr_user                    ),
    .lbc_ext_cs_user                      (lbc_ext_cs_user                      ),
    .lbc_ext_wr_user                      (lbc_ext_wr_user                      ),
    .lbc_ext_rom_access_user              (lbc_ext_rom_access_user              ),
    .lbc_ext_io_access_user               (lbc_ext_io_access_user               ),
    .lbc_ext_dout_user                    (lbc_ext_dout_user                    ),
    .lbc_ext_bar_num_user                 (lbc_ext_bar_num_user                 ),
    .lbc_ext_vfunc_active_user            (lbc_ext_vfunc_active_user            ),
    .lbc_ext_vfunc_num_user               (lbc_ext_vfunc_num_user               ),
    .ext_lbc_din_user                     (ext_lbc_din_user                     ),
    .ext_lbc_ack_user                     (ext_lbc_ack_user                     ),

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
    .ext_lbc_ack_core                     (ext_lbc_ack_core                     )
);
`endif

`ifdef DBI_SIG_EN
dbi_pipeline u_dbi_pipeline(

    .user_clk                             (user_clk                             ),
    .core_rst_n                           (core_rst_n                           ),
    .user_link_up                         (user_link_up                         ),

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
    .drp_lbc_dbi_ack_core                 (drp_lbc_dbi_ack_core                 )
);
`endif

endmodule

module clinet_pipeline(

        input    wire                user_clk                             ,
        input    wire                user_link_up                         ,

        output   wire    [127:0]     client0_tlp_data_core                ,
        output   wire    [63:0]      client0_tlp_addr_core                ,
        output   wire    [15:0]      client0_remote_req_id_core           ,
        output   wire    [7:0]       client0_tlp_byte_en_core             ,
        output   wire    [11:0]      client0_cpl_byte_cnt_core            ,
        output   wire                client0_addr_align_en_core           ,
        output   wire    [2:0]       client0_tlp_tc_core                  ,
        output   wire    [2:0]       client0_tlp_attr_core                ,
        output   wire    [2:0]       client0_cpl_status_core              ,
        output   wire                client0_cpl_bcm_core                 ,
        output   wire                client0_tlp_dv_core                  ,
        output   wire                client0_tlp_eot_core                 ,
        output   wire                client0_tlp_bad_eot_core             ,
        output   wire                client0_tlp_hv_core                  ,
        output   wire    [4:0]       client0_tlp_type_core                ,
        output   wire    [1:0]       client0_tlp_fmt_core                 ,
        output   wire                client0_tlp_td_core                  ,
        output   wire    [12:0]      client0_tlp_byte_len_core            ,
        output   wire    [9:0]       client0_tlp_tid_core                 ,
        output   wire                client0_tlp_ep_core                  ,
        output   wire                client0_tlp_func_num_core            ,
        output   wire    [1:0]       client0_tlp_vfunc_num_core           ,
        output   wire    [1:0]       client0_tlp_ats_core                 ,
        output   wire    [7:0]       client0_tlp_st_core                  ,
        output   wire                client0_tlp_vfunc_active_core        ,
        output   wire                client0_tlp_nw_core                  ,
        output   wire                client0_tlp_th_core                  ,
        output   wire    [1:0]       client0_tlp_ph_core                  ,
        output   wire                client0_tlp_atu_bypass_core          ,
        output   wire    [9:0]       client0_cpl_lookup_id_core           ,
        input    wire                xadm_client0_halt_core               ,

        input    wire    [127:0]     client0_tlp_data_user                ,
        input    wire    [63:0]      client0_tlp_addr_user                ,
        input    wire    [15:0]      client0_remote_req_id_user           ,
        input    wire    [7:0]       client0_tlp_byte_en_user             ,
        input    wire    [11:0]      client0_cpl_byte_cnt_user            ,
        input    wire                client0_addr_align_en_user           ,
        input    wire    [2:0]       client0_tlp_tc_user                  ,
        input    wire    [2:0]       client0_tlp_attr_user                ,
        input    wire    [2:0]       client0_cpl_status_user              ,
        input    wire                client0_cpl_bcm_user                 ,
        input    wire                client0_tlp_dv_user                  ,
        input    wire                client0_tlp_eot_user                 ,
        input    wire                client0_tlp_bad_eot_user             ,
        input    wire                client0_tlp_hv_user                  ,
        input    wire    [4:0]       client0_tlp_type_user                ,
        input    wire    [1:0]       client0_tlp_fmt_user                 ,
        input    wire                client0_tlp_td_user                  ,
        input    wire    [12:0]      client0_tlp_byte_len_user            ,
        input    wire    [9:0]       client0_tlp_tid_user                 ,
        input    wire                client0_tlp_ep_user                  ,
        input    wire                client0_tlp_func_num_user            ,
        input    wire    [1:0]       client0_tlp_vfunc_num_user           ,
        input    wire    [1:0]       client0_tlp_ats_user                 ,
        input    wire    [7:0]       client0_tlp_st_user                  ,
        input    wire                client0_tlp_vfunc_active_user        ,
        input    wire                client0_tlp_nw_user                  ,
        input    wire                client0_tlp_th_user                  ,
        input    wire    [1:0]       client0_tlp_ph_user                  ,
        input    wire                client0_tlp_atu_bypass_user          ,
        input    wire    [9:0]       client0_cpl_lookup_id_user           ,
        output   reg                 xadm_client0_halt_user

);

// ====================================================================
// Parameter/Wire/Reg
// ====================================================================

    reg                 xadm_client0_halt_nege              ;
    wire                client0_handshark_ok_user           ;
    wire                client0_handshark_ok_core           ;
    reg                 d0_vld                              ;
    reg                 halt_vld_cnt                        ;
    reg                 trans_done_dly                      ;

    reg     [127:0]     client0_tlp_data_dly                ;
    reg     [63:0]      client0_tlp_addr_dly                ;
    reg     [15:0]      client0_remote_req_id_dly           ;
    reg     [7:0]       client0_tlp_byte_en_dly             ;
    reg     [11:0]      client0_cpl_byte_cnt_dly            ;
    reg                 client0_addr_align_en_dly           ;
    reg     [2:0]       client0_tlp_tc_dly                  ;
    reg     [2:0]       client0_tlp_attr_dly                ;
    reg     [2:0]       client0_cpl_status_dly              ;
    reg                 client0_cpl_bcm_dly                 ;
    reg                 client0_tlp_dv_dly                  ;
    reg                 client0_tlp_eot_dly                 ;
    reg                 client0_tlp_bad_eot_dly             ;
    reg                 client0_tlp_hv_dly                  ;
    reg     [4:0]       client0_tlp_type_dly                ;
    reg     [1:0]       client0_tlp_fmt_dly                 ;
    reg                 client0_tlp_td_dly                  ;
    reg     [12:0]      client0_tlp_byte_len_dly            ;
    reg     [9:0]       client0_tlp_tid_dly                 ;
    reg                 client0_tlp_ep_dly                  ;
    reg                 client0_tlp_func_num_dly            ;
    reg     [1:0]       client0_tlp_vfunc_num_dly           ;
    reg     [1:0]       client0_tlp_ats_dly                 ;
    reg     [7:0]       client0_tlp_st_dly                  ;
    reg                 client0_tlp_vfunc_active_dly        ;
    reg                 client0_tlp_nw_dly                  ;
    reg                 client0_tlp_th_dly                  ;
    reg     [1:0]       client0_tlp_ph_dly                  ;
    reg                 client0_tlp_atu_bypass_dly          ;
    reg     [9:0]       client0_cpl_lookup_id_dly           ;

    reg     [127:0]     client0_tlp_data_dly2               ;
    reg     [63:0]      client0_tlp_addr_dly2               ;
    reg     [15:0]      client0_remote_req_id_dly2          ;
    reg     [7:0]       client0_tlp_byte_en_dly2            ;
    reg     [11:0]      client0_cpl_byte_cnt_dly2           ;
    reg                 client0_addr_align_en_dly2          ;
    reg     [2:0]       client0_tlp_tc_dly2                 ;
    reg     [2:0]       client0_tlp_attr_dly2               ;
    reg     [2:0]       client0_cpl_status_dly2             ;
    reg                 client0_cpl_bcm_dly2                ;
    reg                 client0_tlp_dv_dly2                 ;
    reg                 client0_tlp_eot_dly2                ;
    reg                 client0_tlp_bad_eot_dly2            ;
    reg                 client0_tlp_hv_dly2                 ;
    reg     [4:0]       client0_tlp_type_dly2               ;
    reg     [1:0]       client0_tlp_fmt_dly2                ;
    reg                 client0_tlp_td_dly2                 ;
    reg     [12:0]      client0_tlp_byte_len_dly2           ;
    reg     [9:0]       client0_tlp_tid_dly2                ;
    reg                 client0_tlp_ep_dly2                 ;
    reg                 client0_tlp_func_num_dly2           ;
    reg     [1:0]       client0_tlp_vfunc_num_dly2          ;
    reg     [1:0]       client0_tlp_ats_dly2                ;
    reg     [7:0]       client0_tlp_st_dly2                 ;
    reg                 client0_tlp_vfunc_active_dly2       ;
    reg                 client0_tlp_nw_dly2                 ;
    reg                 client0_tlp_th_dly2                 ;
    reg     [1:0]       client0_tlp_ph_dly2                 ;
    reg                 client0_tlp_atu_bypass_dly2         ;
    reg     [9:0]       client0_cpl_lookup_id_dly2          ;

// ====================================================================
// Main Code
// ====================================================================

assign  client0_handshark_ok_user =  !xadm_client0_halt_user & ( client0_tlp_dv_user | client0_tlp_hv_user );
assign  client0_handshark_ok_core =  !xadm_client0_halt_nege & ( client0_tlp_dv_core | client0_tlp_hv_core );

always@( posedge user_clk or negedge user_link_up ) begin
    if( !user_link_up ) begin
        client0_tlp_addr_dly          <= 'd0;
        client0_remote_req_id_dly     <= 'd0;
        client0_tlp_byte_en_dly       <= 'd0;
        client0_cpl_byte_cnt_dly      <= 'd0;
        client0_addr_align_en_dly     <= 'd0;
        client0_tlp_tc_dly            <= 'd0;
        client0_tlp_attr_dly          <= 'd0;
        client0_cpl_status_dly        <= 'd0;
        client0_cpl_bcm_dly           <= 'd0;
        client0_tlp_bad_eot_dly       <= 'd0;
        client0_tlp_type_dly          <= 'd0;
        client0_tlp_fmt_dly           <= 'd0;
        client0_tlp_td_dly            <= 'd0;
        client0_tlp_byte_len_dly      <= 'd0;
        client0_tlp_tid_dly           <= 'd0;
        client0_tlp_ep_dly            <= 'd0;
        client0_tlp_func_num_dly      <= 'd0;
        client0_tlp_vfunc_num_dly     <= 'd0;
        client0_tlp_ats_dly           <= 'd0;
        client0_tlp_st_dly            <= 'd0;
        client0_tlp_vfunc_active_dly  <= 'd0;
        client0_tlp_nw_dly            <= 'd0;
        client0_tlp_th_dly            <= 'd0;
        client0_tlp_ph_dly            <= 'd0;
        client0_tlp_atu_bypass_dly    <= 'd0;
        client0_cpl_lookup_id_dly     <= 'd0;
        client0_tlp_hv_dly            <= 'd0;
        client0_tlp_data_dly          <= 'd0;
        client0_tlp_eot_dly           <= 'd0;
        client0_tlp_dv_dly            <= 'd0;
    end else begin

        if( client0_tlp_hv_user ) begin
        client0_tlp_addr_dly          <= client0_tlp_addr_user               ;
        client0_remote_req_id_dly     <= client0_remote_req_id_user          ;
        client0_tlp_byte_en_dly       <= client0_tlp_byte_en_user            ;
        client0_cpl_byte_cnt_dly      <= client0_cpl_byte_cnt_user           ;
        client0_addr_align_en_dly     <= client0_addr_align_en_user          ;
        client0_tlp_tc_dly            <= client0_tlp_tc_user                 ;
        client0_tlp_attr_dly          <= client0_tlp_attr_user               ;
        client0_cpl_status_dly        <= client0_cpl_status_user             ;
        client0_cpl_bcm_dly           <= client0_cpl_bcm_user                ;
        client0_tlp_bad_eot_dly       <= client0_tlp_bad_eot_user            ;
        client0_tlp_type_dly          <= client0_tlp_type_user               ;
        client0_tlp_fmt_dly           <= client0_tlp_fmt_user                ;
        client0_tlp_td_dly            <= client0_tlp_td_user                 ;
        client0_tlp_byte_len_dly      <= client0_tlp_byte_len_user           ;
        client0_tlp_tid_dly           <= client0_tlp_tid_user                ;
        client0_tlp_ep_dly            <= client0_tlp_ep_user                 ;
        client0_tlp_func_num_dly      <= client0_tlp_func_num_user           ;
        client0_tlp_vfunc_num_dly     <= client0_tlp_vfunc_num_user          ;
        client0_tlp_ats_dly           <= client0_tlp_ats_user                ;
        client0_tlp_st_dly            <= client0_tlp_st_user                 ;
        client0_tlp_vfunc_active_dly  <= client0_tlp_vfunc_active_user       ;
        client0_tlp_nw_dly            <= client0_tlp_nw_user                 ;
        client0_tlp_th_dly            <= client0_tlp_th_user                 ;
        client0_tlp_ph_dly            <= client0_tlp_ph_user                 ;
        client0_tlp_atu_bypass_dly    <= client0_tlp_atu_bypass_user         ;
        client0_cpl_lookup_id_dly     <= client0_cpl_lookup_id_user          ;
        end

        if( client0_handshark_ok_user )                 
        client0_tlp_hv_dly            <= client0_tlp_hv_user                 ;
        else if( client0_tlp_hv_core ) 
        client0_tlp_hv_dly            <= 1'b0                                ;

        if( client0_handshark_ok_user )                
        client0_tlp_eot_dly           <= client0_tlp_eot_user                ;
        else if( client0_tlp_eot_core )
        client0_tlp_eot_dly           <= 1'b0                                ;

        if( client0_handshark_ok_user )                      
        client0_tlp_dv_dly            <= client0_tlp_dv_user                 ;
        else if( client0_tlp_dv_core )
        client0_tlp_dv_dly            <= 1'b0                                ;

        if( client0_handshark_ok_user )
        client0_tlp_data_dly          <= client0_tlp_data_user               ;
    end
end

always@( posedge user_clk or negedge user_link_up ) begin
    if( !user_link_up ) begin
        client0_tlp_addr_dly2         <= 'd0;
        client0_remote_req_id_dly2    <= 'd0;
        client0_tlp_byte_en_dly2      <= 'd0;
        client0_cpl_byte_cnt_dly2     <= 'd0;
        client0_addr_align_en_dly2    <= 'd0;
        client0_tlp_tc_dly2           <= 'd0;
        client0_tlp_attr_dly2         <= 'd0;
        client0_cpl_status_dly2       <= 'd0;
        client0_cpl_bcm_dly2          <= 'd0;
        client0_tlp_bad_eot_dly2      <= 'd0;
        client0_tlp_type_dly2         <= 'd0;
        client0_tlp_fmt_dly2          <= 'd0;
        client0_tlp_td_dly2           <= 'd0;
        client0_tlp_byte_len_dly2     <= 'd0;
        client0_tlp_tid_dly2          <= 'd0;
        client0_tlp_ep_dly2           <= 'd0;
        client0_tlp_func_num_dly2     <= 'd0;
        client0_tlp_vfunc_num_dly2    <= 'd0;
        client0_tlp_ats_dly2          <= 'd0;
        client0_tlp_st_dly2           <= 'd0;
        client0_tlp_vfunc_active_dly2 <= 'd0;
        client0_tlp_nw_dly2           <= 'd0;
        client0_tlp_th_dly2           <= 'd0;
        client0_tlp_ph_dly2           <= 'd0;
        client0_tlp_atu_bypass_dly2   <= 'd0;
        client0_cpl_lookup_id_dly2    <= 'd0;
        client0_tlp_hv_dly2           <= 'd0;
        client0_tlp_data_dly2         <= 'd0;
        client0_tlp_eot_dly2          <= 'd0;
        client0_tlp_dv_dly2           <= 'd0;
    end else begin
        if( client0_tlp_hv_dly ) begin
            client0_tlp_addr_dly2         <= client0_tlp_addr_dly                ;
            client0_remote_req_id_dly2    <= client0_remote_req_id_dly           ;
            client0_tlp_byte_en_dly2      <= client0_tlp_byte_en_dly             ;
            client0_cpl_byte_cnt_dly2     <= client0_cpl_byte_cnt_dly            ;
            client0_addr_align_en_dly2    <= client0_addr_align_en_dly           ;
            client0_tlp_tc_dly2           <= client0_tlp_tc_dly                  ;
            client0_tlp_attr_dly2         <= client0_tlp_attr_dly                ;
            client0_cpl_status_dly2       <= client0_cpl_status_dly              ;
            client0_cpl_bcm_dly2          <= client0_cpl_bcm_dly                 ;
            client0_tlp_bad_eot_dly2      <= client0_tlp_bad_eot_dly             ;
            client0_tlp_type_dly2         <= client0_tlp_type_dly                ;
            client0_tlp_fmt_dly2          <= client0_tlp_fmt_dly                 ;
            client0_tlp_td_dly2           <= client0_tlp_td_dly                  ;
            client0_tlp_byte_len_dly2     <= client0_tlp_byte_len_dly            ;
            client0_tlp_tid_dly2          <= client0_tlp_tid_dly                 ;
            client0_tlp_ep_dly2           <= client0_tlp_ep_dly                  ;
            client0_tlp_func_num_dly2     <= client0_tlp_func_num_dly            ;
            client0_tlp_vfunc_num_dly2    <= client0_tlp_vfunc_num_dly           ;
            client0_tlp_ats_dly2          <= client0_tlp_ats_dly                 ;
            client0_tlp_st_dly2           <= client0_tlp_st_dly                  ;
            client0_tlp_vfunc_active_dly2 <= client0_tlp_vfunc_active_dly        ;
            client0_tlp_nw_dly2           <= client0_tlp_nw_dly                  ;
            client0_tlp_th_dly2           <= client0_tlp_th_dly                  ;
            client0_tlp_ph_dly2           <= client0_tlp_ph_dly                  ;
            client0_tlp_atu_bypass_dly2   <= client0_tlp_atu_bypass_dly          ;
            client0_cpl_lookup_id_dly2    <= client0_cpl_lookup_id_dly           ;
        end

        if( client0_tlp_hv_dly )
            client0_tlp_hv_dly2           <= 1'b1                                ;
		else if( !xadm_client0_halt_nege )
            client0_tlp_hv_dly2           <= 1'b0                                ;

        if( client0_tlp_eot_dly2 & !xadm_client0_halt_nege )
            client0_tlp_dv_dly2           <= 1'b0                                ;
        else if( client0_tlp_dv_dly )
            client0_tlp_dv_dly2           <= 1'b1                                ;

        if( !xadm_client0_halt_nege )
            client0_tlp_eot_dly2 <= client0_tlp_eot_dly2 ?  1'b0                 :
                                    halt_vld_cnt         ?  client0_tlp_eot_user : client0_tlp_eot_dly   ;
        else if( client0_tlp_hv_dly )
            client0_tlp_eot_dly2 <= client0_tlp_eot_dly                          ;

        if( client0_tlp_hv_dly )
            client0_tlp_data_dly2         <= client0_tlp_data_dly                ;
        else if( client0_handshark_ok_core )
            client0_tlp_data_dly2         <= halt_vld_cnt ? client0_tlp_data_user : client0_tlp_data_dly ;
    end
end

always@( negedge user_clk ) begin
    xadm_client0_halt_nege <= xadm_client0_halt_core;
end

always@( posedge user_clk or negedge user_link_up ) begin
    if( !user_link_up ) begin
        d0_vld <= 1'b0;
    end else if( client0_tlp_eot_user & !xadm_client0_halt_user )
        d0_vld <= 1'b0;
    else if( client0_tlp_hv_user & !xadm_client0_halt_user )
        d0_vld <= 1'b1;
end

always@( posedge user_clk or negedge user_link_up ) begin
    if( !user_link_up )
        trans_done_dly <= 1'b0;
    else if( client0_tlp_eot_core & !xadm_client0_halt_nege )
        trans_done_dly <= 1'b1;
    else
        trans_done_dly <= 1'b0;
end

always@( posedge user_clk or negedge user_link_up ) begin
    if( !user_link_up )
        xadm_client0_halt_user <= 1'b0;
    else if( client0_tlp_eot_user & !xadm_client0_halt_user )
        xadm_client0_halt_user <= 1'b1;
    else if( d0_vld )
        xadm_client0_halt_user <= xadm_client0_halt_nege;
    else if( trans_done_dly  )
        xadm_client0_halt_user <= 1'b0;
end


always@( posedge user_clk or negedge user_link_up ) begin
    if( !user_link_up )
        halt_vld_cnt <= 1'b0;
    else if( d0_vld & !xadm_client0_halt_nege)
        halt_vld_cnt <= 1'b1 ;
    else 
        halt_vld_cnt <= 1'b0;
end

assign  client0_tlp_data_core         = client0_tlp_data_dly2         ;
assign  client0_tlp_addr_core         = client0_tlp_addr_dly2         ;
assign  client0_remote_req_id_core    = client0_remote_req_id_dly2    ;
assign  client0_tlp_byte_en_core      = client0_tlp_byte_en_dly2      ;
assign  client0_cpl_byte_cnt_core     = client0_cpl_byte_cnt_dly2     ;
assign  client0_addr_align_en_core    = client0_addr_align_en_dly2    ;
assign  client0_tlp_tc_core           = client0_tlp_tc_dly2           ;
assign  client0_tlp_attr_core         = client0_tlp_attr_dly2         ;
assign  client0_cpl_status_core       = client0_cpl_status_dly2       ;
assign  client0_cpl_bcm_core          = client0_cpl_bcm_dly2          ;
assign  client0_tlp_dv_core           = client0_tlp_dv_dly2           ;
assign  client0_tlp_eot_core          = client0_tlp_eot_dly2          ;
assign  client0_tlp_bad_eot_core      = client0_tlp_bad_eot_dly2      ;
assign  client0_tlp_hv_core           = client0_tlp_hv_dly2           ;
assign  client0_tlp_type_core         = client0_tlp_type_dly2         ;
assign  client0_tlp_fmt_core          = client0_tlp_fmt_dly2          ;
assign  client0_tlp_td_core           = client0_tlp_td_dly2           ;
assign  client0_tlp_byte_len_core     = client0_tlp_byte_len_dly2     ;
assign  client0_tlp_tid_core          = client0_tlp_tid_dly2          ;
assign  client0_tlp_ep_core           = client0_tlp_ep_dly2           ;
assign  client0_tlp_func_num_core     = client0_tlp_func_num_dly2     ;
assign  client0_tlp_vfunc_num_core    = client0_tlp_vfunc_num_dly2    ;
assign  client0_tlp_ats_core          = client0_tlp_ats_dly2          ;
assign  client0_tlp_st_core           = client0_tlp_st_dly2           ;
assign  client0_tlp_vfunc_active_core = client0_tlp_vfunc_active_dly2 ;
assign  client0_tlp_nw_core           = client0_tlp_nw_dly2           ;
assign  client0_tlp_th_core           = client0_tlp_th_dly2           ;
assign  client0_tlp_ph_core           = client0_tlp_ph_dly2           ;
assign  client0_tlp_atu_bypass_core   = client0_tlp_atu_bypass_dly2   ;
assign  client0_cpl_lookup_id_core    = client0_cpl_lookup_id_dly2    ;



//reg     [10:0]  debug_cnt;

//always@(posedge user_clk or negedge user_link_up) begin
//    if(!user_link_up)
//        debug_cnt <= 11'd0;
//    else if( client0_handshark_ok_core )
//        if( client0_tlp_eot_core )
//            debug_cnt <= 11'd0;
//        else     
//            debug_cnt <= debug_cnt + 1'b1;
//end


endmodule


module radm_trgt_pipeline(

        input   wire                user_clk                             ,
        input   wire                user_link_up                         ,

        output  reg                 radm_trgt1_dv_user                   ,
        output  reg                 radm_trgt1_hv_user                   ,
        output  reg                 radm_trgt1_eot_user                  ,
        output  reg                 radm_trgt1_tlp_abort_user            ,
        output  reg                 radm_trgt1_dllp_abort_user           ,
        output  reg                 radm_trgt1_ecrc_err_user             ,
        output  reg     [3:0]       radm_trgt1_dwen_user                 ,
        output  reg     [1:0]       radm_trgt1_fmt_user                  ,
        output  reg     [2:0]       radm_trgt1_attr_user                 ,
        output  reg                 radm_trgt1_func_num_user             ,
        output  reg     [4:0]       radm_trgt1_type_user                 ,
        output  reg     [2:0]       radm_trgt1_tc_user                   ,
        output  reg     [15:0]      radm_trgt1_reqid_user                ,
        output  reg     [127:0]     radm_trgt1_data_user                 ,
        output  reg     [3:0]       radm_trgt1_first_be_user             ,
        output  reg     [3:0]       radm_trgt1_last_be_user              ,
        output  reg     [63:0]      radm_trgt1_addr_user                 ,
        output  reg     [1:0]       radm_trgt1_vfunc_num_user            ,
        output  reg                 radm_trgt1_vfunc_active_user         ,
        output  reg                 radm_trgt1_td_user                   ,
        output  reg                 radm_trgt1_poisoned_user             ,
        output  reg                 radm_trgt1_hdr_uppr_bytes_valid_user ,
        output  reg                 radm_trgt1_rom_in_range_user         ,
        output  reg                 radm_trgt1_io_req_in_range_user      ,
        output  reg     [63:0]      radm_trgt1_hdr_uppr_bytes_user       ,
        output  reg     [2:0]       radm_trgt1_in_membar_range_user      ,
        output  reg     [2:0]       radm_trgt1_cpl_status_user           ,
        output  reg     [1:0]       radm_trgt1_ats_user                  ,
        output  reg     [9:0]       radm_trgt1_tag_user                  ,
        output  reg     [9:0]       radm_trgt1_dw_len_user               ,
        output  reg                 radm_trgt1_nw_user                   ,
        output  reg                 radm_trgt1_th_user                   ,
        output  reg     [1:0]       radm_trgt1_ph_user                   ,
        output  reg     [7:0]       radm_trgt1_st_user                   ,
        output  reg     [11:0]      radm_trgt1_byte_cnt_user             ,
        output  reg                 radm_trgt1_bcm_user                  ,
        output  reg     [2:0]       radm_trgt1_vc_user                   ,
        output  reg     [15:0]      radm_trgt1_cmpltr_id_user            ,
        output  reg                 radm_trgt1_cpl_last_user             ,
        output  reg     [2:0]       radm_grant_tlp_type_user             ,
        output  reg     [1:0]       radm_trgt1_atu_sloc_match_user       ,
        output  reg     [1:0]       radm_trgt1_atu_cbuf_err_user         ,
        output  reg     [9:0]       trgt_lookup_id_user                  ,
        output  reg                 trgt_lookup_empty_user               ,
        input   wire                trgt1_radm_halt_user                 ,
        input   wire    [2:0]       trgt1_radm_pkt_halt_user             ,

        input   wire                radm_trgt1_dv_core                   ,
        input   wire                radm_trgt1_hv_core                   ,
        input   wire                radm_trgt1_eot_core                  ,
        input   wire                radm_trgt1_tlp_abort_core            ,
        input   wire                radm_trgt1_dllp_abort_core           ,
        input   wire                radm_trgt1_ecrc_err_core             ,
        input   wire    [3:0]       radm_trgt1_dwen_core                 ,
        input   wire    [1:0]       radm_trgt1_fmt_core                  ,
        input   wire    [2:0]       radm_trgt1_attr_core                 ,
        input   wire                radm_trgt1_func_num_core             ,
        input   wire    [4:0]       radm_trgt1_type_core                 ,
        input   wire    [2:0]       radm_trgt1_tc_core                   ,
        input   wire    [15:0]      radm_trgt1_reqid_core                ,
        input   wire    [127:0]     radm_trgt1_data_core                 ,
        input   wire    [3:0]       radm_trgt1_first_be_core             ,
        input   wire    [3:0]       radm_trgt1_last_be_core              ,
        input   wire    [63:0]      radm_trgt1_addr_core                 ,
        input   wire    [1:0]       radm_trgt1_vfunc_num_core            ,
        input   wire                radm_trgt1_vfunc_active_core         ,
        input   wire                radm_trgt1_td_core                   ,
        input   wire                radm_trgt1_poisoned_core             ,
        input   wire                radm_trgt1_hdr_uppr_bytes_valid_core ,
        input   wire                radm_trgt1_rom_in_range_core         ,
        input   wire                radm_trgt1_io_req_in_range_core      ,
        input   wire    [63:0]      radm_trgt1_hdr_uppr_bytes_core       ,
        input   wire    [2:0]       radm_trgt1_in_membar_range_core      ,
        input   wire    [2:0]       radm_trgt1_cpl_status_core           ,
        input   wire    [1:0]       radm_trgt1_ats_core                  ,
        input   wire    [9:0]       radm_trgt1_tag_core                  ,
        input   wire    [9:0]       radm_trgt1_dw_len_core               ,
        input   wire                radm_trgt1_nw_core                   ,
        input   wire                radm_trgt1_th_core                   ,
        input   wire    [1:0]       radm_trgt1_ph_core                   ,
        input   wire    [7:0]       radm_trgt1_st_core                   ,
        input   wire    [11:0]      radm_trgt1_byte_cnt_core             ,
        input   wire                radm_trgt1_bcm_core                  ,
        input   wire    [2:0]       radm_trgt1_vc_core                   ,
        input   wire    [15:0]      radm_trgt1_cmpltr_id_core            ,
        input   wire                radm_trgt1_cpl_last_core             ,
        input   wire    [2:0]       radm_grant_tlp_type_core             ,
        input   wire    [1:0]       radm_trgt1_atu_sloc_match_core       ,
        input   wire    [1:0]       radm_trgt1_atu_cbuf_err_core         ,
        input   wire    [9:0]       trgt_lookup_id_core                  ,
        input   wire                trgt_lookup_empty_core               ,
        output  wire                trgt1_radm_halt_core                 ,
        output  wire    [2:0]       trgt1_radm_pkt_halt_core         
);

// ====================================================================
// Parameter/Wire/Reg
// ====================================================================

// ====================================================================
// Main Code
// ====================================================================

always@( negedge user_clk ) begin

        radm_trgt1_dv_user                   <= radm_trgt1_dv_core                   ;
        radm_trgt1_hv_user                   <= radm_trgt1_hv_core                   ;
        radm_trgt1_eot_user                  <= radm_trgt1_eot_core                  ;
        radm_trgt1_tlp_abort_user            <= radm_trgt1_tlp_abort_core            ;
        radm_trgt1_dllp_abort_user           <= radm_trgt1_dllp_abort_core           ;
        radm_trgt1_ecrc_err_user             <= radm_trgt1_ecrc_err_core             ;
        radm_trgt1_dwen_user                 <= radm_trgt1_dwen_core                 ;
        radm_trgt1_fmt_user                  <= radm_trgt1_fmt_core                  ;
        radm_trgt1_attr_user                 <= radm_trgt1_attr_core                 ;
        radm_trgt1_func_num_user             <= radm_trgt1_func_num_core             ;
        radm_trgt1_type_user                 <= radm_trgt1_type_core                 ;
        radm_trgt1_tc_user                   <= radm_trgt1_tc_core                   ;
        radm_trgt1_reqid_user                <= radm_trgt1_reqid_core                ;
        radm_trgt1_data_user                 <= radm_trgt1_data_core                 ;
        radm_trgt1_first_be_user             <= radm_trgt1_first_be_core             ;
        radm_trgt1_last_be_user              <= radm_trgt1_last_be_core              ;
        radm_trgt1_addr_user                 <= radm_trgt1_addr_core                 ;
        radm_trgt1_vfunc_num_user            <= radm_trgt1_vfunc_num_core            ;
        radm_trgt1_vfunc_active_user         <= radm_trgt1_vfunc_active_core         ;
        radm_trgt1_td_user                   <= radm_trgt1_td_core                   ;
        radm_trgt1_poisoned_user             <= radm_trgt1_poisoned_core             ;
        radm_trgt1_hdr_uppr_bytes_valid_user <= radm_trgt1_hdr_uppr_bytes_valid_core ;
        radm_trgt1_rom_in_range_user         <= radm_trgt1_rom_in_range_core         ;
        radm_trgt1_io_req_in_range_user      <= radm_trgt1_io_req_in_range_core      ;
        radm_trgt1_hdr_uppr_bytes_user       <= radm_trgt1_hdr_uppr_bytes_core       ;
        radm_trgt1_in_membar_range_user      <= radm_trgt1_in_membar_range_core      ;
        radm_trgt1_cpl_status_user           <= radm_trgt1_cpl_status_core           ;
        radm_trgt1_ats_user                  <= radm_trgt1_ats_core                  ;
        radm_trgt1_tag_user                  <= radm_trgt1_tag_core                  ;
        radm_trgt1_dw_len_user               <= radm_trgt1_dw_len_core               ;
        radm_trgt1_nw_user                   <= radm_trgt1_nw_core                   ;
        radm_trgt1_th_user                   <= radm_trgt1_th_core                   ;
        radm_trgt1_ph_user                   <= radm_trgt1_ph_core                   ;
        radm_trgt1_st_user                   <= radm_trgt1_st_core                   ;
        radm_trgt1_byte_cnt_user             <= radm_trgt1_byte_cnt_core             ;
        radm_trgt1_bcm_user                  <= radm_trgt1_bcm_core                  ;
        radm_trgt1_vc_user                   <= radm_trgt1_vc_core                   ;
        radm_trgt1_cmpltr_id_user            <= radm_trgt1_cmpltr_id_core            ;
        radm_trgt1_cpl_last_user             <= radm_trgt1_cpl_last_core             ;
        radm_grant_tlp_type_user             <= radm_grant_tlp_type_core             ;
        radm_trgt1_atu_sloc_match_user       <= radm_trgt1_atu_sloc_match_core       ;
        radm_trgt1_atu_cbuf_err_user         <= radm_trgt1_atu_cbuf_err_core         ;
        trgt_lookup_id_user                  <= trgt_lookup_id_core                  ;
        trgt_lookup_empty_user               <= trgt_lookup_empty_core               ;

end

        assign  trgt1_radm_halt_core          = trgt1_radm_halt_user                 ;
        assign  trgt1_radm_pkt_halt_core      = trgt1_radm_pkt_halt_user             ;      


endmodule



module  bypass_pipeline(

        input   wire                user_clk                             ,
        input   wire                user_link_up                         ,

        output  reg     [127:0]     radm_bypass_data_user                ,
        output  reg     [3:0]       radm_bypass_dwen_user                ,
        output  reg                 radm_bypass_dv_user                  ,
        output  reg                 radm_bypass_hv_user                  ,
        output  reg                 radm_bypass_eot_user                 ,
        output  reg                 radm_bypass_dllp_abort_user          ,
        output  reg                 radm_bypass_tlp_abort_user           ,
        output  reg                 radm_bypass_ecrc_err_user            ,
        output  reg     [63:0]      radm_bypass_addr_user                ,
        output  reg     [1:0]       radm_bypass_fmt_user                 ,
        output  reg     [2:0]       radm_bypass_tc_user                  ,
        output  reg     [2:0]       radm_bypass_attr_user                ,
        output  reg     [15:0]      radm_bypass_reqid_user               ,
        output  reg     [4:0]       radm_bypass_type_user                ,
        output  reg     [9:0]       radm_bypass_tag_user                 ,
        output  reg                 radm_bypass_func_num_user            ,
        output  reg     [1:0]       radm_bypass_vfunc_num_user           ,
        output  reg                 radm_bypass_vfunc_active_user        ,
        output  reg                 radm_bypass_td_user                  ,
        output  reg                 radm_bypass_poisoned_user            ,
        output  reg     [9:0]       radm_bypass_dw_len_user              ,
        output  reg                 radm_bypass_rom_in_range_user        ,
        output  reg     [3:0]       radm_bypass_first_be_user            ,
        output  reg     [3:0]       radm_bypass_last_be_user             ,
        output  reg                 radm_bypass_io_req_in_range_user     ,
        output  reg     [2:0]       radm_bypass_in_membar_range_user     ,
        output  reg                 radm_bypass_cpl_last_user            ,
        output  reg     [2:0]       radm_bypass_cpl_status_user          ,
        output  reg     [7:0]       radm_bypass_st_user                  ,
        output  reg     [15:0]      radm_bypass_cmpltr_id_user           ,
        output  reg     [11:0]      radm_bypass_byte_cnt_user            ,
        output  reg     [1:0]       radm_bypass_ats_user                 ,
        output  reg                 radm_bypass_th_user                  ,
        output  reg     [1:0]       radm_bypass_ph_user                  ,
        output  reg                 radm_bypass_bcm_user                 ,

        input   wire    [127:0]     radm_bypass_data_core                ,
        input   wire    [3:0]       radm_bypass_dwen_core                ,
        input   wire                radm_bypass_dv_core                  ,
        input   wire                radm_bypass_hv_core                  ,
        input   wire                radm_bypass_eot_core                 ,
        input   wire                radm_bypass_dllp_abort_core          ,
        input   wire                radm_bypass_tlp_abort_core           ,
        input   wire                radm_bypass_ecrc_err_core            ,
        input   wire    [63:0]      radm_bypass_addr_core                ,
        input   wire    [1:0]       radm_bypass_fmt_core                 ,
        input   wire    [2:0]       radm_bypass_tc_core                  ,
        input   wire    [2:0]       radm_bypass_attr_core                ,
        input   wire    [15:0]      radm_bypass_reqid_core               ,
        input   wire    [4:0]       radm_bypass_type_core                ,
        input   wire    [9:0]       radm_bypass_tag_core                 ,
        input   wire                radm_bypass_func_num_core            ,
        input   wire    [1:0]       radm_bypass_vfunc_num_core           ,
        input   wire                radm_bypass_vfunc_active_core        ,
        input   wire                radm_bypass_td_core                  ,
        input   wire                radm_bypass_poisoned_core            ,
        input   wire    [9:0]       radm_bypass_dw_len_core              ,
        input   wire                radm_bypass_rom_in_range_core        ,
        input   wire    [3:0]       radm_bypass_first_be_core            ,
        input   wire    [3:0]       radm_bypass_last_be_core             ,
        input   wire                radm_bypass_io_req_in_range_core     ,
        input   wire    [2:0]       radm_bypass_in_membar_range_core     ,
        input   wire                radm_bypass_cpl_last_core            ,
        input   wire    [2:0]       radm_bypass_cpl_status_core          ,
        input   wire    [7:0]       radm_bypass_st_core                  ,
        input   wire    [15:0]      radm_bypass_cmpltr_id_core           ,
        input   wire    [11:0]      radm_bypass_byte_cnt_core            ,
        input   wire    [1:0]       radm_bypass_ats_core                 ,
        input   wire                radm_bypass_th_core                  ,
        input   wire    [1:0]       radm_bypass_ph_core                  ,
        input   wire                radm_bypass_bcm_core

);


// ====================================================================
// Parameter/Wire/Reg
// ====================================================================

    reg     [127:0]     radm_bypass_data_nege                ;
    reg     [3:0]       radm_bypass_dwen_nege                ;
    reg                 radm_bypass_dv_nege                  ;
    reg                 radm_bypass_hv_nege                  ;
    reg                 radm_bypass_eot_nege                 ;
    reg                 radm_bypass_dllp_abort_nege          ;
    reg                 radm_bypass_tlp_abort_nege           ;
    reg                 radm_bypass_ecrc_err_nege            ;
    reg     [63:0]      radm_bypass_addr_nege                ;
    reg     [1:0]       radm_bypass_fmt_nege                 ;
    reg     [2:0]       radm_bypass_tc_nege                  ;
    reg     [2:0]       radm_bypass_attr_nege                ;
    reg     [15:0]      radm_bypass_reqid_nege               ;
    reg     [4:0]       radm_bypass_type_nege                ;
    reg     [9:0]       radm_bypass_tag_nege                 ;
    reg                 radm_bypass_func_num_nege            ;
    reg     [1:0]       radm_bypass_vfunc_num_nege           ;
    reg                 radm_bypass_vfunc_active_nege        ;
    reg                 radm_bypass_td_nege                  ;
    reg                 radm_bypass_poisoned_nege            ;
    reg     [9:0]       radm_bypass_dw_len_nege              ;
    reg                 radm_bypass_rom_in_range_nege        ;
    reg     [3:0]       radm_bypass_first_be_nege            ;
    reg     [3:0]       radm_bypass_last_be_nege             ;
    reg                 radm_bypass_io_req_in_range_nege     ;
    reg     [2:0]       radm_bypass_in_membar_range_nege     ;
    reg                 radm_bypass_cpl_last_nege            ;
    reg     [2:0]       radm_bypass_cpl_status_nege          ;
    reg     [7:0]       radm_bypass_st_nege                  ;
    reg     [15:0]      radm_bypass_cmpltr_id_nege           ;
    reg     [11:0]      radm_bypass_byte_cnt_nege            ;
    reg     [1:0]       radm_bypass_ats_nege                 ;
    reg                 radm_bypass_th_nege                  ;
    reg     [1:0]       radm_bypass_ph_nege                  ;
    reg                 radm_bypass_bcm_nege                 ;


// ====================================================================
// Main Code
// ====================================================================


always@( negedge user_clk ) begin

    radm_bypass_data_nege                <= radm_bypass_data_core                ;
    radm_bypass_dwen_nege                <= radm_bypass_dwen_core                ;
    radm_bypass_dv_nege                  <= radm_bypass_dv_core                  ;
    radm_bypass_hv_nege                  <= radm_bypass_hv_core                  ;
    radm_bypass_eot_nege                 <= radm_bypass_eot_core                 ;
    radm_bypass_dllp_abort_nege          <= radm_bypass_dllp_abort_core          ;
    radm_bypass_tlp_abort_nege           <= radm_bypass_tlp_abort_core           ;
    radm_bypass_ecrc_err_nege            <= radm_bypass_ecrc_err_core            ;
    radm_bypass_addr_nege                <= radm_bypass_addr_core                ;
    radm_bypass_fmt_nege                 <= radm_bypass_fmt_core                 ;
    radm_bypass_tc_nege                  <= radm_bypass_tc_core                  ;
    radm_bypass_attr_nege                <= radm_bypass_attr_core                ;
    radm_bypass_reqid_nege               <= radm_bypass_reqid_core               ;
    radm_bypass_type_nege                <= radm_bypass_type_core                ;
    radm_bypass_tag_nege                 <= radm_bypass_tag_core                 ;
    radm_bypass_func_num_nege            <= radm_bypass_func_num_core            ;
    radm_bypass_vfunc_num_nege           <= radm_bypass_vfunc_num_core           ;
    radm_bypass_vfunc_active_nege        <= radm_bypass_vfunc_active_core        ;
    radm_bypass_td_nege                  <= radm_bypass_td_core                  ;
    radm_bypass_poisoned_nege            <= radm_bypass_poisoned_core            ;
    radm_bypass_dw_len_nege              <= radm_bypass_dw_len_core              ;
    radm_bypass_rom_in_range_nege        <= radm_bypass_rom_in_range_core        ;
    radm_bypass_first_be_nege            <= radm_bypass_first_be_core            ;
    radm_bypass_last_be_nege             <= radm_bypass_last_be_core             ;
    radm_bypass_io_req_in_range_nege     <= radm_bypass_io_req_in_range_core     ;
    radm_bypass_in_membar_range_nege     <= radm_bypass_in_membar_range_core     ;
    radm_bypass_cpl_last_nege            <= radm_bypass_cpl_last_core            ;
    radm_bypass_cpl_status_nege          <= radm_bypass_cpl_status_core          ;
    radm_bypass_st_nege                  <= radm_bypass_st_core                  ;
    radm_bypass_cmpltr_id_nege           <= radm_bypass_cmpltr_id_core           ;
    radm_bypass_byte_cnt_nege            <= radm_bypass_byte_cnt_core            ;
    radm_bypass_ats_nege                 <= radm_bypass_ats_core                 ;
    radm_bypass_th_nege                  <= radm_bypass_th_core                  ;
    radm_bypass_ph_nege                  <= radm_bypass_ph_core                  ;
    radm_bypass_bcm_nege                 <= radm_bypass_bcm_core                 ;
end

always@( posedge user_clk ) begin

    radm_bypass_data_user                <= radm_bypass_data_nege                ;
    radm_bypass_dwen_user                <= radm_bypass_dwen_nege                ;
    radm_bypass_dv_user                  <= radm_bypass_dv_nege                  ;
    radm_bypass_hv_user                  <= radm_bypass_hv_nege                  ;
    radm_bypass_eot_user                 <= radm_bypass_eot_nege                 ;
    radm_bypass_dllp_abort_user          <= radm_bypass_dllp_abort_nege          ;
    radm_bypass_tlp_abort_user           <= radm_bypass_tlp_abort_nege           ;
    radm_bypass_ecrc_err_user            <= radm_bypass_ecrc_err_nege            ;
    radm_bypass_addr_user                <= radm_bypass_addr_nege                ;
    radm_bypass_fmt_user                 <= radm_bypass_fmt_nege                 ;
    radm_bypass_tc_user                  <= radm_bypass_tc_nege                  ;
    radm_bypass_attr_user                <= radm_bypass_attr_nege                ;
    radm_bypass_reqid_user               <= radm_bypass_reqid_nege               ;
    radm_bypass_type_user                <= radm_bypass_type_nege                ;
    radm_bypass_tag_user                 <= radm_bypass_tag_nege                 ;
    radm_bypass_func_num_user            <= radm_bypass_func_num_nege            ;
    radm_bypass_vfunc_num_user           <= radm_bypass_vfunc_num_nege           ;
    radm_bypass_vfunc_active_user        <= radm_bypass_vfunc_active_nege        ;
    radm_bypass_td_user                  <= radm_bypass_td_nege                  ;
    radm_bypass_poisoned_user            <= radm_bypass_poisoned_nege            ;
    radm_bypass_dw_len_user              <= radm_bypass_dw_len_nege              ;
    radm_bypass_rom_in_range_user        <= radm_bypass_rom_in_range_nege        ;
    radm_bypass_first_be_user            <= radm_bypass_first_be_nege            ;
    radm_bypass_last_be_user             <= radm_bypass_last_be_nege             ;
    radm_bypass_io_req_in_range_user     <= radm_bypass_io_req_in_range_nege     ;
    radm_bypass_in_membar_range_user     <= radm_bypass_in_membar_range_nege     ;
    radm_bypass_cpl_last_user            <= radm_bypass_cpl_last_nege            ;
    radm_bypass_cpl_status_user          <= radm_bypass_cpl_status_nege          ;
    radm_bypass_st_user                  <= radm_bypass_st_nege                  ;
    radm_bypass_cmpltr_id_user           <= radm_bypass_cmpltr_id_nege           ;
    radm_bypass_byte_cnt_user            <= radm_bypass_byte_cnt_nege            ;
    radm_bypass_ats_user                 <= radm_bypass_ats_nege                 ;
    radm_bypass_th_user                  <= radm_bypass_th_nege                  ;
    radm_bypass_ph_user                  <= radm_bypass_ph_nege                  ;
    radm_bypass_bcm_user                 <= radm_bypass_bcm_nege                 ;
end

endmodule

module elbi_pipeline(

        input   wire                user_clk                             ,
        input   wire                user_link_up                         ,

        output  reg     [31:0]      lbc_ext_addr_user                    ,
        output  reg     [1:0]       lbc_ext_cs_user                      ,
        output  reg     [3:0]       lbc_ext_wr_user                      ,
        output  reg                 lbc_ext_rom_access_user              ,
        output  reg                 lbc_ext_io_access_user               ,
        output  reg     [31:0]      lbc_ext_dout_user                    ,
        output  reg     [2:0]       lbc_ext_bar_num_user                 ,
        output  reg                 lbc_ext_vfunc_active_user            ,
        output  reg     [1:0]       lbc_ext_vfunc_num_user               ,
        input   wire    [63:0]      ext_lbc_din_user                     ,
        input   wire    [1:0]       ext_lbc_ack_user                     ,

        input   wire    [31:0]      lbc_ext_addr_core                    ,
        input   wire    [1:0]       lbc_ext_cs_core                      ,
        input   wire    [3:0]       lbc_ext_wr_core                      ,
        input   wire                lbc_ext_rom_access_core              ,
        input   wire                lbc_ext_io_access_core               ,
        input   wire    [31:0]      lbc_ext_dout_core                    ,
        input   wire    [2:0]       lbc_ext_bar_num_core                 ,
        input   wire                lbc_ext_vfunc_active_core            ,
        input   wire    [1:0]       lbc_ext_vfunc_num_core               ,
        output  wire    [63:0]      ext_lbc_din_core                     ,
        output  wire    [1:0]       ext_lbc_ack_core
);


// ====================================================================
// Parameter/Wire/Reg
// ====================================================================


    reg     [31:0]      lbc_ext_addr_nege                    ;
    reg     [1:0]       lbc_ext_cs_nege                      ;
    reg     [3:0]       lbc_ext_wr_nege                      ;
    reg                 lbc_ext_rom_access_nege              ;
    reg                 lbc_ext_io_access_nege               ;
    reg     [31:0]      lbc_ext_dout_nege                    ;
    reg     [2:0]       lbc_ext_bar_num_nege                 ;
    reg                 lbc_ext_vfunc_active_nege            ;
    reg     [1:0]       lbc_ext_vfunc_num_nege               ;

// ====================================================================
// Main Code
// ====================================================================


always@( negedge user_clk ) begin
    lbc_ext_addr_nege         <= lbc_ext_addr_core         ;
    lbc_ext_cs_nege           <= lbc_ext_cs_core           ;
    lbc_ext_wr_nege           <= lbc_ext_wr_core           ;
    lbc_ext_rom_access_nege   <= lbc_ext_rom_access_core   ;
    lbc_ext_io_access_nege    <= lbc_ext_io_access_core    ;
    lbc_ext_dout_nege         <= lbc_ext_dout_core         ;
    lbc_ext_bar_num_nege      <= lbc_ext_bar_num_core      ;
    lbc_ext_vfunc_active_nege <= lbc_ext_vfunc_active_core ;
    lbc_ext_vfunc_num_nege    <= lbc_ext_vfunc_num_core    ;
end

always@( posedge user_clk ) begin
    lbc_ext_addr_user         <= lbc_ext_addr_nege         ;
    lbc_ext_cs_user           <= lbc_ext_cs_nege           ;
    lbc_ext_wr_user           <= lbc_ext_wr_nege           ;
    lbc_ext_rom_access_user   <= lbc_ext_rom_access_nege   ;
    lbc_ext_io_access_user    <= lbc_ext_io_access_nege    ;
    lbc_ext_dout_user         <= lbc_ext_dout_nege         ;
    lbc_ext_bar_num_user      <= lbc_ext_bar_num_nege      ;
    lbc_ext_vfunc_active_user <= lbc_ext_vfunc_active_nege ;
    lbc_ext_vfunc_num_user    <= lbc_ext_vfunc_num_nege    ;
end


assign  ext_lbc_din_core = ext_lbc_din_user ;
assign  ext_lbc_ack_core = ext_lbc_ack_user ;


endmodule


module dbi_pipeline(

        input   wire                user_clk                             ,
        input   wire                core_rst_n                           ,
        input   wire                user_link_up                         ,

        input   wire    [31:0]      drp_dbi_din_user                     ,
        input   wire    [3:0]       drp_dbi_wr_user                      ,
        input   wire    [31:0]      drp_dbi_addr_user                    ,
        input   wire                drp_dbi_cs_user                      ,
        input   wire                drp_dbi_cs2_exp_user                 ,
        input   wire    [1:0]       drp_dbi_vfunc_num_user               ,
        input   wire                drp_dbi_vfunc_active_user            ,
        input   wire    [2:0]       drp_dbi_bar_num_user                 ,
        input   wire                drp_dbi_rom_access_user              ,
        input   wire                drp_dbi_io_access_user               ,
        input   wire                drp_dbi_func_num_user                ,
        input   wire                drp_app_dbi_ro_wr_disable_user       ,
        output  reg     [31:0]      drp_lbc_dbi_dout_user                ,
        output  reg                 drp_lbc_dbi_ack_user                 ,

        output  reg     [31:0]      drp_dbi_din_core                     ,
        output  reg     [3:0]       drp_dbi_wr_core                      ,
        output  reg     [31:0]      drp_dbi_addr_core                    ,
        output  reg                 drp_dbi_cs_core                      ,
        output  reg                 drp_dbi_cs2_exp_core                 ,
        output  reg     [1:0]       drp_dbi_vfunc_num_core               ,
        output  reg                 drp_dbi_vfunc_active_core            ,
        output  reg     [2:0]       drp_dbi_bar_num_core                 ,
        output  reg                 drp_dbi_rom_access_core              ,
        output  reg                 drp_dbi_io_access_core               ,
        output  reg                 drp_dbi_func_num_core                ,
        output  reg                 drp_app_dbi_ro_wr_disable_core       ,
        input   wire    [31:0]      drp_lbc_dbi_dout_core                ,
        input   wire                drp_lbc_dbi_ack_core

);


// ====================================================================
// Parameter/Wire/Reg
// ====================================================================


        reg    [31:0]      drp_lbc_dbi_dout_nege                ;
        reg                drp_lbc_dbi_ack_nege                 ;

// ====================================================================
// Main Code
// ====================================================================


always@( negedge user_clk ) begin
    drp_lbc_dbi_dout_nege <= drp_lbc_dbi_dout_core ;
    drp_lbc_dbi_ack_nege  <= drp_lbc_dbi_ack_core  ;
end

always@( posedge user_clk ) begin
    drp_lbc_dbi_dout_user <= drp_lbc_dbi_dout_nege ;
    drp_lbc_dbi_ack_user  <= drp_lbc_dbi_ack_nege  ;
end

always@( posedge user_clk or negedge core_rst_n ) begin
    
    if( !core_rst_n ) begin
        drp_dbi_din_core               <= 'd0 ;
        drp_dbi_wr_core                <= 'd0 ;
        drp_dbi_addr_core              <= 'd0 ;
        drp_dbi_cs_core                <= 'd0 ;
        drp_dbi_cs2_exp_core           <= 'd0 ;
        drp_dbi_vfunc_num_core         <= 'd0 ;
        drp_dbi_vfunc_active_core      <= 'd0 ;
        drp_dbi_bar_num_core           <= 'd0 ;
        drp_dbi_rom_access_core        <= 'd0 ;
        drp_dbi_io_access_core         <= 'd0 ;
        drp_dbi_func_num_core          <= 'd0 ;
        drp_app_dbi_ro_wr_disable_core <= 'd0 ;
    end else begin
        drp_dbi_din_core               <= drp_dbi_din_user               ;
        drp_dbi_wr_core                <= drp_dbi_wr_user                ;
        drp_dbi_addr_core              <= drp_dbi_addr_user              ;
        drp_dbi_cs_core                <= drp_dbi_cs_user                ;
        drp_dbi_cs2_exp_core           <= drp_dbi_cs2_exp_user           ;
        drp_dbi_vfunc_num_core         <= drp_dbi_vfunc_num_user         ;
        drp_dbi_vfunc_active_core      <= drp_dbi_vfunc_active_user      ;
        drp_dbi_bar_num_core           <= drp_dbi_bar_num_user           ;
        drp_dbi_rom_access_core        <= drp_dbi_rom_access_user        ;
        drp_dbi_io_access_core         <= drp_dbi_io_access_user         ;
        drp_dbi_func_num_core          <= drp_dbi_func_num_user          ;
        drp_app_dbi_ro_wr_disable_core <= drp_app_dbi_ro_wr_disable_user ;
    end
end




endmodule
