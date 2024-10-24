/*===========================================*\
Filename         : 
Author           : wbs
Description      :               
Called by        : 
Revision History : v1.1
Email            : bingsong.wang@anlogic.com
Company          : anlu
Copyright(c)Shanghai Anlu Information Technology Co.,Ltd
Modified         : 
initial 

\*===========================================*/
`timescale 1ns/1ps
`include "tlp_fmt_type.vh"
`include "dt_para.vh"
module pcie_rx_bfm (
	input   core_rst_n,
	input   core_clk,

	input   [9:0]   trgt_lookup_id_i,
	input           trgtlookup_id_rden_i,
	output  [9:0]   trgtlookup_id_o,
	
	output          trgt1_radm_halt_o,//global halt
	input           radm_trgt1_dv_i,
	input           radm_trgt1_hv_i,
	input           radm_trgt1_eot_i,
	input   [`DT_WD-1:0]     radm_trgt1_data_i,
	input   [`HDR_WD-1:0]    radm_trgt1_header_i,//pos&non_pos 4DW,cpl 3DW. 
	input   [3:0]   radm_trgt1_dwen_i,
	input           radm_trgt1_cpl_last_i,
	input   [2:0]   radm_grant_tlp_type_i,//0:pos,1:non_pos,2:cpl
	output  [2:0]   trgt1_radm_pkt_halt_o,
	input           radm_trgt1_tlp_abort_i,
	input           radm_trgt1_dllp_abort_i,
	input           radm_trgt1_ecrc_err_i,
	input   		radm_trgt1_func_num_i,
//	input   [1:0] 	radm_trgt1_vfunc_num_i,
//	input   		radm_trgt1_vfunc_active_i,
	input   		radm_trgt1_hdr_uppr_bytes_valid_i,
	input   		radm_trgt1_rom_in_range_i,
	input   		radm_trgt1_io_req_in_range_i,
	input   [63:0] 	radm_trgt1_hdr_uppr_bytes_i,
	input   [2:0] 	radm_trgt1_in_membar_range_i,
	input   		radm_trgt1_nw_i,
	input   [1:0] 	radm_trgt1_atu_sloc_match_i,
	input   [1:0] 	radm_trgt1_atu_cbuf_err_i,

	input           mrd_rden_i,
	output  [`HDR_WD-1:0]   mrd_q_o,
	output  mrd_rdempty_o,

	output  [`DT_WD*`IDT_NUM-1:0]    c2h_fm_odt,
//	output  [`DT_WD*`AXI4S_NUM-1:0]  axi4s_odt,
	output  [32*`PMODE_NUM-1:0]      h2c_pmode_odt,
	output  [32*`PMODE_NUM-1:0]      c2h_pmode_odt
    
);
//---常量定义---
/*localparam MWR_3DW_TYPE = 7'b1000000,
           MWR_4DW_TYPE = 7'b1100000,
           MRD_3DW_TYPE = 7'b0000000,
		   MRD_4DW_TYPE = 7'b0100000;*/
localparam NTAG = 128,
		   NTAG_WIDTH = $clog2(NTAG);
//---变量定义---
wire   hv_vld; 
wire   [1:0]   radm_trgt1_fmt;
wire   [4:0]   radm_trgt1_type;
reg            mrd_wren;
reg    [`HDR_WD-1:0]   mrd_wheader;

reg    mwr_rgn;
wire   vld_dv;
reg    c2h_pmode_wren;
reg    h2c_pmode_wren;
//reg    axi4s_wren;
reg    fm_wren;
reg    [`DT_WD-1:0]   mwr_wdata;
reg                   trgt1_radm_halt;
reg    [9:0]          trgt_lookup_id;
wire   trgt_wren;
//reg    hv_vld_d1;
reg    [NTAG_WIDTH-1:0]   trgt_wraddr;
reg    [NTAG_WIDTH-1:0]   trgt_rdaddr;
//reg    [9:0]   trgtlookup_id_d1;
wire   [9:0]  trgtlookup_id;
/*
reg    mem_rd_over_d1;
reg    mem_rd_over_d2;
reg    mem_rd_over_d3;
wire   mem_rd_over_rising;
reg    ext_wren;
*/
//reg    vld_dv_d1;
wire   mrd_fmt_type;
//reg    [`DT_WD-1:0]   test_mwr_data;
//reg    [23:0]   cnt_mwr_err;
wire   [31:0]   mwr_addr;

//-------------------------------------------
//---mrd包处理，存储包头，返回cpld包时读出---
assign hv_vld = (~trgt1_radm_halt_o) & radm_trgt1_hv_i;
assign radm_trgt1_fmt = radm_trgt1_header_i[30:29];
assign radm_trgt1_type = radm_trgt1_header_i[28:24];
assign mrd_fmt_type = (radm_trgt1_fmt[1]==1'b0&&radm_trgt1_type==5'd0) ? 1'b1 : 1'b0;
assign mwr_addr = radm_trgt1_header_i[95:64];
always @(posedge core_clk,negedge core_rst_n)
begin
	if(!core_rst_n)
		mrd_wren <= 1'b0;
	else 
		mrd_wren <= hv_vld & mrd_fmt_type;  
end
always @(posedge core_clk,negedge core_rst_n)
begin	
	if(!core_rst_n)
		mrd_wheader <= {`HDR_WD{1'b0}};//{32'h40000000,16'd0,8'd2,8'hff,32'h00000200};
	else if(hv_vld)
		mrd_wheader <= radm_trgt1_header_i;
	else ;
end

//---存储mrd包头---
safifo512x128 u_rx_safifo512x128(
	.rst(~core_rst_n),
	.di(mrd_wheader), 
	.re(mrd_rden_i), 
	.clk(core_clk), 
	.we(mrd_wren),
	.dout(mrd_q_o),
	.empty_flag(mrd_rdempty_o),
	.full_flag(),
	.rdusedw(),
	.wrusedw()
);

//------------------------------------------
//---mwr包数据全部存储---
always @(posedge core_clk,negedge core_rst_n)
begin
	if(!core_rst_n)
		mwr_rgn <= 1'b0;
	else if(hv_vld) begin
		if(radm_trgt1_fmt[1]==1'b1 && radm_trgt1_type==5'd0)//mwr
			mwr_rgn <= 1'b1;
		else ;
	end
	else ;
end
//assign mwr_rgn = (radm_trgt1_fmt[1]==1'b1 && radm_trgt1_type==5'd0 && hv_vld) ? 1'b1 : 1'b0;   ///???????

assign vld_dv = ~trgt1_radm_halt_o & radm_trgt1_dv_i;
always @(posedge core_clk,negedge core_rst_n)
begin
	if(!core_rst_n) begin
		c2h_pmode_wren <= 1'b0;
		h2c_pmode_wren <= 1'b0;
//		axi4s_wren <= 1'b0;
		fm_wren <= 1'b0;
	end
	else if(vld_dv) begin
		h2c_pmode_wren <= (mwr_addr[31:20]>=12'h118&&mwr_addr[31:20]<12'h120) ? 1'b1 : 1'b0;
		c2h_pmode_wren <= (mwr_addr[31:20]>=12'h198&&mwr_addr[31:20]<12'h1a0) ? 1'b1 : 1'b0;
//		axi4s_wren <= (mwr_addr[31:20]>=12'h190&&mwr_addr[31:20]<12'h198) ? 1'b1 : 1'b0;
		fm_wren <= (mwr_addr[31:20]>=12'h1c0&&mwr_addr[31:20]<12'h1df) ? 1'b1 : 1'b0;
	end
	else begin
		c2h_pmode_wren <= 1'b0;
		h2c_pmode_wren <= 1'b0;
//		axi4s_wren <= 1'b0;
		fm_wren <= 1'b0;
	end
end

always @(posedge core_clk,negedge core_rst_n)
begin
	if(!core_rst_n)
		mwr_wdata <= {`DT_WD{1'b0}};
	else if(vld_dv)
    begin
        case ( radm_trgt1_dwen_i )
            4'b0000: mwr_wdata <= 128'd0;
            4'b0001: mwr_wdata <= { 96'd0,radm_trgt1_data_i[31:0] };
            4'b0011: mwr_wdata <= { 64'd0,radm_trgt1_data_i[63:0] };
            4'b0111: mwr_wdata <= { 32'd0,radm_trgt1_data_i[95:0] };
            4'b1111: mwr_wdata <= radm_trgt1_data_i;
        endcase
    end
	else ;
end

localparam PMODE_WD = $clog2(`PMODE_NUM+1),
           IDT_WD = $clog2(`IDT_NUM+1);
//		   AXI4S_WD = $clog2(`AXI4S_NUM);
integer i;
integer j;
//integer m;
integer n;
reg    [PMODE_WD-1:0]  cnt_c2h_pmode;
reg    [PMODE_WD-1:0]  cnt_h2c_pmode;
//reg    [AXI4S_WD-1:0]  cnt_axi4s;
reg    [IDT_WD-1:0]    cnt_idt;
reg    [31:0]          c2h_pmode_odt_x[`PMODE_NUM-1:0];
reg    [31:0]          h2c_pmode_odt_x[`PMODE_NUM-1:0];
reg    [`DT_WD-1:0]    c2h_fm_odt_x[`IDT_NUM-1:0];
//reg    [`DT_WD-1:0]    axi4s_odt_x[`AXI4S_NUM-1:0];
always@(posedge core_clk or negedge core_rst_n)
begin
	if(!core_rst_n) begin
		cnt_c2h_pmode <= {PMODE_WD{1'b0}};
		for (i=0;i<`PMODE_NUM;i=i+1)
		begin
			c2h_pmode_odt_x[i] <= 32'd0;
		end
	end
	else if(c2h_pmode_wren & mwr_rgn) begin
		cnt_c2h_pmode <= cnt_c2h_pmode + 'd1;
		c2h_pmode_odt_x[cnt_c2h_pmode] <= mwr_wdata;
	end
	else ;
end
always@(posedge core_clk or negedge core_rst_n)
begin
	if(!core_rst_n) begin
		cnt_h2c_pmode <= {PMODE_WD{1'b0}};
		for (n=0;n<`PMODE_NUM;n=n+1)
		begin
			h2c_pmode_odt_x[i] <= 32'd0;
		end
	end
	else if(h2c_pmode_wren & mwr_rgn) begin
		cnt_h2c_pmode <= cnt_h2c_pmode + 'd1;
		h2c_pmode_odt_x[cnt_h2c_pmode] <= mwr_wdata;
	end
	else ;
end
always@(posedge core_clk or negedge core_rst_n)
begin
	if(!core_rst_n) begin
		cnt_idt <= {IDT_WD{1'b0}};
		for (j=0;j<`IDT_NUM;j=j+1)
		begin
			c2h_fm_odt_x[j] <= {`DT_WD{1'b0}};
		end
	end
	else if(fm_wren & mwr_rgn) begin
		cnt_idt <= cnt_idt + 'd1;
		c2h_fm_odt_x[cnt_idt] <= mwr_wdata;
	end
	else ;
end/*
always@(posedge core_clk or negedge core_rst_n)
begin
	if(!core_rst_n) begin
		cnt_axi4s <= {AXI4S_WD{1'b0}};
		for (m=0;m<`AXI4S_NUM;m=m+1)
		begin
			axi4s_odt_x[m] <= {`DT_WD{1'b0}};
		end
	end
	else if(axi4s_wren & mwr_rgn) begin
		cnt_axi4s <= cnt_axi4s + 'd1;
		axi4s_odt_x[cnt_axi4s] <= mwr_wdata;
	end
	else ;
end*/

generate 
	genvar c2h_npmode;
	genvar h2c_npmode;
	genvar nidt;
//	genvar naxi4s;
	for(c2h_npmode=0;c2h_npmode<`PMODE_NUM;c2h_npmode=c2h_npmode+1) 
	begin:C2H_PMODE_PACK
		assign c2h_pmode_odt[c2h_npmode*32+31:c2h_npmode*32] = c2h_pmode_odt_x[c2h_npmode];
	end
	for(h2c_npmode=0;h2c_npmode<`PMODE_NUM;h2c_npmode=h2c_npmode+1) 
	begin:H2C_PMODE_PACK
		assign h2c_pmode_odt[h2c_npmode*32+31:h2c_npmode*32] = h2c_pmode_odt_x[h2c_npmode];
	end
	for(nidt=0;nidt<`IDT_NUM;nidt=nidt+1) 
	begin:IDT_PACK
		assign c2h_fm_odt[nidt*`DT_WD+127:nidt*`DT_WD] = c2h_fm_odt_x[nidt];
	end/*
	for(naxi4s=0;naxi4s<`AXI4S_NUM;naxi4s=naxi4s+1) 
	begin:AXI4S_PACK
		assign axi4s_odt[naxi4s*`DT_WD+63:naxi4s*`DT_WD] = axi4s_odt_x[naxi4s];
	end*/
endgenerate

/*
always @(posedge core_clk,negedge core_rst_n)
begin
	if(!core_rst_n)
		test_mwr_data <= {`DT_WD{1'b0}};
	else if(mwr_wren)
		test_mwr_data <= test_mwr_data + 'd1;
	else ;
end

always @(posedge core_clk,negedge core_rst_n)
begin
	if(!core_rst_n)
		cnt_mwr_err <= 24'd0;
	else if(mwr_wren==1'b1 && mwr_wdata[31:0]!=test_mwr_data[31:0])
		cnt_mwr_err <= cnt_mwr_err + 24'd1;
	else ;
end
assign mwr_err_num_o = cnt_mwr_err;*/
/*
//---存储mwr包数据---
showahead_sfifo512x128 U_sfifo4096x64mwr_data(
	.sclr(~core_rst_n),
	.clock(core_clk),
	
	.data(mwr_wdata),
	.wrreq(mwr_wren),
	.rdreq(mwr_rden_i),
	.q(mwr_q_o),
	.almost_full(),
	.empty(mwr_rdempty_o),
	.full()
);
*/



//---反压信号trgt1_radm_halt_o，mwr和mrd公用---
always @(posedge core_clk,negedge core_rst_n)
begin
	if(!core_rst_n)
		trgt1_radm_halt <= 1'b0;
	else 
		trgt1_radm_halt <= ($random%2);
end
assign trgt1_radm_halt_o = trgt1_radm_halt; 		
assign trgt1_radm_pkt_halt_o = 3'b000;


ram128x10 u_rx_ram128x10( 
	.dia(trgt_lookup_id),
	.cea(trgt_wren),
	.addra(trgt_wraddr), 
	.clka(core_clk),
	.ceb(trgtlookup_id_rden_i),
	.dob(trgtlookup_id), 
	.addrb(trgt_rdaddr)
);

assign trgt_wren = mrd_wren;//mwr_rgn

always @(posedge core_clk,negedge core_rst_n)
begin
	if(!core_rst_n)
		trgt_wraddr <= {NTAG_WIDTH{1'b0}};
	else if(trgt_wren)
		trgt_wraddr <= (trgt_wraddr==NTAG-1) ? {NTAG_WIDTH{1'b0}} : (trgt_wraddr + 'd1);
	else ;
end
always @(posedge core_clk,negedge core_rst_n)
begin
	if(!core_rst_n)
		trgt_lookup_id <= 10'd0;
	else if(hv_vld & mrd_fmt_type)
		trgt_lookup_id <= trgt_lookup_id_i;
	else ;
end

always @(posedge core_clk,negedge core_rst_n)
begin
	if(!core_rst_n)
		trgt_rdaddr <= {NTAG_WIDTH{1'b0}};
	else if(trgtlookup_id_rden_i)
		trgt_rdaddr <= (trgt_rdaddr==NTAG-1) ? {NTAG_WIDTH{1'b0}} : (trgt_rdaddr + 'd1);
	else ;
end

assign trgtlookup_id_o = trgtlookup_id;

endmodule
