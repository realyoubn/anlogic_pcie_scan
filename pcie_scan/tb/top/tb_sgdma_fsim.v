
`timescale 1ns/1ps

`include "dt_para.vh"
`include "tlp_fmt_type.vh"
module tb_sgdma_fsim();
	

	parameter CLK_HALF_PERIOD = 5;
	parameter CLK_HALF_PERIOD2= 10;
	parameter CLK_HALF_PERIOD3= 8;
	parameter RESET_CYCLES = 20;
	
	reg           clk;
	reg           clk2;
	reg           clk3;
	reg           rst_n;
	wire          ep_core_clk;
	wire          rc_core_clk;	
	wire          rc_core_rstn;
	wire          refclk_p ;
	wire          refclk_n ;
	wire  [3:0]   txp ;
	wire  [3:0]   txn ;
	wire  [3:0]   rxp ;
	wire  [3:0]   rxn ;
	wire          app_auxclk;
	wire          app_button_rst_n;

//	wire          rc_dbi_en;
	wire  [31:0]  ep_drp_dbi_dout ;
	wire          ep_drp_dbi_ack ;
	wire  [31:0]  ep_drp_dbi_din ;
	wire  [3:0]   ep_drp_dbi_wr ;
	wire  [31:0]  ep_drp_dbi_addr ;
	wire          ep_drp_dbi_cs ;
	wire          ep_drp_dbi_cs2_exp ;
	wire  [1:0]   ep_drp_dbi_vfunc_num ;
	wire          ep_drp_dbi_vfunc_active ;
	wire  [2:0]   ep_drp_dbi_bar_num ;
	wire          ep_drp_dbi_rom_access ;
	wire          ep_drp_dbi_io_access ;
	wire          ep_drp_dbi_func_num ;
	wire          ep_drp_app_dbi_ro_wr_disable ;
	
	wire            rc_drp_dbi_cs;
	wire  [31:0]    rc_drp_dbi_addr;
	wire  [3:0]     rc_drp_dbi_wr;
	wire  [31:0]    rc_drp_dbi_din;
    wire            rc_drp_dbi_cs2_exp;
	wire  [31:0]    rc_drp_dbi_dout;
	wire            rc_drp_dbi_ack;
	wire            rc_drp_app_dbi_ro_wr_disable;
	wire  [1:0]     rc_drp_dbi_vfunc_num;
	wire  [2:0]     rc_drp_dbi_bar_num;


	wire  op_start_init;
	wire                  mw_en;
	wire   [`DT_WD-1:0]   mw_addr;
	wire   [11:0]         mw_len;
	wire   [`DT_WD-1:0]   mw_data;
	wire   [7:0]    mw_data_be;
	wire            mw_data_en;
	wire            mw_op_over;
	wire            mr_en;
	wire   [`DT_WD-1:0]   mr_addr;
	wire   [11:0]         mr_len;
	wire   [7:0]          mr_data_be;
	wire  [`DT_WD-1:0]    mr_data;
	wire            mr_data_vld;
	wire            mr_op_over;

	wire  op_start_regrw; 
	wire            cfg0w_en;
	wire   [31:0]   cfg0w_addr;
	wire   [31:0]   cfg0w_data;
	wire            cfg0w_op_over;

	wire            cfg0r_en;
	wire   [31:0]   cfg0r_addr;
	wire  [31:0]    cfg0r_data;
	wire            cfg0r_data_vld;
	wire            cfg0r_op_over;

	wire            msi_detected ;
    wire  [31:0]    msi_ctrl_clear;
    wire            msi_ctrl_int ;
    wire [31:0]     msi_ctrl_int_vec ;


	wire            op_start;
	wire   init_cfg_over;
 	wire   h2c_rstn;

 	wire   [32*`CFG_NUM-1:0]    cfg_idt;
	wire   [32*`CFG_NUM-1:0]    cfg_oaddr;
	wire   [32*`CFG_NUM-1:0]    cfg_odt;
 	wire   [`DT_WD*`IDT_NUM-1:0]    h2c_fm_idt;
 	wire   [`DT_WD*`IDT_NUM-1:0]    c2h_fm_idt;
//	wire   [`DT_WD*`AXI4S_NUM-1:0]  axi4s_idt;
	wire   [32*`PMODE_NUM-1:0]      h2c_pmode_idt;
	wire   [32*`PMODE_NUM-1:0]      c2h_pmode_idt;
	wire   [32*`INT_NUM-1:0]        int_idt;
	wire   [`DT_WD*`ODT_NUM-1:0]    h2c_fm_odt;
	wire   [`DT_WD*`ODT_NUM-1:0]    c2h_fm_odt;
	wire   [`DT_WD*`WDSCP_NUM-1:0]  wdscp_odt;
	wire   [`DT_WD*`RDSCP_NUM-1:0]  rdscp_odt;
//	wire   [16*`LEN_NUM-1:0]        len_odt;

//	wire   [31:0] 			cnt_rdscp0_ring;
//	wire   [31:0]			cnt_rdscp0;
//	wire   [15:0]                   log_rdaddr;
//	wire   [`DT_WD*`IDT_NUM-1:0]    h2c_ofm_golden;
PH1_PHY_GSR PH1_PHY_GSR();
glbl glbl();


sgdma_rc_exam u_rc_exam (
	.app_auxclk                (app_auxclk                ),
	.app_button_rst_n            (app_button_rst_n            ),
	.refclk_p                    (refclk_p                    ),
	.refclk_n                    (refclk_n                    ),
	.txp                         (txp                         ),
	.txn                         (txn                         ),
	.rxp                         (rxp                         ),
	.rxn                         (rxn                         ),

	.core_clk_c                  (rc_core_clk                 ),
	.core_rst_n_c                (rc_core_rstn               ),
	.op_start                    (op_start                    ),

	.mw_en                       (mw_en                       ),
	.mr_en                       (mr_en                       ),	
	.mw_addr                     (mw_addr                     ),
	.mw_len                      (mw_len                      ),
	.mw_data                     (mw_data                     ),
	.mw_data_be                  (mw_data_be                  ),
	.mw_data_en                  (mw_data_en                  ),
	.mr_addr                     (mr_addr                     ),
	.mr_len                      (mr_len                      ),
	.mr_data_be                  (mr_data_be                  ),
	.mr_data                     (mr_data                     ),
	.mr_data_vld                 (mr_data_vld                 ),
	.mw_op_over                  (mw_op_over                  ),
	.mr_op_over                  (mr_op_over                  ),
	.iow_en                      (1'b0                        ),
	.ior_en                      (1'b0                        ),
	.iow_addr                    (32'd0                    ),
	.iow_data                    (32'd0                    ),
	.ior_addr                    (32'd0                    ),
	.ior_data                    (                         ),
	.ior_data_vld                (                         ),
	.iow_op_over                 (                 ),
	.ior_op_over                 (                 ),

	.cfg0w_en                    (cfg0w_en                    ),
	.cfg0r_en                    (cfg0r_en                    ),
	.cfg0w_addr                  (cfg0w_addr                  ) ,
	.cfg0w_data                  (cfg0w_data                  ) ,
	.cfg0r_addr                  (cfg0r_addr                  ) ,
	.cfg0r_data                  (cfg0r_data                  ) ,
	.cfg0r_data_vld              (cfg0r_data_vld              ) ,
	.cfg0w_op_over               (cfg0w_op_over               ),
	.cfg0r_op_over               (cfg0r_op_over               ),

	.drp_dbi_cs                  (rc_drp_dbi_cs               ),
	.drp_dbi_addr                (rc_drp_dbi_addr             ),
	.drp_dbi_wr                  (rc_drp_dbi_wr               ),
	.drp_dbi_din                 (rc_drp_dbi_din              ),
	.drp_lbc_dbi_dout            (rc_drp_dbi_dout              ),
	.drp_lbc_dbi_ack             (rc_drp_dbi_ack              ),
	.drp_dbi_cs2_exp             (rc_drp_dbi_cs2_exp          ),
	.drp_app_dbi_ro_wr_disable   (rc_drp_app_dbi_ro_wr_disable),

	.h2c_rstn                    (h2c_rstn),
    .msi_detected                (msi_detected),   //output 1bit
	.int_odt                     (int_idt     ),      
	.wdscp_idt                   (wdscp_odt),
	.rdscp_idt                   (rdscp_odt),
	.c2h_fm_odt                  (c2h_fm_idt),//c2h host receive data out to ip_datarw
	.h2c_fm_idt                  (h2c_fm_odt),
//	.axi4s_odt                   (axi4s_idt),
	.h2c_pmode_odt               (h2c_pmode_idt),
	.c2h_pmode_odt               (c2h_pmode_idt)
	
);

wire   user_lnk_up;
wire   core_clk_led;
sgdma_subsys_exam u_subsys_exam(
	.app_auxclk_in(app_auxclk),
	.data_tx_en_button_n(app_button_rst_n),
`ifdef DEBUG_MODE
    .c2h_fm_idt(c2h_fm_odt),
    .h2c_fm_odt(h2c_fm_idt),    
`endif  
	.refclk_p(refclk_p),
	.refclk_n(refclk_n),
	.txp(rxp),
	.txn(rxn),
	.rxp(txp),
	.rxn(txn),
    
	.user_lnk_up(user_lnk_up),			  
    .core_clk_led(core_clk_led)
);




ip_cfginit ip_cfginit(
	.rst_n(rst_n),	
	.clk(clk),
/*
	.ep_core_clk(ep_core_clk),
	.ep_drp_dbi_dout(ep_drp_dbi_dout),
    .ep_drp_dbi_ack(ep_drp_dbi_ack),
    .ep_drp_dbi_din(ep_drp_dbi_din),
    .ep_drp_dbi_wr(ep_drp_dbi_wr),
    .ep_drp_dbi_addr(ep_drp_dbi_addr),
    .ep_drp_dbi_cs(ep_drp_dbi_cs),
    .ep_drp_dbi_cs2_exp(ep_drp_dbi_cs2_exp),
    .ep_drp_dbi_vfunc_num(ep_drp_dbi_vfunc_num),
    .ep_drp_dbi_vfunc_active(ep_drp_dbi_vfunc_active),
    .ep_drp_dbi_bar_num(ep_drp_dbi_bar_num),
    .ep_drp_dbi_rom_access(ep_drp_dbi_rom_access),
    .ep_drp_dbi_io_access(ep_drp_dbi_io_access),
    .ep_drp_dbi_func_num(ep_drp_dbi_func_num),
    .ep_drp_app_dbi_ro_wr_disable(ep_drp_app_dbi_ro_wr_disable),
*/
//	.rc_dbi_en(rc_dbi_en),
	.rc_core_clk(rc_core_clk),
	.rc_drp_dbi_dout(rc_drp_dbi_dout),
    .rc_drp_dbi_ack(rc_drp_dbi_ack),
    .rc_drp_dbi_din(rc_drp_dbi_din),
    .rc_drp_dbi_wr(rc_drp_dbi_wr),
    .rc_drp_dbi_addr(rc_drp_dbi_addr),
    .rc_drp_dbi_cs(rc_drp_dbi_cs),
    .rc_drp_dbi_cs2_exp(rc_drp_dbi_cs2_exp),
    .rc_drp_dbi_vfunc_num(rc_drp_dbi_vfunc_num),
    .rc_drp_dbi_vfunc_active(rc_drp_dbi_vfunc_active),
    .rc_drp_dbi_bar_num(rc_drp_dbi_bar_num),
    .rc_drp_dbi_rom_access(rc_drp_dbi_rom_access),
    .rc_drp_dbi_io_access(rc_drp_dbi_io_access),
    .rc_drp_dbi_func_num(rc_drp_dbi_func_num),
    .rc_drp_app_dbi_ro_wr_disable(rc_drp_app_dbi_ro_wr_disable),

	.cfg0r_en(cfg0r_en),
	.cfg0w_en(cfg0w_en),
	.cfg0w_op_over(cfg0w_op_over),
	.cfg0r_op_over(cfg0r_op_over),
	.cfg0w_addr(cfg0w_addr),
	.cfg0w_data(cfg0w_data),
	.cfg0r_addr(cfg0r_addr),
	.cfg0r_data(cfg0r_data),
	.cfg0r_data_vld(cfg0r_data_vld),

	.op_start(op_start_init),
	.init_cfg_over(init_cfg_over)
);

ip_regrw u_ip_regrw(
/*    .client1_data_i             ( client1_data_out          ),
    .xd_tlp_rdyp_i              ( xd_tlp_rdyp_out           ),
    .radm_bypass_data_i         ( radm_bypass_data_out      ),
    .rdscp0_eot_i               ( rdscp0_eot_out            ),*/
	.rc_core_clk(rc_core_clk),
	.rc_core_rstn(rc_core_rstn),
	.clk(clk),

	.cfg_odt(cfg_idt),
	.cfg_iaddr(cfg_oaddr),
	.cfg_idt(cfg_odt),

	.msi_detected(msi_detected), 
	.init_cfg_over(init_cfg_over),

	.mw_en(mw_en),
	.mr_en(mr_en),
	.mw_addr(mw_addr),
	.mw_len(mw_len),
	.mw_data(mw_data),
	.mw_data_be(mw_data_be),
	.mw_data_en(mw_data_en),
	
	.mr_addr(mr_addr),
	.mr_len(mr_len),
	.mr_data_be(mr_data_be),
	.mr_data(mr_data),
	.mr_data_vld(mr_data_vld),
	.mw_op_over(mw_op_over),
	.mr_op_over(mr_op_over),

	.casen_test_done(casen_test_done),
//	.mwr_err_num(mwr_err_num),
	.op_start(op_start_regrw),
	.h2c_rstn(h2c_rstn)
//	.cnt_rdscp0_ring_i(cnt_rdscp0_ring),
//	.cnt_rdscp0_i(cnt_rdscp0),
//	.log_rdaddr_i(log_rdaddr)
);
assign op_start = init_cfg_over ? op_start_regrw : op_start_init;

ip_datarw u_ip_datarw(
	.cfg_idt(cfg_idt),
	.h2c_fm_idt(h2c_fm_idt),
	.c2h_fm_idt(c2h_fm_idt),
//	.axi4s_idt(axi4s_idt),
	.h2c_pmode_idt(h2c_pmode_idt),
	.c2h_pmode_idt(c2h_pmode_idt),
	.int_idt(int_idt),

	.casen_test_done(casen_test_done),

	.cfg_oaddr(cfg_oaddr),
	.cfg_odt(cfg_odt),
	.c2h_fm_odt(c2h_fm_odt),
	.h2c_fm_odt(h2c_fm_odt),
	.wdscp_odt(wdscp_odt),
	.rdscp_odt(rdscp_odt)
//	.len_odt(len_odt)
);


initial begin
    clk = 1'b0;
    forever #CLK_HALF_PERIOD clk = ~clk;
end
initial begin
    clk2 = 1'b0;
    forever #CLK_HALF_PERIOD2 clk2 = ~clk2;
end
initial begin
    clk3 = 1'b0;
    forever #CLK_HALF_PERIOD3 clk3 = ~clk3;
end
assign app_auxclk = clk2;
assign app_button_rst_n = rst_n;
assign refclk_p = clk;
assign refclk_n = ~clk;


initial 
begin
	rst_n = 1'b0;
	#((CLK_HALF_PERIOD*2)*RESET_CYCLES);
	rst_n = 1'b1;
end

`ifdef FSDB_ON 
	initial 
	begin
	`ifdef CASE0 
	    $fsdbDumpfile("./case0/tb_sgdma_fsim.fsdb"); 
	`elsif CASE1 
	    $fsdbDumpfile("./case1/tb_sgdma_fsim.fsdb"); 
    `elsif CASE2
	    $fsdbDumpfile("./case2/tb_sgdma_fsim.fsdb"); 
	`elsif CASE3 
	    $fsdbDumpfile("./case3/tb_sgdma_fsim.fsdb"); 
	`elsif CASE4 
	    $fsdbDumpfile("./case4/tb_sgdma_fsim.fsdb"); 
	`elsif CASE5
	    $fsdbDumpfile("./case5/tb_sgdma_fsim.fsdb"); 
	`elsif CASE6
	    $fsdbDumpfile("./case6/tb_sgdma_fsim.fsdb"); 
	`elsif CASE7
	    $fsdbDumpfile("./case7/tb_sgdma_fsim.fsdb"); 
	`elsif CASE9
	    $fsdbDumpfile("./case9/tb_sgdma_fsim.fsdb"); 
	`elsif CASE11
	    $fsdbDumpfile("./case11/tb_sgdma_fsim.fsdb"); 
    `elsif CASE12
	    $fsdbDumpfile("./case12/tb_sgdma_fsim.fsdb"); 
    `elsif CASE13
	    $fsdbDumpfile("./case13/tb_sgdma_fsim.fsdb"); 
    `elsif CASE18
	    $fsdbDumpfile("./case18/tb_sgdma_fsim.fsdb"); 
    `elsif CASE19
	    $fsdbDumpfile("./case19/tb_sgdma_fsim.fsdb"); 
    `elsif CASE41
	    $fsdbDumpfile("./case41/tb_sgdma_fsim.fsdb");
	`endif
	
		$fsdbDumpvars(0, tb_sgdma_fsim);
/*		$fsdbDumpMDA(2,u_ip_datarw.h2c_fm_idt_x);
		$fsdbDumpMDA(2,u_ip_datarw.cfg_idt_x);
		$fsdbDumpMDA(2,u_ip_datarw.len_odt_x);
		$fsdbDumpMDA(2,u_ip_datarw.wdscp_odt_x);
		$fsdbDumpMDA(2,u_ip_datarw.rdscp_odt_x);
		$fsdbDumpMDA(2,u_ep_bfm.u_sgdma_app.u_usr_h2c0w.log_reg);
		$fsdbDumpMDA(2,u_ep_bfm.u_sgdma_app.u_usr_h2c0w.fm_odt_x);*/
	end
`endif

endmodule
