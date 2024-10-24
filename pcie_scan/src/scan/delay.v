module delay # (
    parameter NUM_STAGS = 256
)
  (
    out ,
    in,
    lb,
    on

  );


  input in;
  input [NUM_STAGS - 1 :0] on;
  input [NUM_STAGS -1  :0] lb;

  output out;

 (* DONT_TOUCH = "TURE" *) wire  [NUM_STAGS - 1 :1] start_stage ;
 (* DONT_TOUCH = "TURE" *) wire  [NUM_STAGS - 1 :1] return_stage ;
 (* DONT_TOUCH = "TURE" *) wire                     return_out_final;


  assign out = return_out_final;

  
  genvar i ;


  generate 
    for ( i = 1; i< NUM_STAGS -1 ; i = i + 1 )  begin : stage

 (* DONT_TOUCH = "TURE" *)   delay_stage u_delay_stage(

          .start_out  (start_stage [i+1]),
          .return_out (return_stage[i]  ),
          .on         (on[i]            ),
          .lb         (lb[i]            ),
          .start_in   (start_stage[i]   ),
          .return_in  (return_stage[i+1])
      );
    end
  endgenerate 

 (* DONT_TOUCH = "TURE" *)   delay_stage u_initial(

          .start_out  (start_stage [1]   ),
          .return_out (return_out_final  ),
          .on         (on[0]             ),
          .lb         (lb[0]             ),
          .start_in   (in                ),
          .return_in  (return_stage[1]   )
      );


 (* DONT_TOUCH = "TURE" *)   delay_stage u_last(

            .start_out  (   ),
            .return_out (return_stage[NUM_STAGS-1]  ),
            .on         (on[NUM_STAGS-1]            ),
            .lb         (lb[NUM_STAGS-1]            ),
            .start_in   (start_stage[NUM_STAGS-1]   ),
            .return_in  (1'b1                       )
        );



endmodule    
