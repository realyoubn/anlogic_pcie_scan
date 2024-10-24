module cis_exposure 
(
 
    input  clk,
    input  rst_n,//synthesis keep
    input  pos_start,//synthesis keep
    input  color_mode,//synthesis keep
//	input[7:0]	NumBag,
    input  pos_frame,//synthesis keep
    input  sp,       //SI signal
    input[15:0]  r_times,//synthesis keep
    input[15:0]  g_times,//synthesis keep
    input[15:0]  b_times,//synthesis keep
 //   input[15:0]  incr_times,

    output reg led_enr,  //ENALBE LED RED
    output reg led_eng,  //ENABLE LED GREEN
    output reg led_enb,  //ENABLE LED BLUE
    output     led_oe_n//synthesis keep

);

reg [15:0] cnt_exp;//synthesis keep
wire times_done;
reg  rtimes_done;
reg  gtimes_done;
reg  btimes_done;
reg  enalbe_led;//synthesis keep
wire sp_exp_pos;//synthesis keep

//wire [15:0] rtimes_acc;
//wire [15:0] gtimes_acc;
//wire [15:0] btimes_acc;
wire pos_times_done;

reg[15:0] r_tims_d0;
reg[15:0] g_tims_d0;
reg[15:0] b_tims_d0;



wire [15:0]   r_time_div3;

assign r_time_div3 = r_times/3;


wire [15:0]   g_time_div3;

assign g_time_div3 = g_times/3;

wire [15:0]   b_time_div3;

assign b_time_div3 = b_times/3;

always @(posedge clk ) begin
    if(~rst_n)                       r_tims_d0  <=16'b0;
    else if(color_mode)              r_tims_d0  <=r_times;
    else                             r_tims_d0  <=r_time_div3;

end


always @(posedge clk ) begin
    if(~rst_n)                       g_tims_d0  <=16'b0;
    else if(color_mode)              g_tims_d0  <=g_times;
    else                             g_tims_d0  <=r_time_div3 + g_time_div3;

end


always @(posedge clk ) begin
    if(~rst_n)                       b_tims_d0  <=16'b0;
    else if(color_mode)              b_tims_d0  <=b_times;
    else                             b_tims_d0  <=r_time_div3 + g_time_div3 + b_time_div3;

end


always @(posedge clk ) begin
    if(~rst_n)                        cnt_exp<=1'b0;
    else if(times_done)               cnt_exp<=1'b0;
    else if(enalbe_led)               cnt_exp<=cnt_exp+1'b1;

end


always @(posedge clk) begin
    if (~rst_n)                       enalbe_led <= 1'b0;
    else if (sp_exp_pos)              enalbe_led <= 1'b1;
    else if (times_done)              enalbe_led <= 1'b0;     
end


always @(posedge clk) begin
    if (~rst_n)                       rtimes_done <= 1'b0;
    else if (sp_exp_pos)              rtimes_done <= 1'b0;
    else if (pos_frame)               rtimes_done <= 1'b0;
    else if (cnt_exp == r_tims_d0)    rtimes_done <= 1'b1; 
end

always @(posedge clk) begin
    if (~rst_n)                       gtimes_done <= 1'b0;
    else if (sp_exp_pos)              gtimes_done <= 1'b0;
    else if (pos_frame)               gtimes_done <= 1'b0;
    else if (cnt_exp == g_tims_d0)    gtimes_done <= 1'b1; 
end

always @(posedge clk) begin
    if (~rst_n)                       btimes_done <= 1'b0;
    else if (sp_exp_pos)              btimes_done <= 1'b0;
    else if (pos_frame)               btimes_done <= 1'b0;
    else if (cnt_exp == b_tims_d0)    btimes_done <= 1'b1; 
end




assign times_done = rtimes_done & gtimes_done & btimes_done;

reg times_done_d0, times_done_d1/* synthesis syn_preserve=1 */;

always @(posedge clk) begin
    if (~rst_n) begin
          times_done_d0 <= 1'b0;
          times_done_d1 <= 1'b0;
    end
    else begin
          times_done_d0 <= times_done;
          times_done_d1 <= times_done_d0;
    end 
end




assign pos_times_done = ~times_done_d1 & times_done_d0;



reg [2:0]  cstate,nstate;

parameter IDLE            = 3'b000, 
          R_LED           = 3'b001,
          G_LED           = 3'b010,
          B_LED           = 3'b011,
          GRAY_LED        = 3'b100;





reg[1:0]  sp_exp_d/* synthesis syn_preserve=1 */;//synthesis keep

always @(posedge clk)begin
    if (~rst_n)                  sp_exp_d <= 2'b0;
    else                         sp_exp_d <= {sp_exp_d[0],sp};
end

assign sp_exp_pos   =  ~sp_exp_d[1] & sp_exp_d[0];


reg r_expos_en;
reg g_expos_en;
reg b_expos_en;

always @(posedge clk)begin
    if (~rst_n)                                 r_expos_en <= 1'b0;
    else if ((cnt_exp == 3) &enalbe_led )       r_expos_en <= 1'b1;
    else if (rtimes_done)                       r_expos_en <= 1'b0;
end


always @(posedge clk)begin
    if (~rst_n)                                 g_expos_en <= 1'b0;
    else if ((cnt_exp == 3) &enalbe_led )       g_expos_en <= 1'b1;
    else if (gtimes_done)                       g_expos_en <= 1'b0;
end

always @(posedge clk)begin
    if (~rst_n)                                 b_expos_en <= 1'b0;
    else if ((cnt_exp == 3) &enalbe_led )       b_expos_en <= 1'b1;
    else if (btimes_done)                       b_expos_en <= 1'b0;
end




always @(posedge clk)begin
    if (~rst_n | pos_start)       cstate <= IDLE;   //2023.8 version
//      if (~rst_n )       cstate <= IDLE;
    else              cstate <= nstate;
end


always @(*) begin
    nstate = cstate;
    case (cstate)
//      IDLE   :     nstate  =  (~color_mode | pos_frame) ? GRAY_LED : sp_exp_pos ? R_LED  : IDLE;    
        IDLE   :     nstate  =  (~color_mode) ? (sp_exp_pos ? GRAY_LED  : IDLE) : (sp_exp_pos ? R_LED  : IDLE);                     
      R_LED  :     nstate  =   sp_exp_pos               ? G_LED : R_LED ;
      G_LED  :     nstate  =   sp_exp_pos               ? B_LED : G_LED;
      B_LED  :     nstate  =   times_done               ? IDLE  : B_LED  ;
    GRAY_LED :     nstate  =   times_done               ? IDLE  : GRAY_LED ;
      default :    nstate  =   IDLE;
    endcase
end



always @(posedge clk)begin
    if (~rst_n)                  led_enr    <= 1'b0;
    else if(cstate == IDLE)      led_enr    <= 1'b0; 
    else if(cstate == R_LED)     led_enr    <= r_expos_en ; 
    else if(cstate == GRAY_LED)  led_enr    <= r_expos_en ;
end


always @(posedge clk)begin
    if (~rst_n)                                 led_eng    <= 1'b0;
    else if(cstate == IDLE)                     led_eng    <= 1'b0; 
    else if(cstate == G_LED)                    led_eng    <= g_expos_en ; 
    else if((cstate == GRAY_LED) & color_mode)  led_eng    <= g_expos_en ;
    else if(cstate == GRAY_LED)                 led_eng    <= ~r_expos_en & g_expos_en ;
end


always @(posedge clk)begin
    if (~rst_n)                                 led_enb    <= 1'b0;
    else if(cstate == IDLE)                     led_enb    <= 1'b0; 
    else if(cstate == B_LED)                    led_enb    <= b_expos_en ; 
    else if((cstate == GRAY_LED) & color_mode)  led_enb    <= b_expos_en ;
    else if(cstate == GRAY_LED)                 led_enb    <= ~r_expos_en & ~g_expos_en & b_expos_en ;
end





//assign cstate_BorGray   =   ((cstate == B_LED) | (cstate == GRAY_LED))  ? 1'b1 : 1'b0;
//reg cstate_BorGray_d0;
//
//always @(posedge clk ) begin
//    if(~rst_n)                                    cstate_BorGray_d0 <=1'b0;
//    else                                          cstate_BorGray_d0 <= cstate_BorGray;
//
//end
//
//
//
//always @(posedge clk ) begin
//    if(~rst_n)                                    rtimes_acc <=16'b0;
//    else if(pos_frame)                            rtimes_acc <= r_times;
//    else if(pos_times_done &  cstate_BorGray_d0 ) rtimes_acc <= rtimes_acc + incr_times;
//
//end
//
//always @(posedge clk ) begin
//    if(~rst_n)                                    gtimes_acc <=16'b0;
//    else if(pos_frame)                            gtimes_acc <= g_times;
//    else if(pos_times_done & cstate_BorGray_d0 )  gtimes_acc <= gtimes_acc + incr_times;
//
//end
//
//always @(posedge clk ) begin
//    if(~rst_n)                                    btimes_acc <=16'b0;
//    else if(pos_frame)                            btimes_acc <= b_times;
//    else if(pos_times_done & cstate_BorGray_d0)   btimes_acc <= btimes_acc + incr_times;
//
//end






assign led_oe_n = ~enalbe_led;




endmodule 
