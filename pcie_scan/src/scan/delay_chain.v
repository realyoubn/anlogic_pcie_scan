module delay_chain (
    output wire      out,
    input  wire      in,
    input [7:0] delay_line_rx
);

parameter NUM_STAGS = 256;


wire [NUM_STAGS - 1 : 0 ] lb_rx;
wire [NUM_STAGS - 1 : 0 ] on_rx;

assign lb_rx = {NUM_STAGS {1'b1}} << delay_line_rx;

assign on_rx = ~(lb_rx);

(* DONT_TOUCH = "TURE" *) delay # ( 
                .NUM_STAGS(NUM_STAGS)
          ) u_delay(
           .out(out),
           .in (in ),
           .on (on_rx),
           .lb (lb_rx)
 );

 endmodule
