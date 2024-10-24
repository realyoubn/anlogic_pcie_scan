module exboard_sensor(
				input clk,
				input rst_n,
				input borderA_in,borderB_in,
				input deflectionA_in,deflectionB_in,
                input[7:0]  div_reg,
                input[11:0]  samp_reg,
                input[11:0]  diff_reg,
                output reg [11:0] low_cntA,
                output reg [11:0] low_cntB, 
                output reg [11:0] diff_out,
				output border_out,
				output deflection_out
				);
reg [7:0] cnt;
reg [11:0] samp_cnt;
//reg [11:0] low_cntA;
//reg [11:0] low_cntB;
reg clk_int;
reg samp_flag,samp_flag_d0;

reg deflectionA_reg,deflectionB_reg;
reg deflectionA_reg_d0,deflectionB_reg_d0;

reg[7:0] div_reg_sync_d0; 
reg[7:0] div_reg_sync_d1;
reg[7:0] div_reg_sync_d2;


always @ (posedge clk or negedge rst_n) begin
  if (~rst_n) begin
      div_reg_sync_d0 <= 8'b0;
      div_reg_sync_d1 <= 8'b0;
      div_reg_sync_d2 <= 8'b0;
     end
     else begin 
      div_reg_sync_d0 <= div_reg;
      div_reg_sync_d1 <= div_reg_sync_d0;
      if (div_reg_sync_d0 == div_reg_sync_d1)
      div_reg_sync_d2 <= div_reg_sync_d1;
     end
end

reg[11:0] samp_reg_sync_d0; 
reg[11:0] samp_reg_sync_d1;
reg[11:0] samp_reg_sync_d2;

always @ (posedge clk_int ) begin
  if (~rst_n) begin
      samp_reg_sync_d0 <= 12'b0;
      samp_reg_sync_d1 <= 12'b0;
      samp_reg_sync_d2 <= 12'b0;
     end
     else begin 
      samp_reg_sync_d0 <= samp_reg;
      samp_reg_sync_d1 <= samp_reg_sync_d0;
      if (samp_reg_sync_d0 == samp_reg_sync_d1)
      samp_reg_sync_d2 <= samp_reg_sync_d1;
     end
end


reg[11:0] diff_reg_sync_d0; 
reg[11:0] diff_reg_sync_d1;
reg[11:0] diff_reg_sync_d2;

always @ (posedge clk_int ) begin
  if (~rst_n) begin
      diff_reg_sync_d0 <= 12'b0;
      diff_reg_sync_d1 <= 12'b0;
      diff_reg_sync_d2 <= 12'b0;
     end
     else begin 
      diff_reg_sync_d0 <= diff_reg;
      diff_reg_sync_d1 <= diff_reg_sync_d0;
      if (diff_reg_sync_d0 == diff_reg_sync_d1)
      diff_reg_sync_d2 <= diff_reg_sync_d1;
     end
end

always@(posedge clk or negedge rst_n)
if(!rst_n)	begin
	deflectionA_reg<=0;
	deflectionB_reg<=0;
    deflectionA_reg_d0<=0;
	deflectionB_reg_d0<=0;
end
else begin 
     deflectionA_reg<=deflectionA_in;
     deflectionB_reg<=deflectionB_in;
     deflectionA_reg_d0<=deflectionA_reg;
     deflectionB_reg_d0<=deflectionB_reg;
     end
     
always@(posedge clk_int or negedge rst_n)
if(!rst_n)	begin
	samp_flag_d0<=0;
end
else begin 
     samp_flag_d0<=samp_flag;
     end     

always@(posedge clk or negedge rst_n)
if(!rst_n)	begin
	cnt <= 0;
end
else if (cnt == div_reg_sync_d2)
cnt <= 0;
else 
cnt <= cnt +1'b1;


always@(posedge clk or negedge rst_n)
if(!rst_n)	begin
	clk_int <= 0;
end
else if(cnt == div_reg_sync_d2)	clk_int <= ~clk_int;

always@(posedge clk_int or negedge rst_n)
if(!rst_n)	begin
samp_cnt <= 0;
samp_flag <= 0;
end
else if(samp_cnt == samp_reg_sync_d2)	begin
	samp_cnt <= 0;
	samp_flag <= 1;
end
else begin
	samp_cnt <= samp_cnt +1'b1;
	samp_flag <= 0;	
end

//deflection detect
always@(posedge clk_int or negedge rst_n)
if(!rst_n)	low_cntA<= 0;
else if(samp_flag_d0)	low_cntA<= 0;
else if(!deflectionA_reg_d0)	low_cntA <= low_cntA + 1'b1;
else low_cntA <= low_cntA;

always@(posedge clk_int or negedge rst_n)
if(!rst_n)	low_cntB<= 0;
else if(samp_flag_d0)	low_cntB<= 0;
else if(!deflectionB_reg_d0)	low_cntB <= low_cntB + 1'b1;
else low_cntB <= low_cntB;

reg deflection_tmp;
wire[11:0] diff_cnt;


always@(posedge clk_int or negedge rst_n)
if(!rst_n)	begin 
deflection_tmp<= 0;
diff_out<=0;
end
else if(samp_flag)	begin
        diff_out<=diff_cnt;
	if(diff_cnt > diff_reg_sync_d2)	deflection_tmp <= 1;
	else deflection_tmp <= 0;
end
else begin 
//     deflection_tmp <= deflection_tmp;
     deflection_tmp <= 0;
     diff_out<=diff_out;
     end

assign diff_cnt=(low_cntA>=low_cntB)? (low_cntA-low_cntB) : (low_cntB-low_cntA);

reg deflection_out_tmp_d0, deflection_out_tmp_d1, deflection_out_tmp_d2;

always@(posedge clk_int or negedge rst_n)
if(!rst_n) begin	
    deflection_out_tmp_d0<= 1;
    deflection_out_tmp_d1<= 1;
    deflection_out_tmp_d2<= 1;
end
else begin
    deflection_out_tmp_d0 <= deflection_tmp;
    deflection_out_tmp_d1 <= deflection_out_tmp_d0;
    deflection_out_tmp_d2 <= deflection_out_tmp_d1;
end

wire pos_scan_out_tmp_d0;
wire pos_scan_out_tmp_d1;

//assign pos_scan_out_tmp_d0 = ~scan_out_tmp_d1 & scan_out_tmp_d0;
//assign pos_scan_out_tmp_d1 = ~scan_out_tmp_d2 & scan_out_tmp_d1;


assign deflection_out=deflection_tmp;
assign border_out=borderA_in^borderB_in;

endmodule

