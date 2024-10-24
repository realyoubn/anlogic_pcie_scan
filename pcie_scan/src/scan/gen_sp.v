module gen_sp (
input         reset_n    ,
input         frame_start1,   //internal trigger or external trigger
input         frame_start2,
input         clkcis     ,
input         color_mode ,
input   [15:0]y_pixel    ,
input         line_done  ,
output  reg   sp_pad     ,
output  reg   sp_led     ,
output  reg   sp_sampling
);

localparam      IDLE    = 1'b0;
localparam      WORK    = 1'b1;

reg [15 : 0]        cnt;  
reg [15 : 0]   line_cnt; 

reg           cs;
reg           ns;
reg           frame_start1_1d;
reg           frame_start1_2d;
wire          frame_start1_rise;
reg           frame_start2_1d;
reg           frame_start2_2d;
wire          frame_start2_rise;
wire          frame_start_rise;

always @ (posedge clkcis ) begin
  if (!reset_n)
    {frame_start1_2d,frame_start1_1d} <= 2'd0;
  else
    {frame_start1_2d,frame_start1_1d} <= {frame_start1_1d,frame_start1};  
end 

 
assign  frame_start1_rise = frame_start1_1d & (!frame_start1_2d);

always @ (posedge clkcis ) begin
  if (!reset_n)
    {frame_start2_2d,frame_start2_1d} <= 2'd0;
  else
    {frame_start2_2d,frame_start2_1d} <= {frame_start2_1d,frame_start2};  
end 

 
assign  frame_start2_rise = frame_start2_1d & (!frame_start2_2d);


assign  frame_start_rise = color_mode  ?  frame_start2_rise  :  frame_start1_rise;



reg           line_done_1d;
reg           line_done_2d;
wire          line_done_rise;

always @ (posedge clkcis ) begin
  if (!reset_n)
    {line_done_2d,line_done_1d} <= 2'd0;
  else
    {line_done_2d,line_done_1d} <= {line_done_1d,line_done};  
end 

 
assign  line_done_rise = line_done_1d & (!line_done_2d);





always @ (posedge clkcis ) begin 
  if (!reset_n)
    cs <= IDLE;
  else 
    cs <= ns;    
end

always @ (*) begin 
  case (cs)  
    IDLE : ns = (frame_start_rise) ? WORK : IDLE ;
    WORK :begin
           if (color_mode)
              ns = (line_cnt == (3* y_pixel))?   IDLE : WORK;
           else 
              ns = (line_cnt == (y_pixel )) ?    IDLE : WORK;
          end   
  endcase
end 

always @ (posedge clkcis ) begin 
  if (!reset_n) 
    line_cnt <= 16'd0;
  else if (cs == WORK) begin 
    if (line_done_rise) line_cnt <= line_cnt + 1'b1;  
  end
  else
    line_cnt <= 16'd0;  
end 

always @ (posedge clkcis ) begin 
  if (!reset_n)
    cnt <= 16'b0;
  else if (cs == WORK) 
    cnt <= line_done_rise ?  16'b0  : cnt + 1'b1; 
  else  
    cnt <= 16'b0;

end
//
//always @ (posedge clkcis ) begin 
//  if (!reset_n)
//    sp_sampling <= 1'b0;
//  else if ((cs == WORK)&(cnt == 0)&(line_cnt != 0 )) 
//    sp_sampling <= 1'b1;
//  else 
//    sp_sampling <= 1'b0;    
//end

always @ (posedge clkcis ) begin 
  if (!reset_n)
    sp_pad <= 1'b0;
  else if ((cs == WORK)&(cnt >= 0)&(cnt <= 2)) 
    sp_pad <= 1'b1;
  else 
    sp_pad <= 1'b0;    
end

always @ (posedge clkcis ) begin 
  if (!reset_n)
    sp_sampling <= 1'b0;
  else if ((cs == WORK)&(cnt >= 0)&(cnt <= 2)&(line_cnt != 0 )) 
    sp_sampling <= 1'b1;
  else 
    sp_sampling <= 1'b0;    
end

always @ (posedge clkcis ) begin 
  if (!reset_n)
    sp_led <= 1'b0;
  else if ((cs == WORK)&(cnt == 1)&(line_cnt !=  3*y_pixel)&(color_mode)) 
    sp_led <= 1'b1;  
  else if ((cs == WORK)&(cnt == 1)&(line_cnt !=  y_pixel)&(!color_mode)) 
    sp_led <= 1'b1;
  else 
    sp_led <= 1'b0;    
end 




endmodule   
