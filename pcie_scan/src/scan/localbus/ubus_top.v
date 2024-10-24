module ubus_top (


   input clk24m,
   input rx ,
   output tx ,
   (*keep*)input [15:0] adc1_cfg_data_o,
   (*keep*)output [31:0] adc1_cfg_dat,
   (*keep*)input en_adc1_cfg,
   input cl_test,
   input [15:0] st_sp
   
);
wire clk48m;//synthesis keep 
wire reset_n;

pll2 u_pll2(
  .refclk(clk24m),
  .reset(1'b0),
  .lock(reset_n),
  .clk0_out(),
  .clk1_out(clk48m)
);


wire [31:0] nd2reg_0;	
wire [31:0] nd2reg_1;
wire [31:0] nd2reg_2;
wire [31:0] nd2reg_3;
wire [31:0] nd2reg_4;
wire [31:0] nd2reg_5;
wire [31:0] nd2reg_6;
wire [31:0] nd2reg_7;

wire [31:0] reg2nd_0;
wire [31:0] reg2nd_1;
wire [31:0] reg2nd_2;
wire [31:0] reg2nd_3;
wire [31:0] reg2nd_4;
wire [31:0] reg2nd_5;
wire [31:0] reg2nd_6;
wire [31:0] reg2nd_7;
wire [31:0] reg2nd_8;
wire [31:0] reg2nd_9;
wire [31:0] reg2nd_10;
wire [31:0] reg2nd_11;
wire [31:0] reg2nd_12;
wire [31:0] reg2nd_13;
wire [31:0] reg2nd_14;
wire [31:0] reg2nd_15;

local_bus_slve_cis u_local_bus_slve_cis(
               
        .lb_clk        ( clk48m            ) //input              
       ,.lb_reset_n    ( reset_n           ) //input              
       ,.rx            ( rx                ) //input 			   
       ,.tx            ( tx                ) //output  		   
       ,.lb_crc_error_n( uart_crc_error_n  ) //output reg         
       ,.ubus_identify ( ubus_identify     ) //output reg
           
       ,.nd2reg_0      (nd2reg_0						) //input   [31:0]     
       ,.nd2reg_1      (nd2reg_1						) //input   [31:0]     
       ,.nd2reg_2      (nd2reg_2 						) //input   [31:0]     
       ,.nd2reg_3      (nd2reg_3 						) //input   [31:0]     
       ,.nd2reg_4      (nd2reg_4 						) //input   [31:0]     
       ,.nd2reg_5      (nd2reg_5 						) //input   [31:0]     
       ,.nd2reg_6      (reg2nd_6 						) //input   [31:0]     
       ,.nd2reg_7      (7 						) //input   [31:0]     

       ,.reg2nd_0      (reg2nd_0   						) //output reg [31:0]  
       ,.reg2nd_1      (reg2nd_1 						) //output reg [31:0]  
       ,.reg2nd_2      (reg2nd_2 						) //output reg [31:0]  
       ,.reg2nd_3      (reg2nd_3 						) //output reg [31:0]  
       ,.reg2nd_4      (reg2nd_4   						) //output reg [31:0]  
       ,.reg2nd_5      (reg2nd_5 						) //output reg [31:0]  
       ,.reg2nd_6      (reg2nd_6 						) //output reg [31:0]  
       ,.reg2nd_7      (reg2nd_7   						) //output reg [31:0]  
       ,.reg2nd_8      (reg2nd_8   						) //output reg [31:0]  
       ,.reg2nd_9      (reg2nd_9   						) //output reg [31:0]  
       ,.reg2nd_10     (reg2nd_10  						) //output reg [31:0]  
       ,.reg2nd_11     (reg2nd_11  						) //output reg [31:0]  
       ,.reg2nd_12     (reg2nd_12  						) //output reg [31:0]  
       ,.reg2nd_13     (reg2nd_13  						) //output reg [31:0]  
       ,.reg2nd_14     (reg2nd_14  						) //output reg [31:0]  
       ,.reg2nd_15     (reg2nd_15  						) //output reg [31:0]  

);

assign adc1_cfg_dat = reg2nd_0;
//assign en_adc1_cfg = reg2nd_1[0];
//assign cl_test = reg2nd_2[0];
//assign st_sp = reg2nd_3[15:0];

assign nd2reg_0 = {adc1_cfg_data_o,adc1_cfg_data_o};
assign nd2reg_1 = {31'b0,en_adc1_cfg};
assign nd2reg_2 = {31'b0,cl_test};
assign nd2reg_3 = {16'b0,st_sp};

endmodule
