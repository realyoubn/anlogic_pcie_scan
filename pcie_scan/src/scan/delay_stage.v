module delay_stage (

  output    start_out,
  output    return_out,
  input     on,        
  input     lb,        
  input     start_in,  
  input     return_in
 );

 (* DONT_TOUCH = "TURE" *) wire mid_wire;


 (* DONT_TOUCH = "TURE" *) delay_cell u_start (
     .ZN (start_out),
     .A1 (start_in ),
     .A2 (on       )
 );
(* DONT_TOUCH = "TURE" *)  delay_cell u_mid  (
     .ZN (mid_wire ),
     .A1 (start_in ),
     .A2 (lb       )
 );
(* DONT_TOUCH = "TURE" *) delay_cell u_return (
     .ZN (return_out),
     .A1 (return_in ),
     .A2 (mid_wire  )
 );

endmodule
