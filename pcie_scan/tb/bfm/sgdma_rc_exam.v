

`timescale 1ns / 1ps

`include "dt_para.vh"
`include "tlp_fmt_type.vh"
module sgdma_rc_exam (
        app_auxclk,
        app_button_rst_n,

        refclk_p ,
        refclk_n ,
        txp ,
        txn ,
        rxp ,
        rxn ,

        mw_en,
        mr_en,
        iow_en,
        ior_en,
        cfg0w_en,
        cfg0r_en,
        op_start,
        mw_addr,
        mw_len,
        mw_data,
        mw_data_be,
        mw_data_en,
        mr_addr,
        mr_len,
        mr_data_be,
        mr_data,
        mr_data_vld,
        iow_addr,
        iow_data,
        ior_addr,
        ior_data,
        ior_data_vld,
        cfg0w_addr,
        cfg0w_data,
        cfg0r_addr,
        cfg0r_data,
        cfg0r_data_vld,
        mw_op_over,
        mr_op_over,
        iow_op_over,
        ior_op_over,
        cfg0w_op_over,
        cfg0r_op_over,

        h2c_rstn,
        int_odt,
        c2h_fm_odt,
    h2c_fm_idt,
        wdscp_idt,
        rdscp_idt,
        h2c_pmode_odt,
        c2h_pmode_odt,

        msi_detected,
        
        // DBI bus
        drp_dbi_cs,
        drp_dbi_addr,
        drp_dbi_wr,
        drp_dbi_din,
        drp_lbc_dbi_dout,
        drp_lbc_dbi_ack,
        drp_dbi_cs2_exp,
        drp_app_dbi_ro_wr_disable,


        core_clk_c,
        core_rst_n_c

);
`include "bdf.vh"  
        input          app_auxclk;
        input          app_button_rst_n;
        
        input  h2c_rstn;
        output [32*`INT_NUM-1:0]   int_odt;

    input  [`DT_WD*`ODT_NUM-1:0]    h2c_fm_idt;
        output [`DT_WD*`IDT_NUM-1:0]    c2h_fm_odt;
        input  [`DT_WD*`WDSCP_NUM-1:0]  wdscp_idt;
        input  [`DT_WD*`RDSCP_NUM-1:0]  rdscp_idt;
        output  [32*`PMODE_NUM-1:0]     h2c_pmode_odt;
        output  [32*`PMODE_NUM-1:0]     c2h_pmode_odt;
        
        input          refclk_p ;
        input          refclk_n ;
        output [3:0]   txp ;
        output [3:0]   txn ;
        input  [3:0]   rxp ;
        input  [3:0]   rxn ;
        
        // to tlp_access_rc
        input               mw_en;
        input               mr_en;
        input               iow_en;
        input               ior_en;
        input               cfg0w_en;
        input               cfg0r_en;
        input               op_start;
        input    [63:0]     mw_addr;
        input    [11:0]     mw_len;
        input    [`DT_WD-1:0]     mw_data;
        input    [7:0]      mw_data_be;
        input               mw_data_en;
        input    [63:0]     mr_addr;
        input    [11:0]     mr_len;
        input    [7:0]      mr_data_be;
        output   [`DT_WD-1:0]     mr_data;
        output              mr_data_vld;
        input    [31:0]     iow_addr;
        input    [31:0]     iow_data;
        input    [31:0]     ior_addr;
        output   [31:0]     ior_data;
        output              ior_data_vld;
        input    [31:0]     cfg0w_addr;
        input    [31:0]     cfg0w_data;
        input    [31:0]     cfg0r_addr;
        output   [31:0]     cfg0r_data;
        output              cfg0r_data_vld;
        output              mw_op_over;
        output              mr_op_over;
        output              iow_op_over;
        output              ior_op_over;
        output              cfg0w_op_over;
        output              cfg0r_op_over;

    output             msi_detected ;
        
        // DBI bus
        input               drp_dbi_cs;
        input    [31:0]     drp_dbi_addr;
        input    [3:0]      drp_dbi_wr;
        input    [31:0]     drp_dbi_din;
        output   [31:0]     drp_lbc_dbi_dout;
        output              drp_lbc_dbi_ack;
        input               drp_dbi_cs2_exp;
        input               drp_app_dbi_ro_wr_disable;

        output          core_clk_c;     
        output          core_rst_n_c;


// ====================================================================
// Parameter/wire/reg
// ====================================================================
wire  [`DT_WD-1:0]   client0_tlp_data ;
wire  [63:0]   client0_tlp_addr ;
wire  [15:0]   client0_remote_req_id ;
wire  [7:0]    client0_tlp_byte_en ;
wire  [11:0]   client0_cpl_byte_cnt ;
wire           client0_addr_align_en ;
wire  [2:0]    client0_tlp_tc ;
wire  [2:0]    client0_tlp_attr ;
wire  [2:0]    client0_cpl_status ;
wire           client0_cpl_bcm ;
wire           client0_tlp_dv ;
wire           client0_tlp_eot ;
wire           client0_tlp_bad_eot ;
wire           client0_tlp_hv ;
wire  [4:0]    client0_tlp_type ;
wire  [1:0]    client0_tlp_fmt ;
wire           client0_tlp_td ;
wire  [12:0]   client0_tlp_byte_len ;
wire  [9:0]    client0_tlp_tid ;
wire           client0_tlp_ep ;
wire           client0_tlp_func_num ;
wire  [1:0]    client0_tlp_ats ;
wire  [7:0]    client0_tlp_st ;
wire           client0_tlp_nw ;
wire           client0_tlp_th ;
wire  [1:0]    client0_tlp_ph ;
wire           client0_tlp_atu_bypass ;
wire           xadm_client0_halt ;
wire  [9:0]    client0_cpl_lookup_id ;

wire   [`DT_WD-1:0]   client1_tlp_data ;
wire   [63:0]   client1_tlp_addr ;
wire   [15:0]   client1_remote_req_id ;
wire   [7:0]    client1_tlp_byte_en ;
wire   [11:0]   client1_cpl_byte_cnt ;
wire            client1_addr_align_en ;
wire   [2:0]    client1_tlp_tc ;
wire   [2:0]    client1_tlp_attr ;
wire   [2:0]    client1_cpl_status ;
wire            client1_cpl_bcm ;
wire            client1_tlp_dv ;
wire            client1_tlp_eot ;
wire            client1_tlp_bad_eot ;
wire            client1_tlp_hv ;
wire   [4:0]    client1_tlp_type ;
wire   [1:0]    client1_tlp_fmt ;
wire            client1_tlp_td ;
wire   [12:0]   client1_tlp_byte_len ;
wire   [9:0]    client1_tlp_tid ;
wire            client1_tlp_ep ;
wire            client1_tlp_func_num ;
wire   [1:0]    client1_tlp_ats ;
wire   [7:0]    client1_tlp_st ;
wire            client1_tlp_nw ;
wire            client1_tlp_th ;
wire   [1:0]    client1_tlp_ph ;
wire            client1_tlp_atu_bypass ;
wire   [9:0]    client1_cpl_lookup_id ;
wire            xadm_client1_halt ;


wire   [`DT_WD-1:0]  radm_bypass_data ;
wire   [3:0]   radm_bypass_dwen ;
wire           radm_bypass_dv ;
wire           radm_bypass_hv ;
wire           radm_bypass_eot ;
wire           radm_bypass_dllp_abort ;
wire           radm_bypass_tlp_abort ;
wire           radm_bypass_ecrc_err ;
wire   [63:0]  radm_bypass_addr ;
wire   [1:0]   radm_bypass_fmt ;
wire   [2:0]   radm_bypass_tc ;
wire   [2:0]   radm_bypass_attr ;
wire   [15:0]  radm_bypass_reqid ;
wire   [4:0]   radm_bypass_type ;
wire   [9:0]   radm_bypass_tag ;
wire           radm_bypass_func_num ;
wire           radm_bypass_td ;
wire           radm_bypass_poisoned ;
wire   [9:0]   radm_bypass_dw_len ;
wire           radm_bypass_rom_in_range ;
wire   [3:0]   radm_bypass_first_be ;
wire   [3:0]   radm_bypass_last_be ;
wire           radm_bypass_io_req_in_range ;
wire   [2:0]   radm_bypass_in_membar_range ;
wire           radm_bypass_cpl_last ;
wire   [2:0]   radm_bypass_cpl_status ;
wire   [7:0]   radm_bypass_st ;
wire   [15:0]  radm_bypass_cmpltr_id ;
wire   [11:0]  radm_bypass_byte_cnt ;
wire   [1:0]   radm_bypass_ats ;
wire           radm_bypass_th ;
wire   [1:0]   radm_bypass_ph ;
wire           radm_bypass_bcm ;

wire           app_button_rst_n ;
wire           app_auxclk ;
wire           app_auxclk_g;
wire           phy_cr_para_clk ;




    wire           radm_trgt1_dv ;
    wire           radm_trgt1_hv ;
    wire           radm_trgt1_eot ;
    wire           radm_trgt1_tlp_abort ;
    wire           radm_trgt1_dllp_abort ;
    wire           radm_trgt1_ecrc_err ;
    wire   [3:0]   radm_trgt1_dwen ;
    wire   [1:0]   radm_trgt1_fmt ;
    wire   [2:0]   radm_trgt1_attr ;
    wire           radm_trgt1_func_num ;
    wire   [4:0]   radm_trgt1_type ;
    wire   [2:0]   radm_trgt1_tc ;
    wire   [15:0]  radm_trgt1_reqid ;
    wire   [`DT_WD-1:0]  radm_trgt1_data ;
    wire   [3:0]   radm_trgt1_first_be ;
    wire   [3:0]   radm_trgt1_last_be ;
    wire   [63:0]  radm_trgt1_addr ;
    wire           radm_trgt1_td ;
    wire           radm_trgt1_poisoned ;
    wire           radm_trgt1_hdr_uppr_bytes_valid ;
    wire           radm_trgt1_rom_in_range ;
    wire           radm_trgt1_io_req_in_range ;
    wire   [63:0]  radm_trgt1_hdr_uppr_bytes ;
    wire   [2:0]   radm_trgt1_in_membar_range ;
    wire   [2:0]   radm_trgt1_cpl_status ;
    wire   [1:0]   radm_trgt1_ats ;
    wire   [9:0]   radm_trgt1_tag ;
    wire   [9:0]   radm_trgt1_dw_len ;
    wire           radm_trgt1_nw ;
    wire           radm_trgt1_th ;
    wire   [1:0]   radm_trgt1_ph ;
    wire   [7:0]   radm_trgt1_st ;
    wire   [11:0]  radm_trgt1_byte_cnt ;
    wire           radm_trgt1_bcm ;
    wire   [2:0]   radm_trgt1_vc ;
    wire   [15:0]  radm_trgt1_cmpltr_id ;
    wire           radm_trgt1_cpl_last ;
    wire   [2:0]   radm_grant_tlp_type ;
    wire   [1:0]   radm_trgt1_atu_sloc_match ;
    wire   [1:0]   radm_trgt1_atu_cbuf_err ;
        wire           trgt1_radm_halt ;
        wire  [2:0]    trgt1_radm_pkt_halt ;
    wire           radm_idle ;

    wire           rdlh_link_up;

    wire   [1:0]   cfg_eml_control ;
    wire           radm_vendor_msg ;
    wire   [63:0]  radm_msg_payload ;
    wire   [15:0]  radm_msg_req_id ;
    wire   [1:0]   cfg_send_cor_err ;
    wire   [1:0]   cfg_send_nf_err ;
    wire   [1:0]   cfg_send_f_err ;
        wire   [1:0]   cfg_br_ctrl_serren ;

        wire   [1:0] cfg_aer_rc_err_int ; 
    wire   [1:0] cfg_pme_int ; 
    wire   radm_inta_asserted ; 
    wire   radm_intb_asserted ; 
    wire   radm_intc_asserted ; 
    wire   radm_intd_asserted ; 
    wire   radm_inta_deasserted ; 
    wire   radm_intb_deasserted ; 
    wire   radm_intc_deasserted ; 
    wire   radm_intd_deasserted ; 
    wire   cfg_link_auto_bw_int ; 
    wire   cfg_bw_mgt_int ; 
    wire   [1:0] cfg_int_disable ; 
    wire   [15:0] cfg_int_pin ; 

    wire           cfg_link_eq_req_int ;
    wire           smlh_req_rst_not ;
    wire           link_req_rst_not ;


    wire           cfg_2nd_reset ;
    wire   [1:0]   cfg_sys_err_rc ;
    wire           radm_correctable_err ;
    wire           radm_nonfatal_err ;
    wire           radm_fatal_err ;

    wire   [5:0]   smlh_ltssm_state ;

    wire           radm_cpl_timeout ;
        wire           radm_timeout_func_num ;
    wire   [2:0]   radm_timeout_cpl_tc ;
    wire   [1:0]   radm_timeout_cpl_attr ;
    wire   [9:0]   radm_timeout_cpl_tag ;
    wire   [11:0]  radm_timeout_cpl_len ;
    wire           pm_xtlh_block_tlp ;
    wire   [31:0]  cfg_phy_control ;
    wire           cfg_hw_auto_sp_dis ;
    wire           smlh_ltssm_state_rcvry_eq ;
    wire           trgt_cpl_timeout ;
        wire           trgt_timeout_cpl_func_num ;
    wire   [2:0]   trgt_timeout_cpl_tc ;
    wire   [1:0]   trgt_timeout_cpl_attr ;
    wire   [11:0]  trgt_timeout_cpl_len ;
    wire   [9:0]   trgt_timeout_lookup_id ;
    wire   [9:0]   trgt_lookup_id ;
    wire           trgt_lookup_empty ;
    wire   [1:0]   cfg_reg_serren ;
    wire   [1:0]   cfg_cor_err_rpt_en ;
    wire   [1:0]   cfg_nf_err_rpt_en ;
    wire   [1:0]   cfg_f_err_rpt_en ;
    wire           cfg_uncor_internal_err_sts ;
    wire           cfg_rcvr_overflow_err_sts ;
    wire           cfg_fc_protocol_err_sts ;
    wire           cfg_mlf_tlp_err_sts ;
    wire           cfg_surprise_down_er_sts ;
    wire           cfg_dl_protocol_err_sts ;
    wire           cfg_ecrc_err_sts ;
    wire           cfg_corrected_internal_err_sts ;
    wire           cfg_replay_number_rollover_err_sts ;
    wire           cfg_replay_timer_timeout_err_sts ;
    wire           cfg_bad_dllp_err_sts ;
    wire           cfg_bad_tlp_err_sts ;
    wire           cfg_rcvr_err_sts ;
    wire           core_rst_n ;

//    wire   [1:0]   cfg_up_drs_to_frs ;
//    wire   [1:0]   frsq_msi ;
//    wire   [9:0]   frsq_int_msg_num ;


    wire           core_clk ;
    wire           muxd_aux_clk ;
    wire           muxd_aux_clk_g ;
//      wire           comb_rst_n;
        wire       core_clk_c;
        wire       core_rst_n_c;



PH1_LOGIC_BUFG app_auxclk_bufg(
        .i(app_auxclk),
        .o(app_auxclk_g)
);
assign phy_cr_para_clk = app_auxclk_g;

PH1_LOGIC_BUFG core_clk_bufg( //                                                                     
        .i(core_clk),
        .o(core_clk_c)
);
PH1_LOGIC_BUFG core_rst_bufg(
        .i(core_rst_n),
        .o(core_rst_n_c)
); 
// PCIE instance
pcie_rc_core u_rc_core
        (
        .refclk_p                          (refclk_p                          ),
        .refclk_n                          (refclk_n                          ),
        .txp                               (txp                               ),
        .txn                               (txn                               ),
        .rxp                               (rxp                               ),
        .rxn                               (rxn                               ),

    .client0_tlp_data                  (client0_tlp_data                  ),
    .client0_tlp_addr                  (client0_tlp_addr                  ),
    .client0_remote_req_id             (client0_remote_req_id             ),
    .client0_tlp_byte_en               (client0_tlp_byte_en               ),
    .client0_cpl_byte_cnt              (client0_cpl_byte_cnt              ),
    .client0_addr_align_en             (client0_addr_align_en             ),
    .client0_tlp_tc                    (client0_tlp_tc                    ),
    .client0_tlp_attr                  (client0_tlp_attr                  ),
    .client0_cpl_status                (client0_cpl_status                ),
    .client0_cpl_bcm                   (client0_cpl_bcm                   ),
    .client0_tlp_dv                    (client0_tlp_dv                    ),
    .client0_tlp_eot                   (client0_tlp_eot                   ),
    .client0_tlp_bad_eot               (client0_tlp_bad_eot               ),
    .client0_tlp_hv                    (client0_tlp_hv                    ),
    .client0_tlp_type                  (client0_tlp_type                  ),
    .client0_tlp_fmt                   (client0_tlp_fmt                   ),
    .client0_tlp_td                    (client0_tlp_td                    ),
    .client0_tlp_byte_len              (client0_tlp_byte_len              ),
    .client0_tlp_tid                   (client0_tlp_tid                   ),
    .client0_tlp_ep                    (client0_tlp_ep                    ),
    .client0_tlp_func_num              (client0_tlp_func_num              ),
    .client0_tlp_ats                   (client0_tlp_ats                   ),
    .client0_tlp_st                    (client0_tlp_st                    ),
    .client0_tlp_nw                    (client0_tlp_nw                    ),
    .client0_tlp_th                    (client0_tlp_th                    ),
    .client0_tlp_ph                    (client0_tlp_ph                    ),
    .client0_tlp_atu_bypass            (client0_tlp_atu_bypass            ),

    .client1_tlp_data                  (client1_tlp_data                  ),
    .client1_tlp_addr                  ({57'd0,client1_tlp_addr[6:0]}     ),
    .client1_remote_req_id             (client1_remote_req_id             ),
    .client1_tlp_byte_en               (8'd0                              ),
    .client1_cpl_byte_cnt              (client1_cpl_byte_cnt              ),
    .client1_addr_align_en             (client1_addr_align_en             ),
    .client1_tlp_tc                    (client1_tlp_tc                   ),
    .client1_tlp_attr                  (client1_tlp_attr                  ),
    .client1_cpl_status                (client1_cpl_status               ),
    .client1_cpl_bcm                   (client1_cpl_bcm                   ),
    .client1_tlp_dv                    (client1_tlp_dv                    ),
    .client1_tlp_eot                   (client1_tlp_eot                   ),
    .client1_tlp_bad_eot               (client1_tlp_bad_eot               ),
    .client1_tlp_hv                    (client1_tlp_hv                    ),
    .client1_tlp_type                  (client1_tlp_type                  ),
    .client1_tlp_fmt                   (client1_tlp_fmt                   ),
    .client1_tlp_td                    (client1_tlp_td                    ),
    .client1_tlp_byte_len              (client1_tlp_byte_len              ),
    .client1_tlp_tid                   ({2'b00,client1_tlp_tid[7:0]}      ),
    .client1_tlp_ep                    (client1_tlp_ep                    ),
    .client1_tlp_func_num              (client1_tlp_func_num              ),
    .client1_tlp_ats                   (2'b00                             ),
    .client1_tlp_st                    (8'd0                              ),
    .client1_tlp_nw                    (1'b0                              ),
    .client1_tlp_th                    (1'b0                              ),
    .client1_tlp_ph                    (2'b00                             ),
    .client1_tlp_atu_bypass            (client1_tlp_atu_bypass            ),
   
        .trgt1_radm_halt                   (trgt1_radm_halt                   ),
    .trgt1_radm_pkt_halt               (trgt1_radm_pkt_halt               ),

        .app_init_rst                      (1'b0                      ),
    .sys_atten_button_pressed          (2'b00          ),
    .sys_pre_det_state                 (2'b00                 ),
    .sys_mrl_sensor_state              (2'b00              ),
    .sys_pwr_fault_det                 (2'b00                 ),
    .sys_mrl_sensor_chged              (2'b00              ),
    .sys_pre_det_chged                 (2'b00                 ),
    .sys_cmd_cpled_int                 (2'b00                 ),
    .sys_eml_interlock_engaged         (2'b00         ),
    .rx_lane_flip_en                   (1'b0                   ),
    .tx_lane_flip_en                   (1'b0                   ),

    .app_sris_mode                     (1'b1                     ),
    .app_unlock_msg                    (1'b0                    ),
    .app_hdr_log                       (128'd0                       ),
    .app_err_bus                       (13'b0                       ),
    .app_err_advisory                  (1'b0                  ),
    .app_err_func_num                  (1'b0                  ),
    .app_hdr_valid                     (1'b0                     ),
    .client0_cpl_lookup_id             (client0_cpl_lookup_id             ),
        .client1_cpl_lookup_id             (client1_cpl_lookup_id             ),
    .app_bus_num                       (RC_BUS_NUM                       ),
    .app_dev_num                       (RC_DEV_NUM                       ),
    .app_power_up_rst_n                (1'b1                ),
    .app_button_rst_n                  (app_button_rst_n                  ),
    .app_app_ltssm_enable              (1'b1              ),
    .app_auxclk                        (app_auxclk_g                        ),

    .drp_dbi_din                       (drp_dbi_din                       ),
    .drp_dbi_wr                        (drp_dbi_wr                        ),
    .drp_dbi_addr                      (drp_dbi_addr                      ),
    .drp_dbi_cs                        (drp_dbi_cs                        ),
    .drp_dbi_cs2_exp                   (drp_dbi_cs2_exp                   ),
    .drp_app_dbi_ro_wr_disable         (drp_app_dbi_ro_wr_disable         ),          
    .drp_lbc_dbi_dout                  (drp_lbc_dbi_dout                  ),
    .drp_lbc_dbi_ack                   (drp_lbc_dbi_ack                   ),

        .phy_cr_para_clk                   (phy_cr_para_clk                   ),
        .xadm_client0_halt                 (xadm_client0_halt                 ),
        .xadm_client1_halt                 (xadm_client1_halt                 ),

    .radm_bypass_data                  (radm_bypass_data                  ),
    .radm_bypass_dwen                  (radm_bypass_dwen                  ),
    .radm_bypass_dv                    (radm_bypass_dv                    ),
    .radm_bypass_hv                    (radm_bypass_hv                    ),
    .radm_bypass_eot                   (radm_bypass_eot                   ),
    .radm_bypass_dllp_abort            (radm_bypass_dllp_abort            ),
    .radm_bypass_tlp_abort             (radm_bypass_tlp_abort             ),
    .radm_bypass_ecrc_err              (radm_bypass_ecrc_err              ),
    .radm_bypass_addr                  (radm_bypass_addr                  ),
    .radm_bypass_fmt                   (radm_bypass_fmt                   ),
    .radm_bypass_tc                    (radm_bypass_tc                    ),
    .radm_bypass_attr                  (radm_bypass_attr                  ),
    .radm_bypass_reqid                 (radm_bypass_reqid                 ),
    .radm_bypass_type                  (radm_bypass_type                  ),
    .radm_bypass_tag                   (radm_bypass_tag                   ),
    .radm_bypass_func_num              (radm_bypass_func_num              ),
    .radm_bypass_td                    (radm_bypass_td                    ),
    .radm_bypass_poisoned              (radm_bypass_poisoned              ),
    .radm_bypass_dw_len                (radm_bypass_dw_len                ),
    .radm_bypass_rom_in_range          (radm_bypass_rom_in_range          ),
    .radm_bypass_first_be              (radm_bypass_first_be              ),
    .radm_bypass_last_be               (radm_bypass_last_be               ),
    .radm_bypass_io_req_in_range       (radm_bypass_io_req_in_range       ),
    .radm_bypass_in_membar_range       (radm_bypass_in_membar_range       ),
    .radm_bypass_cpl_last              (radm_bypass_cpl_last              ),
    .radm_bypass_cpl_status            (radm_bypass_cpl_status            ),
    .radm_bypass_st                    (radm_bypass_st                    ),
    .radm_bypass_cmpltr_id             (radm_bypass_cmpltr_id             ),
    .radm_bypass_byte_cnt              (radm_bypass_byte_cnt              ),
    .radm_bypass_ats                   (radm_bypass_ats                   ),
    .radm_bypass_th                    (radm_bypass_th                    ),
    .radm_bypass_ph                    (radm_bypass_ph                    ),
    .radm_bypass_bcm                   (radm_bypass_bcm                   ),

    .radm_trgt1_dv                     (radm_trgt1_dv                     ),
    .radm_trgt1_hv                     (radm_trgt1_hv                     ),
    .radm_trgt1_eot                    (radm_trgt1_eot                    ),
    .radm_trgt1_tlp_abort              (radm_trgt1_tlp_abort              ),
    .radm_trgt1_dllp_abort             (radm_trgt1_dllp_abort             ),
    .radm_trgt1_ecrc_err               (radm_trgt1_ecrc_err               ),//no connection
    .radm_trgt1_dwen                   (radm_trgt1_dwen                   ),
    .radm_trgt1_fmt                    (radm_trgt1_fmt                    ),
    .radm_trgt1_attr                   (radm_trgt1_attr                    ),
    .radm_trgt1_func_num               (radm_trgt1_func_num               ),
    .radm_trgt1_type                   (radm_trgt1_type                   ),
    .radm_trgt1_tc                     (radm_trgt1_tc                     ),
    .radm_trgt1_reqid                  (radm_trgt1_reqid                  ),
    .radm_trgt1_data                   (radm_trgt1_data                   ),
    .radm_trgt1_first_be               (radm_trgt1_first_be               ),
    .radm_trgt1_last_be                (radm_trgt1_last_be                ),
    .radm_trgt1_addr                   (radm_trgt1_addr                   ),
    .radm_trgt1_td                     (radm_trgt1_td                    ),
    .radm_trgt1_poisoned               (radm_trgt1_poisoned               ),//ep
    .radm_trgt1_hdr_uppr_bytes_valid   (radm_trgt1_hdr_uppr_bytes_valid   ),
    .radm_trgt1_rom_in_range           (radm_trgt1_rom_in_range           ),
    .radm_trgt1_io_req_in_range        (radm_trgt1_io_req_in_range        ),
    .radm_trgt1_hdr_uppr_bytes         (radm_trgt1_hdr_uppr_bytes         ),//input signal 64bit
    .radm_trgt1_in_membar_range        (radm_trgt1_in_membar_range        ),
    .radm_trgt1_cpl_status             (radm_trgt1_cpl_status             ),//not mwr mrd,
    .radm_trgt1_ats                    (radm_trgt1_ats                    ),//at
    .radm_trgt1_tag                    (radm_trgt1_tag                    ),//10bit->8bit
    .radm_trgt1_dw_len                 (radm_trgt1_dw_len                 ),
    .radm_trgt1_nw                     (radm_trgt1_nw                     ),//not mwr mrd
    .radm_trgt1_th                     (radm_trgt1_th                     ),
    .radm_trgt1_ph                     (radm_trgt1_ph                     ),
    .radm_trgt1_st                     (radm_trgt1_st                     ),//not mwr mrd
    .radm_trgt1_byte_cnt               (radm_trgt1_byte_cnt               ),//cpld 
    .radm_trgt1_bcm                    (radm_trgt1_bcm                    ),//cpld
    .radm_trgt1_vc                     (radm_trgt1_vc                     ),//no connection
    .radm_trgt1_cmpltr_id              (radm_trgt1_cmpltr_id              ),//cpld
    .radm_trgt1_cpl_last               (radm_trgt1_cpl_last               ),//cpld
    .radm_grant_tlp_type               (radm_grant_tlp_type               ),
    .radm_trgt1_atu_sloc_match         (radm_trgt1_atu_sloc_match         ),//???
    .radm_trgt1_atu_cbuf_err           (radm_trgt1_atu_cbuf_err           ),
    .radm_idle                         (radm_idle                         ),

        .rdlh_link_up                      (rdlh_link_up                      ),
    .cfg_eml_control                   (cfg_eml_control                   ),
    .radm_vendor_msg                   (radm_vendor_msg                   ),
    .radm_msg_payload                  (radm_msg_payload                  ),
    .radm_msg_req_id                   (radm_msg_req_id                   ),
    .cfg_send_cor_err                  (cfg_send_cor_err                  ),
    .cfg_send_nf_err                   (cfg_send_nf_err                   ),
    .cfg_send_f_err                    (cfg_send_f_err                    ),
    .cfg_br_ctrl_serren                (cfg_br_ctrl_serren                ),

        .cfg_aer_rc_err_int                (cfg_aer_rc_err_int                ),
        .cfg_pme_int                       (cfg_pme_int                       ),
        .radm_inta_asserted                (radm_inta_asserted                ),
        .radm_intb_asserted                (radm_intb_asserted                ),
        .radm_intc_asserted                (radm_intc_asserted                ),
        .radm_intd_asserted                (radm_intd_asserted                ),
        .radm_intd_deasserted              (radm_intd_deasserted              ),
        .radm_inta_deasserted              (radm_inta_deasserted              ),
        .radm_intb_deasserted              (radm_intb_deasserted              ),
        .radm_intc_deasserted              (radm_intc_deasserted              ),
        .cfg_link_auto_bw_int              (cfg_link_auto_bw_int              ),
        .cfg_bw_mgt_int                    (cfg_bw_mgt_int                    ),
        .cfg_int_disable                   (cfg_int_disable),
        .cfg_int_pin                       (cfg_int_pin),

    .cfg_link_eq_req_int               (cfg_link_eq_req_int               ),
    .smlh_req_rst_not                  (smlh_req_rst_not                  ),
    .link_req_rst_not                  (link_req_rst_not                  ),
    .cfg_2nd_reset                     (cfg_2nd_reset                     ),
    .cfg_sys_err_rc                    (cfg_sys_err_rc                    ),
    .radm_correctable_err              (radm_correctable_err              ),
    .radm_nonfatal_err                 (radm_nonfatal_err                 ),
    .radm_fatal_err                    (radm_fatal_err                    ),
    .smlh_ltssm_state                  (smlh_ltssm_state                  ),

    .radm_cpl_timeout                  (radm_cpl_timeout                  ),
    .radm_timeout_func_num             (radm_timeout_func_num             ),
    .radm_timeout_cpl_tc               (radm_timeout_cpl_tc               ),
    .radm_timeout_cpl_attr             (radm_timeout_cpl_attr             ),
    .radm_timeout_cpl_tag              (radm_timeout_cpl_tag              ),
    .radm_timeout_cpl_len              (radm_timeout_cpl_len              ),
    .pm_xtlh_block_tlp                 (pm_xtlh_block_tlp                 ),
    .cfg_phy_control                   (cfg_phy_control                   ),
    .cfg_hw_auto_sp_dis                (cfg_hw_auto_sp_dis                ),
    .smlh_ltssm_state_rcvry_eq         (smlh_ltssm_state_rcvry_eq         ),

    .trgt_cpl_timeout                  (trgt_cpl_timeout                  ),
    .trgt_timeout_cpl_func_num         (trgt_timeout_cpl_func_num         ),
    .trgt_timeout_cpl_tc               (trgt_timeout_cpl_tc               ),
    .trgt_timeout_cpl_attr             (trgt_timeout_cpl_attr             ),
    .trgt_timeout_cpl_len              (trgt_timeout_cpl_len              ),
    .trgt_timeout_lookup_id            (trgt_timeout_lookup_id            ),
    .trgt_lookup_id                    (trgt_lookup_id                    ),
    .trgt_lookup_empty                 (trgt_lookup_empty                 ),
    .cfg_reg_serren                    (cfg_reg_serren                    ),
    .cfg_cor_err_rpt_en                (cfg_cor_err_rpt_en                ),
    .cfg_nf_err_rpt_en                 (cfg_nf_err_rpt_en                 ),
    .cfg_f_err_rpt_en                  (cfg_f_err_rpt_en                  ),
    .cfg_uncor_internal_err_sts        (cfg_uncor_internal_err_sts        ),
    .cfg_rcvr_overflow_err_sts         (cfg_rcvr_overflow_err_sts         ),
    .cfg_fc_protocol_err_sts           (cfg_fc_protocol_err_sts           ),
    .cfg_mlf_tlp_err_sts               (cfg_mlf_tlp_err_sts               ),
    .cfg_surprise_down_er_sts          (cfg_surprise_down_er_sts          ),
    .cfg_dl_protocol_err_sts           (cfg_dl_protocol_err_sts           ),
    .cfg_ecrc_err_sts                  (cfg_ecrc_err_sts                  ),
    .cfg_corrected_internal_err_sts    (cfg_corrected_internal_err_sts    ),
    .cfg_replay_number_rollover_err_sts(cfg_replay_number_rollover_err_sts),
    .cfg_replay_timer_timeout_err_sts  (cfg_replay_timer_timeout_err_sts  ),
    .cfg_bad_dllp_err_sts              (cfg_bad_dllp_err_sts              ),
    .cfg_bad_tlp_err_sts               (cfg_bad_tlp_err_sts               ),
    .cfg_rcvr_err_sts                  (cfg_rcvr_err_sts                  ),
    .core_rst_n                        (core_rst_n                        ),

    .core_clk                          (core_clk                          ),
    .muxd_aux_clk                      (muxd_aux_clk                      ),
    .muxd_aux_clk_g                    (muxd_aux_clk_g                    )
        );


wire           trgtlookup_id_rden;
wire   [9:0]   trgtlookup_id;
//wire  [`HDR_WD-1:0]   radm_trgt1_header;
//wire  [`HDR_WD-1:0]   client1_header_data;
wire  [`HDR_WD-1:0]   mrd_q;
wire           mrd_rdempty;
pcie_rx_bfm u_rx_bfm(
        .core_rst_n(core_rst_n_c&h2c_rstn),
        .core_clk(core_clk_c),

        .trgt1_radm_halt_o(trgt1_radm_halt),//global halt
        .radm_trgt1_dv_i(radm_trgt1_dv),
        .radm_trgt1_hv_i(radm_trgt1_hv),
        .radm_trgt1_eot_i(radm_trgt1_eot),
        .radm_trgt1_data_i(radm_trgt1_data),
        .radm_trgt1_header_i({radm_trgt1_addr[63:2],radm_trgt1_ph,radm_trgt1_reqid,radm_trgt1_tag[7:0],
                                  radm_trgt1_last_be,radm_trgt1_first_be,1'b0,radm_trgt1_fmt,radm_trgt1_type,1'b0,radm_trgt1_tc,
                                  1'b0,radm_trgt1_attr[2],1'b0,radm_trgt1_th,radm_trgt1_td,radm_trgt1_poisoned,radm_trgt1_attr[1:0],
                                                  radm_trgt1_ats,radm_trgt1_dw_len
                                 }),//pos&non_pos 4DW,cpl 3DW. 
        .radm_trgt1_dwen_i(radm_trgt1_dwen),
        .radm_trgt1_cpl_last_i(radm_trgt1_cpl_last),
        .radm_grant_tlp_type_i(radm_grant_tlp_type),//0:pos,1:non_pos,2:cpl
        .trgt1_radm_pkt_halt_o(trgt1_radm_pkt_halt),
        .radm_trgt1_tlp_abort_i(radm_trgt1_tlp_abort),
        .radm_trgt1_dllp_abort_i(radm_trgt1_dllp_abort),
        .radm_trgt1_ecrc_err_i(radm_trgt1_ecrc_err),
        .radm_trgt1_func_num_i(radm_trgt1_func_num),
        .radm_trgt1_hdr_uppr_bytes_valid_i(radm_trgt1_hdr_uppr_bytes_valid),
        .radm_trgt1_rom_in_range_i(radm_trgt1_rom_in_range),
        .radm_trgt1_io_req_in_range_i(radm_trgt1_io_req_in_range),
        .radm_trgt1_hdr_uppr_bytes_i(radm_trgt1_hdr_uppr_bytes),
        .radm_trgt1_in_membar_range_i(radm_trgt1_in_membar_range),
        .radm_trgt1_nw_i(radm_trgt1_nw),
        .radm_trgt1_atu_sloc_match_i(radm_trgt1_atu_sloc_match),
        .radm_trgt1_atu_cbuf_err_i(radm_trgt1_atu_cbuf_err),

        .trgt_lookup_id_i(trgt_lookup_id),
        .trgtlookup_id_rden_i(trgtlookup_id_rden),
        .trgtlookup_id_o(trgtlookup_id),

        .mrd_rden_i(mrd_rden),
        .mrd_q_o(mrd_q),
        .mrd_rdempty_o(mrd_rdempty),

        .h2c_pmode_odt(h2c_pmode_odt),
        .c2h_pmode_odt(c2h_pmode_odt),
        .c2h_fm_odt(c2h_fm_odt)
);

wire   r10,r11;
wire   [1:0]   r12,r13;
wire   [9:0]   dw1_len;
wire   t18,t19;
wire   [15:0]  completer1_id;
pcie_tx_bfm u_tx_bfm(
        .core_rst_n(core_rst_n_c&h2c_rstn),
        .core_clk(core_clk_c),
        
    .h2c_fm_idt(h2c_fm_idt),
        .wdscp_idt(wdscp_idt),
        .rdscp_idt(rdscp_idt),

        .trgtlookup_id_i(trgtlookup_id),
        .trgtlookup_id_rden_o(trgtlookup_id_rden),

        .mrd_rden_o(mrd_rden),
        .mrd_q_i(mrd_q),
        .mrd_rdempty_i(mrd_rdempty),
        
        .client0_addr_align_en_o(client1_addr_align_en),
        .client0_tlp_byte_en_o(client1_tlp_byte_en),
        .client0_header_data_o({client1_remote_req_id,client1_tlp_tid[7:0],r10,client1_tlp_addr[6:0],completer1_id,
                                                        client1_cpl_status,client1_cpl_bcm,client1_cpl_byte_cnt,r11,client1_tlp_fmt,client1_tlp_type,
                                                        t19,client1_tlp_tc,t18,client1_tlp_attr[2],r12,client1_tlp_td,client1_tlp_ep,client1_tlp_attr[1:0],r13,dw1_len

        }),
        .client0_tlp_dv_o(client1_tlp_dv),
        .client0_tlp_eot_o(client1_tlp_eot),
        .client0_tlp_bad_eot_o(client1_tlp_bad_eot),
        .client0_tlp_hv_o(client1_tlp_hv),
        .client0_tlp_byte_len_o(client1_tlp_byte_len),
        .client0_tlp_data_o(client1_tlp_data),
        .client0_tlp_func_num_o(client1_tlp_func_num),
        .xadm_client0_halt_i(xadm_client1_halt),
        .client0_tlp_atu_bypass_o(client1_tlp_atu_bypass),
        .client0_lookup_cpl_id_o(client1_cpl_lookup_id)

);


// for Memory write/read IO write read request
tlp_access_rc u_tlp_access_rc(
        .core_rst_n                      (core_rst_n_c&h2c_rstn          ),
        .core_clk                        (core_clk_c                     ),
        .rc_bdf                          (RC_BDF                         ),
        .ep_bdf                          (EP_BDF                         ),
    // XALI0 tx
    .client0_tlp_data                (client0_tlp_data               ),
    .client0_tlp_addr                (client0_tlp_addr               ),
    .client0_remote_req_id           (client0_remote_req_id          ),
    .client0_tlp_byte_en             (client0_tlp_byte_en            ),
    .client0_cpl_byte_cnt            (client0_cpl_byte_cnt           ),
    .client0_addr_align_en           (client0_addr_align_en          ),
    .client0_tlp_tc                  (client0_tlp_tc                 ),
    .client0_tlp_attr                (client0_tlp_attr               ),
    .client0_cpl_status              (client0_cpl_status             ),
    .client0_cpl_bcm                 (client0_cpl_bcm                ),
    .client0_tlp_dv                  (client0_tlp_dv                 ),
    .client0_tlp_eot                 (client0_tlp_eot                ),
    .client0_tlp_bad_eot             (client0_tlp_bad_eot            ),
    .client0_tlp_hv                  (client0_tlp_hv                 ),
    .client0_tlp_type                (client0_tlp_type               ),
    .client0_tlp_fmt                 (client0_tlp_fmt                ),
    .client0_tlp_td                  (client0_tlp_td                 ),
    .client0_tlp_byte_len            (client0_tlp_byte_len           ),
    .client0_tlp_tid                 (client0_tlp_tid                ),
    .client0_tlp_ep                  (client0_tlp_ep                 ),
    .client0_tlp_func_num            (client0_tlp_func_num           ),

    .client0_tlp_ats                 (client0_tlp_ats                ),
    .client0_tlp_st                  (client0_tlp_st                 ),

    .client0_tlp_nw                  (client0_tlp_nw                 ),
    .client0_tlp_th                  (client0_tlp_th                 ),
    .client0_tlp_ph                  (client0_tlp_ph                 ),
    .client0_tlp_atu_bypass          (client0_tlp_atu_bypass         ),
        .client0_cpl_lookup_id           (client0_cpl_lookup_id          ),
        // XALI0 rx
    .xadm_client0_halt               (xadm_client0_halt              ),
        // BYPASS rx
    .radm_bypass_data                (radm_bypass_data               ),
    .radm_bypass_dwen                (radm_bypass_dwen               ),
    .radm_bypass_dv                  (radm_bypass_dv                 ),
    .radm_bypass_hv                  (radm_bypass_hv                 ),
    .radm_bypass_eot                 (radm_bypass_eot                ),
    .radm_bypass_dllp_abort          (radm_bypass_dllp_abort         ),
    .radm_bypass_tlp_abort           (radm_bypass_tlp_abort          ),
    .radm_bypass_ecrc_err            (radm_bypass_ecrc_err           ),
    .radm_bypass_addr                (radm_bypass_addr               ),
    .radm_bypass_fmt                 (radm_bypass_fmt                ),
    .radm_bypass_tc                  (radm_bypass_tc                 ),
    .radm_bypass_attr                (radm_bypass_attr               ),
    .radm_bypass_reqid               (radm_bypass_reqid              ),
    .radm_bypass_type                (radm_bypass_type               ),
    .radm_bypass_tag                 (radm_bypass_tag                ),
    .radm_bypass_func_num            (radm_bypass_func_num           ),
    .radm_bypass_td                  (radm_bypass_td                 ),
    .radm_bypass_poisoned            (radm_bypass_poisoned           ),
    .radm_bypass_dw_len              (radm_bypass_dw_len             ),
    .radm_bypass_rom_in_range        (radm_bypass_rom_in_range       ),
    .radm_bypass_first_be            (radm_bypass_first_be           ),
    .radm_bypass_last_be             (radm_bypass_last_be            ),
    .radm_bypass_io_req_in_range     (radm_bypass_io_req_in_range    ),
    .radm_bypass_in_membar_range     (radm_bypass_in_membar_range    ),
    .radm_bypass_cpl_last            (radm_bypass_cpl_last           ),
    .radm_bypass_cpl_status          (radm_bypass_cpl_status         ),
    .radm_bypass_st                  (radm_bypass_st                 ),
    .radm_bypass_cmpltr_id           (radm_bypass_cmpltr_id          ),
    .radm_bypass_byte_cnt            (radm_bypass_byte_cnt           ),
    .radm_bypass_ats                 (radm_bypass_ats                ),
    .radm_bypass_th                  (radm_bypass_th                 ),
    .radm_bypass_ph                  (radm_bypass_ph                 ),
    .radm_bypass_bcm                 (radm_bypass_bcm                ),
        .mw_en                           (mw_en                          ),
        .mr_en                           (mr_en                          ),
        .iow_en                          (iow_en                         ),
        .ior_en                          (ior_en                         ),
        .cfg0w_en                        (cfg0w_en                       ),
        .cfg0r_en                        (cfg0r_en                       ),
        .op_start                        (op_start                       ),
        .mw_addr                         (mw_addr                        ),
        .mw_len                          (mw_len                         ),
        .mw_data                         (mw_data                        ),
        .mw_data_be                      (mw_data_be                     ),
        .mw_data_en                      (mw_data_en                     ),
        .mr_addr                         (mr_addr                        ),
        .mr_len                          (mr_len                         ),
        .mr_data_be                      (mr_data_be                     ),
        .mr_data                         (mr_data                        ),
        .mr_data_vld                     (mr_data_vld                    ),
        .iow_addr                        (iow_addr                       ),
        .iow_data                        (iow_data                       ),
        .ior_addr                        (ior_addr                       ),
        .ior_data                        (ior_data                       ),
        .ior_data_vld                    (ior_data_vld                   ),
        .cfg0w_addr                      (cfg0w_addr                     ),
        .cfg0w_data                      (cfg0w_data                     ),
        .cfg0r_addr                      (cfg0r_addr                     ),
        .cfg0r_data                      (cfg0r_data                     ),
        .cfg0r_data_vld                  (cfg0r_data_vld                 ),
        .mw_op_over                      (mw_op_over                     ),
        .mr_op_over                      (mr_op_over                     ),
        .iow_op_over                     (iow_op_over                    ),
        .ior_op_over                     (ior_op_over                    ),
        .cfg0w_op_over                   (cfg0w_op_over                  ),
        .cfg0r_op_over                   (cfg0r_op_over                  )
);


msi_int_bfm u_int_bfm(
    .core_clk                        (core_clk_c            ), 
    .core_rst_n                      (core_rst_n_c&h2c_rstn          ),
    .trgt1_radm_halt                 (                               ),
    .trgt1_radm_pkt_halt             (                               ),
    .radm_trgt1_dv                   (radm_trgt1_dv                  ),
    .radm_trgt1_hv                   (radm_trgt1_hv                  ),
    .radm_trgt1_eot                  (radm_trgt1_eot                 ),
    .radm_trgt1_tlp_abort            (radm_trgt1_tlp_abort           ),
    .radm_trgt1_dllp_abort           (radm_trgt1_dllp_abort          ),
    .radm_trgt1_ecrc_err             (radm_trgt1_ecrc_err            ),
    .radm_trgt1_dwen                 (radm_trgt1_dwen                ),
    .radm_trgt1_fmt                  (radm_trgt1_fmt                 ),
    .radm_trgt1_attr                 (radm_trgt1_attr                ),
    .radm_trgt1_func_num             (radm_trgt1_func_num            ),
    .radm_trgt1_type                 (radm_trgt1_type                ),
    .radm_trgt1_tc                   (radm_trgt1_tc                  ),
    .radm_trgt1_reqid                (radm_trgt1_reqid               ),
    .radm_trgt1_data                 (radm_trgt1_data                ),
    .radm_trgt1_first_be             (radm_trgt1_first_be            ),
    .radm_trgt1_last_be              (radm_trgt1_last_be             ),
    .radm_trgt1_addr                 (radm_trgt1_addr                ),
    .radm_trgt1_td                   (radm_trgt1_td                  ),
    .radm_trgt1_poisoned             (radm_trgt1_poisoned            ),
    .radm_trgt1_hdr_uppr_bytes_valid (radm_trgt1_hdr_uppr_bytes_valid),
    .radm_trgt1_rom_in_range         (radm_trgt1_rom_in_range        ),
    .radm_trgt1_io_req_in_range      (radm_trgt1_io_req_in_range     ),
    .radm_trgt1_hdr_uppr_bytes       (radm_trgt1_hdr_uppr_bytes      ),
    .radm_trgt1_in_membar_range      (radm_trgt1_in_membar_range     ),
    .radm_trgt1_cpl_status           (radm_trgt1_cpl_status          ),
    .radm_trgt1_ats                  (radm_trgt1_ats                 ),
    .radm_trgt1_tag                  (radm_trgt1_tag                 ),
    .radm_trgt1_dw_len               (radm_trgt1_dw_len              ),
    .radm_trgt1_nw                   (radm_trgt1_nw                  ),
    .radm_trgt1_th                   (radm_trgt1_th                  ),
    .radm_trgt1_ph                   (radm_trgt1_ph                  ),
    .radm_trgt1_st                   (radm_trgt1_st                  ),
    .radm_trgt1_byte_cnt             (radm_trgt1_byte_cnt            ),
    .radm_trgt1_bcm                  (radm_trgt1_bcm                 ),
    .radm_trgt1_vc                   (radm_trgt1_vc                  ),
    .radm_trgt1_cmpltr_id            (radm_trgt1_cmpltr_id           ),
    .radm_trgt1_cpl_last             (radm_trgt1_cpl_last            ),
    .radm_grant_tlp_type             (radm_grant_tlp_type            ),
    .radm_trgt1_atu_sloc_match       (radm_trgt1_atu_sloc_match      ),
    .radm_trgt1_atu_cbuf_err         (radm_trgt1_atu_cbuf_err        ),
        

        .int_odt                         (int_odt),
    .msi_detected                    (msi_detected                   )

   );

//assign comb_rst_n = app_button_rst_n;


endmodule
