`include "../../src/sgdma_ip/def/para_def.vh"
`include "../../tb/def/tlp_fmt_type.vh"
`include "../../tb/def/dt_para.vh"
module pcie_scan(/*AUTOARG*/
	input   app_auxclk,
	input   app_power_up_rst_n,
	
	input   [`REFCLK_WIDTH-1:0]  refclk_p,
	input   [`REFCLK_WIDTH-1:0]  refclk_n,
	output  [`LINK_WIDTH-1:0]    txp,
	output  [`LINK_WIDTH-1:0]    txn,  
	input   [`LINK_WIDTH-1:0]    rxp,
	input   [`LINK_WIDTH-1:0]    rxn,
`ifdef DEBUG_MODE
    input   [`DT_WD*`ODT_NUM-1:0]   c2h_fm_idt,
    output  [`DT_WD*`IDT_NUM-1:0]   h2c_fm_odt,    
`endif   
    output  core_clk_led,
    output  user_lnk_up,
        output  led0,
        
//system port
//input  clkin,
input  [15:0] in1,
input  [15:0] in2,
output vsmp1,rsmp1,mclk1,
output vsmp2,rsmp2,mclk2, 
output SCK1,SEN1,
inout  SDI1,
output cisclk1,si1,cism1,
output cisclk2,si2,cism2,
output cisclk3,si3,cism3,
output cisclk4,si4,cism4,
output cisclk5,si5,cism5,
output cisclk6,si6,cism6,
output led1A_r,
output led1A_g,
output led1A_b,
output led2A_r,
output led2A_g,
output led2A_b,
output led1B_r, 
output led1B_g,
output led1B_b,
output led2B_r,
output led2B_g,
output led2B_b,
  
  output x0_p					,
  output x1_p					,
  output x2_p					,
  output x3_p					,
  output xclk_p					,
  
  output  clk_cis,
  output mclk,
  output vsmp,
  output clk_wram,
  input ubus_rx,
  output ubus_tx
);     
 	
`ifdef AXIS_BUS0_EN
	wire   s0_axis_c2h_rst;
    wire   m0_axis_h2c_rst;
    wire   s0_axis_c2h_run;
    wire   m0_axis_h2c_run;
    
	wire   s0_axis_c2h_tready;//synthesis keep
    wire   [`DATA_WIDTH-1:0]    s0_axis_c2h_tdata;//synthesis keep
    wire   [`KEEP_WIDTH-1:0]    s0_axis_c2h_tkeep;//synthesis keep
    wire   [`KEEP_WIDTH-1:0]    s0_axis_c2h_tuser;
    wire   s0_axis_c2h_tlast;//synthesis keep
    wire   s0_axis_c2h_tvalid;//synthesis keep	
	
	wire   m0_axis_h2c_tready;//synthesis keep
    wire   [`DATA_WIDTH-1:0]    m0_axis_h2c_tdata;//synthesis keep
    wire   [`KEEP_WIDTH-1:0]    m0_axis_h2c_tkeep;//synthesis keep
    wire   [`KEEP_WIDTH-1:0]    m0_axis_h2c_tuser;
    wire   m0_axis_h2c_tlast;//synthesis keep
    wire   m0_axis_h2c_tvalid;//synthesis keep
`endif
`ifdef AXIS_BUS1_EN
	wire   s1_axis_c2h_tready;
    wire   [`DATA_WIDTH-1:0]    s1_axis_c2h_tdata;
    wire   [`KEEP_WIDTH-1:0]    s1_axis_c2h_tkeep;
    wire   [`KEEP_WIDTH-1:0]    s1_axis_c2h_tuser;
    wire   s1_axis_c2h_tlast;
    wire   s1_axis_c2h_tvalid;
	wire   m1_axis_h2c_tready;
    wire   [`DATA_WIDTH-1:0]    m1_axis_h2c_tdata;
    wire   [`KEEP_WIDTH-1:0]    m1_axis_h2c_tkeep;
    wire   [`KEEP_WIDTH-1:0]    m1_axis_h2c_tuser;
    wire   m1_axis_h2c_tlast;
    wire   m1_axis_h2c_tvalid;
`endif
`ifdef AXI4_BUS0_EN
	//---Write Address Interface---
	wire  m_axi_awready;
	wire  [3:0] m_axi_awid;
	wire  [63:0] m_axi_awaddr;
	wire  [7:0] m_axi_awlen;
	wire  [2:0] m_axi_awsize;
	wire  [1:0] m_axi_awburst;
	wire  [2:0] m_axi_awprot;
	wire  m_axi_awvalid;
	wire  m_axi_awlock;
	wire  [3:0] m_axi_awcache;
	//---Write Interface---
	wire  [63:0] m_axi_wdata;
	wire  [7:0] m_axi_wstrb;
	wire  m_axi_wready;
	wire  m_axi_wlast;
	wire  m_axi_wvalid;
	//---Write Response Interface---
	wire  [3:0] m_axi_bid;
	wire  [1:0] m_axi_bresp;
	wire  m_axi_bvalid;
	wire  m_axi_bready;
	//---Read Address Interface---
	wire  m_axi_arready;
	wire  [3:0] m_axi_arid;
	wire  [63:0] m_axi_araddr;
	wire  [7:0] m_axi_arlen;
	wire  [2:0] m_axi_arsize;
	wire  [1:0] m_axi_arburst;
	wire  [2:0] m_axi_arprot;
	wire  m_axi_arvalid;
	wire  m_axi_arlock;
	wire  [3:0] m_axi_arcache;
	//---Read Interface---
	wire  [3:0] m_axi_rid;
	wire  [63:0] m_axi_rdata;
	wire  [1:0] m_axi_rresp;
	wire  m_axi_rlast;
	wire  m_axi_rvalid;
	wire  m_axi_rready;
	
`endif
`ifdef USR_IRQ_EN
	wire  [`DMA_USR_IRQ-1:0] usr_irq_req;
	wire  [`DMA_USR_IRQ-1:0] usr_irq_ack;
	wire  msi_enable;
	wire  [2:0] msi_vector_width;
`endif
`ifdef AXIL_MBUS0_EN
	wire 	[31:0] m_axil_awaddr;
	wire 	[2:0]  m_axil_awprot;	
	wire 	m_axil_awvalid;	
	wire 	m_axil_awready;	
	wire 	[31:0] m_axil_wdata;	
	wire 	[3:0]  m_axil_wstrb;	
	wire 	m_axil_wvalid;	
	wire 	m_axil_wready;	
	wire 	m_axil_bvalid;	
	wire 	[1:0]  m_axil_bresp;	
	wire 	m_axil_bready;	
	wire 	[31:0] m_axil_araddr;	
	wire 	[2:0]  m_axil_arprot;	
	wire 	m_axil_arvalid;	
	wire 	m_axil_arready;	
	wire 	[31:0] m_axil_rdata;	
	wire 	[1:0]  m_axil_rresp;	
	wire 	m_axil_rvalid;		
	wire 	m_axil_rready;
`endif	
`ifdef AXIL_SBUS0_EN
	wire  [31:0] s_axil_awaddr;
	wire  [2:0] s_axil_awprot;
	wire  s_axil_awvalid;	
	wire  s_axil_awready;	
	wire  [31:0] s_axil_wdata;	
	wire  [3:0] s_axil_wstrb;	
	wire  s_axil_wvalid;	
	wire  s_axil_wready;	
	wire  s_axil_bvalid;	
	wire  [1:0] s_axil_bresp;	
	wire  s_axil_bready;	
	wire  [31:0] s_axil_araddr;	
	wire  [2:0] s_axil_arprot;	
	wire  s_axil_arvalid;	
	wire  s_axil_arready;	
	wire  [31:0] s_axil_rdata;	
	wire  [1:0] s_axil_rresp;	
	wire  s_axil_rvalid;	
	wire  s_axil_rready;
`endif
`ifdef CFG_MGMT_EN
	wire   [18:0] cfg_mgmt_addr;
	wire   cfg_mgmt_write;
	wire   [31:0] cfg_mgmt_write_data;
	wire   [3:0] cfg_mgmt_byte_enable;	
	wire   cfg_mgmt_read;	
	wire   [31:0] cfg_mgmt_read_data;	
	wire   cfg_mgmt_read_write_done;
	wire   cfg_mgmt_type1_cfg_reg_access;
`endif

//wire   app_auxclk;
wire   user_resetn;
//wire   user_lnk_up;
wire   user_clk;
//wire   phy_link_up;
wire  [7:0] dout;
wire  frontwr;
wire  tlast;
wire  [127:0]pcie_data;
wire  pcie_valid;
wire  pcie_start;
wire  pcie_stop;

wire  APB_M_0_clk;
wire  rst_sof_n;
wire  si;
wire   c2h0r_run;
//wire   [31:0]  usr_c2h_len_o;	
//wire   usr_c2h_len_en_o;

//PH1_PHY_GCLK app_auxclk_bufg(.clkin({app_auxclk_in,1'b1}),.clkout(app_auxclk),.cen({1'b0,1'b1}),.seln({1'b0,1'b1}),.drct({1'b0,1'b1}));

sgdma_subsys u_sgdma_subsys(
    .app_auxclk(app_auxclk),
    .app_power_up_rst_n(1'b1),//(app_power_up_rst_n),
    .refclk_p(refclk_p),
    .refclk_n(refclk_n),
    .txp(txp),
    .txn(txn),
    .rxp(rxp),
    .rxn(rxn),
    .user_lnk_up(user_lnk_up),
    .user_clk(user_clk),
    .user_rstn(user_resetn),
    .local_int(1'b0),            
    .ltssm_state(),
                        
`ifdef AXI4_BUS0_EN
	.m_axi_awready(m_axi_awready),
    .m_axi_wready(m_axi_wready),
    .m_axi_bid(m_axi_bid),
    .m_axi_bresp(m_axi_bresp),
    .m_axi_bvalid(m_axi_bvalid),
    .m_axi_arready(m_axi_arready),
    .m_axi_rid(m_axi_rid),
    .m_axi_rdata(m_axi_rdata),
//  .m_axi_ruser(),
    .m_axi_rresp(m_axi_rresp),
    .m_axi_rlast(m_axi_rlast),
    .m_axi_rvalid(m_axi_rvalid),
    .m_axi_awid(m_axi_awid),
    .m_axi_awaddr(m_axi_awaddr),
    .m_axi_awlen(m_axi_awlen),
    .m_axi_awsize(m_axi_awsize),
    .m_axi_awburst(m_axi_awburst),
    .m_axi_awprot(m_axi_awprot),
    .m_axi_awvalid(m_axi_awvalid),
    .m_axi_awlock(m_axi_awlock),
    .m_axi_awcache(m_axi_awcache),
    .m_axi_wdata(m_axi_wdata),
//  .m_axi_wuser(),
    .m_axi_wstrb(m_axi_wstrb),
    .m_axi_wlast(m_axi_wlast),
    .m_axi_wvalid(m_axi_wvalid),
    .m_axi_bready(m_axi_bready),
    .m_axi_arid(m_axi_arid),
    .m_axi_araddr(m_axi_araddr),
    .m_axi_arlen(m_axi_arlen),
    .m_axi_arsize(m_axi_arsize),
    .m_axi_arburst(m_axi_arburst),
    .m_axi_arprot(m_axi_arprot),
    .m_axi_arvalid(m_axi_arvalid),
    .m_axi_arlock(m_axi_arlock),
    .m_axi_arcache(m_axi_arcache),
    .m_axi_rready(m_axi_rready),
`endif
`ifdef AXIL_MBUS0_EN	
	//---axi-lite---
	.m_axil_awaddr(m_axil_awaddr),
//  .m_axil_awuser(),
    .m_axil_awprot(m_axil_awprot),
    .m_axil_awvalid(m_axil_awvalid),
    .m_axil_awready(m_axil_awready),
    .m_axil_wdata(m_axil_wdata),
    .m_axil_wstrb(m_axil_wstrb),
    .m_axil_wvalid(m_axil_wvalid),
    .m_axil_wready(m_axil_wready),
    .m_axil_bvalid(m_axil_bvalid),
    .m_axil_bresp(m_axil_bresp),
    .m_axil_bready(m_axil_bready),
    .m_axil_araddr(m_axil_araddr),
//  .m_axil_aruser(),
    .m_axil_arprot(m_axil_arprot),
    .m_axil_arvalid(m_axil_arvalid),
    .m_axil_arready(m_axil_arready),
    .m_axil_rdata(m_axil_rdata),
    .m_axil_rresp(m_axil_rresp),
    .m_axil_rvalid(m_axil_rvalid),
    .m_axil_rready(m_axil_rready),
`endif	
`ifdef AXIL_SBUS0_EN
	.s_axil_awaddr(s_axil_awaddr),
    .s_axil_awprot(s_axil_awprot),
    .s_axil_awvalid(s_axil_awvalid),
    .s_axil_awready(s_axil_awready),
    .s_axil_wdata(s_axil_wdata),
    .s_axil_wstrb(s_axil_wstrb),
    .s_axil_wvalid(s_axil_wvalid),
    .s_axil_wready(s_axil_wready),
    .s_axil_bvalid(s_axil_bvalid),
    .s_axil_bresp(s_axil_bresp),
    .s_axil_bready(s_axil_bready),
    .s_axil_araddr(s_axil_araddr),
    .s_axil_arprot(s_axil_arprot),
    .s_axil_arvalid(s_axil_arvalid),
    .s_axil_arready(s_axil_arready),
    .s_axil_rdata(s_axil_rdata),
    .s_axil_rresp(s_axil_rresp),
    .s_axil_rvalid(s_axil_rvalid),
    .s_axil_rready(s_axil_rready),
`endif
	//---2路axistream---
`ifdef AXIS_BUS0_EN	
  	.s0_axis_c2h_rst(s0_axis_c2h_rst),
    .m0_axis_h2c_rst(m0_axis_h2c_rst),
    .s0_axis_c2h_run(s0_axis_c2h_run),
    .m0_axis_h2c_run(m0_axis_h2c_run),   
      
	.s0_axis_c2h_tdata(s0_axis_c2h_tdata),
    .s0_axis_c2h_tlast(s0_axis_c2h_tlast),
    .s0_axis_c2h_tvalid(s0_axis_c2h_tvalid),
    .s0_axis_c2h_tready(s0_axis_c2h_tready),
    .s0_axis_c2h_tuser(s0_axis_c2h_tuser),
    .s0_axis_c2h_tkeep(s0_axis_c2h_tkeep),
    .m0_axis_h2c_tdata(m0_axis_h2c_tdata),
    .m0_axis_h2c_tlast(m0_axis_h2c_tlast),
    .m0_axis_h2c_tvalid(m0_axis_h2c_tvalid),
    .m0_axis_h2c_tready(m0_axis_h2c_tready),
    .m0_axis_h2c_tuser(m0_axis_h2c_tuser),
    .m0_axis_h2c_tkeep(m0_axis_h2c_tkeep),
`endif	
`ifdef AXIS_BUS1_EN
    .s1_axis_c2h_tdata(s1_axis_c2h_tdata),
    .s1_axis_c2h_tlast(s1_axis_c2h_tlast),
    .s1_axis_c2h_tvalid(s1_axis_c2h_tvalid),
    .s1_axis_c2h_tready(s1_axis_c2h_tready),
    .s1_axis_c2h_tuser(s1_axis_c2h_tuser),
    .s1_axis_c2h_tkeep(s1_axis_c2h_tkeep),
    .m1_axis_h2c_tdata(m1_axis_h2c_tdata),
    .m1_axis_h2c_tlast(m1_axis_h2c_tlast),
    .m1_axis_h2c_tvalid(m1_axis_h2c_tvalid),
    .m1_axis_h2c_tready(m1_axis_h2c_tready),
    .m1_axis_h2c_tuser(m1_axis_h2c_tuser),
    .m1_axis_h2c_tkeep(m1_axis_h2c_tkeep),
`endif	    
`ifdef USR_IRQ_EN	
	//---usr-irq->msi---
    .usr_irq_req(usr_irq_req),
//  .usr_irq_function_number(4'd0),
    .usr_irq_ack(usr_irq_ack),
    .msi_enable(msi_enable),
//  .msix_enable(),
    .msi_vector_width(msi_vector_width),	
`endif	
`ifdef CFG_MGMT_EN
	//---cfg_mgmt->dbi---
    .cfg_mgmt_addr(cfg_mgmt_addr),
    .cfg_mgmt_write(cfg_mgmt_write),
    .cfg_mgmt_write_data(cfg_mgmt_write_data),
    .cfg_mgmt_byte_enable(cfg_mgmt_byte_enable),
    .cfg_mgmt_read(cfg_mgmt_read),
    .cfg_mgmt_read_data(cfg_mgmt_read_data),
    .cfg_mgmt_read_write_done(cfg_mgmt_read_write_done),
    .cfg_mgmt_type1_cfg_reg_access(cfg_mgmt_type1_cfg_reg_access),
`endif	
    
    //---test led
    .core_clk_led(core_clk_led)    
	//.app_auxclk_led(app_auxclk_led),  
	//.cr_clk_led(cr_clk_led)       
);    	
 



 

wire    [31:0]   bram_di;
wire    [19:0]   bram_wraddr;
wire   bram_wren;
sgdma_app u_sgdma_app(
	.usr_rst_n(user_resetn),
	.usr_clk(user_clk),
//        .led0(led0),  
        .pcie_data               ( pcie_data             ),
    	.pcie_valid              ( pcie_valid            ),
    .pcie_start              ( pcie_start            ),
    .pcie_stop               ( pcie_stop             ),
	.c2h0r_run               ( c2h0r_run             ),
    .bram_di(bram_di),
    .bram_wraddr(bram_wraddr),
    .bram_wren(bram_wren),
    
`ifdef DEBUG_MODE 
    .c2h_fm_idt(c2h_fm_idt),	
    .h2c_fm_odt(h2c_fm_odt),
`endif
`ifdef AXIS_BUS0_EN
	.m0_axis_h2c_tready(m0_axis_h2c_tready),
    .m0_axis_h2c_tdata(m0_axis_h2c_tdata),
    .m0_axis_h2c_tkeep(m0_axis_h2c_tkeep),
    .m0_axis_h2c_tuser(m0_axis_h2c_tuser),
    .m0_axis_h2c_tlast(m0_axis_h2c_tlast),
    .m0_axis_h2c_tvalid(m0_axis_h2c_tvalid),	
      	
    .s0_axis_c2h_rst(s0_axis_c2h_rst),
    .m0_axis_h2c_rst(m0_axis_h2c_rst),
    .s0_axis_c2h_run(s0_axis_c2h_run),
    .m0_axis_h2c_run(m0_axis_h2c_run),
    
	.s0_axis_c2h_tready(s0_axis_c2h_tready),
    .s0_axis_c2h_tdata(s0_axis_c2h_tdata),
    .s0_axis_c2h_tkeep(s0_axis_c2h_tkeep),
    .s0_axis_c2h_tuser(s0_axis_c2h_tuser),
    .s0_axis_c2h_tlast(s0_axis_c2h_tlast),
    .s0_axis_c2h_tvalid(s0_axis_c2h_tvalid),
`endif    

`ifdef AXIS_BUS1_EN
	.s1_axis_c2h_tready(s1_axis_c2h_tready),
    .s1_axis_c2h_tdata(s1_axis_c2h_tdata),
    .s1_axis_c2h_tkeep(s1_axis_c2h_tkeep),
    .s1_axis_c2h_tuser(s1_axis_c2h_tuser),
    .s1_axis_c2h_tlast(s1_axis_c2h_tlast),
    .s1_axis_c2h_tvalid(s1_axis_c2h_tvalid),
	.m1_axis_h2c_tready(m1_axis_h2c_tready),
    .m1_axis_h2c_tdata(m1_axis_h2c_tdata),
    .m1_axis_h2c_tkeep(m1_axis_h2c_tkeep),
    .m1_axis_h2c_tuser(m1_axis_h2c_tuser),
    .m1_axis_h2c_tlast(m1_axis_h2c_tlast),
    .m1_axis_h2c_tvalid(m1_axis_h2c_tvalid),
`endif
`ifdef AXI4_BUS0_EN
	.m_axi_awready(m_axi_awready),
	.m_axi_wready(m_axi_wready),
	.m_axi_bid(m_axi_bid),
	.m_axi_bresp(m_axi_bresp),
	.m_axi_bvalid(m_axi_bvalid),
	.m_axi_arready(m_axi_arready),
	.m_axi_rid(m_axi_rid),
	.m_axi_rdata(m_axi_rdata),
	.m_axi_rresp(m_axi_rresp),
	.m_axi_rlast(m_axi_rlast),
	.m_axi_rvalid(m_axi_rvalid),
	.m_axi_awid(m_axi_awid),
//	.m_axi_awid(m_axi_awid),
//	.m_axi_awid(m_axi_awid),
	.m_axi_awaddr(m_axi_awaddr),
	.m_axi_awlen(m_axi_awlen),
	.m_axi_awsize(m_axi_awsize),
	.m_axi_awburst(m_axi_awburst),
	.m_axi_awprot(m_axi_awprot),
	.m_axi_awvalid(m_axi_awvalid),
	.m_axi_awlock(m_axi_awlock),
	.m_axi_awcache(m_axi_awcache),
	.m_axi_wdata(m_axi_wdata),
	.m_axi_wstrb(m_axi_wstrb),
	.m_axi_wlast(m_axi_wlast),
	.m_axi_wvalid(m_axi_wvalid),
	.m_axi_bready(m_axi_bready),
	.m_axi_arid(m_axi_arid),
	.m_axi_araddr(m_axi_araddr),
	.m_axi_arlen(m_axi_arlen),
	.m_axi_arsize(m_axi_arsize),
	.m_axi_arburst(m_axi_arburst),
	.m_axi_arprot(m_axi_arprot),
	.m_axi_arvalid(m_axi_arvalid),
	.m_axi_arlock(m_axi_arlock),
	.m_axi_arcache(m_axi_arcache),
	.m_axi_rready(m_axi_rready),
`endif	

`ifdef CFG_MGMT_EN 
	.cfg_mgmt_addr(cfg_mgmt_addr),
	.cfg_mgmt_write(cfg_mgmt_write),
	.cfg_mgmt_write_data(cfg_mgmt_write_data),
	.cfg_mgmt_byte_enable(cfg_mgmt_byte_enable),	
	.cfg_mgmt_read(cfg_mgmt_read),	
	.cfg_mgmt_read_data(cfg_mgmt_read_data),	
	.cfg_mgmt_read_write_done(cfg_mgmt_read_write_done),
	.cfg_mgmt_type1_cfg_reg_access(cfg_mgmt_type1_cfg_reg_access),
`endif
`ifdef USR_IRQ_EN
	.usr_irq_req(usr_irq_req),
	.usr_irq_ack(usr_irq_ack),
	.msi_enable(msi_enable),
	.msi_vector_width(msi_vector_width),
`endif
`ifdef AXIL_MBUS0_EN
	.m_axil_awaddr(m_axil_awaddr),
	.m_axil_awprot(m_axil_awprot),	
	.m_axil_awvalid(m_axil_awvalid),		
	.m_axil_awready(m_axil_awready),		
	.m_axil_wdata(m_axil_wdata),	
	.m_axil_wstrb(m_axil_wstrb),	
	.m_axil_wvalid(m_axil_wvalid),		
	.m_axil_wready(m_axil_wready),	
	.m_axil_bvalid(m_axil_bvalid),	
	.m_axil_bresp(m_axil_bresp),	
	.m_axil_bready(m_axil_bready),	
	.m_axil_araddr(m_axil_araddr),	
	.m_axil_arprot(m_axil_arprot),	
	.m_axil_arvalid(m_axil_arvalid),		
	.m_axil_arready(m_axil_arready),	
	.m_axil_rdata(m_axil_rdata),	
	.m_axil_rresp(m_axil_rresp),	
	.m_axil_rvalid(m_axil_rvalid),		
	.m_axil_rready(m_axil_rready)
`endif
`ifdef AXIL_SBUS0_EN	
	,.s_axil_awaddr(s_axil_awaddr),
	.s_axil_awprot(s_axil_awprot),
	.s_axil_awvalid(s_axil_awvalid),		
	.s_axil_awready(s_axil_awready),		
	.s_axil_wdata(s_axil_wdata),	
	.s_axil_wstrb(s_axil_wstrb),	
	.s_axil_wvalid(s_axil_wvalid),		
	.s_axil_wready(s_axil_wready),	
	.s_axil_bvalid(s_axil_bvalid),	
	.s_axil_bresp(s_axil_bresp),	
	.s_axil_bready(s_axil_bready),	
	.s_axil_araddr(s_axil_araddr),	
	.s_axil_arprot(s_axil_arprot),	
	.s_axil_arvalid(s_axil_arvalid),		
	.s_axil_arready(s_axil_arready),	
	.s_axil_rdata(s_axil_rdata),	
	.s_axil_rresp(s_axil_rresp),	
	.s_axil_rvalid(s_axil_rvalid),	
	.s_axil_rready(s_axil_rready)
`endif	
//	,.pcie_cfg_test_o()
);
wire cl_test;
wire [15:0] st_sp;
wire [31:0] adc1_cfg_dat;
wire        en_adc1_cfg;
wire [31:0] sp_time; 
wire        dpi_mode;
wire        rgb_en;
wire [15 : 0] red_times1;
wire [15 : 0] green_times1;
wire [15 : 0] blue_times1;
wire color_en;
python uut(
	.clkin(app_auxclk),
	.in1(in1),
	.in2(in2),
	.cisclk1(cisclk1),
	.cisclk2(cisclk2),
	.cisclk3(cisclk3),
	.cisclk4(cisclk4),
	.cisclk5(cisclk5),
	.cisclk6(cisclk6),
	.cism1(cism1),
	.cism2(cism2),
	.cism3(cism3),
	.cism4(cism4),
	.cism5(cism5),
	.cism6(cism6),
	.led1A_b(led1A_b),
	.led1A_g(led1A_g),
	.led1A_r(led1A_r),
	.led1B_b(led1B_b),
	.led1B_g(led1B_g),
	.led1B_r(led1B_r),
	.led2A_b(led2A_b),
	.led2A_g(led2A_g),
	.led2A_r(led2A_r),
	.led2B_b(led2B_b),
	.led2B_g(led2B_g),
	.led2B_r(led2B_r),
	.mclk1(mclk1),
	.mclk2(mclk2),
	.rsmp1(rsmp1),
	.rsmp2(rsmp2),
	.si1(si1),
	.si2(si2),
	.si3(si3),
	.si4(si4),
	.si5(si5),
	.si6(si6),
	.vsmp1(vsmp1),
	.vsmp2(vsmp2),
    .SCK1(SCK1),
    .SEN1(SEN1),
    .SDI1(SDI1),
    .ubus_rx(ubus_rx),
    .ubus_tx(ubus_tx),
    .data_out(dout),
    .frontwr(frontwr),
    .tlast(tlast),
    .APB_M_0_clk             ( APB_M_0_clk           ),
    .rst_sof_n               ( rst_sof_n             ),
    .clk_cis(clk_cis),
    .si                      ( si                    ),
    .cl_test(cl_test),
    .st_sp(st_sp),
    .en_adc1_cfg(en_adc1_cfg),
    .adc1_cfg_dat(adc1_cfg_dat),
    .dpi_mode(dpi_mode),
	.sp_time(sp_time),
    .rgb_en(rgb_en),
    .red_times1(red_times1),
    .green_times1(green_times1),
    .blue_times1(blue_times1),
    .color_en(color_en) 
    
); 

swith u_swith (
    .APB_M_0_clk             ( APB_M_0_clk           ),
    .rst_sof_n               ( rst_sof_n             ),
    .user_clk                ( user_clk              ),
    .user_resetn             ( user_resetn           ),
    .dout                    ( dout                  ),
    .frontwr                  ( frontwr                ),
    .tlast                   ( tlast                 ),
    .m_axil_wdata            ( m_axil_wdata          ),
    .si                      ( si                    ),
    .pcie_data               ( pcie_data             ),
    .pcie_valid              ( pcie_valid            ),
    .pcie_start              ( pcie_start            ),
	.c2h0r_run              ( c2h0r_run            ),
    .pcie_stop               ( pcie_stop             ),
	.s0_axis_c2h_rst(s0_axis_c2h_rst),
    .led0(led0),
        .led1A_r(led1A_r)
);

reg_config u_reg_config( 
   	.usr_clk(user_clk),
	.usr_rst_n(user_resetn),
    .cl_test(cl_test),
    .st_sp(st_sp),
    .en_adc_cfg(en_adc1_cfg),
    .adc_cfg_data(adc1_cfg_dat),
//    .led0(led0),
    .bram_di(bram_di),
    .bram_wraddr(bram_wraddr),
    .bram_wren(bram_wren),
    .dpi_mode(dpi_mode),
    .sp_time(sp_time),
    .rgb_en(rgb_en),
    .red_times1(red_times1),
    .green_times1(green_times1),
    .blue_times1(blue_times1),
    .color_en(color_en)

);
endmodule 
