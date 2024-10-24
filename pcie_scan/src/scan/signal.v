`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    19:07:00 09/24/2012 
// Design Name: 
// Module Name:    signal 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
//为适应单si模式，调整本模块的CNT框架，引入sp_time【31：16】这个参数

module signal (
         rst_n,
         clk,   //8mhz//synthesis keep
         frame_start,//synthesis keep
//         pos_frame_end,
         sp_time,//synthesis keep
         intri_time,//synthesis keep
		 CC1,//synthesis keep
	     CISSI,//synthesis keep
	     triger,         //write    trigger//synthesis keep
	     exp,            //exposure trigger//synthesis keep
         rd_triger,      //read     trigger//synthesis keep
         si_led,//synthesis keep
         start,//synthesis keep
         stop,//synthesis keep
         stop_auto,
         finished,
 		 button,
		 softstop,
		 adj,
         clr_exp,
         line_done,
         frame_done,
		 allempty,test,button_start,flag_just,led_start,led_stop,dpi_mode,en_soft
				);
input          rst_n;
input          clk;
//input          pos_frame_end;
input [15:0]   sp_time;
input [15:0]   intri_time;
input          CC1,start,stop,stop_auto,finished,button,adj,allempty;
input[1:0]     dpi_mode;
input          frame_done;
output         CISSI;
output         triger;
output         rd_triger;
output         exp;
output         si_led;
output     reg    softstop;
output     reg test,button_start,flag_just,led_start,led_stop,en_soft;
output     clr_exp;
output     line_done;
output     frame_start;

reg            over,button_en,all_en;
reg            triger_bw,CISSI_bw1,CISSI_bw2;
reg            rd_triger_r,rd_triger_r1,en_trig,exp_r;
reg [3:0] cnt_trig,button_cnt;
reg dataover,CC1_sys,CC1_r,button_r,button_r1,start_r,start_r1,stop_r,stop_r1,stop_auto_r,stop_auto_r1,adj_en,adj_r,adj_r1,softstop_r,softstop_r1,softstop_r2,softstop_r3,softstop_r4,softstop_r5,softstop_r6;
wire softstop_pos,CC1_pos,CC1_pos1,button_pos1,button_pos2,start_pos,stop_pos,stop_auto_pos,over_pos,adj_pos,start_pos1,rd_triger_pos;
reg [15:0]       CNT,button_start_cnt,cnt_en;
reg [31:0]  cnt_delay,cnt_over;
reg       pos_frame_end_d;
reg F_ack;
reg [1:0] CS;
reg [1:0]NS;
reg si_led = 0;
reg over_r;
//wire frame_done;
reg [7:0] cnt_divide = 0;
parameter CHECK = 2'b01,
          WORK  = 2'b10;   

//always@(posedge clk or negedge rst_n) begin
//if(!rst_n)
//pos_frame_end_d<=0;
//else 
//pos_frame_end_d<=pos_frame_end;
//end


always @ (posedge clk or negedge rst_n)
if(!rst_n)
all_en <= 1;	
else if(finished)
all_en <= 1;
else if (stop_pos |(button_pos1 & (button_cnt == 0)))	
all_en <= 0;	 

always @ (posedge clk or negedge rst_n)
if(!rst_n)
cnt_delay <= 0;
else if (cnt_delay == 10000)
cnt_delay <= cnt_delay;
else 
cnt_delay <= cnt_delay + 1;

//always @ (posedge clk or negedge rst_n)
//if(!rst_n)
//dataover <= 0;
//else if (stop_pos |(button_pos1 & (button_cnt == 0)))
//dataover <= 1;
//else if (start_pos | (button_pos1 & (button_cnt == 1)))
//dataover <= 0;
//
//always @(posedge clk or negedge rst_n)
//if(!rst_n)
//button_cnt <= 0 ;
//else if (button_pos2 | stop_pos | start_pos)
//button_cnt <= button_cnt + 1;
//else if (button_cnt == 2)
//button_cnt <= 0;

always @ (posedge clk or negedge rst_n)
if(!rst_n)
dataover <= 0;
//else if (stop_pos |(button_pos1 & (button_cnt == 0)))
else if (stop_pos|stop_auto_pos )
dataover <= 1;
//else if (start_pos | (button_pos1 & (button_cnt == 1)))
else if (start_pos )
dataover <= 0;

always @(posedge clk or negedge rst_n)
if(!rst_n)
button_cnt <= 0 ;
else if (button_pos2 | stop_pos | start_pos)
button_cnt <= button_cnt + 1;
else if (button_cnt == 2)
button_cnt <= 0;


always @(posedge clk or negedge rst_n)
if(!rst_n)
button_start <= 0 ;
//else if (button_pos1 & (button_cnt == 1))
else if (button_pos1)
button_start <= 1;
else if (button_start_cnt == 40000)
button_start <= 0;

always @(posedge clk or negedge rst_n)
if(!rst_n)
button_start_cnt <= 0;
else if (button_start & (button_start_cnt <= 41000))
button_start_cnt <= button_start_cnt + 1;
else if (!button_start)
button_start_cnt <= 0;


always @ (posedge clk or negedge rst_n)
if(!rst_n)
cnt_over <= 0;
else if (dataover & allempty & (cnt_over <= 100))
cnt_over <= cnt_over + 1;
else if(!(dataover & allempty))
cnt_over <= 0;

always @ (posedge clk or negedge rst_n)
if(!rst_n)
softstop <= 0;
else if (dataover & allempty & (cnt_over <= 100) )
softstop <= 1;
else
softstop <= 0;

always @ (posedge clk or negedge rst_n)		
if(!rst_n)
en_soft <= 0;
//else if ((start_pos & cnt_delay == 10000) |(button_pos1 & (button_cnt == 1)))
//else if (start_pos & cnt_delay == 10000)
else if (start_pos )
en_soft <= 1;
//else if (stop_pos | (button_pos1 & (button_cnt == 0)))
else if (dataover & frame_done )
en_soft <= 0;

assign   softstop_pos = softstop;
assign   over_pos = (!over) &(over_r);
assign   exp = exp_r & en_soft&en_trig; 
//assign   exp = exp_r & en_soft;
//assign   CISSI = dpi_mode?(CISSI_bw1 & en_soft&en_trig):(CISSI_bw2 & en_soft&en_trig);     //如果时序不好的话要涉及到打两拍
assign   CISSI = dpi_mode[0]?(CISSI_bw1 & en_soft):(CISSI_bw2 & en_soft);
assign	triger = triger_bw & en_soft;
assign   rd_triger_pos = (!rd_triger_r1) &(rd_triger_r) & (en_soft) & (en_trig);
assign   stop_pos = (stop_r1) & (!stop_r);
assign   stop_auto_pos = (!stop_auto_r1) & (stop_auto_r);
assign   button_pos2 = (!button_r1) & (button_r);
assign   rd_triger = rd_triger_r & en_soft &en_trig;
assign   adj_pos = (!adj_r1) & (adj_r);
assign   start_pos = (!start_r1) & (start_r);
assign   button_pos1 = (!button_r) &(button_r1);

assign   clr_exp     =  start_pos;
   	 
always @(*)
begin
 if(!rst_n)
  NS = CHECK ;
 else
  case (CS) 
  CHECK : NS = (CC1_pos == 1) ? WORK  : CHECK;
  WORK  : NS = (F_ack   == 1) ? CHECK : WORK;
  default : NS = CHECK;
  endcase
end

always @ (posedge clk)begin
 if (CC1_pos1 == 1)
   begin
	 if (cnt_divide == 200)
   begin 
	 si_led <= ~si_led;
	 cnt_divide <= 0;
	end
    else
    cnt_divide <= cnt_divide + 1'b1;
	end
 else
   cnt_divide <= cnt_divide;
end	
   
 
			 
always @ (posedge clk or negedge rst_n)
if (!rst_n)
begin
start_r <= 0;
start_r1 <= 0;
over_r <= 0;
softstop_r <= 0;
softstop_r1 <= 0;
softstop_r2 <= 0;
softstop_r3 <= 0;
softstop_r4 <= 0;
softstop_r5 <= 0;
softstop_r6 <= 0;
flag_just <= 0;
adj_r <= 0;
adj_r1 <= 0;
rd_triger_r1 <= 0;
button_en <= 0;
end 
else
  begin 
      over_r <= over;
      CC1_r <= CC1;
		CC1_sys <= CC1_r; 
		start_r <= start;
		start_r1 <= start_r;
		stop_r <= stop;
		stop_r1 <= stop_r;
		stop_auto_r <= stop_auto;
		stop_auto_r1<=stop_auto_r;
		button_en <=  button;// button & all_en;
		button_r <= button_en;
		button_r1 <= button_r;
		softstop_r <= softstop;
		softstop_r1 <= softstop_r;
		softstop_r2 <= softstop_r1;
		softstop_r3 <= softstop_r2;
		softstop_r4 <= softstop_r3;
		softstop_r5 <= softstop_r4;
		softstop_r6 <= softstop_r5;
		flag_just <= adj_en;
		rd_triger_r1 <= rd_triger_r;
		adj_r <= adj;
		adj_r1 <= adj_r;
  end     
assign  CC1_pos = (!CC1_sys)&(CC1_r); 
assign  CC1_pos1 = (!CC1_sys)&(CC1);
always @ (posedge clk or negedge rst_n) begin
   if (rst_n == 0) 
	    CS <= CHECK;
	else
       CS <= NS;	
end 
always @ (posedge clk or negedge rst_n)
   if (!rst_n|start_pos)
	begin
		cnt_trig <= 0;
	end
	else if (triger & (cnt_trig <= 3))
	       cnt_trig <= cnt_trig + 1;
		  else
		    cnt_trig <= cnt_trig;
		    
		    
always @ (posedge clk or negedge rst_n)
if(!rst_n|start_pos)
en_trig <= 0;
else if (cnt_trig == 4)
en_trig <= 1;
else
en_trig <= 0;

always @ (posedge clk or negedge rst_n)
if(!rst_n)
begin
led_start <= 1;
led_stop  <= 1;
end
else if (en_soft)
begin
led_start <= 0;
led_stop <= 1;
end
else if (!en_soft)
begin
led_start <= 1;
led_stop <= 0;
end
reg[15:0]  sp_time_d0;
reg[15:0]  sp_time_d1;
reg[15:0]  intri_time_d0;
reg[15:0]  intri_time_d1;

always @ (posedge clk or negedge rst_n) begin 
      if (~rst_n) 
        begin
           sp_time_d0<= 16'b1; 
           sp_time_d1<= 16'b1; 
        end
      else 
        begin
           sp_time_d0<= sp_time;
           sp_time_d1<= sp_time_d0;
        end
 end
 
 always @ (posedge clk or negedge rst_n) begin 
      if (~rst_n) 
        begin
           intri_time_d0<= 16'b1; 
           intri_time_d1<= 16'b1; 
        end
      else 
        begin
           intri_time_d0<= intri_time;
           intri_time_d1<= intri_time_d0;
        end
 end

always @ (posedge clk or negedge rst_n) begin 
      if (rst_n == 0) 
	      F_ack <= 1'b0;
		else begin
		if (CNT == intri_time_d1-50)//2000      5512    //changed in 20230811   原本是sp_time_d1
         F_ack <= 1'b1;       //means that capture a image line successfully 
        else 
         F_ack <= 1'b0;		
		end
 end
 
always @ (posedge clk or negedge rst_n) begin 
    if (rst_n == 0) 
	     CNT <= 16'd0;
	 else begin 
        case (CS)
        CHECK : CNT <= 16'd0;
        WORK : begin 
		             if (CNT == intri_time_d1[15:0])//2000   default:5512  //CNT == sp_time_d1[15:0]
					        CNT <= CNT;
					    else 
                       CNT <= CNT + 16'd1;	 
               end  
        endcase					
    end 	 
        	 
 end

reg [15:0]  sp_time_plus1,sp_time_plus2,sp_time_plus3;
  
always @ (posedge clk or negedge rst_n) begin 
    if (~rst_n) begin
        sp_time_plus1 <= 1'b0;
        sp_time_plus2 <= 1'b0;
        sp_time_plus3 <= 1'b0;
    end    
    else  begin
        sp_time_plus1 <=  sp_time_d1[15:0] + 1;
        sp_time_plus2 <=  sp_time_d1[15:0] + 2;
        sp_time_plus3 <=  sp_time_d1[15:0] + 3;
    end
end




//////////////////////////////////////this part was modiified as single exposure mode ////////////////////////////////

always @ (posedge clk ) 
case (CNT) 
   16'd1 : begin//1
            CISSI_bw1 <= 1'b1; 
            CISSI_bw2 <= 1'b1;  
			   triger_bw <= 1'b0;
			   exp_r       <= 1'b0;	
				rd_triger_r <= 1'b1;
	        end

   16'd2 : begin//1
            CISSI_bw1 <= 1'b1;
            CISSI_bw2 <= 1'b1;   
			   triger_bw <= 1'b0;
			   exp_r       <= 1'b0;	
				rd_triger_r <= 1'b0;
	        end
      
    16'd3 : begin//1
            CISSI_bw1 <= 1'b0;
            CISSI_bw2 <= 1'b1;   
			   triger_bw <= 1'b0;
			   exp_r       <= 1'b0;	
				rd_triger_r <= 1'b0;
	        end
	 
	 16'd4 : begin//1
            CISSI_bw1 <= 1'b0;
            CISSI_bw2 <= 1'b1;   
			   triger_bw <= 1'b0;
			   exp_r       <= 1'b0;	
				rd_triger_r <= 1'b0;
	        end         
      16'd10 : triger_bw <= 1'b1;
      
      16'd11 : triger_bw <= 1'b0;


   sp_time_d1[15:0]: begin//900    2756
            CISSI_bw1 <= 1'b0; 
            CISSI_bw2 <= 1'b0;	
			   triger_bw <= 1'b0;
			   exp_r       <= 1'b1;	
				rd_triger_r <= 1'b0;
           end


   sp_time_plus1 : begin//900        2757  sp_time_plus1 <=  sp_time_d1[15:1] + 1;
            CISSI_bw1 <= 1'b0; 	
            CISSI_bw2 <= 1'b0;
			   triger_bw <= 1'b0;
			   exp_r       <= 1'b0;	
				rd_triger_r <= 1'b0;
           end
           
           
    sp_time_plus2 : begin//900        2757  sp_time_plus1 <=  sp_time_d1[15:1] + 1;
            CISSI_bw1 <= 1'b0;
            CISSI_bw2 <= 1'b0; 	
			   triger_bw <= 1'b0;
			   exp_r       <= 1'b0;	
				rd_triger_r <= 1'b0;
           end
           
     sp_time_plus3 : begin//900        2757  sp_time_plus1 <=  sp_time_d1[15:1] + 1;
            CISSI_bw1 <= 1'b0; 	
            CISSI_bw2 <= 1'b0;
			   triger_bw <= 1'b0;
			   exp_r       <= 1'b0;	
				rd_triger_r <= 1'b0;
           end

	default : begin 
		      CISSI_bw1 <= 1'b0;
		      CISSI_bw2 <= 1'b0; 
		      exp_r <= 1'b0;		
			   triger_bw <= 1'b0;
			   rd_triger_r <= 1'b0;	
				end 
	endcase 



assign line_done = F_ack;
assign frame_start = en_soft;

endmodule 
