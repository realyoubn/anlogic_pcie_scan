`timescale 1ns/1ps

module  ram_data_gen
(
    input   wire        clk_50m     ,   //模块时钟，频率50MHz
    input   wire        usr_rst_n       ,   //复位信号，低电平有效
    input   wire        usr_c2h0r_run_i,
    input   wire        s0_axis_c2h_rst_i,
    output  reg         data_en     ,   //数据使能信号，高电平有效
    output  reg [7:0]   data_in         //输出数据

);

//********************************************************************//
//******************************* Main Code **************************//
//********************************************************************//

//data_en：让其一直为高电平，一直输出数据
always@(posedge clk_50m or  negedge usr_rst_n)
    if(usr_rst_n == 1'b0)
        data_en  <=  1'b0;
    else if(s0_axis_c2h_rst_i)
        data_en  <=  1'b0;
    else if(usr_c2h0r_run_i)
        data_en  <=  1'b1;
        
//data_in:循环生成写入的数据(8'd0 ~ 8'd255)
always@(posedge clk_50m or  negedge usr_rst_n)
    if(usr_rst_n == 1'b0)
        data_in <=  8'd0;
    else if(s0_axis_c2h_rst_i)
        data_in <=  8'd0;  
    else    if(data_in  == 8'd255)
        data_in <=  8'd0;
    else    if(data_en == 1'b1)
        data_in <=  data_in +   1'b1;
    else
        data_in <=  data_in;

endmodule
