module div_mul (
          clk_8m,
			 rst_n,
			 divide2,
			 divide3,
			 divide4,
			 mul2,
			 max_trig_cnt,
			 encoder,  // Encoder Phase A,used
			 encoderb, // Encoder Phase B,idle
			 line_trig,
             clr_err,
			 normal,warning,sample,error			 
			 );
input clk_8m;
input rst_n;
input encoder;
input encoderb;
input divide2;
input divide3;
input divide4;
input mul2;
input normal,sample;
input [31:0] max_trig_cnt;
input        clr_err;

output reg  warning,error;
output wire line_trig;

wire encoder_pos,encoder_poslow,encoder_posb,encoder_posblow,line_trig_pos,warning_pos;
reg [3:0]cnt_encoder,mode;
reg encoder_r,encoder_r1,encoder_rb,encoder_rb1,line_trig_r,line_trig_r1,line_trig_r2,warning_en,warning_en_r,stop_en;
reg [16:0] cnt_warning;

always @(posedge clk_8m or negedge rst_n)
if(!rst_n)
begin
encoder_r <=0;
encoder_r1 <=0;
encoder_rb <=0;
encoder_rb1 <=0;
line_trig_r<= 0;
line_trig_r1<= 0;
warning_en_r <= 0;
end
else
begin
encoder_r <= encoder;
encoder_r1 <= encoder_r;
encoder_rb <= encoderb;
encoder_rb1 <= encoder_rb;
line_trig_r <= line_trig;
line_trig_r1 <= line_trig_r;
warning_en_r <= warning_en;
end

reg[31:0] max_trig_cnt_d0,max_trig_cnt_d1;

always @(posedge clk_8m or negedge rst_n)
if(!rst_n)
begin
  max_trig_cnt_d0 <= 32'b0;
  max_trig_cnt_d1 <= 32'b0;
end
else
begin
  max_trig_cnt_d0 <= max_trig_cnt;
  max_trig_cnt_d1 <= max_trig_cnt_d0;
end



always @ (posedge clk_8m or negedge rst_n)
if(!rst_n)
cnt_warning <= 0;
else if (clr_err)
cnt_warning <= 0;
else if (warning_en & cnt_warning <= 13000)
cnt_warning <= cnt_warning + 1'd1;
else if (warning_pos)
cnt_warning <= 0;

always @ (posedge clk_8m or negedge rst_n)
if(!rst_n)
warning_en <= 0;
else if (line_trig_pos)
warning_en <= ~warning_en;

//always @ (posedge clk_8m or negedge rst_n)
//if(!rst_n)
//error <= 1;
//else if (stop_en)
//error <= 0;
//else 
//error <= 1;
//
//always @ (posedge clk_8m or negedge rst_n)
//if(!rst_n)
//warning <= 1;
//else if ( warning_pos & (cnt_warning <= 12990))
//warning <= 0;
//else if (!sample | (warning_pos & (cnt_warning >= 12995))) 
//warning <= 1;

always @ (posedge clk_8m or negedge rst_n)
if(!rst_n)
error <= 0;
else if (clr_err)
error <= 0;
else if (stop_en)
error <= 1;
else 
error <= 0;

always @ (posedge clk_8m or negedge rst_n)
if(!rst_n)
warning <= 0;
else if ( warning_pos & (cnt_warning <= 12990))//600Hz
//else if ( warning_pos & (cnt_warning <= 7990))//1KHz
warning <= 1;
else if (!sample | (warning_pos & (cnt_warning >= max_trig_cnt_d1))) 
warning <= 0;


always @ (posedge clk_8m or negedge rst_n)
if(!rst_n)
stop_en <= 0;
else if (clr_err)
stop_en <= 0;
else if ( warning_pos & (cnt_warning <= (max_trig_cnt_d1-10))) //super verlosity 1KHz
//else if ( warning_pos & (cnt_warning <= 5300)) //super verlosity 1.5KHz
stop_en <= 1;
else if ((!sample) | ( warning_pos & (cnt_warning > (max_trig_cnt_d1-10))))
stop_en <= 0;

wire [2:0] div_mode;
assign div_mode = {divide4,divide3,divide2};

always @(posedge clk_8m or negedge rst_n) 
   if (!rst_n) 
	mode <= 2;
	else if (normal)
	mode <= 0;
//   else if (divide2)
//	mode <= 1;
//   else if (divide3)
//	mode <= 2;
//   else if (divide4)
//	mode <= 3;
//	else if (mul2)
//	mode <= 4;
	else case(div_mode)
	3'b000:mode <= 1;
	3'b001:mode <= 2;
	3'b010:mode <= 3;
	3'b011:mode <= 4;
	3'b100:mode <= 5;
	3'b101:mode <= 6;
	3'b110:mode <= 7;
	3'b111:mode <= 7;
	endcase
	
	
always @ (posedge clk_8m or negedge rst_n) 
	if (!rst_n) 
	begin
   cnt_encoder <= 0;
	line_trig_r2 <= 0;
	end
	else case(mode)
	0:
	line_trig_r2 <= encoder;
	1:
	if (encoder_pos)
   line_trig_r2 <= ~line_trig_r2;
	else 
	line_trig_r2 <= line_trig_r2;
	2:
	if (encoder_pos)
	begin
	   if (cnt_encoder == 1)
      begin 
	    line_trig_r2 <= ~line_trig_r2;
	    cnt_encoder <= cnt_encoder + 1'b1;
	   end
		else if (cnt_encoder == 2)
		begin
		line_trig_r2 <= ~line_trig_r2;
	   cnt_encoder <= 0;
		end
      else
       cnt_encoder <= cnt_encoder + 1'b1;
   end
	3:
	if (encoder_pos)
	begin
	   if (cnt_encoder == 1)
      begin 
	    line_trig_r2 <= ~line_trig_r2;
	    cnt_encoder <= cnt_encoder + 1'b1;
	   end
		else if (cnt_encoder == 3)
		begin
		line_trig_r2 <= ~line_trig_r2;
	   cnt_encoder <= 0;
		end
      else
       cnt_encoder <= cnt_encoder + 1'b1;
   end
	else
	 cnt_encoder <= cnt_encoder;
	
	4:
	if (encoder_pos)
	begin
	   if (cnt_encoder == 1)
      begin 
	    line_trig_r2 <= ~line_trig_r2;
	    cnt_encoder <= cnt_encoder + 1'b1;
	   end
		else if (cnt_encoder == 4)
		begin
		line_trig_r2 <= ~line_trig_r2;
	   cnt_encoder <= 0;
		end
      else
       cnt_encoder <= cnt_encoder + 1'b1;
   end
	else
	 cnt_encoder <= cnt_encoder;	
	 
	5:
	if (encoder_pos)
	begin
	   if (cnt_encoder == 2)
      begin 
	    line_trig_r2 <= ~line_trig_r2;
	    cnt_encoder <= cnt_encoder + 1'b1;
	   end
		else if (cnt_encoder == 5)
		begin
		line_trig_r2 <= ~line_trig_r2;
	   cnt_encoder <= 0;
		end
      else
       cnt_encoder <= cnt_encoder + 1'b1;
   end
	else
	 cnt_encoder <= cnt_encoder;
	
	6:
	if (encoder_pos)
	begin
	   if (cnt_encoder == 2)
      begin 
	    line_trig_r2 <= ~line_trig_r2;
	    cnt_encoder <= cnt_encoder + 1'b1;
	   end
		else if (cnt_encoder == 6)
		begin
		line_trig_r2 <= ~line_trig_r2;
	   cnt_encoder <= 0;
		end
      else
       cnt_encoder <= cnt_encoder + 1'b1;
   end
	else
	 cnt_encoder <= cnt_encoder;	
	 
	 	7:
	if (encoder_pos)
	begin
	   if (cnt_encoder == 3)
      begin 
	    line_trig_r2 <= ~line_trig_r2;
	    cnt_encoder <= cnt_encoder + 1'b1;
	   end
		else if (cnt_encoder == 7)
		begin
		line_trig_r2 <= ~line_trig_r2;
	   cnt_encoder <= 0;
		end
      else
       cnt_encoder <= cnt_encoder + 1'b1;
   end
	else
	 cnt_encoder <= cnt_encoder;
//	4:
//	if (encoder_pos | encoder_posb | encoder_poslow | encoder_posblow)
//	    line_trig_r2 <= ~line_trig_r2;
//      else
//       line_trig_r2 <= line_trig_r2;
	endcase
assign encoder_pos = (!encoder_r1) & (encoder_r);
assign encoder_poslow = (encoder_r1) & (!encoder_r);
assign encoder_posb = (!encoder_rb1) & (encoder_rb);
assign encoder_posblow = (encoder_rb1) & (!encoder_rb);
assign line_trig_pos = (!line_trig_r1) & (line_trig_r);
assign warning_pos = (!warning_en) & (warning_en_r);
assign line_trig = line_trig_r2 & (!stop_en);
endmodule	
