`timescale 1ns/1ps

module  ram_ctrl
(
    input   wire            clk_50m     ,   //写ram时钟，50MHz
    input   wire            usr_clk     ,   //读ram时钟，25MHz
    input   wire            usr_rst_n   ,   //复位信号，低有效
    input   wire    [7:0]   ram1_rd_data,   //ram1读数据
    input   wire    [7:0]   ram2_rd_data,   //ram2读数据
    input   wire            data_en     ,   //输入数据使能信号
    input   wire    [7:0]   data_in     ,   //输入数据
    input   wire            c2h0r_run_d1,
    input   wire            s0_axis_c2h_tready_i,
    input   wire            s0_axis_c2h_rst_i,
    output  reg             ram1_wr_en  ,   //ram1写使能
    output  reg             ram1_rd_en  ,   //ram1读使能
    output  reg     [11:0]  ram1_wr_addr,   //ram1写地址
    output  reg     [11:0]  ram1_rd_addr,   //ram1读地址
    output  wire    [7:0]   ram1_wr_data,   //ram1写数据
    output  reg             ram2_wr_en  ,   //ram2写使能
    output  reg             ram2_rd_en  ,   //ram2读使能
    output  reg     [11:0]  ram2_wr_addr,   //ram2写地址
    output  reg     [11:0]  ram2_rd_addr,   //ram2读地址
    output  wire    [7:0]   ram2_wr_data,   //ram2写数据
    output  reg             wea1,
    output  reg             wea2,
    output  wire    [7:0]   data_out,       //输出乒乓操作数据
    output  reg             data_valid

);

//********************************************************************//
//****************** Parameter and Internal Signal *******************//
//********************************************************************//

//parameter define
parameter   IDLE        =   4'b0001,   //初始状态
            WRAM1       =   4'b0010,   //写RAM1状态
            WRAM2_RRAM1 =   4'b0100,   //写RAM2读RAM1状态
            WRAM1_RRAM2 =   4'b1000;   //写RAM1读RAM2状态

//reg   define
reg     [3:0]   state           ;   //状态机状态
reg     [7:0]   data_in_reg     ;   //数据寄存器

//********************************************************************//
//******************************* Main Code **************************//
//********************************************************************//

//使用组合逻辑赋值，这样使能和数据地址才能对应
assign  ram1_wr_data    =   (ram1_wr_en == 1'b1) ? data_in_reg: 8'd0;
assign  ram2_wr_data    =   (ram2_wr_en == 1'b1) ? data_in_reg: 8'd0;

//使用写数据时钟下降沿寄存数据，使数据写入存储器时上升沿能踩到稳定的数据
always@(posedge clk_50m or  negedge usr_rst_n)
    if(usr_rst_n == 1'b0)
        data_in_reg <=  8'd0;
    else if(s0_axis_c2h_rst_i)
        data_in_reg <=  8'd0;
    else
        data_in_reg <=  data_in;

//状态机状态跳转
always@(posedge clk_50m or  negedge usr_rst_n)
    if(usr_rst_n == 1'b0)
            state   <=  IDLE;
    else if(s0_axis_c2h_rst_i)
            state   <=  IDLE;
    else    case(state)
        IDLE://检测到数据使能信号为高时，跳转到下一状态将数据写到RAM1
            if(data_en == 1'b1)
                state   <=  WRAM1;
        WRAM1://RAM1数据写完之后，跳转到写RAM2读RAM1状态
            if(ram1_wr_addr == 12'd4095)
                state   <=  WRAM2_RRAM1;
        WRAM2_RRAM1://RAM2数据写完之后，跳转到写RAM1读RAM2状态
            if(ram2_wr_addr == 12'd4095)
                state   <=  WRAM1_RRAM2;
        WRAM1_RRAM2://RAM1数据写完之后，跳转到写RAM2读RAM1状态
            if(ram1_wr_addr == 12'd4095)
                state   <=  WRAM2_RRAM1;
        default:
                state   <=  IDLE;
    endcase

//RAM1,RAM2写使能赋值
always@(*)
    case(state)
        IDLE:
            begin
                ram1_wr_en  <=  1'b0;
                ram2_wr_en  <=  1'b0;
                wea1        <=  1'b0;
                wea2        <=  1'b0;
            end
        WRAM1:
            begin
                ram1_wr_en  <=  1'b1;
                ram2_wr_en  <=  1'b0;
                wea1        <=  1'b1;
                wea2        <=  1'b0;
            end
        WRAM2_RRAM1:
            begin
                ram1_wr_en  <=  1'b0;
                ram2_wr_en  <=  1'b1;
                wea1        <=  1'b0;
                wea2        <=  1'b1;
            end
        WRAM1_RRAM2:
            begin
                ram1_wr_en  <=  1'b1;
                ram2_wr_en  <=  1'b0;
                wea1        <=  1'b1;
                wea2        <=  1'b0;
            end
        default:;
    endcase
//RAM1,RAM2读使能赋值
always@(*)
    case(state)
        IDLE:
            begin
                ram1_rd_en  <=  1'b0;
                ram2_rd_en  <=  1'b0;
            end
        WRAM1:
            begin
                ram1_rd_en  <=  1'b0;
                ram2_rd_en  <=  1'b0;
            end
        WRAM2_RRAM1:
            begin
            ram2_rd_en  <=  1'b0;
            if(c2h0r_run_d1 && s0_axis_c2h_tready_i)
                ram1_rd_en  <=  1'b1;
            else
            	ram1_rd_en  <=  1'b0;
            end
        WRAM1_RRAM2:
            begin
            ram1_rd_en  <=  1'b0;
            if(c2h0r_run_d1 && s0_axis_c2h_tready_i)
                ram2_rd_en  <=  1'b1;
            else
            	ram2_rd_en  <=  1'b0;
            end
        default:;
    endcase


//RAM1写地址
always@(posedge clk_50m or  negedge usr_rst_n)
    if(usr_rst_n == 1'b0)
        ram1_wr_addr   <=  12'd0;
    else if(s0_axis_c2h_rst_i)
        ram1_wr_addr   <=  12'd0;
    else    if(ram1_wr_addr    ==  12'd4095)
        ram1_wr_addr   <=  12'd0;
    else    if(ram1_wr_en == 1'b1)
        ram1_wr_addr   <=  ram1_wr_addr   +   1'b1;

//RAM2写地址
always@(posedge clk_50m or  negedge usr_rst_n)
    if(usr_rst_n == 1'b0)
        ram2_wr_addr   <=  12'd0;
    else if(s0_axis_c2h_rst_i)
        ram2_wr_addr   <=  12'd0; 
    else    if(ram2_wr_addr    ==  12'd4095)
        ram2_wr_addr   <=  12'd0;
    else    if(ram2_wr_en == 1'b1)
        ram2_wr_addr   <=  ram2_wr_addr   +   1'b1;

//RAM1读地址
always@(posedge usr_clk or  negedge usr_rst_n)
    if(usr_rst_n == 1'b0)
        ram1_rd_addr   <=  12'd0;
    else if(s0_axis_c2h_rst_i)
        ram1_rd_addr   <=  12'd0; 
    else    if(ram1_rd_addr    ==  12'd4095)
        ram1_rd_addr   <=  12'd0;
    else    if(ram1_rd_en == 1'b1)
        ram1_rd_addr   <=  ram1_rd_addr   +   1'b1;

//RAM2读地址
always@(posedge usr_clk or  negedge usr_rst_n)
    if(usr_rst_n == 1'b0)
        ram2_rd_addr   <=  12'd0;
    else if(s0_axis_c2h_rst_i)
        ram2_rd_addr   <=  12'd0; 
    else    if(ram2_rd_addr    ==  12'd4095)
        ram2_rd_addr   <=  12'd0;
    else    if(ram2_rd_en == 1'b1)
        ram2_rd_addr   <=  ram2_rd_addr   +   1'b1;
//使用组合逻辑赋值才能使valid与数据对齐        
assign  data_out    =   (ram1_rd_en == 1'b1 && ram2_rd_en == 1'b0) ? ram1_rd_data: ram2_rd_data;

//将乒乓操作读出的数据选择输出（data_out会延迟一个时钟）
always@(posedge usr_clk or  negedge usr_rst_n)
    if(usr_rst_n == 1'b0)begin
//		data_out <= 8'b0;
        data_valid <=  1'b0;
    end
    else if(s0_axis_c2h_rst_i)
    begin
//		data_out <= 8'b0;
        data_valid <=  1'b0;
    end
    else    if(ram1_rd_en == 1'b1)begin
//		data_out <= ram1_rd_data;
        data_valid <=  1'b1;
        end
    else    if(ram2_rd_en == 1'b1)begin
//		data_out <= ram2_rd_data;
        data_valid <=  1'b1;
    end
    else begin
//		data_out <= 8'b0;
        data_valid <=  1'b0;
    end

endmodule
