module lscc_sensor(
				input clk,
				input rst_n,
				input scan_in,
				input paper_in,onoff_in,
                input[5:0]  div_reg,
                input[9:0]  samp_reg,
                input[9:0]  low_reg,
                input[31:0] autotig_dly_time,
				output      scan_out,
				output      auto_scan_out,
				output reg scan_Reg,
				output paper_out,onoff_out
				);
reg [5:0] cnt;
reg [9:0] samp_cnt;
reg [9:0] low_cnt;
reg clk_int;
reg samp_flag;



reg[5:0] div_reg_sync_d0; 
reg[5:0] div_reg_sync_d1;
reg[5:0] div_reg_sync_d2;

always @ (posedge clk or negedge rst_n) begin
  if (~rst_n) begin
      div_reg_sync_d0 <= 6'b0;
      div_reg_sync_d1 <= 6'b0;
      div_reg_sync_d2 <= 6'b0;
     end
     else begin 
      div_reg_sync_d0 <= div_reg;
      div_reg_sync_d1 <= div_reg_sync_d0;
      if (div_reg_sync_d0 == div_reg_sync_d1)
      div_reg_sync_d2 <= div_reg_sync_d1;
     end
end

reg[9:0] samp_reg_sync_d0; 
reg[9:0] samp_reg_sync_d1;
reg[9:0] samp_reg_sync_d2;

always @ (posedge clk_int ) begin
  if (~rst_n) begin
      samp_reg_sync_d0 <= 10'b0;
      samp_reg_sync_d1 <= 10'b0;
      samp_reg_sync_d2 <= 10'b0;
     end
     else begin 
      samp_reg_sync_d0 <= samp_reg;
      samp_reg_sync_d1 <= samp_reg_sync_d0;
      if (samp_reg_sync_d0 == samp_reg_sync_d1)
      samp_reg_sync_d2 <= samp_reg_sync_d1;
     end
end


reg[9:0] low_reg_sync_d0; 
reg[9:0] low_reg_sync_d1;
reg[9:0] low_reg_sync_d2;

always @ (posedge clk_int ) begin
  if (~rst_n) begin
      low_reg_sync_d0 <= 10'b0;
      low_reg_sync_d1 <= 10'b0;
      low_reg_sync_d2 <= 10'b0;
     end
     else begin 
      low_reg_sync_d0 <= low_reg;
      low_reg_sync_d1 <= low_reg_sync_d0;
      if (low_reg_sync_d0 == low_reg_sync_d1)
      low_reg_sync_d2 <= low_reg_sync_d1;
     end
end

reg[31:0] autotig_dly_time_sync_d0; 
reg[31:0] autotig_dly_time_sync_d1;
reg[31:0] autotig_dly_time_sync_d2;

always @ (posedge clk_int or negedge rst_n) begin
  if (~rst_n) begin
      autotig_dly_time_sync_d0 <= 10'b1;
      autotig_dly_time_sync_d1 <= 10'b1;
      autotig_dly_time_sync_d2 <= 10'b1;
     end
     else begin 
      autotig_dly_time_sync_d0 <= autotig_dly_time;
      autotig_dly_time_sync_d1 <= autotig_dly_time_sync_d0;
      if (autotig_dly_time_sync_d0 == autotig_dly_time_sync_d1)
      autotig_dly_time_sync_d2 <= autotig_dly_time_sync_d1;
     end
end

always@(posedge clk or negedge rst_n)
if(!rst_n)	begin
	scan_Reg <= 0;
end
else scan_Reg <= scan_in;

always@(posedge clk or negedge rst_n)
if(!rst_n)	begin
	cnt <= 0;
end
else cnt <= cnt +1'b1;

always@(posedge clk or negedge rst_n)
if(!rst_n)	begin
	clk_int <= 0;
end
//else if(cnt == 6'b111111)	clk_int <= ~clk_int;
else if(cnt == div_reg_sync_d2)	clk_int <= ~clk_int;

always@(posedge clk_int or negedge rst_n)
if(!rst_n)	begin
samp_cnt <= 0;
samp_flag <= 0;
end
//else if(samp_cnt == 10'd1000)	begin
else if(samp_cnt == samp_reg_sync_d2)	begin
	samp_cnt <= 0;
	samp_flag <= 1;
end
else begin
	samp_cnt <= samp_cnt +1'b1;
	samp_flag <= 0;	
end

always@(posedge clk_int or negedge rst_n)
if(!rst_n)	low_cnt<= 0;
else if(samp_flag)	low_cnt<= 0;
else if(!scan_Reg)	low_cnt <= low_cnt + 1'b1;
else low_cnt <= low_cnt;

reg scan_out_tmp;

always@(posedge clk_int or negedge rst_n)
if(!rst_n)	scan_out_tmp<= 1;
else if(samp_flag)	begin
//	if(low_cnt < 10'd30)	scan_out_tmp <= 1;
//	if(low_cnt < 10'd10)	scan_out_tmp <= 1;
	if(low_cnt < low_reg_sync_d2)	scan_out_tmp <= 1;
	else scan_out_tmp <= 0;
end
else scan_out_tmp <= scan_out_tmp;


reg scan_out_tmp_d0, scan_out_tmp_d1, scan_out_tmp_d2;

always@(posedge clk_int or negedge rst_n)
if(!rst_n) begin	
    scan_out_tmp_d0<= 1;
    scan_out_tmp_d1<= 1;
    scan_out_tmp_d2<= 1;
end
else begin
    scan_out_tmp_d0 <= scan_out_tmp;
    scan_out_tmp_d1 <= scan_out_tmp_d0;
    scan_out_tmp_d2 <= scan_out_tmp_d1;
end

wire pos_scan_out_tmp_d0;
wire pos_scan_out_tmp_d1;

assign pos_scan_out_tmp_d0 = ~scan_out_tmp_d1 & scan_out_tmp_d0;
assign pos_scan_out_tmp_d1 = ~scan_out_tmp_d2 & scan_out_tmp_d1;

reg        enable_delay;
reg[31:0]  delay_cnt;

wire       equ_autotig_dly_time;

assign     equ_autotig_dly_time = (delay_cnt == autotig_dly_time_sync_d2) ? 1'b1 : 1'b0;

always@(posedge clk_int or negedge rst_n)
if(!rst_n)	
    enable_delay <= 1'b0;
else if (pos_scan_out_tmp_d1)
    enable_delay <= 1'b1;
else if (equ_autotig_dly_time)
    enable_delay <= 1'b0;


always@(posedge clk_int or negedge rst_n)
if(!rst_n)	
    delay_cnt <= 32'b0;
else if (pos_scan_out_tmp_d0)
    delay_cnt <= 32'b0;
else if (enable_delay)
    delay_cnt <= delay_cnt + 1'b1;
else if (equ_autotig_dly_time)
    delay_cnt <= delay_cnt;

assign  auto_scan_out = equ_autotig_dly_time;
assign  scan_out      = scan_out_tmp;



assign paper_out = paper_in;
assign onoff_out = ~onoff_in;
endmodule
