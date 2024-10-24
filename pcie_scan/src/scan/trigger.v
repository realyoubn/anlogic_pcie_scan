module trigger (
          clk8m,
			 rst_n,
             sp_time,
             sp_time2,
			 line1,
			 line2
			 
			 );
input clk8m;
input[15:0] sp_time;
input[15:0] sp_time2;
input rst_n;
output reg  line1;
output reg  line2;

//parameter num_line = 32'd16000; //Intri 500Hz


reg[15:0]  sp_time_d0;
reg[15:0]  sp_time_d1;
reg[15:0]  sp_time_d2;

reg[15:0]  cnt_line1;

always @ (posedge clk8m ) begin 
      if (~rst_n) 
        begin
           sp_time_d0<= 16'b0; 
           sp_time_d1<= 16'b0; 
           sp_time_d2<= 16'b0; 
        end
      else 
        begin
           sp_time_d0<= sp_time;
           sp_time_d1<= sp_time_d0;
           if (sp_time_d1 == sp_time_d0)
              sp_time_d2 <= sp_time_d1;
        end
 end
 
reg[15:0]  sp_time2_d0;
reg[15:0]  sp_time2_d1;
reg[15:0]  sp_time2_d2;

reg[15:0]  cnt_line2;

 always @ (posedge clk8m ) begin 
      if (~rst_n) 
        begin
           sp_time2_d0<= 16'b0; 
           sp_time2_d1<= 16'b0; 
           sp_time2_d2<= 16'b0; 
        end
      else 
        begin
           sp_time2_d0<= sp_time2;
           sp_time2_d1<= sp_time2_d0;
           if (sp_time2_d1 == sp_time2_d0)
              sp_time2_d2 <= sp_time2_d1;
        end
 end



always @ (posedge clk8m or negedge rst_n) 
begin
	if (!rst_n) 
   cnt_line1 <= 0;
	else if (cnt_line1 == sp_time_d2)
	cnt_line1 <= 0;
	else 
	cnt_line1 <= cnt_line1 + 1;
end
always @(posedge clk8m or negedge rst_n) 
begin
   if (!rst_n) 
	line1 <= 0;
   else if ((cnt_line1 >= (sp_time_d2 - 32'd50)) & (cnt_line1 <= sp_time_d2))
	line1 <= 1;
   else 
   line1 <= 0;	
end  


always @ (posedge clk8m or negedge rst_n) 
begin
	if (!rst_n) 
   cnt_line2 <= 0;
	else if (cnt_line2 == sp_time2_d2)
	cnt_line2 <= 0;
	else 
	cnt_line2 <= cnt_line2 + 1;
end

always @(posedge clk8m or negedge rst_n) 
begin
   if (!rst_n) 
	line2 <= 0;
   else if ((cnt_line2 >= (sp_time2_d2 - 32'd50)) & (cnt_line2 <= sp_time2_d2))
	line2 <= 1;
   else 
   line2 <= 0;	
end  
endmodule	
