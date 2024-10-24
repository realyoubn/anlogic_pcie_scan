module uart_2dsp
(
 (*keep*)input clk,//synthesis keep
 input rst_n,
 
 (*keep*)input      rx,//synthesis keep
 (*keep*)output reg tx,//synthesis keep
 //test
 output rx_negn,
 
 (*keep*)output reg [7:0] rx_byte,  //synthesis keep 
//接收指令的单个字节,每次接受开始前一直保持为上一个接收字节
 (*keep*)output reg       rx_done,  //uart顶层提取rx_byte的触发单脉冲
 (*keep*)input      [7:0] tx_byte,  //synthesis keep 
//uart顶层发送指令的单个字节
 (*keep*)input            tx_valid,//uart低层提取发送字节的触发单脉冲
 (*keep*)output reg       tx_done   //单个字节发送完成时，对uart顶层发送的单脉冲
);
parameter integer BF_N = 10;
parameter  CLKFREQ  = 48000000;
parameter  BAUDRATE = 115473;


localparam B1=  CLKFREQ/BAUDRATE;
localparam B2=  2*CLKFREQ/BAUDRATE;
localparam B3=  3*CLKFREQ/BAUDRATE;
localparam B4=  4*CLKFREQ/BAUDRATE;
localparam B5=  5*CLKFREQ/BAUDRATE;
localparam B6=  6*CLKFREQ/BAUDRATE;
localparam B7=  7*CLKFREQ/BAUDRATE;
localparam B8=  8*CLKFREQ/BAUDRATE;
localparam B9=  9*CLKFREQ/BAUDRATE;
localparam B10 = 10*CLKFREQ/BAUDRATE;
localparam B11 = 11*CLKFREQ/BAUDRATE;

localparam B1_5 = CLKFREQ/BAUDRATE +CLKFREQ/(BAUDRATE*2);
localparam B2_5 = 2*CLKFREQ/BAUDRATE +CLKFREQ/(BAUDRATE*2);
localparam B3_5 = 3*CLKFREQ/BAUDRATE +CLKFREQ/(BAUDRATE*2);
localparam B4_5 = 4*CLKFREQ/BAUDRATE +CLKFREQ/(BAUDRATE*2);
localparam B5_5 = 5*CLKFREQ/BAUDRATE +CLKFREQ/(BAUDRATE*2);
localparam B6_5 = 6*CLKFREQ/BAUDRATE +CLKFREQ/(BAUDRATE*2);
localparam B7_5 = 7*CLKFREQ/BAUDRATE +CLKFREQ/(BAUDRATE*2);
localparam B8_5 = 8*CLKFREQ/BAUDRATE +CLKFREQ/(BAUDRATE*2);


reg [BF_N-1:0]rx_filtration; //接受信号移位滤波寄存器
reg       rx_r;         //滤波后的接收信号
reg       rx_r1;
wire      rx_neg;       //rx进入工作状态的触发触发单脉冲
(*keep*)reg [31:0]rx_cnt;       //synthesis keep
//rx的bit提取计数信号
(*keep*)reg [2:0] rx_state;     //synthesis keep
//状态机状态信号

reg [7:0] tx_byte_r;    //在收到提取字节的触发信号之后，将tx_byte赋值给该寄存器
reg [31:0]tx_cnt;       //发送模块工作时，对bit宽度进行计数的计数器
reg [2:0] tx_state;//synthesis keep


/*//8000_000/9600=833/// (10/9600)/(1/8000_000) == 8333
always @ (posedge clk or negedge rst_n)
begin
  if (!rst_n)
    enable16_cnt  <= 6'd0;
  else
    begin
	   if (enable16_cnt == 6'd51)
		  enable16_cnt <= 6'd0;
		else if (enable16_cnt < 6'd51)
		  enable16_cnt <= enaclbe16_cnt + 6'd1;
		else
		  enable16_cnt <= 6'd0;
	 end
end

assign enable16 = (enable16_cnt == 6'd25) ? 1'b1 : 1'b0;*/

//rx
always @ (posedge clk or negedge rst_n)
begin
  if (!rst_n)
    rx_filtration  <= {BF_N{1'b1}};
  else
    rx_filtration  <= {rx_filtration[BF_N-2:0],rx};
end

always @ (posedge clk or negedge rst_n)
begin
  if (!rst_n)
    rx_r <= 1'b1; //uart长为高电平
  else
    begin
	   if (rx_filtration == {BF_N{1'b1}})
		  rx_r <= 1'b1;
		else if (rx_filtration == {BF_N{1'b0}})
		  rx_r <= 1'b0;
		else
		  rx_r <= rx_r;
	 end
end

always @ (posedge clk or negedge rst_n)
begin
  if (!rst_n)
    rx_r1 <= 1'b1;
  else
    rx_r1 <= rx_r;
end

assign rx_neg = rx_r1 && ( ~ rx_r);
assign rx_negn = rx_neg;

localparam rx_idle      = 3'd1;//起始空闲状态
localparam rx_waitstart = 3'd2;//等待输入信号rx下降沿出现
localparam rx_worktime  = 3'd3;//计数器工作，根据计数值来抽取uart的每个bit
localparam rx_yourword  = 3'd4;//结束单个字节接收工作，提交数据（比在工作状态计数判断）
always @ (posedge clk or negedge rst_n)
begin
  if (!rst_n)
    begin
	   rx_state <= rx_idle;
		rx_cnt   <= 32'd0;
		rx_byte  <= {8{1'b1}};
		rx_done  <= 1'b0;
	 end
  else
    begin
	   case (rx_state)
		  rx_idle :
		    begin
			   rx_state <= rx_waitstart;
		      rx_cnt   <= 32'd0;
		      rx_byte  <= {8{1'b1}};
		      rx_done  <= 1'b0;
			 end
		  rx_waitstart :
		    begin
			   rx_cnt   <= 32'd0;
		      rx_byte  <= rx_byte;
		      rx_done  <= 1'b0;
				if (rx_neg)
				  rx_state <= rx_worktime;
				else
				  rx_state <= rx_waitstart;
			 end
		  rx_worktime :
		    begin
			   rx_done  <= 1'b0;
			   if (rx_cnt == B10)//<10*833//<10*69//<10*26
				  begin
				    rx_state <= rx_yourword;
					 rx_cnt   <= 32'd0;
					 rx_byte  <= rx_byte;
					 rx_done  <= 1'b0; 
				  end
				//else if ((rx_cnt == 14'd36) || (rx_cnt == 14'd65) || (rx_cnt == 14'd91) || (rx_cnt == 14'd117) || (rx_cnt == 14'd143) || (rx_cnt == 14'd169) || (rx_cnt == 14'd195) || (rx_cnt == 14'd221))//（n*833 + 416）± 1\(8>=n>=1)、二进制里1越少，越省逻辑单元/*空除第一个起始位（0-833）*///uart传输一个字节的时候，低位在前，高位在后
				else if ((rx_cnt == B1_5) || (rx_cnt == B2_5) || (rx_cnt == B3_5) || (rx_cnt == B4_5) || (rx_cnt == B5_5) || (rx_cnt == B6_5) || (rx_cnt == B7_5) || (rx_cnt == B8_5))//（n*833 + 416）± 1\(8>=n>=1)、二进制里1越少，越省逻辑单元/*空除第一个起始位（0-833）*///uart传输一个字节的时候，低位在前，高位在后
				  begin
				    rx_state     <= rx_worktime;
					 rx_cnt       <= rx_cnt + 32'd1;
					 rx_byte      <= {rx_r,rx_byte[7:1]};
					 rx_done      <= 1'b0;
				  end
//				else if (rx_cnt > 14'd250)//8192
//				  begin
//				    rx_state <= rx_yourword;
//					 rx_cnt   <= 14'd0;
//					 rx_byte  <= rx_byte;
//					 rx_done  <= 1'b0; 
//				  end
				else
				  begin
				    rx_state     <= rx_worktime;
					 rx_cnt       <= rx_cnt + 32'd1;
					 rx_byte      <= rx_byte;
					 rx_done      <= 1'b0;
				  end
			 end
		  rx_yourword :
		    begin
			   rx_state <= rx_waitstart;
			   rx_cnt   <= 32'd0;
				rx_byte  <= rx_byte;
			   rx_done  <= 1'b1; 
			 end
		  default :
		    begin  
				rx_state <= rx_idle;
		      rx_cnt   <= 32'd0;
		      rx_byte  <= {8{1'b1}};
		      rx_done  <= 1'b0;
			 end
		endcase
	 end
end
////////////

//tx
localparam tx_idle      = 3'd1;//
localparam tx_waitvalid = 3'd2;//等待发送一个字节的valid信号，每个valid只管一个字节，接收到valid单脉冲，将tx_byte赋值到状态机里的对应寄存器中
localparam tx_worktime  = 3'd3;//发送UART一个字节的工作时间，与接收模块不同，发送模块必须保证每个bit发送的时间足够1/9600s,UART是先发最低位，再发高位
localparam tx_finish    = 3'd4;//由工作模块完成命令发送和延迟的工作，这里产生字节发送完成的单脉冲提示信号
always @ (posedge clk or negedge rst_n)
begin
  if (!rst_n)
    begin
	   tx_state  <= tx_idle;
	   tx_cnt    <= 32'd0;
		tx_byte_r <= 8'd0;
		tx_done   <= 1'b0;
		tx        <= 1'b1;
	 end
  else
    begin
	   case(tx_state)
		  tx_idle :
		    begin
			   tx_state   <= tx_waitvalid;
				tx_cnt     <= 32'd0;
				tx_byte_r  <= 8'd0;
				tx_done    <= 1'b0;
				tx         <= 1'b1;
			 end
		  tx_waitvalid :
		    begin
			   tx_done    <= 1'b0;
				tx_cnt     <= 32'd0;
				if (tx_valid == 1'b1)
				  begin
				    tx_byte_r  <= tx_byte;
					 tx_state   <= tx_worktime;
					 tx         <= 1'b0;//起始低电平信号,0-832
				  end
				else
				  begin
				    tx_byte_r  <= 8'd0;
					 tx_state   <= tx_waitvalid;
					 tx         <= 1'b1;
				  end
			 end
		  tx_worktime :
		    begin
			   tx_done   <= 1'b0;
				begin
				  //if (tx_cnt == 14'd286)//11*833.3
				  if (tx_cnt == B11)//11*833.3
				    begin
					   tx_state  <= tx_finish;
						tx_byte_r <= tx_byte_r;
						tx_cnt    <= 32'd0;
						tx        <= 1'b1;
					 end
				  //else if (tx_cnt == 14'd26)
				  else if (tx_cnt == B1)
				    begin
					   tx_state  <= tx_worktime;
						tx_byte_r <= tx_byte_r;
						tx_cnt    <= tx_cnt + 32'd1;
						tx        <= tx_byte_r[0];//将数据发送口换位最低位字节
					 end
				  //else if (tx_cnt == 14'd52)
				  else if (tx_cnt == B2)
				    begin
					   tx_state  <= tx_worktime;
						tx_byte_r <= tx_byte_r;
						tx_cnt    <= tx_cnt + 32'd1;
						tx        <= tx_byte_r[1];//将数据发送口换位第二低位字节
					 end
				  //else if (tx_cnt == 14'd78)
				  else if (tx_cnt == B3)
				    begin
					   tx_state  <= tx_worktime;
						tx_byte_r <= tx_byte_r;
						tx_cnt    <= tx_cnt + 32'd1;
						tx        <= tx_byte_r[2];//将数据发送口换位第三低位字节
					 end
				  //else if (tx_cnt == 14'd104)
				  else if (tx_cnt == B4)
				    begin
					   tx_state  <= tx_worktime;
						tx_byte_r <= tx_byte_r;
						tx_cnt    <= tx_cnt + 32'd1;
						tx        <= tx_byte_r[3];//将数据发送口换位第四低位字节
					 end
				  //else if (tx_cnt == 14'd130)
				  else if (tx_cnt == B5)
				    begin
					   tx_state  <= tx_worktime;
						tx_byte_r <= tx_byte_r;
						tx_cnt    <= tx_cnt + 32'd1;
						tx        <= tx_byte_r[4];//将数据发送口换位第五低位字节
					 end
				  //else if (tx_cnt == 14'd156)
				  else if (tx_cnt == B6)
				    begin
					   tx_state  <= tx_worktime;
						tx_byte_r <= tx_byte_r;
						tx_cnt    <= tx_cnt + 32'd1;
						tx        <= tx_byte_r[5];//将数据发送口换位第六低位字节
					 end
				  //else if (tx_cnt == 14'd182)
				  else if (tx_cnt == B7)
				    begin
					   tx_state  <= tx_worktime;
						tx_byte_r <= tx_byte_r;
						tx_cnt    <= tx_cnt + 32'd1;
						tx        <= tx_byte_r[6];//将数据发送口换位第七低位字节
					 end
				  //else if (tx_cnt == 14'd208)
				  else if (tx_cnt == B8)
				    begin
					   tx_state  <= tx_worktime;
						tx_byte_r <= tx_byte_r;
						tx_cnt    <= tx_cnt + 32'd1;
						tx        <= tx_byte_r[7];//将数据发送口换位最高位字节
					 end
				  //else if (tx_cnt == 14'd234)
				  else if (tx_cnt == B9)
				    begin
					   tx_state  <= tx_worktime;
						tx_byte_r <= tx_byte_r;
						tx_cnt    <= tx_cnt + 32'd1;
						tx        <= 1'b1;//数据发送口将最高位数据保留833个周期后进入结束位：高电平
					 end
				  //else if (tx_cnt > 14'd260)
				  else if (tx_cnt > B10)
				    begin
					   tx_state  <= tx_finish;
						tx_byte_r <= tx_byte_r;
						tx_cnt    <= 32'd0;
						tx        <= 1'b1;
					 end
				 else //当tx_cnt<14'd1968的其他情况
				    begin
					   tx_state  <= tx_worktime;
						tx_byte_r <= tx_byte_r;
						tx        <= tx;
						tx_cnt    <= tx_cnt + 32'd1;
					 end
				end
			 end
		  tx_finish :
		    begin
			   tx_state  <= tx_waitvalid;
				tx_byte_r <= tx_byte_r;
				tx        <= 1'b1;
				tx_cnt    <= 32'd0;
				tx_done   <= 1'b1;
			 end
		  default :
		    begin
			   tx_state  <= tx_waitvalid;
				tx_byte_r <= 8'd0;
				tx        <= 1'b1;
				tx_cnt    <= 32'd0;
				tx_done   <= 1'b0;
			 end
		endcase
	 end
end

////////////
endmodule 
