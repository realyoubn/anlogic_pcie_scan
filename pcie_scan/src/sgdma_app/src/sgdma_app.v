
`include "../../src/sgdma_ip/def/para_def.vh"
`include "../../../tb/def/tlp_fmt_type.vh"
`include "../../../tb/def/dt_para.vh"

module sgdma_app
(
	input   wire   usr_clk,
	input   wire   usr_rst_n,
//        output  wire   led0,
    
        output   wire    [31:0]   bram_di,
    output   wire    [19:0]   bram_wraddr,
    output   wire   bram_wren,
		input   wire   [127:0]pcie_data,
        input   wire   pcie_valid,
        input   wire   pcie_start,
        input   wire   pcie_stop,
		output  wire   c2h0r_run,
`ifdef AXIS_BUS0_EN
	input   wire   s0_axis_c2h_rst,	
    input   wire   m0_axis_h2c_rst,
    input   wire   s0_axis_c2h_run,
    input   wire   m0_axis_h2c_run,

	output  wire   m0_axis_h2c_tready,	
    input   wire   [`DATA_WIDTH-1:0] m0_axis_h2c_tdata,
    input   wire   [`KEEP_WIDTH-1:0] m0_axis_h2c_tkeep,
    input   wire   [`KEEP_WIDTH-1:0] m0_axis_h2c_tuser,
    input   wire   m0_axis_h2c_tlast,	
    input   wire   m0_axis_h2c_tvalid,	
    
	input   wire   s0_axis_c2h_tready,      
    output  wire   [`DATA_WIDTH-1:0] s0_axis_c2h_tdata,
    output  wire   [`KEEP_WIDTH-1:0] s0_axis_c2h_tkeep,
    output  wire   [`KEEP_WIDTH-1:0] s0_axis_c2h_tuser,
    output  wire   s0_axis_c2h_tlast,
    output  wire   s0_axis_c2h_tvalid,
`endif
`ifdef AXIS_BUS1_EN
	output  wire   m1_axis_h2c_tready,
    input   wire   [`DATA_WIDTH-1:0] m1_axis_h2c_tdata,
    input   wire   [`KEEP_WIDTH-1:0] m1_axis_h2c_tkeep,
    input   wire   [`KEEP_WIDTH-1:0] m1_axis_h2c_tuser,
    input   wire   m1_axis_h2c_tlast,
    input   wire   m1_axis_h2c_tvalid,
	input   wire   s1_axis_c2h_tready,
    output  wire   [`DATA_WIDTH-1:0] s1_axis_c2h_tdata,
    output  wire   [`KEEP_WIDTH-1:0] s1_axis_c2h_tkeep,
    output  wire   [`KEEP_WIDTH-1:0] s1_axis_c2h_tuser,
    output  wire   s1_axis_c2h_tlast,
    output  wire   s1_axis_c2h_tvalid,

`endif
`ifdef AXI4_BUS0_EN
	output  wire   m_axi_arready,
	input   wire   [3:0] m_axi_arid,
	input   wire   [`DATA_WIDTH-1:0] m_axi_araddr,
	//specifies the number of data transfers that occur within each burst.
	input   wire   [7:0] m_axi_arlen,
	//specifies the maximum number of data bytes to transfer in each beat. 011-8byte,100-16byte
	input   wire   [2:0] m_axi_arsize,
	input   wire   [1:0] m_axi_arburst,
	input   wire   [2:0] m_axi_arprot,
	input   wire   m_axi_arvalid,
	input   wire   m_axi_arlock,
	input   wire   [3:0] m_axi_arcache,
	
	output  wire   [3:0] m_axi_rid,
	output  wire   [`DATA_WIDTH-1:0]m_axi_rdata,
	output  wire   [1:0] m_axi_rresp,
	output  wire   m_axi_rlast,
	output  wire   m_axi_rvalid,
	input   wire   m_axi_rready,
	
	output  wire   m_axi_awready,
	input   wire   [3:0] m_axi_awid,
	input   wire   [`DATA_WIDTH-1:0] m_axi_awaddr,
	input   wire   [7:0] m_axi_awlen,
	input   wire   [2:0] m_axi_awsize,
	input   wire   [1:0] m_axi_awburst,
	input   wire   [2:0] m_axi_awprot,
	input   wire   m_axi_awvalid,
	input   wire   m_axi_awlock,
	input   wire   [3:0] m_axi_awcache,
	input   wire   [`DATA_WIDTH-1:0] m_axi_wdata,
	input   wire   [7:0] m_axi_wstrb,
	output  wire   m_axi_wready,
	input   wire   m_axi_wlast,
	input   wire   m_axi_wvalid,
	output  wire   [3:0] m_axi_bid,
	output  wire   [1:0] m_axi_bresp,
	output  wire   m_axi_bvalid,
	input   wire   m_axi_bready,
`endif
`ifdef CFG_MGMT_EN 
	output  wire   [18:0] cfg_mgmt_addr,
	output  wire   cfg_mgmt_write,
	output  wire   [31:0] cfg_mgmt_write_data,
	output  wire   [3:0] 	cfg_mgmt_byte_enable,	
	output  wire   cfg_mgmt_read,	
	input   wire   [31:0] cfg_mgmt_read_data,	
	input   wire   cfg_mgmt_read_write_done,
	output  wire   cfg_mgmt_type1_cfg_reg_access,
`endif
`ifdef USR_IRQ_EN
	output  wire   [`DMA_USR_IRQ-1:0]	usr_irq_req,
	input   wire   [`DMA_USR_IRQ-1:0]	usr_irq_ack,
	input   wire   msi_enable,
	input   wire   [2:0] 	msi_vector_width,
`endif     
`ifdef AXIL_MBUS0_EN
	input 	wire   [31:0] m_axil_awaddr,
	input 	wire   [2:0]  m_axil_awprot,	
	input 	wire   m_axil_awvalid,		
	output  wire   m_axil_awready,		
	input 	wire   [31:0] m_axil_wdata,	
	input 	wire   [3:0] 	m_axil_wstrb,	
	input 	wire   m_axil_wvalid,		
	output  wire   m_axil_wready,	
	output  wire   m_axil_bvalid,	
	output  wire   [1:0] 	m_axil_bresp,	
	input 	wire   m_axil_bready,	
	input 	wire   [31:0] m_axil_araddr,	
	input 	wire   [2:0]  m_axil_arprot,	
	input   wire   m_axil_arvalid,		
	output  wire   m_axil_arready,	
	output  wire   [31:0] m_axil_rdata,	
	output  wire   [1:0] 	m_axil_rresp,	
	output  wire   m_axil_rvalid,		
	input   wire   m_axil_rready,
`endif
`ifdef AXIL_SBUS0_EN
	output  wire   [31:0] s_axil_awaddr,
	output  wire   [2 :0] s_axil_awprot,
	output  wire   s_axil_awvalid,		
	input   wire   s_axil_awready,		
	output  wire   [31:0] s_axil_wdata,	
	output  wire   [3:0]  s_axil_wstrb,	
	output  wire   s_axil_wvalid,		
	input   wire   s_axil_wready,	
	input   wire   s_axil_bvalid,	
	input   wire   [1:0]  s_axil_bresp,	
	output  wire   s_axil_bready,	
	output  wire   [31:0] s_axil_araddr,	
	output  wire   [2:0]  s_axil_arprot,	
	output  wire   s_axil_arvalid,		
	input   wire   s_axil_arready,	
	input   wire   [31:0] s_axil_rdata,	
	input   wire   [1:0]  s_axil_rresp,	
	input   wire   s_axil_rvalid,	
	output  wire   s_axil_rready
`endif
//	output  wire   pcie_cfg_tst_o,
`ifdef DEBUG_MODE
   ,output  wire   [`DT_WD*`IDT_NUM-1:0]   h2c_fm_odt,
	input   wire   [`DT_WD*`ODT_NUM-1:0]   c2h_fm_idt
`endif
);
//---Variable definition---
wire   [31:0] c2h0_chn_stts;
wire   [31:0] h2c0_chn_stts;
wire   [31:0] usr_h2c0err_num;
wire   [1:0]  usr_lp0rw_md;
wire   cfg_regrw_run;
wire   [1:0]  dma_regrw_run;
wire   usr_h2c0w_run;
wire   usr_regrw_run;
wire   usr_c2h0r_run;
wire   usr_lp0rw_run;

wire   pcie_cfg_test;
wire   usr_h2c0irq_req;
wire   usr_h2c0irq_ack;
wire   usr_c2h0irq_req;
wire   usr_c2h0irq_ack;
wire   data_rst_flag;
//wire   [1:0]   usr_tst_mode; 

wire   [`DATA_WIDTH-1:0] s0_axis_c2ha_tdata;
wire   [`KEEP_WIDTH-1:0] s0_axis_c2ha_tkeep;
wire   [`KEEP_WIDTH-1:0] s0_axis_c2ha_tuser;
wire   s0_axis_c2ha_tlast;
wire   s0_axis_c2ha_tvalid;
wire   m0_axis_h2ca_tready;
/*
`ifdef C2H_TEST_MODE 
assign usr_tst_mode = 2'b01;
`elsif H2C_TEST_MODE 
assign usr_tst_mode = 2'b10;
`else
assign usr_tst_mode = 2'b11;
`endif*/
app_tst_ctrl u_tst_ctrl(
	.usr_rst_n(usr_rst_n),
	.usr_clk(usr_clk),
    
	.usr_lp0rw_md_i(usr_lp0rw_md),
	.cfg_regrw_run_o(cfg_regrw_run),
    .s0_axis_c2h_run_i(s0_axis_c2h_run),
    .m0_axis_h2c_run_i(m0_axis_h2c_run),
	.dma_regrw_run_o(dma_regrw_run),
	.usr_h2c0w_run_o(usr_h2c0w_run),
    .usr_c2h0r_run_o(usr_c2h0r_run),
	.usr_regrw_run_o(usr_regrw_run),
	.usr_lp0rw_run_o(usr_lp0rw_run)
	
);
/*Instantiate the cfg_regrw.v to copmplete the 
read and write test of configuration space;*/
cfg_regrw u_cfg_regrw(
   	.usr_clk(usr_clk),
	.usr_rst_n(usr_rst_n),
                                                                    
	.cfg_mgmt_addr_o(cfg_mgmt_addr),
    .cfg_mgmt_write_o(cfg_mgmt_write),
    .cfg_mgmt_write_data_o(cfg_mgmt_write_data),
    .cfg_mgmt_byte_enable_o(cfg_mgmt_byte_enable),
    .cfg_mgmt_read_o(cfg_mgmt_read),    
    .cfg_mgmt_read_data_i(cfg_mgmt_read_data),    
    .cfg_mgmt_read_write_done_i(cfg_mgmt_read_write_done),
    .cfg_mgmt_type1_cfg_reg_access_o(cfg_mgmt_type1_cfg_reg_access),

	.cfg_regrw_run_i(cfg_regrw_run),
	.pcie_cfg_tst_o()
);

/*Instantiate the usr_axis0_datarw.v to receive 
or send test data;*/
/*usr_axis0_datarw u_axis0_datarw(

   	.usr_clk(usr_clk),
	.usr_rst_n(usr_rst_n),
	.usr_datarw_run_i(usr_datarw_run),
	 
	.m0_axis_h2c_tready_o(m0_axis_h2c_tready),
    .m0_axis_h2c_tdata_i(m0_axis_h2c_tdata),
    .m0_axis_h2c_tkeep_i(m0_axis_h2c_tkeep),
    .m0_axis_h2c_tuser_i(m0_axis_h2c_tuser),
    .m0_axis_h2c_tlast_i(m0_axis_h2c_tlast),
    .m0_axis_h2c_tvalid_i(m0_axis_h2c_tvalid),	
	                       
	.usr_c2h_len_i(usr_c2h_len_o), 	
	.usr_c2h_len_en_i(usr_c2h_len_en_o),                   
	.s0_axis_c2h_tready_i(s0_axis_c2h_tready),
    .s0_axis_c2h_tdata_o(s0_axis_c2h_tdata),
    .s0_axis_c2h_tkeep_o(s0_axis_c2h_tkeep),
    .s0_axis_c2h_tuser_o(s0_axis_c2h_tuser),
    .s0_axis_c2h_tlast_o(s0_axis_c2h_tlast),
    .s0_axis_c2h_tvalid_o(s0_axis_c2h_tvalid),
   
	.m0_test_mode_i(`TEST_MODE),

	.usr_prg_payload_i(3'b001),
	.usr_prg_read_i(3'b001),
	.usr_eff_payload_o(),
	.usr_eff_read_o(),
                                                                
	.usr_irq_req_o(usr_irq_req),				
	.usr_irq_ack_i(usr_irq_ack),
	.mrd_err_num_o(mrd_err_num)
);*/
/*
`ifdef LOOP_TEST_MODE
assign m0_axis_h2c_tready = s0_axis_c2h_tready;
assign s0_axis_c2h_tdata = m0_axis_h2c_tdata;
assign s0_axis_c2h_tkeep = m0_axis_h2c_tkeep;
assign s0_axis_c2h_tuser = m0_axis_h2c_tuser;
assign s0_axis_c2h_tlast = m0_axis_h2c_tlast;
assign s0_axis_c2h_tvalid = m0_axis_h2c_tvalid;
assign usr_c2h0irq_req = 1'b0;
assign usr_c2h0err = 1'b0;
assign usr_h2c0irq_req = 1'b0;
assign usr_h2c0err_num = 32'd0;
`elsif H2C_TEST_MODE*/
usr_h2c0w u_usr_h2c0w(
   	.usr_rst_n(usr_rst_n),
	.usr_clk(usr_clk),
	
	.usr_h2c0w_run_i(usr_h2c0w_run),
	.m0_axis_h2c_rst_i(m0_axis_h2c_rst),
    
	.m0_axis_h2c_tready_o(m0_axis_h2ca_tready),
    .m0_axis_h2c_tdata_i(m0_axis_h2c_tdata),
    .m0_axis_h2c_tkeep_i(m0_axis_h2c_tkeep),
    .m0_axis_h2c_tuser_i(m0_axis_h2c_tuser),
    .m0_axis_h2c_tlast_i(m0_axis_h2c_tlast),
    .m0_axis_h2c_tvalid_i(m0_axis_h2c_tvalid),	
   
	.usr_h2c0irq_req_o(usr_h2c0irq_req),				
	.usr_h2c0irq_ack_i(usr_h2c0irq_ack),	
	.usr_h2c0err_num_o(usr_h2c0err_num)
`ifdef DEBUG_MODE	
	,.h2c_fm_odt(h2c_fm_odt)
`endif
);
/*assign usr_c2h0irq_req = 1'b0;
assign usr_c2h0err = 1'b0;
`else //C2H_TEST_MODE*/
usr_c2h0r u_usr_c2h0r(
   	.usr_rst_n(usr_rst_n),
	.usr_clk(usr_clk),
	.usr_c2h0r_run_i(usr_c2h0r_run),
	.c2h0r_run(c2h0r_run),
//    .stop(stop),
	.s0_axis_c2h_rst_i(s0_axis_c2h_rst),
`ifdef DEBUG_MODE		
	.c2h_fm_idt(c2h_fm_idt),
`endif
	.s0_axis_c2h_tready_i(s0_axis_c2h_tready),
    .s0_axis_c2h_tdata_o(s0_axis_c2ha_tdata),
    .s0_axis_c2h_tkeep_o(s0_axis_c2ha_tkeep),
    .s0_axis_c2h_tuser_o(s0_axis_c2ha_tuser),
    .s0_axis_c2h_tlast_o(s0_axis_c2ha_tlast),
    .s0_axis_c2h_tvalid_o(s0_axis_c2ha_tvalid),
    
	.usr_c2h0irq_req_o(usr_c2h0irq_req),				
	.usr_c2h0irq_ack_i(usr_c2h0irq_ack),
	.usr_c2h0err_o(usr_c2h0err),
            .pcie_data               ( pcie_data             ),
    	.pcie_valid              ( pcie_valid            ),
                    .pcie_start               ( pcie_start             ),
    	.pcie_stop              ( pcie_stop            )
);
/*assign usr_h2c0irq_req = 1'b0;
assign usr_h2c0err_num = 32'd0; 
assign h2c_fm_odt = 'd0;
`endif*/

usr_lp0rw u_usr_lp0rw(
    .usr_lp0rw_run_i(usr_lp0rw_run),
    
    .m0_axis_h2c_tdata_i(m0_axis_h2c_tdata),
    .m0_axis_h2c_tkeep_i(m0_axis_h2c_tkeep),
    .m0_axis_h2c_tuser_i(m0_axis_h2c_tuser),
    .m0_axis_h2c_tlast_i(m0_axis_h2c_tlast),
    .m0_axis_h2c_tvalid_i(m0_axis_h2c_tvalid),	
    .m0_axis_h2ca_tready_i(m0_axis_h2ca_tready),
    
    .s0_axis_c2ha_tdata_i(s0_axis_c2ha_tdata),
    .s0_axis_c2ha_tkeep_i(s0_axis_c2ha_tkeep),
    .s0_axis_c2ha_tuser_i(s0_axis_c2ha_tuser),
    .s0_axis_c2ha_tlast_i(s0_axis_c2ha_tlast),
    .s0_axis_c2ha_tvalid_i(s0_axis_c2ha_tvalid),
    .s0_axis_c2h_tready_i(s0_axis_c2h_tready),
    
    .m0_axis_h2c_tready_o(m0_axis_h2c_tready),
    .s0_axis_c2h_tdata_o(s0_axis_c2h_tdata),
    .s0_axis_c2h_tkeep_o(s0_axis_c2h_tkeep),
    .s0_axis_c2h_tuser_o(s0_axis_c2h_tuser),
    .s0_axis_c2h_tlast_o(s0_axis_c2h_tlast),
    .s0_axis_c2h_tvalid_o(s0_axis_c2h_tvalid)
);

assign usr_irq_req = {usr_c2h0irq_req,usr_h2c0irq_req};
assign {usr_h2c0irq_ack,usr_c2h0irq_ack} = usr_irq_ack;


//---Instantiate the usr_regrw.v to test reading and writing registers;*/
usr_regrw u_usr_regrw(
	.usr_rst_n(usr_rst_n),
	.usr_clk(usr_clk),
    .bram_di(bram_di),
    .bram_wraddr(bram_wraddr),
    .bram_wren(bram_wren),

    .s0_axis_c2h_rst_i(s0_axis_c2h_rst),
    .m0_axis_h2c_rst_i(m0_axis_h2c_rst),
    
	.usr_regrw_run_i(usr_regrw_run),
	.m_axil_awaddr_i(m_axil_awaddr),
	.m_axil_awprot_i(m_axil_awprot),	
	.m_axil_awvalid_i(m_axil_awvalid),		
	.m_axil_awready_o(m_axil_awready),		
	.m_axil_wdata_i	(m_axil_wdata),	
	.m_axil_wstrb_i	(m_axil_wstrb),	
	.m_axil_wvalid_i(m_axil_wvalid),		
	.m_axil_wready_o(m_axil_wready),	
	.m_axil_bvalid_o(m_axil_bvalid),	
	.m_axil_bresp_o	(m_axil_bresp),	
	.m_axil_bready_i(m_axil_bready),	
	.m_axil_araddr_i(m_axil_araddr),	
	.m_axil_arprot_i(m_axil_arprot),	
	.m_axil_arvalid_i(m_axil_arvalid),		
	.m_axil_arready_o(m_axil_arready),	
	.m_axil_rdata_o	(m_axil_rdata),	
	.m_axil_rresp_o	(m_axil_rresp),	
	.m_axil_rvalid_o(m_axil_rvalid),		
	.m_axil_rready_i(m_axil_rready),
	
    .usr_h2c0err_num_i(usr_h2c0err_num),
    .usr_lp0rw_md_o(usr_lp0rw_md)
/*	
	.usr_prg_payload_o(usr_prg_payload),
	.usr_prg_read_o(usr_prg_read),
	.usr_eff_payload_i(usr_eff_payload),
	.usr_eff_read_i(usr_eff_read)
*/	
);

dma_regrw u_dma_regrw(

	.usr_rst_n(usr_rst_n),
	.usr_clk(usr_clk),
                                                                    
	.s_axil_awaddr_o(s_axil_awaddr),
    .s_axil_awprot_o(s_axil_awprot),
    .s_axil_awvalid_o(s_axil_awvalid),
    .s_axil_awready_i(s_axil_awready),
    .s_axil_wdata_o(s_axil_wdata),
    .s_axil_wstrb_o(s_axil_wstrb),
    .s_axil_wvalid_o(s_axil_wvalid),
    .s_axil_wready_i(s_axil_wready),
    .s_axil_bvalid_i(s_axil_bvalid),
    .s_axil_bresp_i(s_axil_bresp),
    .s_axil_bready_o(s_axil_bready),
    .s_axil_araddr_o(s_axil_araddr),
    .s_axil_arprot_o(s_axil_arprot),
    .s_axil_arvalid_o(s_axil_arvalid),
    .s_axil_arready_i(s_axil_arready),
    .s_axil_rdata_i(s_axil_rdata),
    .s_axil_rresp_i(s_axil_rresp),
    .s_axil_rvalid_i(s_axil_rvalid),
    .s_axil_rready_o(s_axil_rready),
               
    .dma_regrw_run_i(dma_regrw_run),                                           
	.c2h0_chn_stts_o(c2h0_chn_stts),
	.h2c0_chn_stts_o(h2c0_chn_stts)

);

//text_led utext(
//   	.usr_clk(usr_clk),
//	.usr_rst_n(usr_rst_n),
//    .m_axil_wdata(m_axil_wdata),
//    .led0(led0),
//    .stop(stop)
// );
endmodule
