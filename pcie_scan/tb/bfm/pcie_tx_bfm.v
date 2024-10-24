/*===========================================*\
Filename         : pcie_tx_bfm.v
Author           : wbs
Description      : RC-Bypass收到EP读请求后，回送完成包，
	               由Client0发出；              
Called by        : pcie_rc_case0.v
Revision History : v1.0
Email            : bingsong.wang@anlogic.com
Company          : anlu
Copyright(c)Shanghai Anlu Information Technology Co.,Ltd
Modified         : 
\*===========================================*/
`timescale 1ns/1ps
`include "tlp_fmt_type.vh"
`include "dt_para.vh"
module pcie_tx_bfm(
	input   core_rst_n,
	input   core_clk,
	
	output  mrd_rden_o,
	input   [`HDR_WD-1:0]   mrd_q_i,
	input   mrd_rdempty_i,

	input   [`DT_WD*`ODT_NUM-1:0]    h2c_fm_idt,
	input   [`WDSCP_NUM*`DT_WD-1:0]  wdscp_idt,
	input   [`RDSCP_NUM*`DT_WD-1:0]  rdscp_idt,
	input   [9:0]   trgtlookup_id_i,
	output   trgtlookup_id_rden_o,
	
	output  client0_addr_align_en_o,
	output  [7:0]   client0_tlp_byte_en_o,
	output  [`HDR_WD-1:0]   client0_header_data_o,
	output  client0_tlp_dv_o,
	output  client0_tlp_eot_o,
	output  client0_tlp_bad_eot_o,
	output  client0_tlp_hv_o,
	output  [12:0]   client0_tlp_byte_len_o,
	output  [`DT_WD-1:0]   client0_tlp_data_o,
	output  client0_tlp_func_num_o,
	output  [1:0]   client0_tlp_vfunc_num_o,
	output  client0_tlp_vfunc_active_o,
	input   xadm_client0_halt_i,
	output  client0_tlp_atu_bypass_o,
	output  [9:0]   client0_lookup_cpl_id_o
);

//---常量定义---
localparam DT_NB = `DT_WD/8,
           DT_NB_WD = $clog2(DT_NB);
localparam NDT = 2048/`DT_WD,
		     NDT_WD = $clog2(NDT);
localparam NRDSCP_WD = $clog2(`RDSCP_NUM+1),
		     NWDSCP_WD = $clog2(`WDSCP_NUM+1),
           IDT_WD = $clog2(`IDT_NUM+1);
//---变量定义---
reg   mrd_rden;
wire  cpld_rgn;
reg   client0_tlp_hv;
reg   client0_tlp_dv;
reg   client0_tlp_eot;
reg   [6:0]   lower_addr;
reg   [11:0]  byte_count;
reg   [`HDR_WD-1:0]   client0_header_data;
wire  [`DT_WD-1:0]    client0_tlp_data;
wire  [11:0]   cpld_len;
reg   [9:0]    cnt_cpld;
wire  vld_hv;
wire  vld_dv;
wire  vld_eot;
reg   [9:0]   client0_lookup_cpl_id;

reg  [`DT_WD-1:0]    rdscp_idt_x[0:`RDSCP_NUM-1];
reg  [`DT_WD-1:0]    wdscp_idt_x[0:`WDSCP_NUM-1];
reg  [`DT_WD-1:0]    h2c_fm_idt_x[0:`ODT_NUM-1];
reg   [7:0]           dscp_rgn;
wire  [3:0]           addr_msb;
reg   [NWDSCP_WD-1:0] cnt_wdscp0 = {NWDSCP_WD{1'b0}};
reg   [NRDSCP_WD-1:0] cnt_rdscp0;
reg   [`DT_WD-1:0]    rd0_tlp_data;
reg   [9:0]           cpld_len_a;
wire  [9:0]           cpld_len_x;

wire  [7:0]   byte_en;
wire  [9:0]   dw_len;


generate 
genvar nwdscp;
genvar nrdscp;
genvar h2c_nodt;
for(nwdscp=0;nwdscp<`WDSCP_NUM;nwdscp=nwdscp+1) 
begin:WDSCP_UNPACK
	assign wdscp_idt_x[nwdscp] = wdscp_idt[nwdscp*`DT_WD+(`DT_WD-1):nwdscp*`DT_WD];
end
for(nrdscp=0;nrdscp<`RDSCP_NUM;nrdscp=nrdscp+1) 
begin:RDSCP_UNPACK
	assign rdscp_idt_x[nrdscp] = rdscp_idt[nrdscp*`DT_WD+(`DT_WD-1):nrdscp*`DT_WD];
end
for(h2c_nodt=0;h2c_nodt<`ODT_NUM;h2c_nodt=h2c_nodt+1) 
begin:H2C_ODT_UNPACK
	assign h2c_fm_idt_x[h2c_nodt] = h2c_fm_idt[h2c_nodt*`DT_WD+(`DT_WD-1):h2c_nodt*`DT_WD];
end
endgenerate

assign addr_msb = mrd_q_i[92:89]|mrd_q_i[`HDR_WD-4:`HDR_WD-7]; 	
always @(posedge core_clk,negedge core_rst_n)
begin
	if(!core_rst_n)
		dscp_rgn <= 8'b0000_0000;
	else if(vld_eot)
		dscp_rgn <= 8'b0000_0000;
	else if(mrd_rden) begin
		case (addr_msb)
			4'b1000: dscp_rgn <= 8'b0000_0001;//rdscp0 addr
			4'b1001: dscp_rgn <= 8'b0000_0010;//rdscp1 addr
            4'b1010: dscp_rgn <= 8'b0000_0100;//rd0 addr
			4'b1011: dscp_rgn <= 8'b0000_1000;//rd1 addr
/*
c2h0 channel
[32'h1800_0000~32'h1900_0000)->wdscp0_addr;
[32'h1900_0000~32'h1980_0000)->axi4-stream write back
[32'h1980_0000~32'h1a00_0000)->poll mode
*/
			4'b1100: dscp_rgn <= 8'b0001_0000;//wdscp0 addr 
			4'b1101: dscp_rgn <= 8'b0010_0000;//wdscp1 addr
			4'b1110: dscp_rgn <= 8'b0100_0000;//wd0 addr
			4'b1111: dscp_rgn <= 8'b1000_0000;//wd1 addr
			default: dscp_rgn <= 8'b0000_0000;
		endcase
	end
	else ;
end
assign cpld_rgn = |dscp_rgn[5:0];

assign byte_en = mrd_q_i[39:32];
assign dw_len = mrd_q_i[9:0];

always @ (dw_len,byte_en) 
begin
	if(dw_len == 10'd1) begin
	  case (byte_en[3:0])
		4'b0001 : byte_count = 12'h001;
		4'b0011 : byte_count = 12'h002;
		4'b0111 : byte_count = 12'h003;
		4'b1111 : byte_count = 12'h004;
		default: byte_count = 12'h004;
	  endcase
	end
	else begin
		 case (byte_en[7:4])
		4'b0001 : byte_count = (dw_len<<2)-12'd3;
		4'b0011 : byte_count = (dw_len<<2)-12'h002;
		4'b0111 : byte_count = (dw_len<<2)-12'h001;
		4'b1111 : byte_count = (dw_len<<2);
		default: byte_count = (dw_len<<2);
	  endcase
	end
end

//---检测FIFO非空时，且上次包发完时产生一个读信号---
always @(posedge core_clk,negedge core_rst_n)
begin
	if(!core_rst_n)
		mrd_rden <= 1'b0;
	else if(~mrd_rdempty_i & (~cpld_rgn) & (~mrd_rden))
		mrd_rden <= 1'b1;
	else 
		mrd_rden <= 1'b0;
end
assign vld_eot = ~xadm_client0_halt_i & client0_tlp_eot;
/*always @(posedge core_clk,negedge core_rst_n)
begin
	if(!core_rst_n)
		cpld_rgn <= 1'b0;
	else if(vld_eot)
		cpld_rgn <= 1'b0;
	else if(mrd_rden)
		cpld_rgn <= 1'b1;
	else ;
end*/

always @(posedge core_clk,negedge core_rst_n)
begin
	if(!core_rst_n)
		client0_tlp_hv <= 1'b0;
	else if(vld_hv)
		client0_tlp_hv <= 1'b0;
	else if(mrd_rden)
		client0_tlp_hv <= 1'b1;
	else ;
end

//---Calculate lower address based on  byte enable;
always @ (byte_en[3:0]) begin
  case (byte_en[3:0])//完成包的address，读请求之后的第一个返回的数据地址  
	4'b0000 : lower_addr = 7'd0;
	4'b1110 : lower_addr = 7'd1;
	4'b1100 : lower_addr = 7'd2;
	4'b1000 : lower_addr = 7'd3;
	default : lower_addr = 7'd0;
  endcase
end

//assign lower_addr = {mrd_q_i[68:64],2'b00};
//---ip 默认最大值2048byte，所以不考虑10'd0为4096dw的情况---
//assign byte_count = {mrd_q_i[9:0],2'b00};
assign vld_hv = ~xadm_client0_halt_i & client0_tlp_hv;
always @(posedge core_clk,negedge core_rst_n)
begin
	if(!core_rst_n)
		client0_header_data <= {`HDR_WD{1'b0}};
	else if(vld_hv)
		client0_header_data <= {`HDR_WD{1'b0}};
	else if(mrd_rden)
		client0_header_data <= {mrd_q_i[63:48],//requester id
						        mrd_q_i[47:40],//tag
					            {1'b0,lower_addr},//lower addr
					            16'd0,//completer id ???ph1手册上没有，参考
					            4'd0,
					            byte_count,
					            {`CPLD_FMT,`CPLD_TYPE},
					            mrd_q_i[23:0]};
	else ;
end	
always @(posedge core_clk,negedge core_rst_n)
begin
	if(!core_rst_n)
		cpld_len_a <= 10'd0;
	else if(mrd_rden)
		cpld_len_a <= mrd_q_i[9:0];//mrd_q_i[9:0]....last_be & first_be?????
	else ;
end
assign cpld_len_x = mrd_rden ? mrd_q_i[9:0] : cpld_len_a;
assign cpld_len = {cpld_len_x,2'b00} + (DT_NB-1);

always @(posedge core_clk,negedge core_rst_n)
begin
	if(!core_rst_n)
		cnt_cpld <= 10'd0;
	else if(vld_eot)
		cnt_cpld <= 10'd0;
	else if(vld_dv)
		cnt_cpld <= cnt_cpld + 10'd1;
	else ;
end

always @(posedge core_clk,negedge core_rst_n)
begin
	if(!core_rst_n)
		client0_tlp_dv <= 1'b0;
	else if(vld_eot)
		client0_tlp_dv <= 1'b0;
	else if(mrd_rden)
		client0_tlp_dv <= 1'b1;
	else ;
end
always @(posedge core_clk,negedge core_rst_n)
begin
	if(!core_rst_n)
		client0_tlp_eot <= 1'b0;
	else if(vld_eot)
		client0_tlp_eot <= 1'b0;
	else if(cpld_len[11:DT_NB_WD]>'d1) begin
        if(vld_dv==1'b1&&cnt_cpld==cpld_len[11:DT_NB_WD]-2)
		    client0_tlp_eot <= 1'b1;
        else ;
    end
	else if(mrd_rden)
		client0_tlp_eot <= 1'b1;
	else ;
end
assign vld_dv = ~xadm_client0_halt_i & client0_tlp_dv;
/*
always @(posedge core_clk,negedge core_rst_n)
begin
	if(!core_rst_n)
		cnt_wdscp0 <= {NDSCP{1'b0}};
	else if(dscp_rgn[2] & vld_dv)
		cnt_wdscp0 <= cnt_wdscp0 + 'd1;
	else ;
end*/
always @(posedge core_clk,negedge core_rst_n)
begin
   if(!core_rst_n)
        cnt_rdscp0 <= {NRDSCP_WD{1'b0}};
	else if(dscp_rgn[0] & vld_dv) begin
		if(cnt_rdscp0 == `RDSCP_NUM-1)
			cnt_rdscp0 <= {NRDSCP_WD{1'b0}};
		else 
			cnt_rdscp0 <= cnt_rdscp0 + 'd1;
	end
	else ;
end
`ifdef CASE3
reg core_rst_n_1d;

always @ ( posedge core_clk )
begin
    core_rst_n_1d <= core_rst_n;
end

always @(posedge core_clk)
begin
    if (~core_rst_n & core_rst_n_1d)
        cnt_wdscp0 <= 5'd10;
	else if(dscp_rgn[4] & vld_dv) begin
		if(cnt_wdscp0 == `WDSCP_NUM-1)
		    ;
		else 
			cnt_wdscp0 <= cnt_wdscp0 + 'd1;
	end	
	else ;
end
`else
always @(posedge core_clk,negedge core_rst_n)
begin
	if(!core_rst_n)
		cnt_wdscp0 <= {NWDSCP_WD{1'b0}};
	else if(dscp_rgn[4] & vld_dv) begin
		if(cnt_wdscp0 == `WDSCP_NUM-1)
			cnt_wdscp0 <= {NWDSCP_WD{1'b0}};
		else 
			cnt_wdscp0 <= cnt_wdscp0 + 'd1;
	end	
	else ;
end
`endif
always @(posedge core_clk,negedge core_rst_n)
begin
	if(!core_rst_n)
		rd0_tlp_data <= {`DT_WD{1'b0}};
	else if(dscp_rgn[2] & vld_dv) begin
		if(rd0_tlp_data==`IDT_NUM-1)
			rd0_tlp_data <= {`DT_WD{1'b0}};
		else 
			rd0_tlp_data <= rd0_tlp_data + 'd1;
	end
	else ;
end

assign client0_tlp_data = dscp_rgn[2] ? h2c_fm_idt_x[rd0_tlp_data] : (dscp_rgn[4]?wdscp_idt_x[cnt_wdscp0]:
                                        (dscp_rgn[0]?rdscp_idt_x[cnt_rdscp0]:{`DT_WD{1'b0}}));

assign trgtlookup_id_rden_o = (~mrd_rdempty_i) & (~cpld_rgn) & (~mrd_rden);
always @(posedge core_clk,negedge core_rst_n)
begin
	if(!core_rst_n)
		client0_lookup_cpl_id <= 10'd0;
	else if(mrd_rden)
		client0_lookup_cpl_id <= trgtlookup_id_i;
	else ;
end/*
always @(posedge core_clk,negedge core_rst_n)
begin
	if(!core_rst_n)
		client0_tlp_byte_len <= 13'd0;
	else if(mrd_rden)
		client0_tlp_byte_len <= {1'b0,byte_count};
end
*/
assign mrd_rden_o = mrd_rden;
assign client0_tlp_bad_eot_o = 1'b0;
assign client0_addr_align_en_o = 1'b0;
assign client0_header_data_o = client0_header_data;
assign client0_tlp_dv_o = client0_tlp_dv;
assign client0_tlp_eot_o = client0_tlp_eot;
assign client0_tlp_hv_o = client0_tlp_hv;
assign client0_tlp_byte_len_o = {1'b0,cpld_len_a,2'b00};
assign client0_tlp_data_o = client0_tlp_data;
assign client0_tlp_func_num_o = 1'b0;//只用到一个pf0
assign client0_tlp_vfunc_num_o = 2'b00;//起始值为0，表示client0_tlp_func_num 所选中的PF的第一个VF。
assign client0_tlp_vfunc_active_o = 1'b0;
assign client0_tlp_atu_bypass_o = 1'b1;//??？旁路内部的置位该信，号表示本次传输不应该被内部地址翻译单元执行
assign client0_tlp_byte_en_o = 8'hff;
assign client0_lookup_cpl_id_o = client0_lookup_cpl_id;

/*
//--gen golden.sim file
reg   [31:0]    mrd_addr;
wire            cpld_rd0_rgn;
wire		rd0_byte_en_vld;
wire  [7:0]     client0_tlp_byte_en = 8'hff;
reg   [2:0]     h2c0_vld_num;
reg   [2:0]     byte_en_sum;
reg   [63:0]    h2c0_tdata_d1;
reg   [63:0]    h2c0_wrdata;
reg             h2c0_wren;
wire  [3:0]     byte_en_sum_pre;

//divide rd0 region
always @(posedge core_clk,negedge core_rst_n)
begin
	if(!core_rst_n)
		mrd_addr <= 32'd0;
	else if(client0_tlp_eot & (~xadm_client0_halt_i))
		mrd_addr <= 32'd0;
	else if(mrd_rden)
		mrd_addr <= mrd_q_i[95:64];
	else ;
end
	
assign cpld_rd0_rgn = ((mrd_addr[31:20] >= 12'h140) && (mrd_addr[31:20] < 12'h15f)) ? 1'b1 : 1'b0;
assign rd0_byte_en_vld = ~xadm_client0_halt_i & cpld_rd0_rgn;
//gen wrdata
always @(client0_tlp_byte_en)//对界功能实现后client0_tlp_byte_en_o = client0_tlp_byte_en;
begin
	case (client0_tlp_byte_en)
		'h01: h2c0_vld_num = 'd1;
		'h03: h2c0_vld_num = 'd2;
		'h07: h2c0_vld_num = 'd3;
		'h0f: h2c0_vld_num = 'd4;
		'h1f: h2c0_vld_num = 'd5;
		'h3f: h2c0_vld_num = 'd6;
		'h7f: h2c0_vld_num = 'd7;
		'hff: h2c0_vld_num = 'd0;
		default: h2c0_vld_num = 'd0;
	endcase
end
	
always @(posedge core_clk,negedge core_rst_n)
begin
	if(!core_rst_n)
		byte_en_sum <= 8'd0;
	else if(client0_tlp_eot)  
		byte_en_sum <= byte_en_sum + h2c0_vld_num;
	else ;
end

always @(posedge core_clk)
begin
	if(rd0_byte_en_vld) begin	
		case (h2c0_vld_num) 
			3'b000: h2c0_tdata_d1 <= client0_tlp_data;
			3'b001: h2c0_tdata_d1 <= {client0_tlp_data[7:0],h2c0_tdata_d1[63:8]};
			3'b010: h2c0_tdata_d1 <= {client0_tlp_data[15:0],h2c0_tdata_d1[63:16]};
			3'b011: h2c0_tdata_d1 <= {client0_tlp_data[23:0],h2c0_tdata_d1[63:24]};
			3'b100: h2c0_tdata_d1 <= {client0_tlp_data[31:0],h2c0_tdata_d1[63:32]};
			3'b101: h2c0_tdata_d1 <= {client0_tlp_data[39:0],h2c0_tdata_d1[63:40]};
			3'b110: h2c0_tdata_d1 <= {client0_tlp_data[47:0],h2c0_tdata_d1[63:48]};
			3'b111: h2c0_tdata_d1 <= {client0_tlp_data[55:0],h2c0_tdata_d1[63:56]};
			default: h2c0_tdata_d1 <= client0_tlp_data;
		endcase
	end
	else ;
end

always @(posedge core_clk,negedge core_rst_n)
begin
	if(!core_rst_n)
		h2c0_wrdata <= 64'd0;
	else if(rd0_byte_en_vld) begin
		case (byte_en_sum)
			3'd0: h2c0_wrdata <= client0_tlp_data;
			3'd1: h2c0_wrdata <= {client0_tlp_data[55:0],h2c0_tdata_d1[63:56]};
			3'd2: h2c0_wrdata <= {client0_tlp_data[47:0],h2c0_tdata_d1[63:48]};
			3'd3: h2c0_wrdata <= {client0_tlp_data[39:0],h2c0_tdata_d1[63:40]};
			3'd4: h2c0_wrdata <= {client0_tlp_data[31:0],h2c0_tdata_d1[63:32]};
			3'd5: h2c0_wrdata <= {client0_tlp_data[23:0],h2c0_tdata_d1[63:24]};
			3'd6: h2c0_wrdata <= {client0_tlp_data[15:0],h2c0_tdata_d1[63:16]};
			3'd7: h2c0_wrdata <= {client0_tlp_data[7:0],h2c0_tdata_d1[63:8]};
			default: h2c0_wrdata <= client0_tlp_data;
		endcase
	end
	else ;
end
//gen wren
assign byte_en_sum_pre = {1'b0,byte_en_sum}+{1'b0,byte_en_sum};

always @(posedge core_clk,negedge core_rst_n)
begin
	if(!core_rst_n)
		h2c0_wren <= 1'b0;
	else if(rd0_byte_en_vld) begin
		if(&client0_tlp_byte_en)
			h2c0_wren <= 1'b1;
		else if(byte_en_sum_pre >= 8)
			h2c0_wren <= 1'b1;
		else 
			h2c0_wren <= 1'b0;
		end
	else 
		h2c0_wren <= 1'b0;
end
//print wrdata to file
reg  [IDT_WD:0]   cnt_golden_odt;
reg  [`DT_WD-1:0]   golden_odt_x  [`IDT_NUM-1:0];
wire                h2c0_trans_done;
integer i,j;
integer golden_data_file; 
always@(posedge core_clk or negedge core_rst_n)
begin
	if(!core_rst_n) begin
		cnt_golden_odt <= {IDT_WD{1'b0}};
		for (j=0;j<`IDT_NUM;j=j+1)
		begin
			golden_odt_x[j] <= {`DT_WD{1'b0}};
		end
	end
	else if(h2c0_wren) begin
		cnt_golden_odt <= cnt_golden_odt + 'd1;
		golden_odt_x[cnt_golden_odt] <= h2c0_wrdata;
	end
	else ;
end

assign h2c0_trans_done = (cnt_golden_odt >= `IDT_NUM) ? 1'b1 : 1'b0;

initial
begin
	`ifdef CASE21	
		golden_data_file = $fopen("../data/case21/case_ofm_golden.dat","w");
	`elsif CASE23	
		golden_data_file = $fopen("../data/case23/case_ofm_golden.dat","w");
	`elsif CASE24	
		golden_data_file = $fopen("../data/case24/case_ofm_golden.dat","w");
	`elsif CASE25	
		golden_data_file = $fopen("../data/case25/case_ofm_golden.dat","w");
	`elsif CASE26	
		golden_data_file = $fopen("../data/case26/case_ofm_golden.dat","w");
	`elsif CASE30	
		golden_data_file = $fopen("../data/case30/case_ofm_golden.dat","w");
	`elsif CASE31	
		golden_data_file = $fopen("../data/case31/case_ofm_golden.dat","w");
	`elsif CASE34	
		golden_data_file = $fopen("../data/case34/case_ofm_golden.dat","w");
	`elsif CASE36	
		golden_data_file = $fopen("../data/case36/case_ofm_golden.dat","w");
	`elsif CASE38	
		golden_data_file = $fopen("../data/case38/case_ofm_golden.dat","w");
	`endif
end

initial
begin
	#100;
	@(h2c0_trans_done);
	#50;
	`ifdef CASE21	
		for (i=0;i<`IDT_NUM;i=i+1)
		begin
			$fdisplay(golden_data_file,"%h",golden_odt_x[i]);
		end
	`elsif CASE23	
		for (i=0;i<`IDT_NUM;i=i+1)
		begin
			$fdisplay(golden_data_file,"%h",golden_odt_x[i]);
		end
	`elsif CASE24	
		for (i=0;i<`IDT_NUM;i=i+1)
		begin
			$fdisplay(golden_data_file,"%h",golden_odt_x[i]);
		end
	`elsif CASE25	
		for (i=0;i<`IDT_NUM;i=i+1)
		begin
			$fdisplay(golden_data_file,"%h",golden_odt_x[i]);
		end
	`elsif CASE26	
		for (i=0;i<`IDT_NUM;i=i+1)
		begin
			$fdisplay(golden_data_file,"%h",golden_odt_x[i]);
		end

	`elsif CASE30
		for (i=0;i<`IDT_NUM;i=i+1)
		begin
			$fdisplay(golden_data_file,"%h",golden_odt_x[i]);
		end
	`elsif CASE31	
		for (i=0;i<`IDT_NUM;i=i+1)
		begin
			$fdisplay(golden_data_file,"%h",golden_odt_x[i]);
		end
	`elsif CASE34	
		for (i=0;i<`IDT_NUM;i=i+1)
		begin
			$fdisplay(golden_data_file,"%h",golden_odt_x[i]);
		end
	`elsif CASE36	
		for (i=0;i<`IDT_NUM;i=i+1)
		begin
			$fdisplay(golden_data_file,"%h",golden_odt_x[i]);
		end
	`elsif CASE38
		for (i=0;i<`IDT_NUM;i=i+1)
		begin
			$fdisplay(golden_data_file,"%h",golden_odt_x[i]);
		end
	`endif
	$fclose(golden_data_file);
end*/
endmodule
