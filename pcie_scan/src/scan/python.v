module python
(
//system port
input  clkin,
//input  reset,
//input  scan_in,
//input  paper_in,
//input  onoff_in,
//input  borderA_in,
//input  borderB_in,
//input  deflectionA_in,
//input  deflectionB_in,
// EXTRI trigger
input  [15:0] in1,
input  [15:0] in2,
output vsmp1,rsmp1,mclk1,
output vsmp2,rsmp2,mclk2, 
output SCK1,SEN1,
inout  SDI1,
//output SCK2,SEN2,
//inout  SDI2,
//cis port
output cisclk1,si1,cism1,
output cisclk2,si2,cism2,
output cisclk3,si3,cism3,
output cisclk4,si4,cism4,
output cisclk5,si5,cism5,
output cisclk6,si6,cism6,
//cis led port
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
//output test   ,
//pwm
//output        o_pwm0,

//output        locked,
//output reg    s2mm_fsync,

//input         APB_M_0_rstn,
//input         APB_M_0_clk,

//output reg[7:0]  S_AXIS_S2MM_0_tdata,
//output reg       S_AXIS_S2MM_0_tlast,
//input            S_AXIS_S2MM_0_tready,
//output reg       S_AXIS_S2MM_0_tvalid,

//output           scan_out,
//output           auto_scan_out,
//output           scan_origin     ,
//output           paper_out    ,
//output           onoff_out    ,
//output           border_out   ,
//output           deflection_out,
//output         triger_err_irq,

//input       start       ,
//input       stop        
  output x0_p					,
  output x1_p					,
  output x2_p					,
  output x3_p					,
  output xclk_p					,
  
  output         APB_M_0_clk,
  output rst_sof_n,
  output  clk_cis,
  output mclk,
  output vsmp,
  output clk_wram,
  input ubus_rx,
  output ubus_tx,
//  input [31:0] adc1_cfg_dat,
//  input        en_adc1_cfg
output [7:0]data_out,
output  frontwr,//synthesis keep
output  tlast,
output  si,
    input    cl_test,
    input    [15:0] st_sp,
    input    en_adc1_cfg,
    input    [31:0]   adc1_cfg_dat,
    input dpi_mode,
    input [31 : 0] sp_time,//行频率
    input rgb_en,
input [15 : 0] red_times1,
input [15 : 0] green_times1,
input [15 : 0] blue_times1,
input color_en
);




/////////////////////////////////////////////
wire  test;
wire  scan_in;
wire  paper_in;
wire  onoff_in;
wire  borderA_in;
wire  borderB_in;
wire  deflectionA_in;
wire  deflectionB_in;
//wire  SCK1,SEN1;
//wire  SDI1;
wire  SCK2,SEN2;
wire  SDI2;
wire  o_pwm0;
wire  locked;
reg   s2mm_fsync;
wire         APB_M_0_rstn;
//wire         APB_M_0_clk;
assign APB_M_0_clk = clkin;
wire [31:0]  APB_M_0_paddr;
wire         APB_M_0_penable;
wire  [31:0] APB_M_0_prdata;
wire  [0:0]  APB_M_0_pready;
wire [0:0]   APB_M_0_psel;
wire  [0:0]  APB_M_0_pslverr;
wire [31:0]  APB_M_0_pwdata;
wire         APB_M_0_pwrite;
wire [31:0]   AXI_LIT4_CLOCK_araddr;
wire [2:0]    AXI_LIT4_CLOCK_arprot;
wire          AXI_LIT4_CLOCK_arready;
wire          AXI_LIT4_CLOCK_arvalid;
wire [31:0]   AXI_LIT4_CLOCK_awaddr;
wire [2:0]    AXI_LIT4_CLOCK_awprot;
wire          AXI_LIT4_CLOCK_awready;
wire          AXI_LIT4_CLOCK_awvalid;
wire          AXI_LIT4_CLOCK_bready;
wire  [1:0]   AXI_LIT4_CLOCK_bresp;
wire          AXI_LIT4_CLOCK_bvalid;
wire  [31:0]  AXI_LIT4_CLOCK_rdata;
wire          AXI_LIT4_CLOCK_rready;
wire  [1:0]   AXI_LIT4_CLOCK_rresp;
wire          AXI_LIT4_CLOCK_rvalid;
wire [31:0]   AXI_LIT4_CLOCK_wdata;
wire          AXI_LIT4_CLOCK_wready;
wire [3:0]    AXI_LIT4_CLOCK_wstrb;
reg           AXI_LIT4_CLOCK_wvalid;
reg[7:0]  	  S_AXIS_S2MM_0_tdata;
reg           S_AXIS_S2MM_0_tlast;
wire          S_AXIS_S2MM_0_tready;
assign        S_AXIS_S2MM_0_tready = 1;
reg           S_AXIS_S2MM_0_tvalid;
wire          scan_out;
wire          auto_scan_out;
wire          scan_origin;
wire          paper_out;
wire          onoff_out;
wire          border_out;
wire          deflection_out;
wire          triger_err_irq;
reg           start=0;
wire          stop ;
assign stop = 1;
/////////////////////////////////////////////////////////

//wire  clk_cis;
reg [15:0]start_cnt=0;
always@(posedge clk_cis)
begin
if(start_cnt==24000)
begin
start <=1;
end
else
begin
start_cnt <= start_cnt + 1;
end
end
wire  csen;
wire  [7:0] din1;//synthesis keep
wire  [7:0] din1b;//synthesis keep
wire  [7:0] din2;//synthesis keep
wire  [7:0] din2b;//synthesis keep
wire  [7:0] din3,din3b;
wire	[7:0] din4,din4b;
wire	[7:0] dout1;//synthesis keep
wire	[7:0] dout2;//synthesis keep
wire	[7:0] dout3,dout4;
wire  [7:0] douta;
wire  [7:0] doutb;
wire  rd_ack;
wire  empty_sdram;
wire  en_frameset;
wire  [7:0] dout;
wire  button_start;//PC5
wire  over;
wire  en_a,en_b;

wire  StartStop_flag;
wire  soft_rstn;
assign soft_rstn = 1;
wire  en_stop;
wire  enr,enrb;
wire  error;
wire  exp;
wire  flag_just;
wire  frontrd;

wire  line_ctrl;
//wire  mclk;
//wire  vsmp;
wire  adcfgclk;
wire  mul2;
wire  over_ALTERA_SYNTHESIZED;
wire  rd_trig;
wire  [14:0] rdaddr1;//synthesis keep
wire  [14:0] rdaddr2;//synthesis keep
wire  [14:0] wraddr1;
wire  [14:0] wraddr2;
wire  [14:0] wraddr_r;
wire  rdclk;
wire  rden1,rden1b;
wire  rden2,rden2b;

wire  RST_n;
reg   RST_n_d0;

wire  switch_out;
wire  trig;

wire  wrclk;
wire  SYNTHESIZED_WIRE_0;
wire  SYNTHESIZED_WIRE_1;
wire  SYNTHESIZED_WIRE_2;
wire  SYNTHESIZED_WIRE_3;
wire  SYNTHESIZED_WIRE_4;
wire  SYNTHESIZED_WIRE_5;
wire  SYNTHESIZED_WIRE_6;
wire  SYNTHESIZED_WIRE_9;
wire  SYNTHESIZED_WIRE_11;

//wire    Extri;
 
wire    clr_exp; 
assign clr_exp = 1;
wire    line_done; 


wire[7:0]  i_ctrl0;
wire[15:0] i_divisor0;
wire[15:0] i_period0;
wire[15:0] i_dc0;

//wire[7:0]  i_ctrl1;
//wire[15:0] i_divisor1;
//wire[15:0] i_period1;
//wire[15:0] i_dc1;
wire[15:0] line_cnt;
wire[15:0] frame_cnt;
wire[15:0] framecnt_tx;


//wire       start       ;
//wire       stop        ;
wire       stop_auto        ;
wire       mul         ;
wire       button      ;
wire       A           ;
wire       B           ;
wire       trigger_flag;
wire       finished    ;

wire       psen;
wire       psincdec;
wire       psdone;

wire       frame_done ;

wire       fifo_act;

wire [31:0] delay_config;
reg [15:0] cnt_frame;
reg [15:0] cnt_line;
reg[15:0] frame_cnt_d0, frame_cnt_d1;
reg [1:0]dpi_set_d;
wire[1:0]dpi_set;

assign SYNTHESIZED_WIRE_5 = 0;
assign SYNTHESIZED_WIRE_9 = 0;
assign SYNTHESIZED_WIRE_11 = 0;


//assign  test=enr;

wire   sw_button; 


assign SYNTHESIZED_WIRE_0 =  button  | sw_button;
//assign en_b = !B;
//assign Extri = !A;



//wire [15 : 0] gray_times1;
//wire [15 : 0] red_times1='h0E10;
//wire [15 : 0] green_times1='h0E10;
//wire [15 : 0] blue_times1='h0E10; 
wire [15 : 0] red_times2='h0E10;
wire [15 : 0] green_times2='h0E10;
wire [15 : 0] blue_times2='h0E10;
wire          colo_mode=1;

//wire [31 : 0] sp_time=32'h1fff0000;//行频率
wire [31 : 0] sp_time2=32'h1fff0000;

wire locked1;

//wire divide2; 
//wire divide3; 
//wire divide4; 
//wire normal ; 

//wire dpi_mode=1;
wire dpi200;
assign dpi200=0;


wire [12:0] HoriPixNum;
//wire [15:0] st_sp;
//wire        clr_err;

//assign HoriPixNum = dpi_mode ? 2592 : 5184; //216
//assign HoriPixNum = dpi_mode ? 3672 : 7344; //310
//assign HoriPixNum = dpi_mode ? 432 : 864;   //515
assign HoriPixNum = dpi_set[0] ? 432 : 864;


//sensor
wire [5:0] div_reg;
wire [9:0] samp_reg;
wire [9:0] low_reg;
wire [7:0] div_reg_n;
wire [11:0] samp_reg_n;
wire [11:0] diff_reg;
wire [11:0] diff_out;
wire [11:0] low_cntA;
wire [11:0] low_cntB;
wire [31:0]autotig_dly_time;

wire clkin_o;
    
//    lscc_sensor    sensor(
//				. clk(APB_M_0_clk),
//				. rst_n(RST_n),
//				. scan_in(scan_in),
//				. paper_in(paper_in),
//				. onoff_in(onoff_in),
//                . div_reg(div_reg),
//                . samp_reg(samp_reg),
//                . low_reg(low_reg),
//                . autotig_dly_time(autotig_dly_time),
//				. scan_out(scan_out),
//				. auto_scan_out(auto_scan_out),
//				. scan_origin(scan_origin),
//				. paper_out(paper_out),
//				. onoff_out(onoff_out)
//				);
				
//				 exboard_sensor    newsensor(
//				. clk(APB_M_0_clk),
//				. rst_n(RST_n),
//				. borderA_in(borderA_in),
//				. borderB_in(borderB_in),
//				. deflectionA_in(deflectionA_in),
//				. deflectionB_in(deflectionB_in),
//                . div_reg(div_reg_n),
//                . samp_reg(samp_reg_n),
//                . diff_reg(diff_reg),
//                . diff_out(diff_out),
//                .low_cntA(low_cntA),
//                .low_cntB(low_cntB),
//				. border_out(border_out),
//				. deflection_out(deflection_out)
//				);						
//------------------------PLL------------------------------

/*
pll u_pll (
    .clk_out1(clk_cis),
    .clk_out2(mclk),
    .reset(reset),
    .locked(locked1),
    .clk_in1(clkin)

);

*/

reg start_d0, start_d1, start_d2, start_d3, start_d4, start_d5, start_d6, start_d7, start_d8, start_d9,start_d10;
wire start_delay;
always @ (posedge APB_M_0_clk) begin
  if (~rst_sof_n) begin
     start_d0 <= 1'b0;
	 start_d1 <= 1'b0;
	 start_d2 <= 1'b0;
	 start_d3 <= 1'b0;
	 start_d4 <= 1'b0;
	 start_d5 <= 1'b0;
	 start_d6 <= 1'b0;
	 start_d7 <= 1'b0;
	 start_d8 <= 1'b0;
	 start_d9 <= 1'b0;
	 start_d10 <= 1'b0;
	 end
  else begin
     start_d0 <= start;
	 start_d1 <= start_d0; 
	 start_d2 <= start_d1;
	 start_d3 <= start_d2;
	 start_d4 <= start_d3;
	 start_d5 <= start_d4;
	 start_d6 <= start_d5;
	 start_d7 <= start_d6;
	 start_d8 <= start_d7;
	 start_d9 <= start_d8;  
	 start_d10 <= start_d9;  
     end
end
assign start_delay=start|start_d0|start_d1|start_d2|start_d3|start_d4|start_d5|start_d6|start_d7|start_d8|start_d9|start_d10;

wire pos_start;

assign pos_start = ~start_d1 & start_d0;

reg pos_start0,pos_start1,pos_start2,pos_start3,pos_start4,pos_start5,pos_start6,pos_start7,pos_start8,pos_start9,pos_start10;
wire pos_start_exp;
always @ (posedge APB_M_0_clk) begin
  if (~rst_sof_n) begin
     pos_start0 <= 1'b0;
	 pos_start1 <= 1'b0;
	 pos_start2 <= 1'b0;
	 pos_start3 <= 1'b0;
	 pos_start4 <= 1'b0;
	 pos_start5 <= 1'b0;
	 pos_start6 <= 1'b0;
	 pos_start7 <= 1'b0;
	 pos_start8 <= 1'b0;
	 pos_start9 <= 1'b0;
	 pos_start10 <= 1'b0;
	 end
  else begin
     pos_start0 <= pos_start;    
     pos_start1 <= pos_start0;
     pos_start2 <= pos_start1;
     pos_start3 <= pos_start2;
     pos_start4 <= pos_start3;
     pos_start5 <= pos_start4;
     pos_start6 <= pos_start5;
     pos_start7 <= pos_start6;
     pos_start8 <= pos_start7;
     pos_start9 <= pos_start8;
     pos_start10 <= pos_start9;
     end
end

assign pos_start_exp=pos_start|pos_start0|pos_start1|pos_start2|pos_start3|pos_start4|pos_start5|pos_start6|pos_start7|pos_start8|pos_start9|pos_start10;

reg  tlast_0,tlast_1;
wire pos_tlast;

always @ (posedge APB_M_0_clk) begin
  if (~rst_sof_n) begin
     tlast_0 <= 0;
     tlast_1 <= 0;
     end
  else   begin
     tlast_0 <= tlast;
     tlast_1 <= tlast_0;
     end
end

assign pos_tlast= ~tlast_1&tlast_0;

reg [31:0] linecnt_tx;

always @ (posedge APB_M_0_clk) begin
  if (~rst_sof_n)
     linecnt_tx <= 32'b0;
  else if (pos_start)
     linecnt_tx <= 32'b0;
  else if (pos_tlast)
     linecnt_tx <= linecnt_tx + 1'b1;
end





reg   psen_d0,psen_d1;
wire  pos_psen;

always @ (posedge APB_M_0_clk) begin
  if (~rst_sof_n) begin
      psen_d0 <= 1'd0;
      psen_d1 <= 1'd0;
    end
  else begin
      psen_d0 <= psen;
      psen_d1 <= psen_d0;
   end
end

assign pos_psen = ~psen_d1 & psen_d0;

reg   clr_ps_done_d0,clr_ps_done_d1;
wire  clr_posdone;

always @ (posedge APB_M_0_clk) begin
  if (~rst_sof_n) begin
      clr_ps_done_d0 <= 1'd0;
      clr_ps_done_d1 <= 1'd0;
    end
  else begin
      clr_ps_done_d0 <= clr_posdone;
      clr_ps_done_d1 <= clr_ps_done_d0;
   end
end

wire   pos_clrposdone;

assign pos_clrposdone = ~clr_ps_done_d1 & clr_ps_done_d0;

reg ps_done;

always @ (posedge APB_M_0_clk) begin
  if (~rst_sof_n)
       ps_done <= 1'b0;  
  else if (psdone)
       ps_done <= 1'b1;  
  else if (pos_clrposdone)
       ps_done <= 1'b0;  
end

wire I_3_5pclk; //synthesis keep 
pll u_pll(
  .refclk(clkin),
  .reset(1'b0),
  .lock(locked1),
  .clk0_out(),
  .clk1_out(clk_cis),
  .clk2_out(mclk),
  .clk3_out(vsmp),
  .clk4_out(clk_wram)
//  .clk5_out(I_3_5pclk),
//  .clk6_out(clk_ADC_config)
);

pll3 u_pll3(
  .refclk(clkin),
  .reset(1'b0),
  .lock(),
  .clk0_out(I_3_5pclk),
  .clk1_out(clk_ADC_config)
);

assign debug = {psen,psincdec,psdone};



wire apb_clk;

assign apb_clk = APB_M_0_clk;

//------------------------reset------------------------------



SYNC_ASYNC_RST SYNC_ASYNC_RST
(
   .RST(reset_n),
   .CLK_IN(APB_M_0_clk),
   .RST_N(RST_n)
);
//always@(posedge apb_clk)begin
//RST_n_d1<=RST_n_d0
//RST_n   <=
//end
//always@(posedge apb_clk)
//RST_n_d0<=RST_n;

assign reset_n = locked1;
assign locked  = locked1;
assign sys_rst_done = RST_n;
assign rst_sof_n  = RST_n & soft_rstn;

//------------------------trigger select------------------------------
wire frame_start;
wire trigerInner;
wire trigerInner_tmp;
wire Intri1;
wire Intri2;



glitch_filter #(
     .GLITCH_FILTER_SIZE(16)
) u_glitch_filter
(
  .clk(clk_cis),
  .restn(RST_n),
  .in(Extri),
  .out(en_a)     // Extenal trigger

);



//assign en_a = (trigger_flag == 0) ? Extri : Intri;
//assign en_a = Extri ;

reg en_a_d0,en_a_d1;

always @ (posedge clk_cis) begin
    if (~RST_n)
      begin
        en_a_d0 <= 1'b0;
        en_a_d1 <= 1'b0;
      end
     else if (~soft_rstn)
      begin
        en_a_d0 <= 1'b0;
        en_a_d1 <= 1'b0;
      end
     else begin
        en_a_d0 <= en_a;
        en_a_d1 <= en_a_d0;
     end 
end





trigger trigger
(
   .clk8m(clk_cis),
   .rst_n(rst_sof_n),
   .sp_time(sp_time[31:16]),
   .sp_time2(sp_time2[31:16]),
   .line1(Intri1),//
   .line2(Intri2)
);
//------------------------div------------------------------

gen_sp  gen_sp(
     .reset_n    (  rst_sof_n),
     .frame_start1(  trigerInner1 ),              //internal trigger or external trigger
     .frame_start2(  trigerInner2 ),
     .clkcis     (  clk_cis     ),
     .color_mode (  colo_mode   ),
     .y_pixel    (  16'b1        ),
     .line_done  (  line_done   ),
     .sp_pad     (              ),
     .sp_led     (  trigerInner_tmp            ),//capture the rising edge of this signal to enable ram's cs signal      organized by cisclk
     .sp_sampling(              )
);



wire        line_trig;
//wire [31:0] max_trig_cnt;

//div_mul	div_mul
//(
//   .clk_8m(clk_cis),
//   .rst_n(rst_sof_n),
//   .max_trig_cnt(max_trig_cnt),
//   .divide2(SYNTHESIZED_WIRE_1),
//   .divide3(SYNTHESIZED_WIRE_2),
//   .divide4(SYNTHESIZED_WIRE_3),
//   .normal (SYNTHESIZED_WIRE_4),
//   .mul2(mul2),
//   .encoder(en_a_d1 & frame_start),    //External trigger
//   .encoderb(en_b),
//   .sample(en_stop),
//   .line_trig(line_trig),
//   .warning(warning),//
//   .clr_err(clr_err),
//   .error(error)//
//);

//assign trigerInner = (trigger_flag == 0)&(~error) ? line_trig : Intri1;
//assign trigerInner = (trigger_flag == 0)&(~error) ? line_trig : Intri2;
assign trigerInner1=Intri1;
assign trigerInner2=Intri2;

//assign {warning,error,led_start,led_stop} = {1'b0,1'b0,1'b0,1'b1};
//------------------------bing bang------------------------------
op  op
(
   .clk24m(clk_wram),
   .rst_n(rst_sof_n),
   //.SI(trigerInner),
   .SI(trigerInner_tmp),
   .csen(csen)
);
//------------------------filter------------------------------
xiaodou xiaodou
(
   .clk_cis(clk_cis),
   .rst_n(rst_sof_n),
   .switch(SYNTHESIZED_WIRE_0),
   .switch_out(switch_out)
);
//------------------------signal------------------------------



always @ (posedge APB_M_0_clk) begin
  if (~rst_sof_n) begin
     dpi_set_d<=2'b00;
	 end
  else if(s2mm_fsync)begin
     dpi_set_d<= dpi_mode;    
     end
end
assign dpi_set=dpi_set_d;


signal	signal
(
   .rst_n(rst_sof_n),
   .clk(clk_cis),       //8m
   .frame_start(frame_start),
   .CC1(trigerInner_tmp),      //this signal is coming from module gen_sp
//   .pos_frame_end(pos_frame_end),
   .start(start_delay),
   .stop(stop),
   .stop_auto(stop_auto),
   .finished(finished),
   .button(switch_out),
   .sp_time(sp_time[15:0]), //sp_time[15:0]
    .intri_time(sp_time[31:16]),
   .adj(SYNTHESIZED_WIRE_9),
   .allempty(),
   .CISSI(si),
   .triger(trig),
   .exp(exp),
   .rd_triger(rd_trig),
   .softstop(over_ALTERA_SYNTHESIZED),
   .button_start(button_start),
   .flag_just(flag_just),
   .led_start(led_start),
   .led_stop(led_stop),
   .line_done(line_done),
   .frame_done(frame_done),
   .clr_exp(),
   .dpi_mode(dpi_set),
   .en_soft(en_stop)
);


assign frame_done=line_done&(cnt_line==0);
assign stop_auto=en_frameset? ( (cnt_frame==frame_cnt_d1+1)?1'b1:1'b0  ) : 1'b0 ;
reg rd_trig_d0,rd_trig_d1;

always @ (posedge APB_M_0_clk) begin
  if (~rst_sof_n) begin
       rd_trig_d0<= 1'b0;
       rd_trig_d1<= 1'b0;
    end
  else begin
      rd_trig_d0 <= rd_trig;
      rd_trig_d1 <= rd_trig_d0;
   end
end







CISOUT	CISOUT(
   .CISCLK(clk_cis),
   .CISSI(si),
   .dpi_mode(dpi_mode),
   .CISCLK1(cisclk1),
   .CISCLK2(cisclk2),
   .CISCLK3(cisclk3),
   .CISCLK4(cisclk4),
   .CISCLK5(cisclk5),
   .CISCLK6(cisclk6),

   .CISSI1(si1),
   .CISSI2(si2),
   .CISSI3(si3),
   .CISSI4(si4),
   .CISSI5(si5),
   .CISSI6(si6),

   .CISM1(cism1),
   .CISM2(cism2),
   .CISM3(cism3),
   .CISM4(cism4),
   .CISM5(cism5),
   .CISM6(cism6)

);
//------------------------exposure------------------------------
reg trigerInner_d0,trigerInner_d1;

always @ (posedge clk_cis) begin
    if (~RST_n)
      begin
        trigerInner_d0 <= 1'b0;
        trigerInner_d1 <= 1'b0;
      end
    else if (~soft_rstn)
      begin
        trigerInner_d0 <= 1'b0;
        trigerInner_d1 <= 1'b0;
      end
     else begin
        trigerInner_d0 <= trigerInner;
        trigerInner_d1 <= trigerInner_d0;
     end 
end

wire pos_trigerInner;

assign  pos_trigerInner = ~trigerInner_d1 & trigerInner_d0;



reg frame_start_d0,frame_start_d1;

always @ (posedge clk_cis) begin
    if (~RST_n)
      begin
        frame_start_d0 <= 1'b0;
        frame_start_d1 <= 1'b0;
      end
    else if (~soft_rstn)
      begin
        frame_start_d0 <= 1'b0;
        frame_start_d1 <= 1'b0;
      end
     else begin
        frame_start_d0 <= frame_start;
        frame_start_d1 <= frame_start_d0;
     end 
end

wire pos_frame_start;

assign  pos_frame_start = ~frame_start_d1 & frame_start_d0;


wire  sync_pos_frame_start;
reg   pos_frame_start_d0, pos_frame_start_d1;

always @ (posedge APB_M_0_clk) begin
  if (~rst_sof_n) begin
      pos_frame_start_d0 <= 1'd0;
      pos_frame_start_d1 <= 1'd0;
    end
  else begin
      pos_frame_start_d0 <= pos_frame_start;
      pos_frame_start_d1 <= pos_frame_start_d0;
   end
end

assign sync_pos_frame_start = ~pos_frame_start_d1 & pos_frame_start_d0;



cis_exposure u_cis_exposure1(
   .clk        ( clk_cis         ),
   .rst_n      ( rst_sof_n & clr_exp ),
   .pos_start  ( pos_start_exp),
   .color_mode ( colo_mode       ),
   .pos_frame  ( pos_frame_start_d0 ),
   .sp         ( exp            ),
   //.sp         ( trig            ),
   //.sp         ( pos_trigerInner ),
   .r_times    ( red_times1       ),
   .g_times    ( green_times1     ),
   .b_times    ( blue_times1      ),
   .led_enr    ( ledr1            ),
   .led_eng    ( ledg1            ),
   .led_enb    ( ledb1            ),
   .led_oe_n   (                 )

);

cis_exposure u_cis_exposure2(
   .clk        ( clk_cis         ),
   .rst_n      ( rst_sof_n & clr_exp ),
   .pos_start  (pos_start_exp),
   .color_mode ( colo_mode       ),
   .pos_frame  ( pos_frame_start_d0 ),
   .sp         ( exp            ),
   //.sp         ( trig            ),
   //.sp         ( pos_trigerInner ),
   .r_times    ( red_times2       ),
   .g_times    ( green_times2     ),
   .b_times    ( blue_times2      ),
   .led_enr    ( ledr2            ),
   .led_eng    ( ledg2            ),
   .led_enb    ( ledb2            ),
   .led_oe_n   (                 )

);

assign  led1A_r   = (color_en ? ledr1 : (ledr1 || ledg1 || ledb1)) && rgb_en;
assign  led1A_g   = (color_en ? ledg1 : (ledr1 || ledg1 || ledb1)) && rgb_en;
assign  led1A_b   = (color_en ? ledb1 : (ledr1 || ledg1 || ledb1)) && rgb_en;
assign  led2A_r   = ledr1 && rgb_en;
assign  led2A_g   = ledg1 && rgb_en;
assign  led2A_b   = ledb1 && rgb_en;

assign  led1B_r   = ledr2;
assign  led1B_g   = ledg2;
assign  led1B_b   = ledb2;
assign  led2B_r   = ledr2;
assign  led2B_g   = ledg2;
assign  led2B_b   = ledb2;



//------------------------ad clock and config------------------------------
//AD_Clock AD_Clock(
//    .VSMP(vsmp),
//    .MCLK(mclk),
//    .RSMP(SYNTHESIZED_WIRE_11),
//    .VSMP1(vsmp1),
//    .RSMP1(rsmp1),
//    .MCLK1(mclk1),
//    .VSMP2(vsmp2),
//    .RSMP2(rsmp2),
//    .MCLK2(mclk2),
//    .vsp_config(delay_config)

//);
assign vsmp1 = vsmp;
assign vsmp2 = vsmp;
assign mclk1 = mclk;
assign mclk2 = mclk;

//wire [31:0] adc1_cfg_dat;
//wire        en_adc1_cfg;
//assign adc1_cfg_dat = 0;
reg[31:0]   adc1_cfg_dat_d0,adc1_cfg_dat_d1;
reg         en_adc1_cfg_d0,en_adc1_cfg_d1,en_adc1_cfg_d2;
wire        pos_en_adc1_cfg;
wire[15:0]  adc1_cfg_data_o;


/*
ADConfig   uADConfig
(
    .RST         (rst_sof_n),
    .CLK_SYSTEM  (mclk ),
    .ADC_CFG_DATA(adc_cfg_dat_d1), 
    .EN_ADC_CFG  (pos_en_adc_cfg),
    .SCK         (ad_sck ),
    .SEN         (ad_sen ),
    .SDI         (ad_sdi )
);
*/
reg  rst_sof_n_d0,rst_sof_n_d1;
wire rst_ADconfig;  

always@(posedge mclk)begin
rst_sof_n_d0<=rst_sof_n;
rst_sof_n_d1<=rst_sof_n_d0;
end

assign rst_ADconfig=rst_sof_n_d1;

ADconfig uADConfig1
(
     .clk_sck       ( clk_ADC_config            ),
     .rst_n         ( rst_ADconfig       ),
     .adc_cfg_data  ( adc1_cfg_dat_d1  ), 
     .adc_cfg_data_o( adc1_cfg_data_o  ),
     .en_adc_cfg    ( pos_en_adc1_cfg  ),
     .SCK           ( ad_sck1          ),
     .SEN           ( ad_sen1          ),
     .SDI          ( SDI1            )  
);
wire [31:0] adc2_cfg_dat;
wire        en_adc2_cfg;

reg[31:0]   adc2_cfg_dat_d0,adc2_cfg_dat_d1;
reg         en_adc2_cfg_d0,en_adc2_cfg_d1,en_adc2_cfg_d2;
wire        pos_en_adc2_cfg;
wire[15:0]  adc2_cfg_data_o;



ADconfig uADConfig2
(
     .clk_sck       ( mclk            ),
     .rst_n         ( rst_ADconfig       ),
     .adc_cfg_data  ( adc2_cfg_dat_d1  ), 
     .adc_cfg_data_o( adc2_cfg_data_o  ),
     .en_adc_cfg    ( pos_en_adc2_cfg  ),
     .SCK           ( ad_sck2          ),
     .SEN           ( ad_sen2          ),
     .SDI          ( SDI2            ) 
);
//assign SDI2=SDI1;
//adc1


always @ ( posedge clk_cis or negedge RST_n ) begin
    if (~RST_n) begin
      adc1_cfg_dat_d0 <= 32'b0;
      adc1_cfg_dat_d1 <= 32'b0;
     end
     else if (~soft_rstn) begin
      adc1_cfg_dat_d0 <= 32'b0;
      adc1_cfg_dat_d1 <= 32'b0;
     end
     else begin
      adc1_cfg_dat_d0 <= adc1_cfg_dat;
      adc1_cfg_dat_d1 <= adc1_cfg_dat_d0;
     end
end

always @ ( posedge clk_cis or negedge RST_n ) begin
    if (~RST_n) begin
      en_adc1_cfg_d0 <= 1'b0;
      en_adc1_cfg_d1 <= 1'b0;
      en_adc1_cfg_d2 <= 1'b0;
     end
     else if (~soft_rstn) begin
      en_adc1_cfg_d0 <= 1'b0;
      en_adc1_cfg_d1 <= 1'b0;
      en_adc1_cfg_d2 <= 1'b0;
     end   
     else begin
      en_adc1_cfg_d0 <= en_adc1_cfg;
      en_adc1_cfg_d1 <= en_adc1_cfg_d0;
      en_adc1_cfg_d2 <= en_adc1_cfg_d1;
     end
end


assign pos_en_adc1_cfg = ~en_adc1_cfg_d2 &  en_adc1_cfg_d0;

//adc2
always @ ( posedge clk_cis or negedge RST_n ) begin
    if (~RST_n) begin
      adc2_cfg_dat_d0 <= 32'b0;
      adc2_cfg_dat_d1 <= 32'b0;
     end
     else if (~soft_rstn) begin
      adc2_cfg_dat_d0 <= 32'b0;
      adc2_cfg_dat_d1 <= 32'b0;
     end
     else begin
      adc2_cfg_dat_d0 <= adc2_cfg_dat;
      adc2_cfg_dat_d1 <= adc2_cfg_dat_d0;
     end
end

always @ ( posedge clk_cis or negedge RST_n ) begin
    if (~RST_n) begin
      en_adc2_cfg_d0 <= 1'b0;
      en_adc2_cfg_d1 <= 1'b0;
      en_adc2_cfg_d2 <= 1'b0;
     end
     else if (~soft_rstn) begin
      en_adc2_cfg_d0 <= 1'b0;
      en_adc2_cfg_d1 <= 1'b0;
      en_adc2_cfg_d2 <= 1'b0;
     end   
     else begin
      en_adc2_cfg_d0 <= en_adc2_cfg;
      en_adc2_cfg_d1 <= en_adc2_cfg_d0;
      en_adc2_cfg_d2 <= en_adc2_cfg_d1;
     end
end


assign pos_en_adc2_cfg = ~en_adc2_cfg_d2 &  en_adc2_cfg_d1;

//wire[7:0] rin1,rin2,rin3,rin4;

//------------------------write ram------------------------------

reg [12:0] HoriPixNum_d0,HoriPixNum_d1;

always@(posedge APB_M_0_clk)begin
HoriPixNum_d0<=HoriPixNum;
HoriPixNum_d1<=HoriPixNum_d0;
end

reg trig_d0;

always@(posedge clk_wram)
trig_d0<=trig;


WRADDATA WRADDATA
(
   .clk(clk_wram),    //24MHZ
   .rst_n(rst_sof_n),
   .CSEN(csen),
   .SI(trig_d0),
//   .din1(in1[7:0]),//in1
//   .din2(in1[15:8]),//in2
//   .din3(in2[7:0]),//in3
//   .din4(in2[15:8]),//in4
   .din1(in1[15:8]),//in1
   .din2(in1[7:0]),//in2
   .din3(in2[7:0]),//in3   /////////////////////////////////////////////////////this part was modified by mjh   20230808/////////////////
   .din4(in2[15:8]),//in4  /////////////////////////////////////////////////////this part was modified by mjh   20230808/////////////////
//   .din1(rin1),//in1
//   .din2(rin2),//in2
//   .din3(rin3),//in3   
//   .din4(rin4),//in4  
   .enr(enr),
   .enrb(enrb),
   .wr_clk(wrclk),
   .addra1(wraddr1),
   .addra2(wraddr2),
   .dout1(dout1),
   .dout2(dout2),
   .dout3(dout3),
   .dout4(dout4),
   .HoriPixNum(HoriPixNum_d1),
   .st_sp(st_sp)

);
wire en_pattern, en_num;
//reg[7:0]   test_data1;
//reg[7:0]   test_data2;
//assign rin1=en_pattern ? test_data1 : in1[15:8] ;
//assign rin2=en_pattern ? test_data2 : in1[7 :0] ;
//assign rin3=en_pattern ? test_data1 : in2[7 :0] ;
//assign rin4=en_pattern ? test_data2 : in2[15:8] ;




/*

WriteRAM_r	   WriteRAM_r
(
	.clk(mclk),
	.rst_n(rst_sof_n),
	.CSEN(csen),
	.wr_trigger(trig),
	.HoriPixNum(HoriPixNum),
    .st_sp(st_sp),
	.addra(wraddr_r)
);

*/
//wire rd_fifo;
//------------------------read ram------------------------------
wire [7:0] dout_test;
DRAM_reverse	DRAM_reverse
(
   .clk_sys(APB_M_0_clk),      //100MHZ
   .rst_n(rst_sof_n),
   .CSEN(csen),
   .dpi200(dpi200),
   .dpi_mode(dpi_set),
   .rd_triger(rd_trig_d0),
   .S_AXIS_S2MM_0_tready(S_AXIS_S2MM_0_tready),
   .HoriPixNum(HoriPixNum_d1),
   .din1(din1),
   .din1b(din1b),
   .din2(din2),
   .din2b(din2b),
   .din3(din3),
   .din3b(din3b),
   .din4(din4),
   .din4b(din4b),
   .wrdwfront(32'b0),
   .rd_clk(rdclk),
   .rden1(rden1),
   .rden1b(rden1b),
   .rden2(rden2),
   .rden2b(rden2b),
   .rden3(rden3),
   .rden3b(rden3b),
   .rden4(rden4),
   .rden4b(rden4b),
   .frontrd_out_axi(frontwr),
   .fifo_act(fifo_act),
   .addrb1(rdaddr1),
   .addrb2(rdaddr2),
//   .douta(douta),
//   .doutb(doutb),
   .dout(dout),
   .rd_ack(rd_ack),
   .tl_last(tlast),
   .dout_test(dout_test)
);
//------------------------ram group------------------------------
//ram_1
//the depth of each ram was 15552 before
//2023.7.6  the depth was modified to 2600 by mjh ,especially for DL515

DPRAM  DPRAMA1(
  .clka (  wrclk      ),
  .wea  (  enr        ),
  .addra(  wraddr1     ),
  .dia (  dout1      ),
  .clkb (  rdclk      ),
  .ceb  (  rden1      ),
  .addrb(  rdaddr1     ),
  .dob(  din1       )
);



DPRAM DPRAMB1(
  .clka (  wrclk      ),
  .wea  (  enrb       ),
  .addra(  wraddr1     ),
  .dia (  dout1      ),
  .clkb (  rdclk      ),
  .ceb  (  rden1b     ),
  .addrb(  rdaddr1     ),
  .dob(  din1b      )
);



//ram_2
DPRAM  DPRAMA2(
  .clka (  wrclk      ),
  .wea  (  enr        ),
  .addra(  wraddr2     ),
  .dia (  dout2      ),
  .clkb (  rdclk      ),
  .ceb  (  rden2      ),
  .addrb(  rdaddr1     ),
  .dob(  din2       )
);



DPRAM DPRAMB2(
  .clka (  wrclk      ),
  .wea  (  enrb       ),
  .addra(  wraddr2     ),
  .dia (  dout2      ),
  .clkb (  rdclk      ),
  .ceb  (  rden2b     ),
  .addrb(  rdaddr1     ),
  .dob(  din2b      )
);
//  ram1和ram2与ram3和ram4不同，前者是DIN1用wraddr1,DIN2用wraddr2，后者相反
//ram3
DPRAM  DPRAMA3(
  .clka (  wrclk      ),
  .wea  (  enr        ),
  .addra(  wraddr2     ),
  .dia (  dout3      ),
  .clkb (  rdclk      ),
  .ceb  (  rden3      ),
  .addrb(  rdaddr2     ),
  .dob(  din3       )
);

DPRAM DPRAMB3(
  .clka (  wrclk      ),
  .wea  (  enrb       ),
  .addra(  wraddr2     ),
  .dia (  dout3      ),
  .clkb (  rdclk      ),
  .ceb  (  rden3b     ),
  .addrb(  rdaddr2     ),
  .dob(  din3b      )
);


//ram4


DPRAM  DPRAMA4(
  .clka (  wrclk      ),
  .wea  (  enr        ),
  .addra(  wraddr1     ),
  .dia (  dout4      ),
  .clkb (  rdclk      ),
  .ceb  (  rden4      ),
  .addrb(  rdaddr2     ),
  .dob(  din4       )
);

DPRAM DPRAMB4(
  .clka (  wrclk      ),
  .wea  (  enrb       ),
  .addra(  wraddr1     ),
  .dia (  dout4      ),
  .clkb (  rdclk      ),
  .ceb  (  rden4b     ),
  .addrb(  rdaddr2     ),
  .dob(  din4b      )
);




reg rden1_d0,rden1_d1,rden1_d2,rden1_d3;
reg rden1b_d0,rden1b_d1,rden1b_d2,rden1b_d3;

reg rden2_d0,rden2_d1,rden2_d2,rden2_d3;
reg rden2b_d0,rden2b_d1,rden2b_d2,rden2b_d3;

reg rden3_d0,rden3_d1,rden3_d2,rden3_d3;
reg rden3b_d0,rden3b_d1,rden3b_d2,rden3b_d3;

reg rden4_d0,rden4_d1,rden4_d2,rden4_d3;
reg rden4b_d0,rden4b_d1,rden4b_d2,rden4b_d3;

reg rd_fifo_d0,rd_fifo_d1,rd_fifo_d2,rd_fifo_d3;

always @ ( posedge rdclk or negedge RST_n ) begin
    if (~RST_n) begin
        rden1_d0 <= 1'b0;
		rden1_d1 <= 1'b0;
		rden1_d2 <= 1'b0;
		rden1_d3 <= 1'b0;
      end
    else begin
        rden1_d0 <= rden1;
		rden1_d1 <= rden1_d0;
		rden1_d2 <= rden1_d1;
		rden1_d3 <= rden1_d2;
      end
end

always @ ( posedge rdclk or negedge RST_n ) begin
    if (~RST_n) begin
        rden1b_d0 <= 1'b0;
		rden1b_d1 <= 1'b0;
		rden1b_d2 <= 1'b0;
		rden1b_d3 <= 1'b0;
      end
    else begin
        rden1b_d0 <= rden1b;
		rden1b_d1 <= rden1b_d0;
		rden1b_d2 <= rden1b_d1;
		rden1b_d3 <= rden1b_d2;
      end
end


always @ ( posedge rdclk or negedge RST_n ) begin
    if (~RST_n) begin
        rden2_d0 <= 1'b0;
		rden2_d1 <= 1'b0;
		rden2_d2 <= 1'b0;
		rden2_d3 <= 1'b0;
      end
    else begin
        rden2_d0 <= rden2;
		rden2_d1 <= rden2_d0;
		rden2_d2 <= rden2_d1;
		rden2_d3 <= rden2_d2;
      end
end

always @ ( posedge rdclk or negedge RST_n ) begin
    if (~RST_n) begin
        rden2b_d0 <= 1'b0;
		rden2b_d1 <= 1'b0;
		rden2b_d2 <= 1'b0;
		rden2b_d3 <= 1'b0;
      end
    else begin
        rden2b_d0 <= rden2b;
		rden2b_d1 <= rden2b_d0;
		rden2b_d2 <= rden2b_d1;
		rden2b_d3 <= rden2b_d2;
      end
end

always @ ( posedge rdclk or negedge RST_n ) begin
    if (~RST_n) begin
        rden3_d0 <= 1'b0;
		rden3_d1 <= 1'b0;
		rden3_d2 <= 1'b0;
		rden3_d3 <= 1'b0;
      end
    else begin
        rden3_d0 <= rden3;
		rden3_d1 <= rden3_d0;
		rden3_d2 <= rden3_d1;
		rden3_d3 <= rden3_d2;
      end
end

always @ ( posedge rdclk or negedge RST_n ) begin
    if (~RST_n) begin
        rden3b_d0 <= 1'b0;
		rden3b_d1 <= 1'b0;
		rden3b_d2 <= 1'b0;
		rden3b_d3 <= 1'b0;
      end
    else begin
        rden3b_d0 <= rden3b;
		rden3b_d1 <= rden3b_d0;
		rden3b_d2 <= rden3b_d1;
		rden3b_d3 <= rden3b_d2;
      end
end


always @ ( posedge rdclk or negedge RST_n ) begin
    if (~RST_n) begin
        rden4_d0 <= 1'b0;
		rden4_d1 <= 1'b0;
		rden4_d2 <= 1'b0;
		rden4_d3 <= 1'b0;
      end
    else begin
        rden4_d0 <= rden4;
		rden4_d1 <= rden4_d0;
		rden4_d2 <= rden4_d1;
		rden4_d3 <= rden4_d2;
      end
end

always @ ( posedge rdclk or negedge RST_n ) begin
    if (~RST_n) begin
        rden4b_d0 <= 1'b0;
		rden4b_d1 <= 1'b0;
		rden4b_d2 <= 1'b0;
		rden4b_d3 <= 1'b0;
      end
    else begin
        rden4b_d0 <= rden4b;
		rden4b_d1 <= rden4b_d0;
		rden4b_d2 <= rden4b_d1;
		rden4b_d3 <= rden4b_d2;
      end
end

//always @ ( posedge rdclk or negedge RST_n ) begin
//    if (~RST_n) begin
//        fifo_act_d0 <= 1'b0;
//		fifo_act_d1 <= 1'b0;
//		fifo_act_d2 <= 1'b0;
//		fifo_act_d3 <= 1'b0;
//      end
//    else begin
//        fifo_act_d0 <= fifo_act;
//		rd_fifo_d1 <= rd_fifo_d0;
//		rd_fifo_d2 <= rd_fifo_d1;
//		rd_fifo_d3 <= rd_fifo_d2;
//      end
//end

assign pos_rden1   = ~rden1_d3  & rden1_d2;
assign pos_rden1b  = ~rden1b_d3 & rden1b_d2;

reg pos_rden1_d0,pos_rden1_d1;
reg pos_rden1b_d0,pos_rden1b_d1;

always @ ( posedge rdclk or negedge RST_n ) begin
    if (~RST_n) begin
       pos_rden1_d0  <= 1'b0;
	   pos_rden1b_d0 <= 1'b0;
      end
    else begin
       pos_rden1_d0  <= pos_rden1;
       pos_rden1_d1  <= pos_rden1_d0;
	   pos_rden1b_d0 <= pos_rden1b;
	   pos_rden1b_d1 <= pos_rden1b_d0;
      end
end






reg        test_vaild;
wire       pos_rd_trig;
reg [7:0] cnt_line_tmp;
//reg [15:0] cnt_line;

reg[7:0]  test_data;

always @ ( posedge rdclk or negedge RST_n ) begin
    if (~RST_n) begin
        test_data  <= 8'b0;
		test_vaild <= 1'b0;
     end
     else if (~soft_rstn | pos_rd_trig) begin
        test_data <= 8'b0;
		test_vaild <= 1'b0;
     end   
     else if (start&S_AXIS_S2MM_0_tready& (rden1_d3 | rden1b_d3 | rden2_d0 |rden2b_d0|fifo_act )) begin 
//	  	  test_data  <=16'b1111_0000_0000_1111 ;
	  	  test_data <= test_data + 1'b1;
		  test_vaild <= 1'b1;
      end		
     
     else begin
	    test_data <=  test_data;
		test_vaild <= 1'b0;
     end
end
//reg[3:0]      test_cnt;
//always @ ( posedge clk_wram or negedge RST_n ) begin
//    if (~RST_n) begin
//        test_data1  <= 8'b0;
//        test_data2  <= 8'b11111111;
//        test_cnt    <= 0;
//     end
//     else if(test_cnt==2)begin
//        test_data1  <= test_data1+1;
//        test_data2  <= test_data2-1;
//        test_cnt    <= 0;
//     end
//     else
//        test_cnt<=test_cnt+1;   
//end

//wire en_pattern, en_num;

always @ (posedge rdclk) begin
    if (~APB_M_0_rstn) begin
      S_AXIS_S2MM_0_tdata  <= 8'h0;
      S_AXIS_S2MM_0_tvalid <= 1'b0;
      S_AXIS_S2MM_0_tlast  <= 1'b0;
     end
//    else if (( pos_rden1 | pos_rden1b ) & en_num ) begin
//	   S_AXIS_S2MM_0_tdata  <= cnt_line_tmp[7:0];
//	   S_AXIS_S2MM_0_tvalid	<= 1'b1;
//       S_AXIS_S2MM_0_tlast  <= tlast;
//      end
    else if ((pos_rden1_d1 | pos_rden1b_d1) & en_num ) begin
//	   S_AXIS_S2MM_0_tdata <= cnt_line_tmp[15:8];
       S_AXIS_S2MM_0_tdata <= cnt_line_tmp;
	   S_AXIS_S2MM_0_tvalid	<= frontwr;
       S_AXIS_S2MM_0_tlast  <= tlast;
       end
    else begin
//       S_AXIS_S2MM_0_tdata  <= en_pattern ? test_data  : {doutb,douta};
       S_AXIS_S2MM_0_tdata  <= en_pattern ? test_data  : dout;
//         S_AXIS_S2MM_0_tdata  <= dout;
//       S_AXIS_S2MM_0_tvalid <= en_pattern ? test_vaild :frontwr;
       S_AXIS_S2MM_0_tvalid <= frontwr;
       S_AXIS_S2MM_0_tlast  <= tlast;
     end
 end
//------------------------------------------------------
//assign SYNTHESIZED_WIRE_1 =  divide2;
//assign SYNTHESIZED_WIRE_2 =  divide3;
//assign SYNTHESIZED_WIRE_3 =  divide4;
//assign SYNTHESIZED_WIRE_4 =  normal;
assign mul2 =  ~mul;

//------------------------------------------------------

assign StartStop_flag = en_stop;

//------------------------------------------------------
//wire cl_test;
ubus_top u_ubus_top(
   .clk24m(clkin),
   .rx(ubus_rx),
   .tx(ubus_tx),
   .adc1_cfg_data_o(adc1_cfg_data_o),
   .adc1_cfg_dat(),
   .en_adc1_cfg(en_adc1_cfg),
   .cl_test(cl_test),
   .st_sp(st_sp)
); 
//ubus_top u_ubus_top(
//   .clk24m(clkin),
//   .rx(ubus_rx),
//   .tx(ubus_tx),
//   .adc1_cfg_data_o(adc1_cfg_data_o),
//   .adc1_cfg_dat(adc1_cfg_dat),
//   .en_adc1_cfg(en_adc1_cfg),
//   .cl_test(cl_test),
//   .st_sp(st_sp)
//); 
//ubus_top u_ubus_top (

//    .APB_M_0_rstn(APB_M_0_rstn),
//    .APB_M_0_clk(APB_M_0_clk),
//    .APB_M_0_paddr(APB_M_0_paddr),
//    .APB_M_0_penable(APB_M_0_penable),
//    .APB_M_0_prdata(APB_M_0_prdata),
//    .APB_M_0_pready(APB_M_0_pready),
//    .APB_M_0_psel(APB_M_0_psel),
//    .APB_M_0_pslverr(APB_M_0_pslverr),
//    .APB_M_0_pwdata(APB_M_0_pwdata),
//    .APB_M_0_pwrite(APB_M_0_pwrite),

//    .colo_mode(),
//    .mcu_cmd_reg(adc2_cfg_dat ),
//    .mcu_wr_data_reg({16'd0,adc1_cfg_data_o} ),
//    .mcu_status_reg({4'b0010,5'h0,error,locked1,ps_done,16'd0,trigger_flag,StartStop_flag,button,button_start}),
     
////    .gray_times   (   gray_times   ),
//    .red_times1    (       ),
//    .green_times1  (     ),
//    .blue_times1   (     ),
//    .red_times2    (       ),
//    .green_times2  (     ),
//    .blue_times2   (     ),
////    .gpio_out     (   gpio         ),  
//    .en_frameset    (en_frameset    ),

////    .divide2      (   divide2      ),
////    .divide3      (   divide3      ),
////    .divide4      (   divide4      ),
////    .normal       (   normal       ),
//    .adc1_cfg_dat  (     ),
//    .en_adc1_cfg   (   en_adc1_cfg   ),
//    .en_adc2_cfg   (   en_adc2_cfg   ),
//    .dis_led      (   dis_led      ),
//    .sw_button    (   sw_button    ),
//    .clr_exp      (   clr_exp      ),
////    .General_out2usb (General_out2usb),
////    .General_out2interface (General_out2interface),
//    .sp_time      (         ),
//    .sp_time2     (         ),
//    .soft_rstn    (       ),
//    .dpi_mode     (        ),
//    .st_sp        (           ),
//    .i_ctrl0       (  i_ctrl0      ), 
//    .i_divisor0    (  i_divisor0   ), 
//    .i_period0     (  i_period0    ), 
//    .i_dc0         (  i_dc0        ),
    
////    .i_ctrl1       (  i_ctrl1      ), 
////    .i_divisor1    (  i_divisor1   ), 
////    .i_period1     (  i_period1    ), 
////    .i_dc1         (  i_dc1        ),
//    .line_cnt      (  line_cnt     ),
//    .frame_cnt     (  frame_cnt             ),



//    .start        (           ),
//    .stop         (            ),
//    .mul          (  mul           ),
//    .button       (  button        ),
//    .A            (              ),
//    .B            (  B             ),
//    .trigger_flag (  trigger_flag  ),
//    .finished     (  finished      ),
//    .en_pattern   (  en_pattern    ),
//    .en_num       (  en_num        ),
//    .psen         (  psen          ),
//    .psincdec     (  psincdec      ),
//    .clr_posdone  (  clr_posdone   ),
//    .linecnt_tx   (  linecnt_tx    ),
//    .framecnt_tx  (  cnt_frame  ),
////    .max_trig_cnt (  max_trig_cnt  ),
//    .delay_config (  delay_config  ),
//    .dpi200       (          ),
////    .clr_err      (  clr_err       ),
//    .div_reg      (  div_reg              ),//sensor
//    .samp_reg     (  samp_reg              ),//sensor
//    .low_reg      (  low_reg              ),//sensor
//    .div_reg_n      (  div_reg_n              ),//new sensor
//    .samp_reg_n     (  samp_reg_n              ),//new sensor
//    .diff_reg      (  diff_reg              ),//new sensor
//    .diff_out      (  diff_out        ),    //new sensor
//    .low_cntA (low_cntA),
//    .low_cntB (low_cntB),
//    .autotig_dly_time(  autotig_dly_time              ),//sensor
//    .adc2_cfg_data_o(adc2_cfg_data_o)
// );



pwm u0_pwm(
   
    .i_wb_clk     ( clk_cis      ) ,
    .i_wb_rst     ( ~RST_n       ) ,
    .i_ctrl       (  i_ctrl0     ) ,
    .i_divisor    (  i_divisor0  ) ,
    .i_period     (  i_period0   ) ,
    .i_dc         (  i_dc0       ) ,
    .o_pwm        (  o_pwm0      )
);

//wire o_pwm1;

//pwm u1_pwm(
   
//    .i_wb_clk     (  mclk        ) ,
//    .i_wb_rst     ( ~RST_n       ) ,
//    .i_ctrl       (  i_ctrl1     ) ,
//    .i_divisor    (  i_divisor1  ) ,
//    .i_period     (  i_period1   ) ,
//    .i_dc         (  i_dc1       ) ,
//    .o_pwm        (  o_pwm1      )
//);


//assign vsmp1 = clk_cis & ~mclk;

//assign  SCK1   =   ad_sck1 ;
//assign  SEN1   =   ad_sen1 ;




//reg pos_frame_end_d0,pos_frame_end_d1,pos_frame_end_d2,pos_frame_end_d3,pos_frame_end_d4,pos_frame_end_d5,pos_frame_end_d6,pos_frame_end_d7,pos_frame_end_d8,pos_frame_end_d9,pos_frame_end_d10,pos_frame_end_d11,pos_frame_end_d12,pos_frame_end_d13;

//always @ (posedge APB_M_0_clk) begin
//  if (~rst_sof_n) begin
//      pos_frame_end_d0 <= 1'd0;
//      pos_frame_end_d1 <= 1'd0;
//      pos_frame_end_d2 <= 1'd0;
//      pos_frame_end_d3 <= 1'd0;
//      pos_frame_end_d4 <= 1'd0;
//      pos_frame_end_d5 <= 1'd0;
//      pos_frame_end_d6 <= 1'd0;
//      pos_frame_end_d7 <= 1'd0;
//      pos_frame_end_d8 <= 1'd0;
//      pos_frame_end_d9 <= 1'd0;
//      pos_frame_end_d10 <= 1'd0;
//      pos_frame_end_d11 <= 1'd0;
//      pos_frame_end_d12 <= 1'd0;
//      pos_frame_end_d13 <= 1'd0;
//    end
//  else begin
//      pos_frame_end_d0 <= s2mm_fsync;
//      pos_frame_end_d1 <= pos_frame_end_d0;
//      pos_frame_end_d2 <= pos_frame_end_d1;
//      pos_frame_end_d3 <= pos_frame_end_d2;
//      pos_frame_end_d4 <= pos_frame_end_d3;
//      pos_frame_end_d5 <= pos_frame_end_d4;
//      pos_frame_end_d6 <= pos_frame_end_d5;
//      pos_frame_end_d7 <= pos_frame_end_d6;
//      pos_frame_end_d8 <= pos_frame_end_d7;
//      pos_frame_end_d9 <= pos_frame_end_d8;
//      pos_frame_end_d10 <= pos_frame_end_d9;
//      pos_frame_end_d11 <= pos_frame_end_d10;
//      pos_frame_end_d12 <= pos_frame_end_d11;
//      pos_frame_end_d13 <= pos_frame_end_d12;

//   end
//end

//assign pos_frame_end= pos_frame_end_d0 | pos_frame_end_d1| pos_frame_end_d2| pos_frame_end_d3| pos_frame_end_d4| pos_frame_end_d5| pos_frame_end_d6| pos_frame_end_d7| pos_frame_end_d8| pos_frame_end_d9|pos_frame_end_d10| pos_frame_end_d11| pos_frame_end_d12 |pos_frame_end_d13;




reg[15:0] line_cnt_d0, line_cnt_d1;
//modified in 20230829
always @ (posedge APB_M_0_clk) begin
  if (~rst_sof_n) begin
      cnt_line <= 16'b0;
    end
  else if ((cnt_line == line_cnt_d1+1)| pos_frame_start_d0) begin
      cnt_line <= 16'b0;
   end
  else if (pos_rd_trig) begin
      cnt_line <= cnt_line + 1'b1;
   end
end
//always @ (posedge APB_M_0_clk) begin
//  if (~rst_sof_n) begin
//      cnt_line <= 16'b0;
//    end
//  else if ((cnt_line == line_cnt_d1)) begin
//      cnt_line <= 16'b0;
//   end
//  else if (pos_rd_trig) begin
//      cnt_line <= cnt_line + 1'b1;
//   end
//end


always @ (posedge APB_M_0_clk) begin
  if (~rst_sof_n) begin
      cnt_frame <= 16'b0;
    end
  else if (  pos_frame_start_d0  ) begin
      cnt_frame <= 0;
   end  
  else if ((cnt_frame == frame_cnt_d1+1)) begin
      if(en_frameset)
      cnt_frame <= cnt_frame ;
      else
      cnt_frame <= cnt_frame + 1'b1;
   end
  else if (s2mm_fsync) begin
      cnt_frame <= cnt_frame + 1'b1;
   end
//  else if (!StartStop_flag) begin
//      cnt_frame <= 0;
//   end
end

always @ (posedge APB_M_0_clk) begin
  if (~rst_sof_n) begin
      cnt_line_tmp <= 16'b0;
    end
  else if (pos_rd_trig) begin
      cnt_line_tmp <= cnt_line_tmp + 1'b1;
   end
end


always @ (posedge APB_M_0_clk) begin
  if (~rst_sof_n) begin
      line_cnt_d0 <= 16'd0;
      line_cnt_d1 <= 16'd0;
    end
  else begin
      line_cnt_d0 <= line_cnt;
      line_cnt_d1 <= line_cnt_d0;
   end
end

always @ (posedge APB_M_0_clk) begin
  if (~rst_sof_n) begin
      frame_cnt_d0 <= 16'd0;
      frame_cnt_d1 <= 16'd0;
    end
  else begin
      frame_cnt_d0 <= frame_cnt;
      frame_cnt_d1 <= frame_cnt_d0;
   end
end

assign pos_rd_trig = ~rd_trig_d1 & rd_trig_d0;

always @ (posedge APB_M_0_clk) begin
  if (~rst_sof_n) 
    s2mm_fsync <= 1'b0;
  else 
    //s2mm_fsync <= sync_pos_frame_start | (tlast_cnt == 3)  &(cnt_line == line_cnt_d1) ;
    s2mm_fsync <= (pos_rd_trig && (cnt_line == 0)) ;
end



assign  SCK1   =   ad_sck1 ;
assign  SEN1   =   ad_sen1 ;
//assign  SDI1   =   ad_sdi ;
assign  SCK2   =   ad_sck2 ;
assign  SEN2   =   ad_sen2 ;
//assign  SDI2   =   ad_sdi ;


reg error_d0 , error_d1;

always @ (posedge APB_M_0_clk) begin
  if (~rst_sof_n) begin
     error_d0 <= 1'b0;
     error_d1 <= 1'b0;
   end
  else begin
     error_d0 <= error;
     error_d1 <= error_d0;
   end
end


wire pos_error;

assign pos_error = ~error_d1 & error_d0;


assign triger_err_irq = pos_error;

//////////////////////////////////////////////
//CameraLink测试输出
parameter PROTOCOL = "VESA"; // 协议：JEIDA、VESA  
parameter DEVICE   = "PH1";    // "AL3"  "EF1"  "EF2"  "EF3"  "EG4"  "PH1"  "SF1"
parameter CLOCKINV = 0;      // 时钟极性反转
parameter DATA0INV = 0;      // 数据0极性反转
parameter DATA1INV = 0;      // 数据1极性反转
parameter DATA2INV = 0;      // 数据2极性反转
parameter DATA3INV = 0;      // 数据3极性反转
parameter DATA4INV = 0;      // 数据4极性反转
wire	 O_X0					;
wire	 O_X1					;
wire	 O_X2					;
wire	 O_X3					;
wire	 O_X4					; 
wire	 O_XCLK					;
reg re = 1'b0;
(*keep*)wire	[23:0] 	S_port_data		;//synthesis keep
(*keep*)reg		[29:0] 	S_tx_data		;//synthesis keep
assign  S_port_data = cl_test?{dout_test,dout_test,dout_test}:{dout,dout,dout};
assign data_out = S_port_data[7:0];
assign  x0_p=O_X0		;
assign  x1_p=O_X1		;
assign  x2_p=O_X2		;
assign  x3_p=O_X3		;
assign  xclk_p=O_XCLK	;
always @(posedge clkin or negedge rst_sof_n)
begin
    if(!rst_sof_n)
        S_tx_data <= 0;
    else 
        begin	         
  			// B          
            S_tx_data[ 0]    <=		S_port_data[0];	
			S_tx_data[ 1]    <=		S_port_data[1];
			S_tx_data[ 2]    <=		S_port_data[2];
			S_tx_data[ 3]    <=     S_port_data[3];
			S_tx_data[ 4]    <=     S_port_data[4];
			S_tx_data[ 5]    <=		S_port_data[5];
			S_tx_data[ 6]    <=		S_port_data[6];
			S_tx_data[ 7]    <=  	S_port_data[7];
                                    
			S_tx_data[ 8]    <=  	S_port_data[8];
            S_tx_data[ 9]    <=		S_port_data[9];
            // G                    
			S_tx_data[10]    <=		S_port_data[10];						
			S_tx_data[11]    <=		S_port_data[11];
			S_tx_data[12]    <=     S_port_data[12];
			S_tx_data[13]    <=		S_port_data[13];
			S_tx_data[14]    <=		S_port_data[14];
			S_tx_data[15]    <=     S_port_data[15];
			S_tx_data[16]    <=		S_port_data[16];
			S_tx_data[17]    <=		S_port_data[17];
			S_tx_data[18]    <=		S_port_data[18];
            S_tx_data[19]    <=		S_port_data[19];
      		//R      	                    
			S_tx_data[20]    <=		S_port_data[20];	
			S_tx_data[21]    <=     S_port_data[21];
			S_tx_data[22]    <=		S_port_data[22];
			S_tx_data[23]    <=		S_port_data[23];
                                    
			S_tx_data[24]    <=		frontwr;
			S_tx_data[25]    <=		frontwr;
			S_tx_data[26]    <=		frontwr;
			S_tx_data[27]    <=     0;
			S_tx_data[28]    <=     0;
            S_tx_data[29]    <=     0;
			
        end
end

lvds_tx	
#(
    .PROTOCOL (PROTOCOL ), // 协议：JEIDA、VESA
    .DEVICE   (DEVICE   ),    // "AL3"  "EF1"  "EF2"  "EF3"  "EG4"  "PH1"  "SF1"
    .CLOCKINV (CLOCKINV ),      // 时钟极性反转
    .DATA0INV (DATA0INV ),      // 数据0极性反转
    .DATA1INV (DATA1INV ),      // 数据1极性反转
    .DATA2INV (DATA2INV ),      // 数据2极性反转
    .DATA3INV (DATA3INV ),      // 数据3极性反转
    .DATA4INV (DATA4INV )       // 数据4极性反转
)
u1(   
	.lvds_clk(O_XCLK),
    .lvds_data({O_X4,O_X3,O_X2,O_X1,O_X0}),
    // pll
    .rst(~rst_sof_n),
    .sclk(I_3_5pclk), // sclk = pclk * 3.5
    .pclk(clkin), // pclk = lvds_clk
    // video
    .vs	(frontwr),
    .hs	(frontwr),
    .de	(frontwr),
    .rgb(S_tx_data), //S_tx_data  30'b10_1010_1010_1010_1010_1010_1010_1010
    .re(re)
);

 
oddr
#(
    .DEVICE( "PH1") // "AL3"  "EF1"  "EF2"  "EF3"  "EG4"  "PH1" "SF1"
)
u2(
    .clk(clkin),
    .rst(~rst_sof_n),
    .d0(1'b1),
    .d1(1'b0),
    .q()
);
//reg  [15:0] in1;
//always @(posedge clk_wram)
//begin
//	if(si1)
//    in1 <= 16'b0;
//    else
//	in1 <= in1 + 1'b1;
//end
endmodule 
