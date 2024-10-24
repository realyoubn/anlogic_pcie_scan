
`include "../../src/sgdma_ip/def/para_def.vh"
module sgdma_subsys(
	input                         app_auxclk,
	input                         app_power_up_rst_n, //not use
	input    [`REFCLK_WIDTH-1:0]  refclk_p ,
	input    [`REFCLK_WIDTH-1:0]  refclk_n ,
	output   [`LINK_WIDTH-1:0]    txp ,
	output   [`LINK_WIDTH-1:0]    txn ,  
	input    [`LINK_WIDTH-1:0]    rxp ,
	input    [`LINK_WIDTH-1:0]    rxn ,
	output                        user_lnk_up,
	output                        user_clk,
	output                        user_rstn,
	input                         local_int,				  
	output   [5:0]                ltssm_state,
`ifdef AXIS_BUS0_EN	              
	output   s0_axis_c2h_rst,
    output   m0_axis_h2c_rst,
    output   s0_axis_c2h_run,
    output   m0_axis_h2c_run,
    
	output   s0_axis_c2h_tready,
    input    [`DATA_WIDTH-1:0]    s0_axis_c2h_tdata,
    input    [`KEEP_WIDTH-1:0]    s0_axis_c2h_tkeep,
    input    [`KEEP_WIDTH-1:0]    s0_axis_c2h_tuser,
    input    s0_axis_c2h_tlast,
    input    s0_axis_c2h_tvalid,	
	
	input    m0_axis_h2c_tready,
    output   [`DATA_WIDTH-1:0]    m0_axis_h2c_tdata,
    output   [`KEEP_WIDTH-1:0]    m0_axis_h2c_tkeep,
    output   [`KEEP_WIDTH-1:0]    m0_axis_h2c_tuser,
    output   m0_axis_h2c_tlast,
    output   m0_axis_h2c_tvalid,
`endif
`ifdef AXIS_BUS1_EN
	output   s1_axis_c2h_tready,
    input    [`DATA_WIDTH-1:0]    s1_axis_c2h_tdata,
    input    [`KEEP_WIDTH-1:0]    s1_axis_c2h_tkeep,
    input    [`KEEP_WIDTH-1:0]    s1_axis_c2h_tuser,
    input    s1_axis_c2h_tlast,
    input    s1_axis_c2h_tvalid,
	input    m1_axis_h2c_tready,
    output   [`DATA_WIDTH-1:0]    m1_axis_h2c_tdata,
    output   [`KEEP_WIDTH-1:0]    m1_axis_h2c_tkeep,
    output   [`KEEP_WIDTH-1:0]    m1_axis_h2c_tuser,
    output   m1_axis_h2c_tlast,
    output   m1_axis_h2c_tvalid,
`endif
`ifdef AXI4_BUS0_EN
	//---Write Address Interface---
	input   m_axi_awready,
	output  [3:0] m_axi_awid,
	output  [63:0] m_axi_awaddr,
	output  [7:0] m_axi_awlen,
	output  [2:0] m_axi_awsize,
	output  [1:0] m_axi_awburst,
	output  [2:0] m_axi_awprot,
	output  m_axi_awvalid,
	output  m_axi_awlock,
	output  [3:0] m_axi_awcache,
	//---Write Interface---
	output  [63:0] m_axi_wdata,
	output  [7:0] m_axi_wstrb,
	input   m_axi_wready,
	output  m_axi_wlast,
	output  m_axi_wvalid,
	//---Write Response Interface---
	input   [3:0] m_axi_bid,
	input   [1:0] m_axi_bresp,
	input   m_axi_bvalid,
	output  m_axi_bready,
	//---Read Address Interface---
	input   m_axi_arready,
	output  [3:0] m_axi_arid,
	output  [63:0] m_axi_araddr,
	output  [7:0] m_axi_arlen,
	output  [2:0] m_axi_arsize,
	output  [1:0] m_axi_arburst,
	output  [2:0] m_axi_arprot,
	output  m_axi_arvalid,
	output  m_axi_arlock,
	output  [3:0] m_axi_arcache,
	//---Read Interface---ccf
	input   [3:0] m_axi_rid,
	input   [63:0] m_axi_rdata,
	input   [1:0] m_axi_rresp,
	input   m_axi_rlast,
	input   m_axi_rvalid,
	output  m_axi_rready,
	
`endif
`ifdef USR_IRQ_EN
	input   [1:0] usr_irq_req,
	output  [1:0] usr_irq_ack,
	output  msi_enable,
	output  [2:0] msi_vector_width,
`endif
`ifdef AXIL_MBUS0_EN
	output 	[31:0] m_axil_awaddr,
	output 	[2:0] m_axil_awprot,	
	output 	m_axil_awvalid,	
	input  	m_axil_awready,	
	output 	[31:0] m_axil_wdata,	
	output 	[3:0] m_axil_wstrb,	
	output 	m_axil_wvalid,	
	input  	m_axil_wready,	
	input  	m_axil_bvalid,	
	input  	[1:0] m_axil_bresp,	
	output 	m_axil_bready,	
	output 	[31:0] m_axil_araddr,	
	output 	[2:0] m_axil_arprot,	
	output 	m_axil_arvalid,	
	input  	m_axil_arready,	
	input  	[31:0] m_axil_rdata,	
	input  	[1:0] m_axil_rresp,	
	input  	m_axil_rvalid,		
	output 	m_axil_rready,
`endif	
`ifdef AXIL_SBUS0_EN
	input   [31:0] s_axil_awaddr,
	input   [2:0] s_axil_awprot,
	input   s_axil_awvalid,	
	output  s_axil_awready,	
	input   [31:0] s_axil_wdata,	
	input   [3:0] s_axil_wstrb,	
	input   s_axil_wvalid,	
	output  s_axil_wready,	
	output  s_axil_bvalid,	
	output  [1:0] s_axil_bresp,	
	input   s_axil_bready,	
	input   [31:0] s_axil_araddr,	
	input   [2:0] s_axil_arprot,	
	input   s_axil_arvalid,	
	output  s_axil_arready,	
	output  [31:0] s_axil_rdata,	
	output  [1:0] s_axil_rresp,	
	output  s_axil_rvalid,	
	input   s_axil_rready,
`endif	
`ifdef CFG_MGMT_EN
	input    [18:0] cfg_mgmt_addr,
	input    cfg_mgmt_write,
	input    [31:0] cfg_mgmt_write_data,
	input    [3:0] cfg_mgmt_byte_enable,	
	input    cfg_mgmt_read,	
	output   [31:0] cfg_mgmt_read_data,	
	output   cfg_mgmt_read_write_done,
	input    cfg_mgmt_type1_cfg_reg_access,	
`endif

	output   core_clk_led


);
wire [1:0]		cfg_msi_en;		
wire [63:0]		cfg_msi_mask;		
wire [63:0]		cfg_msi_pending;	
wire ven_msi_req ;
wire ven_msi_func_num ;

wire [1:0] ven_msi_vfunc_num ;
wire ven_msi_vfunc_active ;
wire [2:0] ven_msi_tc ;
wire [4:0] ven_msi_vector ;

wire			client0_addr_align_en;	
wire			client0_cpl_bcm;	
wire [11:0]		client0_cpl_byte_cnt;	
wire [9:0]		client0_cpl_lookup_id;	
wire [2:0]		client0_cpl_status;	
wire [15:0]		client0_remote_req_id;	
wire [63:0]		client0_tlp_addr;	
wire [1:0]		client0_tlp_ats;	
wire [2:0]		client0_tlp_attr;	
wire			client0_tlp_atu_bypass;	
wire			client0_tlp_bad_eot;	
wire [7:0]		client0_tlp_byte_en;	
wire [12:0]		client0_tlp_byte_len;	
wire [`DATA_WIDTH-1:0]		client0_tlp_data;	
wire			client0_tlp_dv;		
wire			client0_tlp_eot;	
wire			client0_tlp_ep;		
wire [1:0]		client0_tlp_fmt;	
wire			client0_tlp_func_num;	
wire			client0_tlp_hv;		
wire			client0_tlp_nw;		
wire [1:0]		client0_tlp_ph;		
wire [7:0]		client0_tlp_st;		
wire [2:0]		client0_tlp_tc;		
wire			client0_tlp_td;		
wire			client0_tlp_th;		
wire [9:0]		client0_tlp_tid;	
wire [4:0]		client0_tlp_type;	
wire			client0_tlp_vfunc_active;
wire [1:0]		client0_tlp_vfunc_num;	
wire			client1_addr_align_en;	
wire			client1_cpl_bcm;	
wire [11:0]		client1_cpl_byte_cnt;	
wire [9:0]		client1_cpl_lookup_id;	
wire [2:0]		client1_cpl_status;	
wire [15:0]		client1_remote_req_id;	
wire [63:0]		client1_tlp_addr;	
wire [1:0]		client1_tlp_ats;	
wire [2:0]		client1_tlp_attr;	
wire			client1_tlp_atu_bypass;	
wire			client1_tlp_bad_eot;	
wire [7:0]		client1_tlp_byte_en;	
wire [12:0]		client1_tlp_byte_len;	
wire [`DATA_WIDTH-1:0]		client1_tlp_data;	
wire			client1_tlp_dv;		
wire			client1_tlp_eot;	
wire			client1_tlp_ep;		
wire [1:0]		client1_tlp_fmt;	
wire			client1_tlp_func_num;	
wire			client1_tlp_hv;		
wire			client1_tlp_nw;		
wire [1:0]		client1_tlp_ph;		
wire [7:0]		client1_tlp_st;		
wire [2:0]		client1_tlp_tc;		
wire			client1_tlp_td;		
wire			client1_tlp_th;		
wire [9:0]		client1_tlp_tid;	
wire [4:0]		client1_tlp_type;	
wire			client1_tlp_vfunc_active;
wire [1:0]		client1_tlp_vfunc_num;	

wire [31:0]		drp_dbi_addr;//synthesis keep		
wire [2:0]		drp_dbi_bar_num;	
wire			drp_dbi_cs;	//synthesis keep		
wire			drp_dbi_cs2_exp;	
wire [31:0]		drp_dbi_din;		
wire			drp_dbi_func_num;	
wire			drp_dbi_io_access;	
wire			drp_dbi_rom_access;	
wire			drp_dbi_vfunc_active;	
wire [1:0]		drp_dbi_vfunc_num;	
wire [3:0]		drp_dbi_wr;	//synthesis keep		
wire			drp_lbc_dbi_ack;//synthesis keep		
wire [31:0]		drp_lbc_dbi_dout;	//synthesis keep	

wire [31:0]		lbc_ext_addr;	
wire            lbc_ext_addr2_buf;
wire            lbc_ext_addr2_buf2;
wire            lbc_ext_addr2_buf3;
PH1_LOGIC_BUF u_lbc_ext_addr20(
    .i(lbc_ext_addr[2]),
    .o(lbc_ext_addr2_buf)
);	
PH1_LOGIC_BUF u_lbc_ext_addr21(
    .i(lbc_ext_addr2_buf),
    .o(lbc_ext_addr2_buf2)
);	
PH1_LOGIC_BUF u_lbc_ext_addr22(
    .i(lbc_ext_addr2_buf2),
    .o(lbc_ext_addr2_buf3)
);	
wire [2:0]		lbc_ext_bar_num;	
wire [1:0]		lbc_ext_cs;		
wire [31:0]		lbc_ext_dout;		
wire			lbc_ext_io_access;	
wire			lbc_ext_rom_access;	
wire			lbc_ext_vfunc_active;	
wire [1:0]		lbc_ext_vfunc_num;	
wire [3:0]		lbc_ext_wr;		


wire [63:0]		radm_bypass_addr;//synthesis keep	
wire [1:0]		radm_bypass_ats;	
wire [2:0]		radm_bypass_attr;	
wire			radm_bypass_bcm;	
wire [11:0]		radm_bypass_byte_cnt;//synthesis keep	
wire [15:0]		radm_bypass_cmpltr_id;	
wire			radm_bypass_cpl_last;	
wire [2:0]		radm_bypass_cpl_status;//synthesis keep
wire [`DATA_WIDTH-1:0]		radm_bypass_data;	
wire			radm_bypass_dllp_abort;	
wire			radm_bypass_dv;		
wire [9:0]		radm_bypass_dw_len;	
wire [1:0]		radm_bypass_dwen;	
wire			radm_bypass_ecrc_err;	
wire			radm_bypass_eot;	
wire [3:0]		radm_bypass_first_be;	
wire [1:0]		radm_bypass_fmt;	
wire			radm_bypass_func_num;	
wire			radm_bypass_hv;		
wire [2:0]		radm_bypass_in_membar_range;
wire			radm_bypass_io_req_in_range;
wire [3:0]		radm_bypass_last_be;	
wire [1:0]		radm_bypass_ph;		
wire			radm_bypass_poisoned;	
wire [15:0]		radm_bypass_reqid;	
wire			radm_bypass_rom_in_range;
wire [7:0]		radm_bypass_st;		
wire [9:0]		radm_bypass_tag;
wire [2:0]		radm_bypass_tc;		
wire			radm_bypass_td;		
wire			radm_bypass_th;		
wire			radm_bypass_tlp_abort;	
wire [4:0]		radm_bypass_type;	
wire			radm_bypass_vfunc_active;
wire [1:0]		radm_bypass_vfunc_num;	


wire [63:0]		radm_trgt1_addr;	
wire [1:0]		radm_trgt1_ats;		
wire [2:0]		radm_trgt1_attr;	
wire [1:0]		radm_trgt1_atu_cbuf_err;
wire [1:0]		radm_trgt1_atu_sloc_match;
wire			radm_trgt1_bcm;		
wire [11:0]		radm_trgt1_byte_cnt;	
wire [15:0]		radm_trgt1_cmpltr_id;	
wire			radm_trgt1_cpl_last;	
wire [2:0]		radm_trgt1_cpl_status;	
wire [`DATA_WIDTH-1:0]		radm_trgt1_data;	
wire			radm_trgt1_dllp_abort;	
wire			radm_trgt1_dv;		
wire [9:0]		radm_trgt1_dw_len;	
wire [1:0]		radm_trgt1_dwen;	
wire			radm_trgt1_ecrc_err;	
wire			radm_trgt1_eot;		
wire [3:0]		radm_trgt1_first_be;	
wire [1:0]		radm_trgt1_fmt;		
wire			radm_trgt1_func_num;	
wire [63:0]		radm_trgt1_hdr_uppr_bytes;
wire			radm_trgt1_hdr_uppr_bytes_valid;
wire			radm_trgt1_hv;		
wire [2:0]		radm_trgt1_in_membar_range;
wire			radm_trgt1_io_req_in_range;
wire [3:0]		radm_trgt1_last_be;	
wire			radm_trgt1_nw;		
wire [1:0]		radm_trgt1_ph;		
wire			radm_trgt1_poisoned;	
wire [15:0]		radm_trgt1_reqid;	
wire			radm_trgt1_rom_in_range;
wire [7:0]		radm_trgt1_st;		
wire [9:0]		radm_trgt1_tag;		
wire [2:0]		radm_trgt1_tc;		
wire			radm_trgt1_td;		
wire			radm_trgt1_th;		
wire			radm_trgt1_tlp_abort;	
wire [4:0]		radm_trgt1_type;	
wire [2:0]		radm_trgt1_vc;		
wire			radm_trgt1_vfunc_active;
wire [1:0]		radm_trgt1_vfunc_num;	
//wire			smlh_link_up;		
wire            rdlh_link_up;
		
wire			xadm_client0_halt;	
wire            xadm_client0_halt_buf;
PH1_LOGIC_BUF u_xadm_client0_halt (
	.i(xadm_client0_halt),
    .o(xadm_client0_halt_buf)
);
wire            lbc_ext_dout10_buf; 
PH1_LOGIC_BUF u_lbc_ext_dout10 (
	.i(lbc_ext_dout[10]),
    .o(lbc_ext_dout10_buf)
);
wire			xadm_client1_halt;	
wire            core_clk;
wire   [2:0]    radm_grant_tlp_type;
wire   [2:0]    trgt1_radm_pkt_halt;
wire   [63:0]   ext_lbc_din;
wire   [1:0]    ext_lbc_ack;
wire   [9:0]    trgt_lookup_id;
wire   [5:0]    smlh_ltssm_state;//synthesis keep
wire            app_app_ltssm_enable;
wire            app_auxclk_g;
wire            aux_clk;
//---test signal
wire   cfg_uncor_internal_err_sts        ;//synthesis keep
wire   cfg_rcvr_overflow_err_sts         ;//synthesis keep
wire   cfg_fc_protocol_err_sts           ;//synthesis keep
wire   cfg_mlf_tlp_err_sts               ;//synthesis keep
                                        
wire   cfg_surprise_down_er_sts          ;//synthesis keep
wire   cfg_dl_protocol_err_sts           ;//synthesis keep
wire   cfg_ecrc_err_sts                  ;//synthesis keep
wire   cfg_corrected_internal_err_sts    ;//synthesis keep
wire   cfg_replay_number_rollover_err_sts;//synthesis keep
wire   cfg_replay_timer_timeout_err_sts  ;//synthesis keep
wire   cfg_bad_dllp_err_sts              ;//synthesis keep
wire   cfg_bad_tlp_err_sts               ;//synthesis keep
wire   cfg_rcvr_err_sts                  ;//synthesis keep
//wire   [15:0]    diag_status_bus;//synthesis keep

wire [31:0]		ext_drp_dbi_addr;		
wire [2:0]		ext_drp_dbi_bar_num;	
wire			ext_drp_dbi_cs;		
wire			ext_drp_dbi_cs2_exp;	
wire [31:0]		ext_drp_dbi_din;		
wire			ext_drp_dbi_func_num;	
wire			ext_drp_dbi_io_access;	
wire			ext_drp_dbi_rom_access;	
wire			ext_drp_dbi_vfunc_active;	
wire [1:0]		ext_drp_dbi_vfunc_num;	
wire [3:0]		ext_drp_dbi_wr;	
wire			ext_drp_lbc_dbi_ack;		
wire [31:0]		ext_drp_lbc_dbi_dout;	
wire            ext_app_app_ltssm_enable;

`ifdef DEBUG_MODE
    PH1_LOGIC_BUFG app_auxclk_bufg(
	    .i(app_auxclk),
	    .o(app_auxclk_g)
	    );
    PH1_LOGIC_BUFG core_clk_bufg(
	    .i(core_clk),
	    .o(user_clk)
	    );

    PH1_LOGIC_BUFG core_rst_bufg(
	    .i(core_rst_n),
	    .o(user_rstn)
	    ); 	
`else     
    PH1_PHY_GCLK_V2 app_auxclk_bufg(.clkin({app_auxclk,1'b1}),.clkout(app_auxclk_g),
                    .cen({1'b0,1'b1}),.seln({1'b0,1'b1}),.drct({1'b0,1'b1}));
    sys_ctrl u_sys_ctrl(
	    .core_rst_n(core_rst_n),//rdlh_link_up
	    .core_clk(core_clk),	
	    .aux_clk(aux_clk),

	    .core_clk_pll(user_clk),
	    .core_rst_n_pll(user_rstn)
     );  	 
`endif




wire             r00;
wire             t09,t08;
wire             ln0;
wire             r10;
wire             t19,t18;
wire             ln1;

wire   [9:0]     length1;
wire   [9:0]     length0;

assign client0_tlp_addr[1:0] = 2'b00;
assign client0_cpl_status = 3'b000;
assign client0_cpl_bcm = 1'b0;
assign client0_cpl_byte_cnt = 12'd0;
assign client0_cpl_lookup_id = 10'd0;
assign client0_tlp_tid[9:8] = 2'b00;
assign client0_tlp_st = 8'd0;
assign client0_tlp_nw = 1'b0;
assign client1_tlp_addr[1:0] = 2'b00;
assign client1_cpl_status = 3'b000;
assign client1_cpl_bcm = 1'b0;
assign client1_cpl_byte_cnt = 12'd0;
assign client1_cpl_lookup_id = 10'd0;
assign client1_tlp_tid[9:8] = 2'b00;
assign client1_tlp_st = 8'd0;
assign client1_tlp_nw = 1'b0;

//---pcie_ep_core---
pcie_ep_core u_ep_core
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
    .client0_tlp_vfunc_num             (client0_tlp_vfunc_num             ),
    .client0_tlp_ats                   (client0_tlp_ats                   ),
    .client0_tlp_st                    (client0_tlp_st                    ),
    .client0_tlp_vfunc_active          (client0_tlp_vfunc_active          ),
    .client0_tlp_nw                    (client0_tlp_nw                    ),
    .client0_tlp_th                    (client0_tlp_th                    ),
    .client0_tlp_ph                    (client0_tlp_ph                    ),
    .client0_tlp_atu_bypass            (client0_tlp_atu_bypass            ),
    .client0_cpl_lookup_id             (client0_cpl_lookup_id             ),
    .xadm_client0_halt                 (xadm_client0_halt                 ), 

	.client1_tlp_data                  (client1_tlp_data                  ),
    .client1_tlp_addr                  (client1_tlp_addr                  ),
    .client1_remote_req_id             (client1_remote_req_id             ),
    .client1_tlp_byte_en               (client1_tlp_byte_en               ),
    .client1_cpl_byte_cnt              (client1_cpl_byte_cnt              ),
    .client1_addr_align_en             (client1_addr_align_en             ),
    .client1_tlp_tc                    (client1_tlp_tc                    ),
    .client1_tlp_attr                  (client1_tlp_attr                  ),
    .client1_cpl_status                (client1_cpl_status                ),
    .client1_cpl_bcm                   (client1_cpl_bcm                   ),
    .client1_tlp_dv                    (client1_tlp_dv                    ),
    .client1_tlp_eot                   (client1_tlp_eot                   ),
    .client1_tlp_bad_eot               (client1_tlp_bad_eot               ),
    .client1_tlp_hv                    (client1_tlp_hv                    ),
    .client1_tlp_type                  (client1_tlp_type                  ),
    .client1_tlp_fmt                   (client1_tlp_fmt                   ),
    .client1_tlp_td                    (client1_tlp_td                    ),
    .client1_tlp_byte_len              (client1_tlp_byte_len              ),
    .client1_tlp_tid                   (client1_tlp_tid                   ),
    .client1_tlp_ep                    (client1_tlp_ep                    ),
    .client1_tlp_func_num              (client1_tlp_func_num              ),
    .client1_tlp_vfunc_num             (client1_tlp_vfunc_num             ),
    .client1_tlp_ats                   (client1_tlp_ats                   ),
    .client1_tlp_st                    (client1_tlp_st                    ),
    .client1_tlp_vfunc_active          (client1_tlp_vfunc_active          ),
    .client1_tlp_nw                    (client1_tlp_nw                    ),
    .client1_tlp_th                    (client1_tlp_th                    ),
    .client1_tlp_ph                    (client1_tlp_ph                    ),
    .client1_tlp_atu_bypass            (client1_tlp_atu_bypass            ),



    .cfg_msi_en                        (cfg_msi_en                        ),
    .cfg_msi_mask                      (cfg_msi_mask                      ),
	
    .ven_msi_grant                     (ven_msi_grant                     ),	
    .ven_msi_req                       (ven_msi_req                       ),
    .ven_msi_func_num                  (ven_msi_func_num                  ),
    .cfg_msi_pending                   (cfg_msi_pending                   ),
    .ven_msi_vfunc_num                 (ven_msi_vfunc_num                 ),
    .ven_msi_vfunc_active              (ven_msi_vfunc_active              ),
    .ven_msi_tc                        (ven_msi_tc                        ),
    .ven_msi_vector                    (ven_msi_vector                    ),
 /* 
    .msix_addr                         (msix_addr                         ),
    .msix_data                         (msix_data                         ),
    
    .ven_msg_data                      (ven_msg_data                      ),
    .ven_msg_code                      (ven_msg_code                      ),
    .ven_msg_fmt                       (ven_msg_fmt                       ),
    .ven_msg_td                        (ven_msg_td                        ),
    .ven_msg_func_num                  (ven_msg_func_num                  ),
    .ven_msg_vfunc_num                 (ven_msg_vfunc_num                 ),
    .ven_msg_vfunc_active              (ven_msg_vfunc_active              ),
    .ven_msg_req                       (ven_msg_req                       ),
    .ven_msg_type                      (ven_msg_type                      ),
    .ven_msg_tc                        (ven_msg_tc                        ),
    .ven_msg_tag                       (ven_msg_tag                       ),
    .ven_msg_len                       (ven_msg_len                       ),
    .ven_msg_attr                      (ven_msg_attr                      ),
    .ven_msg_ep                        (ven_msg_ep                        ),
  
    .prs_res_failure                   (prs_res_failure                   ),
    .prs_uprgi                         (prs_uprgi                         ),
    .prs_stopped                       (prs_stopped                       ),

    .diag_ctrl_bus                     (diag_ctrl_bus                     ),
    .diag_status_bus_sel               (diag_status_bus_sel               ),
*/	
    .sys_atten_button_pressed          (2'b00                             ),
    .sys_pre_det_state                 (2'b00                             ),
    .sys_mrl_sensor_state              (2'b00                             ),
    .sys_pwr_fault_det                 (2'b00                             ),
    .sys_mrl_sensor_chged              (2'b00                             ),
    .sys_pre_det_chged                 (2'b00                             ),
    .sys_cmd_cpled_int                 (2'b00                             ),
    .sys_eml_interlock_engaged         (2'b00                             ),
    
    .rx_lane_flip_en                   (1'b0                              ),
    .tx_lane_flip_en                   (1'b0                              ),
    
    .app_req_retry_en                  (1'b0                              ),
    .app_sris_mode                     (1'b0                              ),
    .app_vf_req_retry_en               (4'b0                              ),
    .app_pf_req_retry_en               (2'b0                              ),
	.app_unlock_msg                    (1'b0                              ),  
    .app_hdr_log                       (128'd0                            ),
    .app_err_bus                       (13'd0                             ),
    .app_err_advisory                  (1'b0                              ),
    .app_err_func_num                  (1'b0                              ),
    .app_err_vfunc_active              (1'b0                              ),
    .app_hdr_valid                     (1'b0                              ),
    .app_err_vfunc_num                 (2'b00                             ),
 /*   
    .sys_int                           (sys_int                           ),
  
    .app_ltr_msg_latency               (app_ltr_msg_latency               ),
    .app_ltr_msg_req                   (app_ltr_msg_req                   ),
    .app_ltr_msg_func_num              (app_ltr_msg_func_num              ),
      
    .apps_pm_xmt_turnoff               (apps_pm_xmt_turnoff               ),
  

   
    .outband_pwrup_cmd                 (outband_pwrup_cmd                 ),
    .apps_pm_xmt_pme                   (apps_pm_xmt_pme                   ),
    .sys_aux_pwr_det                   (sys_aux_pwr_det                   ),
    .app_req_entr_l1_exp               (app_req_entr_l1_exp               ),
    .app_ready_entr_l23_exp            (app_ready_entr_l23_exp            ),
    .app_req_exit_l1_exp               (app_req_exit_l1_exp               ),
    .app_xfer_pending                  (app_xfer_pending                  ),
    .clkreq_in_n                       (clkreq_in_n                       ),
    .app_clk_pm_en                     (app_clk_pm_en                     ),
    .app_l1sub_disable                 (app_l1sub_disable                 ),
  
   
   
    .exp_rom_validation_status_strobe  (exp_rom_validation_status_strobe  ),
    .exp_rom_validation_status         (exp_rom_validation_status         ),
    .exp_rom_validation_details        (exp_rom_validation_details        ),
    .exp_rom_validation_details_strobe (exp_rom_validation_details_strobe ),
   
    .app_flr_vf_done                   (app_flr_vf_done                   ),
    .app_flr_pf_done                   (app_flr_pf_done                   ),
 */ 


    .client1_cpl_lookup_id             (client1_cpl_lookup_id             ),
 /*    
    .app_ras_des_sd_hold_ltssm         (app_ras_des_sd_hold_ltssm         ),
    .app_ras_des_tba_ctrl              (app_ras_des_tba_ctrl              ),
*/   
	.app_perst_n                       (1'b1							  ),
    .app_button_rst_n                  (1'b1                              ),
    .app_power_up_rst_n				   (app_power_up_rst_n			      ),
    
    .app_app_ltssm_enable              (app_app_ltssm_enable              ),//mm
    .app_auxclk                        (app_auxclk_g                      ),
`ifdef PH1A400_DEV

`else
    .app_drs_ready                     (1'b0                              ),
    .app_vf_frs_ready                  (4'd0                              ),
    .app_pf_frs_ready                  (2'd0                              ),
`endif
    .drp_dbi_din                       (drp_dbi_din                       ),
    .drp_dbi_wr                        (drp_dbi_wr                        ),
    .drp_dbi_addr                      (drp_dbi_addr                      ),
    .drp_dbi_cs                        (drp_dbi_cs                        ),
    .drp_dbi_cs2_exp                   (drp_dbi_cs2_exp                   ),
    .drp_dbi_vfunc_num                 (drp_dbi_vfunc_num                 ),
    .drp_dbi_vfunc_active              (drp_dbi_vfunc_active              ),
    .drp_dbi_bar_num                   (drp_dbi_bar_num                   ),
    .drp_dbi_rom_access                (drp_dbi_rom_access                ),
    .drp_dbi_io_access                 (drp_dbi_io_access                 ),
    .drp_dbi_func_num                  (drp_dbi_func_num                  ),
    .drp_app_dbi_ro_wr_disable         (drp_app_dbi_ro_wr_disable         ),
`ifdef PH1A400_DEV	

`else
     .drp_cr_para_clk                   (1'b0                              ),
`endif
    .drp_lbc_dbi_dout                  (drp_lbc_dbi_dout                  ),
    .drp_lbc_dbi_ack                   (drp_lbc_dbi_ack                   ),  
//  .drp_cr_para_addr                  (drp_cr_para_addr                  ),
//  .drp_cr_para_wr_data               (drp_cr_para_wr_data               ),
//  .drp_cr_para_wr_en                 (drp_cr_para_wr_en                 ),
//  .drp_cr_para_rd_en                 (drp_cr_para_rd_en                 ),
   
 
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
    .radm_bypass_vfunc_num             (radm_bypass_vfunc_num             ),
    .radm_bypass_vfunc_active          (radm_bypass_vfunc_active          ),
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
/*   
    .radm_trgt1_dv                     (radm_trgt1_dv                     ),
    .radm_trgt1_hv                     (radm_trgt1_hv                     ),
    .radm_trgt1_eot                    (radm_trgt1_eot                    ),
    .radm_trgt1_tlp_abort              (radm_trgt1_tlp_abort              ),
    .radm_trgt1_dllp_abort             (radm_trgt1_dllp_abort             ),
    .radm_trgt1_ecrc_err               (radm_trgt1_ecrc_err               ),
    .radm_trgt1_dwen                   (radm_trgt1_dwen                   ),
    .radm_trgt1_fmt                    (radm_trgt1_fmt                    ),
    .radm_trgt1_attr                   (radm_trgt1_attr                   ),
    .radm_trgt1_func_num               (radm_trgt1_func_num               ),
    .radm_trgt1_type                   (radm_trgt1_type                   ),
    .radm_trgt1_tc                     (radm_trgt1_tc                     ),
    .radm_trgt1_reqid                  (radm_trgt1_reqid                  ),
    .radm_trgt1_data                   (radm_trgt1_data                   ),
    .radm_trgt1_first_be               (radm_trgt1_first_be               ),
    .radm_trgt1_last_be                (radm_trgt1_last_be                ),
    .radm_trgt1_addr                   (radm_trgt1_addr                   ),
    .radm_trgt1_vfunc_num              (radm_trgt1_vfunc_num              ),
    .radm_trgt1_vfunc_active           (radm_trgt1_vfunc_active           ),
    .radm_trgt1_td                     (radm_trgt1_td                     ),
    .radm_trgt1_poisoned               (radm_trgt1_poisoned               ),
    .radm_trgt1_hdr_uppr_bytes_valid   (radm_trgt1_hdr_uppr_bytes_valid   ),
    .radm_trgt1_rom_in_range           (radm_trgt1_rom_in_range           ),
    .radm_trgt1_io_req_in_range        (radm_trgt1_io_req_in_range        ),
    .radm_trgt1_hdr_uppr_bytes         (radm_trgt1_hdr_uppr_bytes         ),
    .radm_trgt1_in_membar_range        (radm_trgt1_in_membar_range        ),
    .radm_trgt1_cpl_status             (radm_trgt1_cpl_status             ),
    .radm_trgt1_ats                    (radm_trgt1_ats                    ),
    .radm_trgt1_tag                    (radm_trgt1_tag                    ),
    .radm_trgt1_dw_len                 (radm_trgt1_dw_len                 ),
    .radm_trgt1_nw                     (radm_trgt1_nw                     ),
    .radm_trgt1_th                     (radm_trgt1_th                     ),
    .radm_trgt1_ph                     (radm_trgt1_ph                     ),
    .radm_trgt1_st                     (radm_trgt1_st                     ),
    .radm_trgt1_byte_cnt               (radm_trgt1_byte_cnt               ),
    .radm_trgt1_bcm                    (radm_trgt1_bcm                    ),
    .radm_trgt1_vc                     (radm_trgt1_vc                     ),
    .radm_trgt1_cmpltr_id              (radm_trgt1_cmpltr_id              ),
    .radm_trgt1_cpl_last               (radm_trgt1_cpl_last               ),
    .radm_grant_tlp_type               (radm_grant_tlp_type               ),
    .radm_trgt1_atu_sloc_match         (radm_trgt1_atu_sloc_match         ),
    .radm_trgt1_atu_cbuf_err           (radm_trgt1_atu_cbuf_err           ),
    .trgt1_radm_halt                   (trgt1_radm_halt                   ),
    .trgt1_radm_pkt_halt               (trgt1_radm_pkt_halt               ),  
*/	
//  .radm_idle                         (radm_idle                         ),
	
    .training_rst_n                    (                                  ),
	
    .ext_lbc_din                       (ext_lbc_din                       ),
    .ext_lbc_ack                       (ext_lbc_ack                       ),	
    .lbc_ext_addr                      (lbc_ext_addr                      ),
    .lbc_ext_cs                        (lbc_ext_cs                        ),
    .lbc_ext_wr                        (lbc_ext_wr                        ),
    .lbc_ext_rom_access                (lbc_ext_rom_access                ),
    .lbc_ext_io_access                 (lbc_ext_io_access                 ),
    .lbc_ext_dout                      (lbc_ext_dout                      ),
    .lbc_ext_bar_num                   (lbc_ext_bar_num                   ),
    .lbc_ext_vfunc_active              (lbc_ext_vfunc_active              ),
    .lbc_ext_vfunc_num                 (lbc_ext_vfunc_num                 ),
	

/*   
    .cfg_vf_msix_table_offset          (cfg_vf_msix_table_offset          ),
    .cfg_vf_msix_table_bir             (cfg_vf_msix_table_bir             ),
    .cfg_vf_msix_pba_offset            (cfg_vf_msix_pba_offset            ),
    .cfg_vf_msix_pba_bir               (cfg_vf_msix_pba_bir               ),
    .cfg_msix_table_offset             (cfg_msix_table_offset             ),
    .cfg_msix_table_bir                (cfg_msix_table_bir                ),
    .cfg_msix_pba_offset               (cfg_msix_pba_offset               ),
    .cfg_msix_pba_bir                  (cfg_msix_pba_bir                  ),
    .cfg_vf_msix_table_size            (cfg_vf_msix_table_size            ),
    .cfg_msix_en                       (cfg_msix_en                       ),
    .cfg_msix_table_size               (cfg_msix_table_size               ),
    .cfg_msix_func_mask                (cfg_msix_func_mask                ),
    .cfg_vf_msix_en                    (cfg_vf_msix_en                    ),
    .cfg_vf_msix_func_mask             (cfg_vf_msix_func_mask             ),
  
    .ven_msg_grant                     (ven_msg_grant                     ),
   
    .cfg_bus_master_en                 (cfg_bus_master_en                 ),
    .cfg_mem_space_en                  (cfg_mem_space_en                  ),
    .cfg_pbus_num                      (cfg_pbus_num                      ),
    .cfg_pbus_dev_num                  (cfg_pbus_dev_num                  ),
 */  

/*  .cxpl_debug_info                   (cxpl_debug_info                   ),
    .rtlh_rfc_data                     (rtlh_rfc_data                     ),
    .cxpl_debug_info_ei                (cxpl_debug_info_ei                ),
    .rtlh_rfc_upd                      (rtlh_rfc_upd                      ),
    .radm_q_not_empty                  (radm_q_not_empty                  ),
    .radm_qoverflow                    (radm_qoverflow                    ),
    .diag_status_bus                   (diag_status_bus                   ),
*/	
    .cfg_vf_bme                        (                                  ),
    .radm_vendor_msg                   (                                  ),
    .radm_msg_payload                  (                                  ),
    .radm_msg_req_id                   (                                  ),
    .cfg_send_cor_err                  (                                  ),
    .cfg_send_nf_err                   (                                  ),
    .cfg_send_f_err                    (                                  ),
 /*   
    .assert_inta_grt                   (assert_inta_grt                   ),
    .assert_intb_grt                   (assert_intb_grt                   ),
    .assert_intc_grt                   (assert_intc_grt                   ),
    .assert_intd_grt                   (assert_intd_grt                   ),
    .deassert_inta_grt                 (deassert_inta_grt                 ),
    .deassert_intb_grt                 (deassert_intb_grt                 ),
    .deassert_intc_grt                 (deassert_intc_grt                 ),
    .deassert_intd_grt                 (deassert_intd_grt                 ),
  
    .cfg_int_disable                   (cfg_int_disable                   ),
    .cfg_int_pin                       (cfg_int_pin                       ),
*/  
    .cfg_link_eq_req_int               (                                  ),
	//`ifdef DBG_SIG_EN
 // .smlh_link_up                      (smlh_link_up                      ),
	//`endif
    .smlh_req_rst_not                  (                                  ),
    .link_req_rst_not                  (                                  ), 
 /*   
    .app_ltr_msg_grant                 (app_ltr_msg_grant                 ),
    .app_ltr_latency                   (app_ltr_latency                   ),
 */  
    .radm_msg_unlock                   (                                  ),

//  .radm_pm_turnoff                   (radm_pm_turnoff                   ),
//  .pm_curnt_state                    (pm_curnt_state                    ),
/*  .wake                              (wake                              ),
    .pm_linkst_in_l0s                  (pm_linkst_in_l0s                  ),
    .pm_linkst_in_l1_exp               (pm_linkst_in_l1_exp               ),
    .pm_linkst_in_l2_exp               (pm_linkst_in_l2_exp               ),
    .pm_linkst_l2_exit                 (pm_linkst_l2_exit                 ),*/
	
    .smlh_ltssm_state                  (smlh_ltssm_state                  ),//i6
	
/*  .pm_status                         (pm_status                         ),
    .pm_dstate                         (pm_dstate                         ),
    .pm_pme_en                         (pm_pme_en                         ),
    .local_ref_clk_req_n               (local_ref_clk_req_n               ),
    .pm_master_state                   (pm_master_state                   ),
    .aux_pm_en                         (aux_pm_en                         ),
    .pm_slave_state                    (pm_slave_state                    ),
    .pm_l1sub_state                    (pm_l1sub_state                    ),
    .pm_linkst_in_l1sub                (pm_linkst_in_l1sub                ),
    .cfg_l1sub_en                      (cfg_l1sub_en                      ),
    .dpa_substate_update               (dpa_substate_update               ),
    .pm_l1_entry_started               (pm_l1_entry_started               ),
*/   
    .radm_cpl_timeout                  (                                 ),
    .radm_timeout_func_num             (                                 ),
    .radm_timeout_vfunc_num            (                                 ),
    .radm_timeout_vfunc_active         (                                 ),
    .radm_timeout_cpl_tc               (                                 ),
    .radm_timeout_cpl_attr             (                                 ),
    .radm_timeout_cpl_tag              (                                 ),
    .radm_timeout_cpl_len              (                                 ),
    
    .pm_xtlh_block_tlp                 (                                 ),
    .cfg_phy_control                   (                                 ),
    .cfg_hw_auto_sp_dis                (                                 ),
    .smlh_ltssm_state_rcvry_eq         (                                 ),
   
//  .cfg_flr_pf_active                 (cfg_flr_pf_active                 ),
//  .cfg_flr_vf_active                 (cfg_flr_vf_active                 ),
   
    .trgt_cpl_timeout                  (                                  ),
    .trgt_timeout_cpl_func_num         (                                  ),
    .trgt_timeout_cpl_vfunc_num        (                                  ),
    .trgt_timeout_cpl_vfunc_active     (                                  ),
    .trgt_timeout_cpl_tc               (                                  ),
    .trgt_timeout_cpl_attr             (                                  ),
    .trgt_timeout_cpl_len              (                                  ),
    .trgt_timeout_lookup_id            (                                  ),
    .trgt_lookup_id                    (trgt_lookup_id                    ),
    .trgt_lookup_empty                 (                                  ),
    
    .cfg_reg_serren                    (                                  ),
    .cfg_cor_err_rpt_en                (                                  ),
    .cfg_nf_err_rpt_en                 (                                  ),
    .cfg_f_err_rpt_en                  (                                  ),//start
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
    .cfg_rcvr_err_sts                  (cfg_rcvr_err_sts                  ),//end
    
    .core_rst_n                        (core_rst_n                        ),
`ifdef PH1A400_DEV

`else
    .pf_frs_grant                      (                                  ),
    .vf_frs_grant                      (                                  ),
`endif
/*   
    .dtb_out_phy_o_dbg                 (dtb_out_phy_o_dbg                 ),
    .rx0_ack_phy_o_dbg                 (rx0_ack_phy_o_dbg                 ),
    .rx0_cdr_ppm_max_phy_i_dbg         (rx0_cdr_ppm_max_phy_i_dbg         ),
    .rx0_cdr_ssc_en_phy_i_dbg          (rx0_cdr_ssc_en_phy_i_dbg          ),
    .rx0_cdr_vco_freqband_phy_i_dbg    (rx0_cdr_vco_freqband_phy_i_dbg    ),
    .rx0_cdr_vco_step_ctrl_phy_i_dbg   (rx0_cdr_vco_step_ctrl_phy_i_dbg   ),
    .rx0_cdr_vco_temp_comp_en_phy_i_dbg(rx0_cdr_vco_temp_comp_en_phy_i_dbg),
    .rx0_clk_phy_o_dbg                 (rx0_clk_phy_o_dbg                 ),
    .rx0_data_phy_o_dbg                (rx0_data_phy_o_dbg                ),
    .rx0_data_en_phy_i_dbg             (rx0_data_en_phy_i_dbg             ),
    .rx0_delta_iq_phy_i_dbg            (rx0_delta_iq_phy_i_dbg            ),
    .rx0_dfe_bypass_phy_i_dbg          (rx0_dfe_bypass_phy_i_dbg          ),
    .rx0_disable_phy_i_dbg             (rx0_disable_phy_i_dbg             ),
    .rx0_div16p5_clk_phy_o_dbg         (rx0_div16p5_clk_phy_o_dbg         ),
    .rx0_div16p5_clk_en_phy_i_dbg      (rx0_div16p5_clk_en_phy_i_dbg      ),
    .rx0_eq_att_lvl_phy_i_dbg          (rx0_eq_att_lvl_phy_i_dbg          ),
    .rx0_eq_ctle_boost_phy_i_dbg       (rx0_eq_ctle_boost_phy_i_dbg       ),
    .rx0_eq_ctle_pole_phy_i_dbg        (rx0_eq_ctle_pole_phy_i_dbg        ),
    .rx0_eq_dfe_tap1_phy_i_dbg         (rx0_eq_dfe_tap1_phy_i_dbg         ),
    .rx0_eq_vga1_gain_phy_i_dbg        (rx0_eq_vga1_gain_phy_i_dbg        ),
    .rx0_eq_vga2_gain_phy_i_dbg        (rx0_eq_vga2_gain_phy_i_dbg        ),
    .rx0_invert_phy_i_dbg              (rx0_invert_phy_i_dbg              ),
    .rx0_los_phy_o_dbg                 (rx0_los_phy_o_dbg                 ),
    .rx0_los_lfps_en_phy_i_dbg         (rx0_los_lfps_en_phy_i_dbg         ),
    .rx0_los_threshold_phy_i_dbg       (rx0_los_threshold_phy_i_dbg       ),
    .rx0_lpd_phy_i_dbg                 (rx0_lpd_phy_i_dbg                 ),
    .rx0_margin_iq_phy_i_dbg           (rx0_margin_iq_phy_i_dbg           ),
    .rx0_misc_phy_i_dbg                (rx0_misc_phy_i_dbg                ),
    .rx0_ppm_drift_phy_o_dbg           (rx0_ppm_drift_phy_o_dbg           ),
    .rx0_ppm_drift_vld_phy_o_dbg       (rx0_ppm_drift_vld_phy_o_dbg       ),
    .rx0_pstate_phy_i_dbg              (rx0_pstate_phy_i_dbg              ),
    .rx0_rate_phy_i_dbg                (rx0_rate_phy_i_dbg                ),
    .rx0_ref_ld_val_phy_i_dbg          (rx0_ref_ld_val_phy_i_dbg          ),
    .rx0_req_phy_i_dbg                 (rx0_req_phy_i_dbg                 ),
    .rx0_reset_phy_i_dbg               (rx0_reset_phy_i_dbg               ),
    .rx0_term_acdc_phy_i_dbg           (rx0_term_acdc_phy_i_dbg           ),
    .rx0_term_en_phy_i_dbg             (rx0_term_en_phy_i_dbg             ),
    .rx0_valid_phy_o_dbg               (rx0_valid_phy_o_dbg               ),
    .rx0_vco_ld_val_phy_i_dbg          (rx0_vco_ld_val_phy_i_dbg          ),
    .rx0_width_phy_i_dbg               (rx0_width_phy_i_dbg               ),
    .tx0_ack_phy_o_dbg                 (tx0_ack_phy_o_dbg                 ),
    .tx0_beacon_en_phy_i_dbg           (tx0_beacon_en_phy_i_dbg           ),
    .tx0_clk_phy_i_dbg                 (tx0_clk_phy_i_dbg                 ),
    .tx0_clk_rdy_phy_i_dbg             (tx0_clk_rdy_phy_i_dbg             ),
    .tx0_data_phy_i_dbg                (tx0_data_phy_i_dbg                ),
    .tx0_data_en_phy_i_dbg             (tx0_data_en_phy_i_dbg             ),
    .tx0_detrx_req_phy_i_dbg           (tx0_detrx_req_phy_i_dbg           ),
    .tx0_detrx_result_phy_o_dbg        (tx0_detrx_result_phy_o_dbg        ),
    .tx0_disable_phy_i_dbg             (tx0_disable_phy_i_dbg             ),
    .tx0_iboost_lvl_phy_i_dbg          (tx0_iboost_lvl_phy_i_dbg          ),
    .tx0_invert_phy_i_dbg              (tx0_invert_phy_i_dbg              ),
    .tx0_lpd_phy_i_dbg                 (tx0_lpd_phy_i_dbg                 ),
    .tx0_master_mplla_state_phy_i_dbg  (tx0_master_mplla_state_phy_i_dbg  ),
    .tx0_master_mpllb_state_phy_i_dbg  (tx0_master_mpllb_state_phy_i_dbg  ),
    .tx0_misc_phy_i_dbg                (tx0_misc_phy_i_dbg                ),
    .tx0_mpll_en_phy_i_dbg             (tx0_mpll_en_phy_i_dbg             ),
    .tx0_mpllb_sel_phy_i_dbg           (tx0_mpllb_sel_phy_i_dbg           ),
    .tx0_pstate_phy_i_dbg              (tx0_pstate_phy_i_dbg              ),
    .tx0_rate_phy_i_dbg                (tx0_rate_phy_i_dbg                ),
    .tx0_req_phy_i_dbg                 (tx0_req_phy_i_dbg                 ),
    .tx0_reset_phy_i_dbg               (tx0_reset_phy_i_dbg               ),
    .tx0_vboost_en_phy_i_dbg           (tx0_vboost_en_phy_i_dbg           ),
    .tx0_width_phy_i_dbg               (tx0_width_phy_i_dbg               ),
    .tx0_word_clk_phy_o_dbg            (tx0_word_clk_phy_o_dbg            ),
    .rx0_adapt_sel_phy_i_dbg           (rx0_adapt_sel_phy_i_dbg           ),
    .rx1_ack_phy_o_dbg                 (rx1_ack_phy_o_dbg                 ),
    .rx1_cdr_ppm_max_phy_i_dbg         (rx1_cdr_ppm_max_phy_i_dbg         ),
    .rx1_cdr_ssc_en_phy_i_dbg          (rx1_cdr_ssc_en_phy_i_dbg          ),
    .rx1_cdr_vco_freqband_phy_i_dbg    (rx1_cdr_vco_freqband_phy_i_dbg    ),
    .rx1_cdr_vco_step_ctrl_phy_i_dbg   (rx1_cdr_vco_step_ctrl_phy_i_dbg   ),
    .rx1_cdr_vco_temp_comp_en_phy_i_dbg(rx1_cdr_vco_temp_comp_en_phy_i_dbg),
    .rx1_clk_phy_o_dbg                 (rx1_clk_phy_o_dbg                 ),
    .rx1_data_phy_o_dbg                (rx1_data_phy_o_dbg                ),
    .rx1_data_en_phy_i_dbg             (rx1_data_en_phy_i_dbg             ),
    .rx1_delta_iq_phy_i_dbg            (rx1_delta_iq_phy_i_dbg            ),
    .rx1_dfe_bypass_phy_i_dbg          (rx1_dfe_bypass_phy_i_dbg          ),
    .rx1_disable_phy_i_dbg             (rx1_disable_phy_i_dbg             ),
    .rx1_div16p5_clk_phy_o_dbg         (rx1_div16p5_clk_phy_o_dbg         ),
    .rx1_div16p5_clk_en_phy_i_dbg      (rx1_div16p5_clk_en_phy_i_dbg      ),
    .rx1_eq_att_lvl_phy_i_dbg          (rx1_eq_att_lvl_phy_i_dbg          ),
    .rx1_eq_ctle_boost_phy_i_dbg       (rx1_eq_ctle_boost_phy_i_dbg       ),
    .rx1_eq_ctle_pole_phy_i_dbg        (rx1_eq_ctle_pole_phy_i_dbg        ),
    .rx1_eq_dfe_tap1_phy_i_dbg         (rx1_eq_dfe_tap1_phy_i_dbg         ),
    .rx1_eq_vga1_gain_phy_i_dbg        (rx1_eq_vga1_gain_phy_i_dbg        ),
    .rx1_eq_vga2_gain_phy_i_dbg        (rx1_eq_vga2_gain_phy_i_dbg        ),
    .rx1_invert_phy_i_dbg              (rx1_invert_phy_i_dbg              ),
    .rx1_los_phy_o_dbg                 (rx1_los_phy_o_dbg                 ),
    .rx1_los_lfps_en_phy_i_dbg         (rx1_los_lfps_en_phy_i_dbg         ),
    .rx1_los_threshold_phy_i_dbg       (rx1_los_threshold_phy_i_dbg       ),
    .rx1_lpd_phy_i_dbg                 (rx1_lpd_phy_i_dbg                 ),
    .rx1_margin_iq_phy_i_dbg           (rx1_margin_iq_phy_i_dbg           ),
    .rx1_misc_phy_i_dbg                (rx1_misc_phy_i_dbg                ),
    .rx1_ppm_drift_phy_o_dbg           (rx1_ppm_drift_phy_o_dbg           ),
    .rx1_ppm_drift_vld_phy_o_dbg       (rx1_ppm_drift_vld_phy_o_dbg       ),
    .rx1_pstate_phy_i_dbg              (rx1_pstate_phy_i_dbg              ),
    .rx1_rate_phy_i_dbg                (rx1_rate_phy_i_dbg                ),
    .rx1_ref_ld_val_phy_i_dbg          (rx1_ref_ld_val_phy_i_dbg          ),
    .rx1_req_phy_i_dbg                 (rx1_req_phy_i_dbg                 ),
    .rx1_reset_phy_i_dbg               (rx1_reset_phy_i_dbg               ),
    .rx1_term_acdc_phy_i_dbg           (rx1_term_acdc_phy_i_dbg           ),
    .rx1_term_en_phy_i_dbg             (rx1_term_en_phy_i_dbg             ),
    .rx1_valid_phy_o_dbg               (rx1_valid_phy_o_dbg               ),
    .rx1_vco_ld_val_phy_i_dbg          (rx1_vco_ld_val_phy_i_dbg          ),
    .rx1_width_phy_i_dbg               (rx1_width_phy_i_dbg               ),
    .tx1_ack_phy_o_dbg                 (tx1_ack_phy_o_dbg                 ),
    .tx1_beacon_en_phy_i_dbg           (tx1_beacon_en_phy_i_dbg           ),
    .tx1_clk_phy_i_dbg                 (tx1_clk_phy_i_dbg                 ),
    .tx1_clk_rdy_phy_i_dbg             (tx1_clk_rdy_phy_i_dbg             ),
    .tx1_data_phy_i_dbg                (tx1_data_phy_i_dbg                ),
    .tx1_data_en_phy_i_dbg             (tx1_data_en_phy_i_dbg             ),
    .tx1_detrx_req_phy_i_dbg           (tx1_detrx_req_phy_i_dbg           ),
    .tx1_detrx_result_phy_o_dbg        (tx1_detrx_result_phy_o_dbg        ),
    .tx1_disable_phy_i_dbg             (tx1_disable_phy_i_dbg             ),
    .tx1_iboost_lvl_phy_i_dbg          (tx1_iboost_lvl_phy_i_dbg          ),
    .tx1_invert_phy_i_dbg              (tx1_invert_phy_i_dbg              ),
    .tx1_lpd_phy_i_dbg                 (tx1_lpd_phy_i_dbg                 ),
    .tx1_master_mplla_state_phy_i_dbg  (tx1_master_mplla_state_phy_i_dbg  ),
    .tx1_master_mpllb_state_phy_i_dbg  (tx1_master_mpllb_state_phy_i_dbg  ),
    .tx1_misc_phy_i_dbg                (tx1_misc_phy_i_dbg                ),
    .tx1_mpll_en_phy_i_dbg             (tx1_mpll_en_phy_i_dbg             ),
    .tx1_mpllb_sel_phy_i_dbg           (tx1_mpllb_sel_phy_i_dbg           ),
    .tx1_pstate_phy_i_dbg              (tx1_pstate_phy_i_dbg              ),
    .tx1_rate_phy_i_dbg                (tx1_rate_phy_i_dbg                ),
    .tx1_req_phy_i_dbg                 (tx1_req_phy_i_dbg                 ),
    .tx1_reset_phy_i_dbg               (tx1_reset_phy_i_dbg               ),
    .tx1_vboost_en_phy_i_dbg           (tx1_vboost_en_phy_i_dbg           ),
    .tx1_width_phy_i_dbg               (tx1_width_phy_i_dbg               ),
    .tx1_word_clk_phy_o_dbg            (tx1_word_clk_phy_o_dbg            ),
    .rx1_adapt_sel_phy_i_dbg           (rx1_adapt_sel_phy_i_dbg           ),
 */ 


//  .drp_cr_para_ack                   (drp_cr_para_ack                   ),
//  .drp_cr_para_rd_data               (drp_cr_para_rd_data               ),
  
    .core_clk                          (core_clk                          ),
    .muxd_aux_clk                      (aux_clk                           ),
    .muxd_aux_clk_g                    (                                  ),
    .rdlh_link_up                      (rdlh_link_up                      )

//	.diag_status_bus                   (diag_status_bus        )
//	.phy0_sram_init_done               (phy0_sram_init_done               )
);
	
//---State flag---
status_sig u_status_sig(
	.core_rst_n(user_rstn),
	.core_clk(user_clk),
	
	.core_clk_led_o(core_clk_led),
	.app_app_ltssm_enable_o(ext_app_app_ltssm_enable)
 );

 
// --------------------------------------------------------------------
// reset process
// when reset, reconfigure pcie contrller by dbi bus 
// --------------------------------------------------------------------
ep_dbi_init_mux	u_ep_dbi_init_mux(
    	.core_clk						   (user_clk	  				      ),
    	.pcie_rst_n						   (app_power_up_rst_n			  	  ),
    	.core_rst_n_pll                    (user_rstn                         ),
    	.dbi_init_disable				   (1'b0							  ),
    	
    	// external dbi bus 
    	.ext_app_app_ltssm_enable		   (ext_app_app_ltssm_enable		  ),
    	.ext_drp_dbi_din                   (ext_drp_dbi_din                   ),
    	.ext_drp_dbi_wr                    (ext_drp_dbi_wr                    ),
    	.ext_drp_dbi_addr                  (ext_drp_dbi_addr                  ),
    	.ext_drp_dbi_cs                    (ext_drp_dbi_cs                    ),
    	.ext_drp_dbi_cs2_exp               (ext_drp_dbi_cs2_exp               ),
    	.ext_drp_dbi_vfunc_num             (ext_drp_dbi_vfunc_num             ),
    	.ext_drp_dbi_vfunc_active          (ext_drp_dbi_vfunc_active          ),
    	.ext_drp_dbi_bar_num               (ext_drp_dbi_bar_num               ),
    	.ext_drp_dbi_rom_access            (ext_drp_dbi_rom_access            ),
    	.ext_drp_dbi_io_access             (ext_drp_dbi_io_access             ),
    	.ext_drp_dbi_func_num              (ext_drp_dbi_func_num              ),
    	.ext_drp_app_dbi_ro_wr_disable     (ext_drp_app_dbi_ro_wr_disable     ),  
    	.ext_drp_lbc_dbi_ack			   (ext_drp_lbc_dbi_ack				  ),	   
    	.ext_drp_lbc_dbi_dout			   (ext_drp_lbc_dbi_dout			  ),  
    	     
    	// master bdi bus 
    	.app_app_ltssm_enable			   (app_app_ltssm_enable			  ),
    	.drp_dbi_din                       (drp_dbi_din                       ),
    	.drp_dbi_wr                        (drp_dbi_wr                        ),
    	.drp_dbi_addr                      (drp_dbi_addr                      ),
    	.drp_dbi_cs                        (drp_dbi_cs                        ),
    	.drp_dbi_cs2_exp                   (drp_dbi_cs2_exp                   ),
    	.drp_dbi_vfunc_num                 (drp_dbi_vfunc_num                 ),
    	.drp_dbi_vfunc_active              (drp_dbi_vfunc_active              ),
    	.drp_dbi_bar_num                   (drp_dbi_bar_num                   ),
    	.drp_dbi_rom_access                (drp_dbi_rom_access                ),
    	.drp_dbi_io_access                 (drp_dbi_io_access                 ),
    	.drp_dbi_func_num                  (drp_dbi_func_num                  ),
    	.drp_app_dbi_ro_wr_disable         (drp_app_dbi_ro_wr_disable         ),
    	.drp_lbc_dbi_ack			       (drp_lbc_dbi_ack				  	  ),	   
    	.drp_lbc_dbi_dout			       (drp_lbc_dbi_dout			  	  )       
	);


//---SGDMA-IP软核---
sgdma_ip u_sgdma_ip(
	.core_rst_n(user_rstn),
	.core_clk (user_clk),
	.rdlh_link_up_i(rdlh_link_up),
	//---一路axi4 bus---	

`ifdef AXI4_BUS0_EN
	.m_axi_awready_i(m_axi_awready),
    .m_axi_wready_i(m_axi_wready),
    .m_axi_bid_i(m_axi_bid),
    .m_axi_bresp_i(m_axi_bresp),
    .m_axi_bvalid_i(m_axi_bvalid),
    .m_axi_arready_i(m_axi_arready),
    .m_axi_rid_i(m_axi_rid),
    .m_axi_rdata_i(m_axi_rdata),
//  .m_axi_ruser(),
    .m_axi_rresp_i(m_axi_rresp),
    .m_axi_rlast_i(m_axi_rlast),
    .m_axi_rvalid_i(m_axi_rvalid),
    .m_axi_awid_o(m_axi_awid),
    .m_axi_awaddr_o(m_axi_awaddr),
    .m_axi_awlen_o(m_axi_awlen),
    .m_axi_awsize_o(m_axi_awsize),
    .m_axi_awburst_o(m_axi_awburst),
    .m_axi_awprot_o(m_axi_awprot),
    .m_axi_awvalid_o(m_axi_awvalid),
    .m_axi_awlock_o(m_axi_awlock),
    .m_axi_awcache_o(m_axi_awcache),
    .m_axi_wdata_o(m_axi_wdata),
//  .m_axi_wuser(),
    .m_axi_wstrb_o(m_axi_wstrb),
    .m_axi_wlast_o(m_axi_wlast),
    .m_axi_wvalid_o(m_axi_wvalid),
    .m_axi_bready_o(m_axi_bready),
    .m_axi_arid_o(m_axi_arid),
    .m_axi_araddr_o(m_axi_araddr),
    .m_axi_arlen_o(m_axi_arlen),
    .m_axi_arsize_o(m_axi_arsize),
    .m_axi_arburst_o(m_axi_arburst),
    .m_axi_arprot_o(m_axi_arprot),
    .m_axi_arvalid_o(m_axi_arvalid),
    .m_axi_arlock_o(m_axi_arlock),
    .m_axi_arcache_o(m_axi_arcache),
    .m_axi_rready_o(m_axi_rready),
`endif
`ifdef AXIL_MBUS0_EN	
	//---axi-lite---
	.m_axil_awaddr_o(m_axil_awaddr),
//  .m_axil_awuser(),
    .m_axil_awprot_o(m_axil_awprot),
    .m_axil_awvalid_o(m_axil_awvalid),
    .m_axil_awready_i(m_axil_awready),
    .m_axil_wdata_o(m_axil_wdata),
    .m_axil_wstrb_o(m_axil_wstrb),
    .m_axil_wvalid_o(m_axil_wvalid),
    .m_axil_wready_i(m_axil_wready),
    .m_axil_bvalid_i(m_axil_bvalid),
    .m_axil_bresp_i(m_axil_bresp),
    .m_axil_bready_o(m_axil_bready),
    .m_axil_araddr_o(m_axil_araddr),
//  .m_axil_aruser(),
    .m_axil_arprot_o(m_axil_arprot),
    .m_axil_arvalid_o(m_axil_arvalid),
    .m_axil_arready_i(m_axil_arready),
    .m_axil_rdata_i(m_axil_rdata),
    .m_axil_rresp_i(m_axil_rresp),
    .m_axil_rvalid_i(m_axil_rvalid),
    .m_axil_rready_o(m_axil_rready),
`endif	
`ifdef AXIL_SBUS0_EN
	.s_axil_awaddr_i(s_axil_awaddr),
    .s_axil_awprot_i(s_axil_awprot),
    .s_axil_awvalid_i(s_axil_awvalid),
    .s_axil_awready_o(s_axil_awready),
    .s_axil_wdata_i(s_axil_wdata),
    .s_axil_wstrb_i(s_axil_wstrb),
    .s_axil_wvalid_i(s_axil_wvalid),
    .s_axil_wready_o(s_axil_wready),
    .s_axil_bvalid_o(s_axil_bvalid),
    .s_axil_bresp_o(s_axil_bresp),
    .s_axil_bready_i(s_axil_bready),
    .s_axil_araddr_i(s_axil_araddr),
    .s_axil_arprot_i(s_axil_arprot),
    .s_axil_arvalid_i(s_axil_arvalid),
    .s_axil_arready_o(s_axil_arready),
    .s_axil_rdata_o(s_axil_rdata),
    .s_axil_rresp_o(s_axil_rresp),
    .s_axil_rvalid_o(s_axil_rvalid),
    .s_axil_rready_i(s_axil_rready),
`endif
	//---2路axistream---
`ifdef AXIS_BUS0_EN	
	.s0_axis_tx_rst_o(s0_axis_c2h_rst),
    .m0_axis_rx_rst_o(m0_axis_h2c_rst),
    .s0_axis_tx_run_o(s0_axis_c2h_run),
    .m0_axis_rx_run_o(m0_axis_h2c_run), 
    
	.s0_axis_tx_tdata_i(s0_axis_c2h_tdata),
    .s0_axis_tx_tlast_i(s0_axis_c2h_tlast),
    .s0_axis_tx_tvalid_i(s0_axis_c2h_tvalid),
    .s0_axis_tx_tready_o(s0_axis_c2h_tready),
    .s0_axis_tx_tuser_i(s0_axis_c2h_tuser),
    .s0_axis_tx_tkeep_i(s0_axis_c2h_tkeep),
    .m0_axis_rx_tdata_o(m0_axis_h2c_tdata),
    .m0_axis_rx_tlast_o(m0_axis_h2c_tlast),
    .m0_axis_rx_tvalid_o(m0_axis_h2c_tvalid),
    .m0_axis_rx_tready_i(m0_axis_h2c_tready),
    .m0_axis_rx_tuser_o(m0_axis_h2c_tuser),
    .m0_axis_rx_tkeep_o(m0_axis_h2c_tkeep),
`endif	
`ifdef AXIS_BUS1_EN
    .s1_axis_tx_tdata_i(s1_axis_c2h_tdata),
    .s1_axis_tx_tlast_i(s1_axis_c2h_tlast),
    .s1_axis_tx_tvalid_i(s1_axis_c2h_tvalid),
    .s1_axis_tx_tready_o(s1_axis_c2h_tready),
    .s1_axis_tx_tuser_i(s1_axis_c2h_tuser),
    .s1_axis_tx_tkeep_i(s1_axis_c2h_tkeep),
    .m1_axis_rx_tdata_o(m1_axis_h2c_tdata),
    .m1_axis_rx_tlast_o(m1_axis_h2c_tlast),
    .m1_axis_rx_tvalid_o(m1_axis_h2c_tvalid),
    .m1_axis_rx_tready_i(m1_axis_h2c_tready),
    .m1_axis_rx_tuser_o(m1_axis_h2c_tuser),
    .m1_axis_rx_tkeep_o(m1_axis_h2c_tkeep),
`endif		
	//---XALI0 TX---    
	.client0_addr_align_en_o(client0_addr_align_en),
	.client0_tlp_header_o({{client0_tlp_addr[63:2],client0_tlp_ph,client0_remote_req_id,client0_tlp_tid[7:0],client0_tlp_byte_en},
						   {r00,client0_tlp_fmt,client0_tlp_type,t09,client0_tlp_tc,t08,client0_tlp_attr[2],ln0,client0_tlp_th,
						   client0_tlp_td,client0_tlp_ep,client0_tlp_attr[1:0],client0_tlp_ats,length0}}),
	.client0_tlp_dv_o(client0_tlp_dv),
	.client0_tlp_eot_o(client0_tlp_eot),
	.client0_tlp_bad_eot_o(client0_tlp_bad_eot),
	.client0_tlp_hv_o(client0_tlp_hv),
	.client0_tlp_byte_len_o(client0_tlp_byte_len),
	.client0_tlp_data_o(client0_tlp_data),
	.client0_tlp_func_num_o(client0_tlp_func_num),
	.client0_tlp_vfunc_num_o(client0_tlp_vfunc_num),
	.client0_tlp_vfunc_active_o(client0_tlp_vfunc_active),
	.xadm_client0_halt_i(xadm_client0_halt_buf),
	.client0_tlp_atu_bypass_o(client0_tlp_atu_bypass),
/*	
	.client0_remote_req_id_o(client0_remote_req_id),
	.client0_tlp_tid_o(client0_tlp_tid),
	.client0_tlp_byte_en_o(client0_tlp_byte_en),
	.client0_tlp_addr_o(client0_tlp_addr),
	.client0_tlp_ph_o(client0_tlp_ph),
	.client0_cpl_status_o(client0_cpl_status),
	.client0_cpl_bcm_o(client0_cpl_bcm),
	.client0_cpl_byte_cnt_o(client0_cpl_byte_cnt),
	.client0_cpl_lookup_id_o(client0_cpl_lookup_id),
*/	
	//---XALI0 TX interface---    
	.client1_addr_align_en_o(client1_addr_align_en),
	.client1_tlp_header_o({{client1_tlp_addr[63:2],client1_tlp_ph,client1_remote_req_id,client1_tlp_tid[7:0],client1_tlp_byte_en},
							{r10,client1_tlp_fmt,client1_tlp_type,t19,client1_tlp_tc,t18,client1_tlp_attr[2],ln1,client1_tlp_th,
						   client1_tlp_td,client1_tlp_ep,client1_tlp_attr[1:0],client1_tlp_ats,length1}}),
	.client1_tlp_dv_o(client1_tlp_dv),
	.client1_tlp_eot_o(client1_tlp_eot),
	.client1_tlp_bad_eot_o(client1_tlp_bad_eot),
	.client1_tlp_hv_o(client1_tlp_hv),
	.client1_tlp_byte_len_o(client1_tlp_byte_len),
	.client1_tlp_data_o(client1_tlp_data),
	.client1_tlp_func_num_o(client1_tlp_func_num),
	.client1_tlp_vfunc_num_o(client1_tlp_vfunc_num),
	.client1_tlp_vfunc_active_o(client1_tlp_vfunc_active),
	.xadm_client1_halt_i(xadm_client1_halt),
	.client1_tlp_atu_bypass_o(client1_tlp_atu_bypass),
/*	
	.client1_remote_req_id_o(client1_remote_req_id),
	.client1_tlp_tid_o(client1_tlp_tid),
	.client1_tlp_byte_en_o(client1_tlp_byte_en),
	.client1_tlp_addr_o(client1_tlp_addr),
	.client1_tlp_ph_o(client1_tlp_ph),
	.client1_cpl_status_o(client1_cpl_status),
	.client1_cpl_bcm_o(client1_cpl_bcm),
	.client1_cpl_byte_cnt_o(client1_cpl_byte_cnt),
	.client1_cpl_lookup_id_o(client1_cpl_lookup_id),
*/
	 //---bypass interface---
	.radm_bypass_dv_i(radm_bypass_dv),
	.radm_bypass_hv_i(radm_bypass_hv),
	.radm_bypass_eot_i(radm_bypass_eot),
	.radm_bypass_data_i(radm_bypass_data),
	.radm_bypass_header_i({32'd0,{radm_bypass_reqid,radm_bypass_tag[7:0],1'b0,radm_bypass_addr[6:0]},
						  {radm_bypass_cmpltr_id,radm_bypass_cpl_status,radm_bypass_bcm,radm_bypass_byte_cnt},
						  {1'b0,radm_bypass_fmt,radm_bypass_type,1'b0,radm_bypass_tc,1'b0,radm_bypass_attr[2],2'b00,
						   radm_bypass_td,radm_bypass_poisoned,radm_bypass_attr[1:0],2'b00,radm_bypass_dw_len}
						  }),//pos&non_pos 4DW,cpl 3DW. 
	.radm_bypass_dwen_i(radm_bypass_dwen),
	.radm_bypass_cpl_last_i(radm_bypass_cpl_last),
	.radm_bypass_dllp_abort_i(radm_bypass_dllp_abort),
	.radm_bypass_tlp_abort_i(radm_bypass_tlp_abort),
	.radm_bypass_ecrc_err_i(radm_bypass_ecrc_err),
	.radm_bypass_func_num_i(radm_bypass_func_num),
	.radm_bypass_vfunc_num_i(radm_bypass_vfunc_num),
	.radm_bypass_vfunc_active_i(radm_bypass_vfunc_active),
	.radm_bypass_io_req_in_range_i(radm_bypass_io_req_in_range),
	.radm_bypass_in_membar_range_i(radm_bypass_in_membar_range),
	.radm_bypass_rom_in_range_i(radm_bypass_rom_in_range),

	//---elbi interface---
	.lbc_ext_cs_i(lbc_ext_cs[1:0]),
    .ext_lbc_ack_o(ext_lbc_ack[1:0]),
    .lbc_ext_addr_i({lbc_ext_addr[31:3],lbc_ext_addr2_buf3,lbc_ext_addr[1:0]}),
    .lbc_ext_wr_i(lbc_ext_wr[3:0]),
    .ext_lbc_din_o(ext_lbc_din[63:0]), 
    .lbc_ext_dout_i({lbc_ext_dout[31:11],lbc_ext_dout10_buf,lbc_ext_dout[9:0]}),
    .lbc_ext_rom_access_i(lbc_ext_rom_access),
	.lbc_ext_io_access_i(lbc_ext_io_access),
	.lbc_ext_bar_num_i(lbc_ext_bar_num[2:0]),
	.lbc_ext_vfunc_active_i(lbc_ext_vfunc_active),
	.lbc_ext_vfunc_num_i(lbc_ext_vfunc_num),

	.ven_msi_grant_i(ven_msi_grant),
	//当msi使能时，用户逻辑请求控制器发出MSI报文
	.cfg_msi_en_i(cfg_msi_en),
	//用的PF0,也就是[31:0]每个bit对应一个中断
	.cfg_msi_mask_i(cfg_msi_mask),	
	.ven_msi_req_o(ven_msi_req),
	.ven_msi_func_num_o(ven_msi_func_num),
	.ven_msi_vfunc_num_o(ven_msi_vfunc_num),
	.ven_msi_vfunc_active_o(ven_msi_vfunc_active),
	.ven_msi_tc_o(ven_msi_tc),
	//DMA读写完成各分一个中断号，写5'd0,读5'd1
	.ven_msi_vector_o(ven_msi_vector),
	.cfg_msi_pending_o(cfg_msi_pending),
`ifdef USR_IRQ_EN	
	//---usr-irq->msi---
    .usr_irq_req_i(usr_irq_req),
//  .usr_irq_function_number(4'd0),
    .usr_irq_ack_o(usr_irq_ack),
    .msi_enable_o(msi_enable),
//  .msix_enable_o(),
    .msi_vector_width_o(msi_vector_width)
`endif	
`ifdef CFG_MGMT_EN
	//---cfg_mgmt->dbi---
    ,.cfg_mgmt_addr_i(cfg_mgmt_addr),
    .cfg_mgmt_write_i(cfg_mgmt_write),
    .cfg_mgmt_write_data_i(cfg_mgmt_write_data),
    .cfg_mgmt_byte_enable_i(cfg_mgmt_byte_enable),
    .cfg_mgmt_read_i(cfg_mgmt_read),
    .cfg_mgmt_read_data_o(cfg_mgmt_read_data),
    .cfg_mgmt_read_write_done_o(cfg_mgmt_read_write_done),
    .cfg_mgmt_type1_cfg_reg_access_i(cfg_mgmt_type1_cfg_reg_access),

/*  .cfg_mgmt_addr_sd(),
    .cfg_mgmt_write_sd(),
    .cfg_mgmt_function_number_sd(),
    .cfg_mgmt_write_data_sd(),
    .cfg_mgmt_byte_enable_sd(),
    .cfg_mgmt_read_sd(),
    .cfg_mgmt_read_data_sd(32'B0),
    .cfg_mgmt_read_write_done_sd(1'B0),
    .cfg_mgmt_type1_cfg_reg_access_sd(),*/
    //---dbi interface---
    
    .drp_dbi_din_o(ext_drp_dbi_din),
    .drp_dbi_wr_o(ext_drp_dbi_wr[3:0]),
    .drp_dbi_addr_o(ext_drp_dbi_addr[31:0]),
    .drp_dbi_cs_o(ext_drp_dbi_cs),
	.drp_dbi_cs2_o(ext_drp_dbi_cs2_exp),
    .drp_lbc_dbi_dout_i(ext_drp_lbc_dbi_dout),
    .drp_lbc_dbi_ack_i(ext_drp_lbc_dbi_ack), 
    .drp_dbi_vfunc_num_o(ext_drp_dbi_vfunc_num),	
    .drp_dbi_vfunc_active_o(ext_drp_dbi_vfunc_active),
	.drp_dbi_func_num_o(ext_drp_dbi_func_num),
	.drp_dbi_bar_num_o	(ext_drp_dbi_bar_num[2:0]),
	.drp_dbi_rom_access_o(ext_drp_dbi_rom_access),
	.drp_dbi_io_access_o(ext_drp_dbi_io_access),
	.drp_app_dbi_ro_wr_disable_o(ext_drp_app_dbi_ro_wr_disable)
 `endif   
 

);

assign user_lnk_up = rdlh_link_up; 

endmodule
