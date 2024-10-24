`timescale 1ns/1ps

`include "dt_para.vh"
`include "tlp_fmt_type.vh"
module ip_regrw(
    input   wire  rc_core_clk,
    input   wire  rc_core_rstn,
    input   wire  clk,

    input   wire   [32*`CFG_NUM-1:0]    cfg_iaddr,
    input   wire   [32*`CFG_NUM-1:0]    cfg_idt,
    output  wire   [32*`CFG_NUM-1:0]    cfg_odt,

    output  reg                   mw_en,
    output  reg   [`DT_WD-1:0]    mw_addr,
    output  reg   [11:0]          mw_len,
    output  reg   [`DT_WD-1:0]    mw_data,
    output  reg   [7:0]           mw_data_be,
    output  reg                   mw_data_en,
    input   wire  mw_op_over,

    output  reg   mr_en,    
    output  reg   [`DT_WD-1:0]    mr_addr,
    output  reg   [11:0]          mr_len,
    output  reg   [7:0]           mr_data_be,
    input   wire  [`DT_WD-1:0]    mr_data,
    input   wire                  mr_data_vld,
    input   wire  mr_op_over,

    output  reg   casen_test_done,
    input   wire  init_cfg_over,
    input   wire  msi_detected,

    output  reg   op_start,
    output  reg   h2c_rstn

);
`include "bdf.vh"
localparam OVER_TIME = 20'h03000;
localparam INT_NUM_WD = $clog2(`INT_NUM+1);
reg   [`DT_WD-1:0]  tmp_memwr_data;
reg   [`DT_WD-1:0]  tmp_memrd_data;     
reg   [31:0]  h2c0_addr;
reg   [31:0]  c2h0_addr;
integer       i;

wire  [31:0]   cfg_iaddr_x[`CFG_NUM-1:0];
wire  [31:0]   cfg_idt_x[`CFG_NUM-1:0];
reg   [31:0]   cfg_odt_x[`CFG_NUM-1:0]; 

reg   [19:0]  cnt_clk;
reg   [INT_NUM_WD:0]  cnt_det;
//reg   int_err_d1;
reg   int_err;
reg   wt_msi_det_rgn;
reg   init_cfg_over_d1;
wire  init_cfg_over_rising;
reg   int_over;
reg   nxt_wt_strt;
reg       h2c_rstn_d1;
wire  h2c_rstn_rising;
reg   [1:0] rand_data;
//reg   [31:0]  compl_cnt = 32'd0;
generate 
    genvar ncfg;
    for(ncfg=0;ncfg<`CFG_NUM;ncfg=ncfg+1) 
    begin:CFG_PACK
        assign cfg_iaddr_x[ncfg] = cfg_iaddr[ncfg*32+31:ncfg*32];
        assign cfg_idt_x[ncfg] = cfg_idt[ncfg*32+31:ncfg*32];
        assign cfg_odt[ncfg*32+31:ncfg*32] = cfg_odt_x[ncfg];
    end
endgenerate

//----Interrupt process code;
always @(posedge rc_core_clk,negedge rc_core_rstn)
begin
    if(!rc_core_rstn)
        cnt_det <= {INT_NUM_WD{1'b0}};
    else if(~h2c_rstn)//|c2h_rstn
        cnt_det <= {INT_NUM_WD{1'b0}};
    else if(msi_detected)
        cnt_det <= cnt_det + 'd1;
    else ;
end

always @(posedge rc_core_clk,negedge rc_core_rstn)
begin
    if(!rc_core_rstn)
        init_cfg_over_d1 <= 1'b0;
    else 
        init_cfg_over_d1 <= init_cfg_over;
end
assign init_cfg_over_rising = (~init_cfg_over_d1) & init_cfg_over;
always @(posedge rc_core_clk,negedge rc_core_rstn)
begin
    if(!rc_core_rstn)
        h2c_rstn_d1 <= 1'd1;
    else 
        h2c_rstn_d1 <= h2c_rstn;
end
assign h2c_rstn_rising = (~h2c_rstn_d1) & h2c_rstn;
always @(posedge rc_core_clk,negedge rc_core_rstn)
begin
    if(!rc_core_rstn)
        wt_msi_det_rgn <= 1'b0;
    else if((wt_msi_det_rgn&msi_detected) | (~h2c_rstn))
        wt_msi_det_rgn <= 1'b0;
    else if(init_cfg_over_rising | nxt_wt_strt | h2c_rstn_rising)
        wt_msi_det_rgn <= 1'b1;
    else ;
end
always @(posedge rc_core_clk,negedge rc_core_rstn)
begin
    if(!rc_core_rstn)
        nxt_wt_strt <= 1'b0;
    else 
        nxt_wt_strt <= (msi_detected==1'b1&&cnt_det!=`INT_NUM-1) ? 1'b1 : 1'b0;
end

always @(posedge rc_core_clk,negedge rc_core_rstn)
begin
    if(!rc_core_rstn)
        cnt_clk <= 20'd0;
    else if(msi_detected | (~h2c_rstn))
        cnt_clk <= 20'd0;
    else if(wt_msi_det_rgn) 
        cnt_clk <= cnt_clk + 20'd1;
    else ;
end

always @(posedge rc_core_clk,negedge rc_core_rstn)
begin
    if(!rc_core_rstn) begin
        int_err <= 1'b0;
        int_over <= 1'b0;
    end
    else begin
        if(~h2c_rstn)
            int_over <= 1'b0;
        else if(msi_detected == 1'b1 && cnt_det==`INT_NUM-1)
            int_over <= 1'b1;
        else ;
        if(~h2c_rstn)
            int_err <= 1'b0;
        else if(cnt_clk==OVER_TIME-1)
            int_err <= 1'b1;
        else ;
    end
end

initial 
begin
    mw_en = 0; //      task      mw_dw   mr_dw
    mr_en = 0;

    op_start = 0;
    casen_test_done = 0;
    mw_addr = 0;
    mw_len = 0;
    mw_data = 0;
    mw_data_be = 0;
    mw_data_en = 0;

    mr_addr = 0;
    mr_len = 0;
    mr_data_be = 0;

    c2h0_addr = 0;
    h2c0_addr = 0;
    h2c_rstn = 1;
    delay(200);


    @(init_cfg_over) ;
`ifdef CASE0 
    $display("CASE0 test start...");
    for (i=0;i<`CFG_NUM;i=i+1)
    begin           
            h2c0_addr = ADDR_BAR0_BA + cfg_iaddr_x[i];
            mw_dw(h2c0_addr,cfg_idt_x[i]);
    end
    for (i=0;i<`CFG_NUM;i=i+1)
    begin           
            h2c0_addr = ADDR_BAR0_BA + cfg_iaddr_x[i];
            mr_dw(h2c0_addr,tmp_memrd_data);
            cfg_odt_x[i] = tmp_memrd_data;
    end     
    $display("Register write&read test over!");
    mw_dw(ADDR_BAR0_BA+16'h1_0_04,32'd0);//stop

`elsif CASE1
    $display("CASE1 test start...");
    mw_dw(ADDR_BAR0_BA+32'h0008_0000,32'd1);
    //---c2h0 channel
    mr_dw(ADDR_BAR0_BA+16'h1_0_00,tmp_memrd_data[31:0]);
    $display("C2H0 version %h",tmp_memrd_data);

    for (i=0;i<`CFG_NUM;i=i+1)
    begin           
        h2c0_addr = ADDR_BAR0_BA + cfg_iaddr_x[i];
        mw_dw(h2c0_addr,cfg_idt_x[i]);  
    end
    
    while (~(int_err|int_over))
    begin
        @(posedge rc_core_clk) begin
            if(msi_detected) mr_dw(ADDR_BAR0_BA+16'h2_0_44,tmp_memrd_data[31:0]);
            else ;
        end
    end
    delay(10);
    $display("DMA-MWR test over,and rc receives  %h interrputs!",cnt_det);
    mw_dw(ADDR_BAR0_BA+16'h1_0_04,32'd0);//stop
    
`elsif CASE2

	$display("CASE2 test start...");
	//---c2h0 channel
	mr_dw(ADDR_BAR0_BA+16'h1_0_00,tmp_memrd_data[31:0]);
	$display("C2H0 version %h",tmp_memrd_data);

    mw_dw(32'h8008_0000,32'd1);//close loop back mode
	for (i=0;i<`CFG_NUM;i=i+1)
	begin		
		h2c0_addr = ADDR_BAR0_BA + cfg_iaddr_x[i];
		mw_dw(h2c0_addr,cfg_idt_x[i]);	
	end
	
	while (~int_over)
	begin
		@(msi_detected) mr_dw(ADDR_BAR0_BA+16'h2_0_44,tmp_memrd_data[31:0]);
		@(posedge rc_core_clk);
	end  

	$display("DMA-MWR test over,and rc receives  %h interrputs!",cnt_det);
	mw_dw(ADDR_BAR0_BA+16'h1_0_04,32'd0);//stop

`elsif CASE3 //test case3 need close mwr_axi4s0.v fifo rst
	$display("CASE3 test start...");
	mr_dw(ADDR_BAR0_BA+16'h1_0_00,tmp_memrd_data[31:0]);
	$display("C2H0 version %h",tmp_memrd_data);
    mw_dw(32'h8008_0000,32'd1);//close loop back mode
	for (i=0;i<`CFG_NUM/2;i=i+1)
	begin		
		h2c0_addr = ADDR_BAR0_BA + cfg_iaddr_x[i];
		mw_dw(h2c0_addr,cfg_idt_x[i]);	
	end
	@(msi_detected|int_err)    
    mr_dw(ADDR_BAR0_BA+16'h2_0_44,tmp_memrd_data[31:0]);

	mr_dw(ADDR_BAR0_BA+16'h1_0_40,tmp_memrd_data[31:0]);	
	$display("Address 16'h1_0_40 is %h",tmp_memrd_data[31:0]);
	mw_dw(ADDR_BAR0_BA+16'h1_0_04,32'd0);//stop
    delay(500);
    h2c_rstn = 1'b0;
    delay(10);
    h2c_rstn = 1'b1;
	$display("CASE3 test start again...");
    mw_dw(32'h8008_0000,32'd1);//close loop back mode
	for (i=`CFG_NUM/2;i<`CFG_NUM;i=i+1)
	begin		
		h2c0_addr = ADDR_BAR0_BA + cfg_iaddr_x[i];
		mw_dw(h2c0_addr,cfg_idt_x[i]);	
	end
	while (~int_over)
	begin
		@(msi_detected) mr_dw(ADDR_BAR0_BA+16'h2_0_44,tmp_memrd_data[31:0]);
		@(posedge rc_core_clk);
	end  
	delay(10);
	$display("MSI interrupt test over,and rc receives  %h interrputs!",cnt_det);
	mw_dw(ADDR_BAR0_BA+16'h1_0_04,32'd0);//stop

`elsif CASE4
    $display("CASE4 test start...");
    //---c2h0 channel
    mr_dw(ADDR_BAR0_BA+16'h1_0_00,tmp_memrd_data[31:0]);
    $display("C2H0 version %h",tmp_memrd_data);
    mw_dw(32'h8008_0000,32'd1);//close loop back mode
    for (i=0;i<`CFG_NUM;i=i+1)
    begin           
        h2c0_addr = ADDR_BAR0_BA + cfg_iaddr_x[i];
        mw_dw(h2c0_addr,cfg_idt_x[i]);  
    end

    @(int_err|int_over) delay(10);
    $display("DMA-MWR test over,and rc receives  %h interrputs!",cnt_det);
    mw_dw(ADDR_BAR0_BA+16'h1_0_04,32'd0);//stop
`elsif CASE5
    $display("CASE5 test start...");
    //---c2h0 channel
    mr_dw(ADDR_BAR0_BA+16'h1_0_00,tmp_memrd_data[31:0]);
    $display("C2H0 version %h",tmp_memrd_data);
    mw_dw(32'h8008_0000,32'd1);//close loop back mode
    for (i=0;i<`CFG_NUM;i=i+1)
    begin           
        h2c0_addr = ADDR_BAR0_BA + cfg_iaddr_x[i];
        mw_dw(h2c0_addr,cfg_idt_x[i]);  
    end

    while (~(int_err|int_over))
    begin
        @(posedge rc_core_clk) begin
            if(msi_detected) mr_dw(ADDR_BAR0_BA+16'h2_0_44,tmp_memrd_data[31:0]);
            else ;
        end
    end 
    delay(1000);
    $display("Completed flag test over,and rc receives  %h interrputs!",cnt_det);
    mw_dw(ADDR_BAR0_BA+16'h1_0_04,32'd0);//stop
`elsif CASE6
    $display("CASE6 test start...");
    mr_dw(ADDR_BAR0_BA+16'h1_0_00,tmp_memrd_data[31:0]);
    $display("C2H0 version %h",tmp_memrd_data);

    mw_dw(32'h8008_0000,32'd1);//close loop back mode
    for (i=0;i<`CFG_NUM/2;i=i+1)
    begin           
        h2c0_addr = ADDR_BAR0_BA + cfg_iaddr_x[i];
        mw_dw(h2c0_addr,cfg_idt_x[i]);  
    end

    $display("CASE6 random stop");
    rand_data = {$random}%4;
    //delay_time = rand_data
    delay({rand_data,11'h200});
    mw_dw(ADDR_BAR0_BA+16'h1_0_04,32'd0);//stop
    delay(100);
    h2c_rstn = 1'b0;
    delay(10);
    h2c_rstn = 1'b1;
    $display("CASE6 test restart...");
    mw_dw(32'h8008_0000,32'd1);//close loop back mode
    for (i=`CFG_NUM/2;i<`CFG_NUM;i=i+1)
    begin           
        h2c0_addr = ADDR_BAR0_BA + cfg_iaddr_x[i];
        mw_dw(h2c0_addr,cfg_idt_x[i]);  
    end
    
    while (~(int_err|int_over))//---When receive N interrupts, stop the process.
    begin   
        @(posedge rc_core_clk);
        if(msi_detected) 
        mr_dw(ADDR_BAR0_BA+16'h2_0_44,tmp_memrd_data[31:0]);
    end
    delay(10);
    $display("Ring descriptors test over,and rc receives  %h interrputs!",cnt_det);
    mw_dw(ADDR_BAR0_BA+16'h1_0_04,32'd0);//stop

`elsif CASE7
    $display("CASE7 test start...");
    //---c2h0 channel
    mr_dw(ADDR_BAR0_BA+16'h1_0_00,tmp_memrd_data[31:0]);
    $display("C2H0 version %h",tmp_memrd_data);
    mw_dw(32'h8008_0000,32'd1);//close loop back mode
    for (i=0;i<`CFG_NUM;i=i+1)
    begin           
        h2c0_addr = ADDR_BAR0_BA + cfg_iaddr_x[i];
        mw_dw(h2c0_addr,cfg_idt_x[i]);  
    end

    while (~(int_err|int_over))
    begin
        @(posedge rc_core_clk) begin
            if(msi_detected) mr_dw(ADDR_BAR0_BA+16'h2_0_44,tmp_memrd_data[31:0]);
            else ;
        end
    end 
    delay(200);
    $display("Completed flag test over,and rc receives  %h interrputs!",cnt_det);
    mw_dw(ADDR_BAR0_BA+16'h1_0_04,32'd0);//stop

`elsif CASE9
    $display("CASE9 test start...");
    //---c2h0 channel
    mr_dw(ADDR_BAR0_BA+16'h1_0_00,tmp_memrd_data[31:0]);
    $display("C2H0 version %h",tmp_memrd_data);
    mw_dw(32'h8008_0000,32'd1);//close loop back mode
    for (i=0;i<`CFG_NUM;i=i+1)
    begin           
        h2c0_addr = ADDR_BAR0_BA + cfg_iaddr_x[i];
        mw_dw(h2c0_addr,cfg_idt_x[i]);  
    end

    while (~(int_err|int_over))
    begin
        @(posedge rc_core_clk) begin
            if(msi_detected) mr_dw(ADDR_BAR0_BA+16'h2_0_44,tmp_memrd_data[31:0]);
            else ;
        end
    end 
    delay(200);
    $display("Completed flag test over,and rc receives  %h interrputs!",cnt_det);
    mw_dw(ADDR_BAR0_BA+16'h1_0_04,32'd0);//stop

`elsif CASE11
    $display("CASE11 test start...");
    //---C2H0 channel
    mr_dw(ADDR_BAR0_BA+16'h1_0_00,tmp_memrd_data[31:0]);
    $display("C2H0 version %h",tmp_memrd_data);
    mw_dw(32'h8008_0000,32'd1);//close loop back mode
    for (i=0;i<`CFG_NUM;i=i+1)
    begin           
        h2c0_addr = ADDR_BAR0_BA + cfg_iaddr_x[i];
        mw_dw(h2c0_addr,cfg_idt_x[i]);  
    end

    while (~(int_err|int_over))
    begin
        @(posedge rc_core_clk) begin
            if(msi_detected) mr_dw(ADDR_BAR0_BA+16'h2_0_44,tmp_memrd_data[31:0]);
            else ;
        end
    end 
    delay(200);
    $display("Completed flag test over,and rc receives  %h interrputs!",cnt_det);
    mw_dw(ADDR_BAR0_BA+16'h1_0_04,32'd0);//stop

`elsif CASE12
    $display("CASE12 test start...");
    //---C2H0 channel
    mr_dw(ADDR_BAR0_BA+16'h1_0_00,tmp_memrd_data[31:0]);
    $display("C2H0 version %h",tmp_memrd_data);
    mw_dw(32'h8008_0000,32'd1);//close loop back mode
    for (i=0;i<`CFG_NUM;i=i+1)
    begin           
        h2c0_addr = ADDR_BAR0_BA + cfg_iaddr_x[i];
        mw_dw(h2c0_addr,cfg_idt_x[i]);  
    end
    $display("waitting interrupt...");
    while (~(int_err|int_over))
    begin
        @(posedge rc_core_clk) begin
            if(msi_detected) mr_dw(ADDR_BAR0_BA+16'h2_0_44,tmp_memrd_data[31:0]);
            else ;
        end
    end 
    delay(200);
    $display("Completed flag test over,and rc receives  %h interrputs!",cnt_det);
    mw_dw(ADDR_BAR0_BA+16'h0_0_04,32'd0);//stop

`elsif CASE13
    $display("CASE13 test start...");
    //---C2H0 channel
    mr_dw(ADDR_BAR0_BA+16'h1_0_00,tmp_memrd_data[31:0]);
    $display("C2H0 version %h",tmp_memrd_data);
    mw_dw(32'h8008_0000,32'd1);//close loop back mode
    for (i=0;i<`CFG_NUM;i=i+1)
    begin           
        h2c0_addr = ADDR_BAR0_BA + cfg_iaddr_x[i];
        mw_dw(h2c0_addr,cfg_idt_x[i]);  
    end
    $display("waitting interrupt...");
    while (~(int_err|int_over))
    begin
        @(posedge rc_core_clk) begin
            if(msi_detected) mr_dw(ADDR_BAR0_BA+16'h2_0_44,tmp_memrd_data[31:0]);
            else ;
        end
    end 
    delay(200);
    $display("Completed flag test over,and rc receives  %h interrputs!",cnt_det);
    mw_dw(ADDR_BAR0_BA+16'h0_0_04,32'd0);//stop
`elsif CASE18
    $display("CASE18 test start...");
    //---C2H0 channel
    mr_dw(ADDR_BAR0_BA+16'h0_0_00,tmp_memrd_data[31:0]);
    $display("H2C0 version %h",tmp_memrd_data);
    mw_dw(32'h8008_0000,32'd2);//close loop back mode
    for (i=0;i<`CFG_NUM;i=i+1)
    begin           
        h2c0_addr = ADDR_BAR0_BA + cfg_iaddr_x[i];
        mw_dw(h2c0_addr,cfg_idt_x[i]);  
    end
    delay(2000);
    mw_dw(ADDR_BAR0_BA+16'h4_0_8c,32'd5);//add credit value
    $display("waitting interrupt...");
    while (~(int_err|int_over))
    begin
        @(posedge rc_core_clk) begin
            if(msi_detected) mr_dw(ADDR_BAR0_BA+16'h2_0_44,tmp_memrd_data[31:0]);
            else ;
        end
    end 
    delay(100);
    $display("Completed flag test over,and rc receives  %h interrputs!",cnt_det);
    mw_dw(ADDR_BAR0_BA+16'h0_0_04,32'd0);//stop

`elsif CASE19
    $display("CASE19 test start...");
    //---C2H0 channel
    mr_dw(ADDR_BAR0_BA+16'h0_0_00,tmp_memrd_data[31:0]);
    $display("H2C0 version %h",tmp_memrd_data);
    mw_dw(32'h8008_0000,32'd2);//close loop back mode
    for (i=0;i<`CFG_NUM;i=i+1)
    begin           
        h2c0_addr = ADDR_BAR0_BA + cfg_iaddr_x[i];
        mw_dw(h2c0_addr,cfg_idt_x[i]);  
    end
    $display("waitting interrupt...");
    while (~(int_err|int_over))
    begin
        @(posedge rc_core_clk) begin
            if(msi_detected) mr_dw(ADDR_BAR0_BA+16'h2_0_44,tmp_memrd_data[31:0]);
            else ;
        end
    end 
    delay(100);
    $display("Completed flag test over,and rc receives  %h interrputs!",cnt_det);
    mw_dw(ADDR_BAR0_BA+16'h0_0_04,32'd0);//stop

`elsif CASE41
    $display("CASE41 test start...");
    mr_dw(ADDR_BAR0_BA+16'h0_0_00,tmp_memrd_data[31:0]);
    $display("H2C0 version %h",tmp_memrd_data);
    mr_dw(ADDR_BAR0_BA+16'h1_0_00,tmp_memrd_data[31:0]);
    $display("C2H0 version %h",tmp_memrd_data);
    for (i=0;i<`CFG_NUM;i=i+1)
    begin           
        h2c0_addr = ADDR_BAR0_BA + cfg_iaddr_x[i];
        mw_dw(h2c0_addr,cfg_idt_x[i]);  
    end
    mw_dw(32'h8008_0000,32'd3);//close loop back mode
    mw_dw(ADDR_BAR0_BA+16'h1_0_04,{31'h27C1F03,1'b1});//start
    mw_dw(ADDR_BAR0_BA+16'h0_0_04,{31'h7C1F03,1'b1});//start
    $display("engine run");
    while(~(int_err|int_over))
    begin
        @(posedge rc_core_clk) begin
            if(msi_detected) mr_dw(ADDR_BAR0_BA+16'h2_0_44,tmp_memrd_data[31:0]);
            else ;
        end
    end
    delay(100);
    mw_dw(ADDR_BAR0_BA+16'h1_0_04,32'd0);//stop
    mw_dw(ADDR_BAR0_BA+16'h0_0_04,32'd0);//stop
    $display("Loopback mode test over,and rc receives  %h interrputs!",cnt_det); 
`endif
        
casen_test_done = 1'b1;

end

task automatic delay;
    input [31:0] dc;//ori[3:0]
    begin
        repeat (dc) @ (posedge clk);
        # 1;
    end
endtask

task automatic mw_dw(
    input [`DT_WD-1:0] address,
    input [31:0] data
);      
    begin
        @(posedge rc_core_clk);
        mw_en = 1;
        @(posedge rc_core_clk);
        mw_addr = address;
        mw_data = {96'd0, data};
        mw_data_en = 1;
        mw_len = 12'd4;
        mw_data_be = 8'h0F;
        @(posedge rc_core_clk);
        mw_data_en = 0;
        @(posedge rc_core_clk);
        op_start = 1;
        @(posedge rc_core_clk);
        op_start = 0;
        wait (mw_op_over);
        mw_en = 0;
        @(posedge rc_core_clk);
        end
endtask

// MEM RD
task automatic mr_dw(
    input  [`DT_WD-1:0] address,
    output [31:0] data
);
    begin
        @(posedge rc_core_clk);
        mr_en = 1;
        @(posedge rc_core_clk);
        mr_addr = address;
        mr_len = 12'd4;
        mr_data_be = 8'h0F;
        @(posedge rc_core_clk);
        op_start = 1;
        @(posedge rc_core_clk);
        op_start = 0;
        wait (mr_data_vld);
        data = mr_data;
        wait (mr_op_over);
        @(posedge rc_core_clk);
        mr_en = 0;
        @(posedge rc_core_clk);
        end
endtask



endmodule
