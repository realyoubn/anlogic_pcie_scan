`timescale 1ns/1ps


module ip_cfginit(
	input   rst_n,
	input   clk,
/*	
	input   ep_core_clk,
	input [31:0]    ep_drp_dbi_dout,
    input           ep_drp_dbi_ack,
    output [31:0]   ep_drp_dbi_din,
    output [3:0]    ep_drp_dbi_wr,
    output [31:0]   ep_drp_dbi_addr,
    output          ep_drp_dbi_cs,
    output          ep_drp_dbi_cs2_exp,
    output [1:0]    ep_drp_dbi_vfunc_num,
    output          ep_drp_dbi_vfunc_active,
    output [2:0]    ep_drp_dbi_bar_num,
    output          ep_drp_dbi_rom_access,
    output          ep_drp_dbi_io_access,
    output          ep_drp_dbi_func_num,
    output          ep_drp_app_dbi_ro_wr_disable,
*/
	input   rc_core_clk,
	input  [31:0]    rc_drp_dbi_dout,
    input           rc_drp_dbi_ack,
    output [31:0]   rc_drp_dbi_din,
    output [3:0]    rc_drp_dbi_wr,
    output [31:0]   rc_drp_dbi_addr,
    output          rc_drp_dbi_cs,
    output          rc_drp_dbi_cs2_exp,
    output [1:0]    rc_drp_dbi_vfunc_num,
    output          rc_drp_dbi_vfunc_active,
    output [2:0]    rc_drp_dbi_bar_num,
    output          rc_drp_dbi_rom_access,
    output          rc_drp_dbi_io_access,
    output          rc_drp_dbi_func_num,
    output          rc_drp_app_dbi_ro_wr_disable,

    output reg      cfg0w_en,
	input           cfg0w_op_over,
	output reg      [31:0]    cfg0w_addr,
	output reg      [31:0]    cfg0w_data,

	input           cfg0r_op_over,
	output reg      cfg0r_en,
	output reg      [31:0]    cfg0r_addr,
	input  wire     [31:0]    cfg0r_data,
	input  wire     cfg0r_data_vld,

	output reg      op_start,
	output reg      init_cfg_over
);

`include "../def/cfg_addr_table.vh"
`include "../def/bdf.vh"

reg   [31:0]  tmp_rc_dbi_data;
reg   [31:0]  tmp_ep_dbi_data;	

/*
dbi_master_bfm u_dbi_ep(
    .clk                       (ep_core_clk                 ),
    .drp_lbc_dbi_dout          (ep_drp_dbi_dout         ),
    .drp_lbc_dbi_ack           (ep_drp_dbi_ack          ),
    .drp_dbi_din               (ep_drp_dbi_din              ),
    .drp_dbi_wr                (ep_drp_dbi_wr               ),
    .drp_dbi_addr              (ep_drp_dbi_addr             ),
    .drp_dbi_cs                (ep_drp_dbi_cs               ),
    .drp_dbi_cs2_exp           (ep_drp_dbi_cs2_exp          ),
    .drp_dbi_vfunc_num         (ep_drp_dbi_vfunc_num        ),
    .drp_dbi_vfunc_active      (ep_drp_dbi_vfunc_active     ),
    .drp_dbi_bar_num           (ep_drp_dbi_bar_num          ),
    .drp_dbi_rom_access        (ep_drp_dbi_rom_access       ),
    .drp_dbi_io_access         (ep_drp_dbi_io_access        ),
    .drp_dbi_func_num          (ep_drp_dbi_func_num         ),
    .drp_app_dbi_ro_wr_disable (ep_drp_app_dbi_ro_wr_disable)
);
*/

dbi_master_bfm u_dbi_rc(
	.clk                       (rc_core_clk                 ), 
	.drp_lbc_dbi_dout          (rc_drp_dbi_dout              ),
	.drp_lbc_dbi_ack           (rc_drp_dbi_ack              ),
	.drp_dbi_din               (rc_drp_dbi_din              ),
	.drp_dbi_wr                (rc_drp_dbi_wr               ),
	.drp_dbi_addr              (rc_drp_dbi_addr             ),
	.drp_dbi_cs                (rc_drp_dbi_cs               ),
	.drp_dbi_cs2_exp           (rc_drp_dbi_cs2_exp          ),
	.drp_dbi_vfunc_num         (rc_drp_dbi_vfunc_num           ),
	.drp_dbi_vfunc_active      (rc_drp_dbi_vfunc_active),
	.drp_dbi_bar_num           (rc_drp_dbi_bar_num),
	.drp_dbi_rom_access        (rc_drp_dbi_rom_access),
	.drp_dbi_io_access         (rc_drp_dbi_io_access),
	.drp_dbi_func_num          (rc_drp_dbi_func_num),
	.drp_app_dbi_ro_wr_disable (rc_drp_app_dbi_ro_wr_disable)
);

// CFG0 WR
task cfg0w;
	input [31:0] address;
	input [31:0] data;
	
    begin
	@(posedge rc_core_clk);
	cfg0w_en = 1;
	@(posedge rc_core_clk);
	cfg0w_addr = address;
	cfg0w_data = data;
	@(posedge rc_core_clk);
	op_start = 1;
	@(posedge rc_core_clk);
	op_start = 0;
	wait (cfg0w_op_over);
	@(posedge rc_core_clk);
	cfg0w_en = 0;
	@(posedge rc_core_clk);
	end
endtask

// CFG0 RD
task cfg0r;
    input  [31:0] address;
    output [31:0] data;
	
    begin
	@(posedge rc_core_clk);
	cfg0r_en = 1;
	@(posedge rc_core_clk);
	cfg0r_addr = address;
	@(posedge rc_core_clk);
	op_start = 1;
	@(posedge rc_core_clk);
	op_start = 0;
	wait (cfg0r_op_over);
	@(posedge rc_core_clk);
	cfg0r_en = 0;
	data = cfg0r_data;
	@(posedge rc_core_clk);
	end
endtask

task automatic delay;
    input [31:0] dc;//ori[3:0]
    begin
        repeat (dc) @ (posedge clk);
        # 1;
    end
endtask

initial
begin
	tmp_rc_dbi_data = 0;
	tmp_ep_dbi_data = 0;

	force u_subsys_exam.u_sgdma_subsys.u_ep_core.app_app_ltssm_enable = 0;

	cfg0w_en = 0;
	cfg0r_en = 0;
	op_start = 0;	
	cfg0w_addr = 0;
	cfg0w_data = 0;
	cfg0r_addr = 0;
    
	init_cfg_over = 1'b0;
	$display("Debug: PCIe dbi configuration start at time:",$time);
	while (~rst_n) @(posedge rc_core_clk);
	delay (200);

	u_dbi_rc.start_init;
	//u_dbi_ep.start_init;

	u_dbi_rc.open_wr_prot; //写配置空间寄存器之前，先打开写保护
	//u_dbi_ep.open_wr_prot;

    //---Set fase link mode;
    u_dbi_rc.dbi_rd(BASE_ADDR_PF0+ADDR_PF_PORT_LOGIC+PORT_LINK_CTRL_OFF, tmp_rc_dbi_data);
    u_dbi_rc.dbi_wr(BASE_ADDR_PF0+ADDR_PF_PORT_LOGIC+PORT_LINK_CTRL_OFF, {tmp_rc_dbi_data[31:8],1'b1, tmp_rc_dbi_data[6:0]});
    
    $display("Debug: Enable rc bus master at time:",$time);
    //u_dbi_rc.dbi_rd(BASE_ADDR_PF0+ADDR_PF_TYPE0_HDR+RC_ADDR_TYPE1_STATUS_COMMAND_REG, tmp_rc_dbi_data);
    u_dbi_rc.dbi_wr(BASE_ADDR_PF0+ADDR_PF_TYPE0_HDR+RC_ADDR_TYPE1_STATUS_COMMAND_REG,32'h00110007);//{tmp_rc_dbi_data[31:3],3'd7}
    
   	$display("Debug: EP and RC are link up ing ... at time:",$time);
    //wait (rc_R_led1);
    //wait (ep_R_led1);
    release u_subsys_exam.u_sgdma_subsys.u_ep_core.app_app_ltssm_enable;
	wait (u_rc_exam.u_rc_core.rdlh_link_up); //wait here
	wait (u_subsys_exam.u_sgdma_subsys.u_ep_core.rdlh_link_up);
	#20000;// delay for speed changed
   	$display("Debug: EP and RC alreay link up at time:",$time);

    u_dbi_rc.dbi_rd(BASE_ADDR_PF0+ADDR_PF_TYPE0_HDR+RC_ADDR_TYPE1_DEV_ID_VEND_ID_REG, tmp_rc_dbi_data);
   	$display("Debug: RC side read device id is %h  and  vendor id is %h at time: ",tmp_rc_dbi_data[31:16], tmp_rc_dbi_data[15:00] ,$time);
    cfg0r(BASE_ADDR_PF0+ADDR_PF_TYPE0_HDR+EP_DEVICE_ID_VENDOR_ID_REG, tmp_ep_dbi_data);
    $display("Debug: EP side read device id is %h  and  vendor id is %h at time: ",tmp_ep_dbi_data[31:16], tmp_ep_dbi_data[15:00] ,$time);

    $display("Debug: Enable ep bus master at time:",$time);
    //cfg0r(BASE_ADDR_PF0+ADDR_PF_TYPE0_HDR+EP_STATUS_COMMAND_REG, tmp_ep_dbi_data);
    cfg0w(BASE_ADDR_PF0+ADDR_PF_TYPE0_HDR+EP_STATUS_COMMAND_REG, 32'h00110007);

    u_dbi_rc.dbi_rd(BASE_ADDR_PF0+ 128, tmp_rc_dbi_data);
   	$display("Debug: Link up speed : gen%h at time:",tmp_rc_dbi_data[19:16],$time);
   	$display("Debug: Link up width : x%h at time:",tmp_rc_dbi_data[23:20],$time);

    //---Set the MPS after negotiation;
    cfg0r(BASE_ADDR_PF0+ADDR_PF_PCIE_CAP + DEVICE_CAPABILITIES_REG ,tmp_ep_dbi_data);//0x80+0x4
    $display("Debug: EP msp support is  %d at time:" ,( 16'd128 << tmp_ep_dbi_data[2:0]),$time );
    cfg0r(BASE_ADDR_PF0+ADDR_PF_PCIE_CAP + DEVICE_CONTROL_DEVICE_STATUS ,tmp_ep_dbi_data);//0x80+0x8
    cfg0w(BASE_ADDR_PF0+ADDR_PF_PCIE_CAP + DEVICE_CONTROL_DEVICE_STATUS ,{tmp_ep_dbi_data[31:15],3'b100, tmp_ep_dbi_data[11:8] ,3'b100, tmp_ep_dbi_data[4:0] });//4096byte
    u_dbi_rc.dbi_rd(BASE_ADDR_PF0+ADDR_PF_PCIE_CAP+DEVICE_CONTROL_DEVICE_STATUS, tmp_rc_dbi_data);
	u_dbi_rc.dbi_wr(BASE_ADDR_PF0+ADDR_PF_PCIE_CAP+DEVICE_CONTROL_DEVICE_STATUS, {tmp_rc_dbi_data[31:15],3'b100,tmp_ep_dbi_data[11:8],3'b100, tmp_rc_dbi_data[4:0]});
    $display("Debug: RC set EP msp  is  %d at time:" , ( 16'd128 << 3'b100 ),$time );
    $display("Debug: RC set EP mrrs is  %d at time:" , ( 16'd128 << 3'b100 ),$time );


    //---BAR0 has already define as 32bit memory bar;
    cfg0w(BASE_ADDR_PF0+EP_BAR0_REG, 32'hffffffff );
    cfg0r(BASE_ADDR_PF0+EP_BAR0_REG, tmp_ep_dbi_data);
    if(tmp_ep_dbi_data[0] == 1'b0 && tmp_ep_dbi_data[2:1] == 2'b00) begin
		 $display("Debug: Bar0 is 32bit memory bar at time:",$time );
		 cfg0w(BASE_ADDR_PF0+EP_BAR0_REG, ADDR_BAR0_BA );//Set the base address of BAR0;
		 cfg0r(BASE_ADDR_PF0+EP_BAR0_REG, tmp_ep_dbi_data );
		 $display("Debug: Bar0 assign address is %h at time:" , {tmp_ep_dbi_data[31:4],4'b0},$time);
    end
	
	// Configure RC MEM Base and Limit
	$display("Debug: RC configure base address and limit address at:",$time);
	u_dbi_rc.dbi_wr(BASE_ADDR_PF0+ADDR_PF_TYPE0_HDR+RC_MEM_LIMIT_MEM_BASE_REG, {ADDR_BAR0_BA[31:20], 4'd0, ADDR_BAR3_BA[31:20], 4'd0});
	//u_dbi_rc.dbi_wr(BASE_ADDR_PF0+ADDR_PF_TYPE0_HDR+RC_PREF_MEM_LIMIT_PREF_MEM_BASE_REG, {ADDR_BAR3_BA[31:20], 4'd0, ADDR_BAR0_BA[31:20], 4'd0});
	
	// Configures MSI for EP
	$display("Debug: Msi interrupt enable at time:",$time);
	cfg0r(BASE_ADDR_PF0+ADDR_PF_MSI_CAP+PCI_MSI_CAP_ID_NEXT_CTRL_REG, tmp_ep_dbi_data);
	cfg0w(BASE_ADDR_PF0+ADDR_PF_MSI_CAP+PCI_MSI_CAP_ID_NEXT_CTRL_REG, {tmp_ep_dbi_data[31:23] , 
	                tmp_ep_dbi_data[19:17] , tmp_ep_dbi_data[19:17], 1'b1, tmp_ep_dbi_data[15:0]});//MSI enable, multiple message enable
	cfg0r(BASE_ADDR_PF0+ADDR_PF_MSI_CAP+PCI_MSI_CAP_ID_NEXT_CTRL_REG, tmp_ep_dbi_data);
	cfg0w(BASE_ADDR_PF0+ADDR_PF_MSI_CAP+MSI_CAP_OFF_04H_REG, {MSI_CTRL_ADDR[31:2], 2'b00});//message address
	cfg0r(BASE_ADDR_PF0+ADDR_PF_MSI_CAP+MSI_CAP_OFF_08H_REG, tmp_ep_dbi_data);
	cfg0w(BASE_ADDR_PF0+ADDR_PF_MSI_CAP+MSI_CAP_OFF_08H_REG, {tmp_ep_dbi_data[31:16], MSI_CTRL_DATA}); // message data????
	//For a function that supports a 32-bit message address, this field contains the lower Mask Bits when the Per Vector Masking Capable bit (PCI_MSI_CAP_ID_NEXT_CTRL_REG.PCI_PVM_SUPPORT) is set.
	cfg0w(BASE_ADDR_PF0+ADDR_PF_MSI_CAP+MSI_CAP_OFF_0CH_REG, 32'h0000_0000); // mask bits		


	init_cfg_over = 1'b1;
	$display("Debug: PCIe dbi configuration over at time:",$time);

   
end


endmodule

