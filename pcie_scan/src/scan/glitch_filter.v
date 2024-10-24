module glitch_filter #(
    parameter GLITCH_FILTER_SIZE = 64
) (
  input  clk,
  input  restn,
  input  in,
  output out


);


reg [GLITCH_FILTER_SIZE-1:0]      glitch_shift_register_r0;

wire                              low_glitch_filter_out0;
wire                              high_glitch_filter_out0;
reg                               por_r;


 //======== por filter logic ==========
 
always @(posedge clk)
   if (~restn)
      glitch_shift_register_r0 <= {GLITCH_FILTER_SIZE{1'b0}};
   else 
      glitch_shift_register_r0 <= {glitch_shift_register_r0[GLITCH_FILTER_SIZE-2:0],in};

assign low_glitch_filter_out0 = |glitch_shift_register_r0;


assign high_glitch_filter_out0 = &glitch_shift_register_r0;

always @(posedge clk)
begin
 if (~restn)
    por_r <= 1'b0;
 else if (!low_glitch_filter_out0)
    por_r <= 1'b0;
 else if (high_glitch_filter_out0)
    por_r <= 1'b1;
 else
    por_r <= por_r;
end
      //filtered por reset.
assign out =  por_r;

endmodule
