`timescale 1ns/1ps
module delay_cell (
   output ZN,
   input  A1,
   input  A2
 );

(* DONT_TOUCH = "TURE" *) wire ZN_INT;

(* DONT_TOUCH = "TURE" *) NAND2 u_D2(

     .I1(A1),
     .I0(A2),
     .O(ZN_INT)
 );

 assign #0.01 ZN=  ZN_INT;

 endmodule
