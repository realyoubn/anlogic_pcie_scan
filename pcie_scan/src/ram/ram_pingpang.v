module  ram_pingpang
(
    input   wire    usr_clk     ,   //系统时钟
    input   wire    usr_rst_n   ,    //复位信号，低有效
    input   wire    clk_50m     ,
    input   wire    stop,
    input   wire    usr_c2h0r_run_i,
    input   wire    s0_axis_c2h_rst_i,
    input   wire    s0_axis_c2h_tready_i,
    output  reg     [127:0] s0_axis_c2h_tdata_o,      //输出乒乓操作数据
    output  reg     s0_axis_c2h_tvalid_o,
    output  reg     s0_axis_c2h_tlast_o
);

//********************************************************************//
//******************** Parameter And Internal Signal *****************//
//********************************************************************//

//wire  define

wire    [7:0]   ram1_rd_data ;   //ram1读数据
wire    [7:0]   ram2_rd_data ;   //ram2读数据
wire            data_en      ;   //输入数据使能信号
wire    [7:0]   data_in      ;   //输入数据
wire            ram1_wr_en   ;   //ram1写使能
wire            ram1_rd_en   ;   //ram1读使能
wire    [11:0]  ram1_wr_addr ;   //ram1写地址
wire    [11:0]  ram1_rd_addr ;   //ram1写地址
wire    [7:0]   ram1_wr_data ;   //ram1写数据
wire            ram2_wr_en   ;   //ram2写使能
wire            ram2_rd_en   ;   //ram2读使能
wire    [11:0]  ram2_wr_addr ;   //ram2写地址
wire    [11:0]  ram2_rd_addr ;   //ram2写地址
wire    [7:0]   ram2_wr_data ;   //ram2写数据
wire    [7:0]   data_out     ;   //输出乒乓操作数据
wire			wea1;
wire			wea2;
reg     [15:0]  data_cnt_o  ;
reg				c2h0r_run_d1;
reg     [127:0] data_out_tem    ;
reg     [3:0]   data_cnt        ;

wire			data_valid;

localparam      DATA_CNT0 = 16'd255;
//********************************************************************//
//*************************** Instantiation **************************//
//********************************************************************//
//pc启动时使c2h0r_run_d1为高，启动读
always @(posedge usr_clk,negedge usr_rst_n)
begin
	if(!usr_rst_n)
		c2h0r_run_d1 <= 1'b0;
    else if(s0_axis_c2h_rst_i)
        c2h0r_run_d1 <= 1'b0;
	else if(usr_c2h0r_run_i)
        c2h0r_run_d1 <= 1'b1;
end

//axi协议决定了每传输4096次数据就要发送last信号
always @(posedge usr_clk,negedge usr_rst_n)
	if(!usr_rst_n)begin
    	data_cnt <= 8'd0;
		data_cnt_o <= 16'd0;
        data_out_tem <= 128'b0;
        s0_axis_c2h_tdata_o <= 128'b0;
        s0_axis_c2h_tvalid_o <= 1'b0;
        s0_axis_c2h_tlast_o <= 1'b0;     
    end
    else if(s0_axis_c2h_rst_i)begin
    	data_cnt <= 8'd0;
		data_cnt_o <= 16'd0;
        data_out_tem <= 128'b0;
        s0_axis_c2h_tdata_o <= 128'b0;
        s0_axis_c2h_tvalid_o <= 1'b0;
        s0_axis_c2h_tlast_o <= 1'b0;     
    end
    else if(data_valid)begin
    	if(stop==1'b1)begin
        	s0_axis_c2h_tvalid_o <= 1'b1;
        	s0_axis_c2h_tlast_o <= 1'b1;
            end
        else begin
    	if(data_cnt == 4'b1111)begin
        	if (data_cnt_o < DATA_CNT0)begin
        	s0_axis_c2h_tdata_o <= {data_out,data_out_tem[127:8]}; 
        	data_cnt <= 4'b0;
            data_cnt_o <= data_cnt_o + 1'b1;
        	s0_axis_c2h_tvalid_o <= 1'b1;
        	s0_axis_c2h_tlast_o <= 1'b0;
        	end
	    	else if(data_cnt_o == DATA_CNT0)begin
        	s0_axis_c2h_tdata_o <= {data_out,data_out_tem[127:8]}; 
        	data_cnt <= 4'b0;
            data_cnt_o <= 16'd0;
        	s0_axis_c2h_tvalid_o <= 1'b1;
        	s0_axis_c2h_tlast_o <= 1'b1;
        	end
        end
        else begin
            data_out_tem  <= {data_out,data_out_tem[127:8]};
            data_cnt <= data_cnt + 1'b1;
            s0_axis_c2h_tvalid_o <= 1'b0;
            s0_axis_c2h_tlast_o <= 1'b0;
        end
    end
    end
    else begin
        s0_axis_c2h_tdata_o <= 128'b0;
        s0_axis_c2h_tvalid_o <= 1'b0;
        s0_axis_c2h_tlast_o <= 1'b0;
    end

//----------- ram_ctrl_inst -----------
ram_ctrl    ram_ctrl_inst
(
    .clk_50m                (clk_50m       ),   //
    .usr_clk                (usr_clk       ),   //
    .usr_rst_n              (usr_rst_n     ),   //复位信号，低有效
    .ram1_rd_data           (ram1_rd_data  ),   //ram1读数据
    .ram2_rd_data           (ram2_rd_data  ),   //ram2读数据
    .data_en                (data_en       ),   //输入数据使能信号
    .data_in                (data_in       ),   //输入数据
    .c2h0r_run_d1           (c2h0r_run_d1  ),
    .s0_axis_c2h_tready_i   (s0_axis_c2h_tready_i),
    .s0_axis_c2h_rst_i      (s0_axis_c2h_rst_i),
    .ram1_wr_en             (ram1_wr_en    ),   //ram1写使能
    .ram1_rd_en             (ram1_rd_en    ),   //ram1读使能
    .ram1_wr_addr           (ram1_wr_addr  ),   //ram1读写地址
    .ram1_rd_addr           (ram1_rd_addr  ),   //ram1读地址
    .ram1_wr_data           (ram1_wr_data  ),   //ram1写数据
    .ram2_wr_en             (ram2_wr_en    ),   //ram2写使能
    .ram2_rd_en             (ram2_rd_en    ),   //ram2读使能
    .ram2_wr_addr           (ram2_wr_addr  ),   //ram2写地址
    .ram2_rd_addr           (ram2_rd_addr  ),   //ram2读地址
    .ram2_wr_data           (ram2_wr_data  ),   //ram2写数据
    .wea1		            (wea1          ),
    .wea2		            (wea2          ),    
    .data_out               (data_out      ),   //输出乒乓操作数据
    .data_valid             (data_valid    )
);

//----------- data_gen_inst -----------
ram_data_gen    data_gen_inst
(
    .clk_50m            (clk_50m   ),   //模块时钟，频率50MHz
    .usr_rst_n          (usr_rst_n ),   //复位信号，低电平有效
    .usr_c2h0r_run_i    (usr_c2h0r_run_i),
    .s0_axis_c2h_rst_i  (s0_axis_c2h_rst_i),
    .data_en            (data_en   ),   //数据使能信号，高电平有效
    .data_in            (data_in   )    //输出数据
        
);

//------------ dq_ram1-------------
dp_ram  dp_ram1
(
    .dia    (ram1_wr_data   ),  //写数据
    .addra  (ram1_wr_addr   ),  //写地址
    .clka   (clk_50m        ),  //写时钟
    .cea    (ram1_wr_en     ),  //写使能
    .addrb  (ram1_rd_addr   ),  //读地址
    .clkb   (usr_clk        ),  //读时钟
    .ceb    (ram1_rd_en     ),  //读使能
    .dob    (ram1_rd_data   ),   //读数据
    .wea	(wea1)
);

//------------ dq_ram2-------------
dp_ram  dp_ram2
(
    .dia    (ram2_wr_data   ),  //写数据
    .addra  (ram2_wr_addr   ),  //写地址
    .clka   (clk_50m        ),  //写时钟
    .cea    (ram2_wr_en     ),  //写使能
    .addrb  (ram2_rd_addr   ),  //读地址
    .clkb   (usr_clk        ),  //读时钟
    .ceb    (ram2_rd_en     ),  //读使能
    .dob    (ram2_rd_data   ),  //读数据
    .wea	(wea2)
);
endmodule
