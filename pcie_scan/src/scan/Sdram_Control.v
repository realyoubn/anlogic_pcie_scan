module Sdram_Control(
                     clk,rst_n,
                     CKE,
							CS,RAS,CAS,WE,
							DQML,DQMH,
							BA0,BA1,
							address,
							DQ,
							q_front,
							rdreq_front,
							rdempty_front,
							data_back,
							wrreq_back,
							wrfull_back,
							empty_sdram,
							DQ_EN
							);

input clk,rst_n;
output CKE;
output CS,RAS,CAS,WE;
output DQML,DQMH;
output BA0,BA1;
output [12:0]address;
inout [15:0] DQ;
output     DQ_EN; 
input [127:0] q_front;
output reg rdreq_front;
input rdempty_front;

output reg [127:0] data_back;
output reg wrreq_back;
input wrfull_back;

output empty_sdram;

`define INHIBIT 4'b1000
`define NOP 4'b0111
`define PRECHARGE 4'b0010
`define PREFRESH 4'b0001
`define LMR 4'b0000
`define ACTIVE 4'b0011 
`define WRITE 4'b0100
`define READ 4'b0101

reg CKE;
reg CS,RAS,CAS,WE;
reg DQML,DQMH;
reg BA0,BA1;
reg [12:0] address;
reg [15:0] DQ_r;
reg DQ_EN;

reg start_lmr;
reg start_precharge;
reg start_row_wr;
reg start_row_rd;
reg start_column_wr;
reg start_column_rd;

reg [127:0] data_in;
reg [2:0] num_wr;
reg [21:0] wraddress,rdaddress;
reg empty_sdram;
reg read_write;
reg [13:0] cnt_read_write;

assign DQ=(DQ_EN)? DQ_r : 16'bzzzzzzzz_zzzzzzzz;

always @(posedge clk or negedge rst_n)
if(!rst_n) 
  begin
    DQMH<=1;
	 DQML<=1;
  end
else 
  begin
    DQMH<=0;
	 DQML<=0;
  end

reg [12:0] cnt;
reg flag_60us;
reg flag_60us_2;
reg clr_cnt;
reg flag_TRFC;
reg flag_TRFC_2;
reg flag_TMRD;
wire flag_TRP;
wire flag_TRC;
wire flag_readend;

always @(posedge clk or negedge rst_n)
if(!rst_n) start_precharge<=0;
else start_precharge<=flag_60us_2;

always @(posedge clk or negedge rst_n)
if(!rst_n) start_lmr<=0;
else start_lmr<=flag_TRFC_2;

always @(posedge clk or negedge rst_n)
if(!rst_n) cnt<=0;
else if(clr_cnt) cnt<=0;
else cnt<=cnt+1'b1;

always @(posedge clk or negedge rst_n)
if(!rst_n) flag_60us<=0;
else if(cnt==13'd7200) flag_60us<=1;
else flag_60us<=0;

always @(posedge clk or negedge rst_n)
if(!rst_n) flag_60us_2<=0;
else if(cnt==13'd7220) flag_60us_2<=1;
else flag_60us_2<=0;

always @(posedge clk or negedge rst_n)
if(!rst_n) flag_TRFC<=0;
else if(cnt==13'd8) flag_TRFC<=1;
else flag_TRFC<=0;

always @(posedge clk or negedge rst_n)
if(!rst_n) flag_TRFC_2<=0;
else if(cnt==13'd12) flag_TRFC_2<=1;
else flag_TRFC_2<=0;

always @(posedge clk or negedge rst_n)
if(!rst_n) flag_TMRD<=0;
else if(cnt==13'd2) flag_TMRD<=1;
else flag_TMRD<=0;

assign flag_TRP=flag_TMRD;
assign flag_TRC=flag_TRFC;
assign flag_readend=flag_TRFC_2;

reg quest_refresh;
reg [9:0]cnt_refresh;
reg clr_refresh;

always @(posedge clk or negedge rst_n)
if(!rst_n) cnt_refresh<=0;
else if(clr_refresh) cnt_refresh<=0;
else if(cnt_refresh==10'd840) cnt_refresh<=10'd840;
else cnt_refresh<=cnt_refresh+1'b1;

always @(posedge clk or negedge rst_n)
if(!rst_n) quest_refresh<=0;
else if(cnt_refresh==10'd840) quest_refresh<=1;
else quest_refresh<=0;

always @(posedge clk or negedge rst_n)
if(!rst_n) cnt_read_write<=0;
else if(cnt_read_write==14'd12000) cnt_read_write<=0;
else cnt_read_write<=cnt_read_write+1'b1;

always @(posedge clk or negedge rst_n)
if(!rst_n) read_write<=0;
else if(cnt_read_write==14'd12000) read_write<=~read_write;
else read_write<=read_write;

parameter IDLE_commend_1 =5'd0;
parameter IDLE_commend_2 =5'd1;
parameter PRECHARGE_commend=5'd2;
parameter WAIT_TRP_commend=5'd3;
parameter PREFRESH_commend_1=5'd4;
parameter WAIT_TRFC_commend_1=5'd5;
parameter PREFRESH_commend_2=5'd6;
parameter WAIT_TRFC_commend_2=5'd7;
parameter LOAD_MODE_commend=5'd8;
parameter WAIT_TMRD_commend=5'd9;
parameter WAIT_commend=5'd10;
parameter ACTIVE_WRITE_commend=5'd11;
parameter WAIT_TRCD_wr=5'd12;
parameter WRITE_commend=5'd13;
parameter WAIT_TRC_commend=5'd14;
parameter ACTIVE_READ_commend=5'd15;
parameter WAIT_TRCD_rd=5'd16;
parameter READ_commend=5'd17;
parameter WAIT_READEND_commend=5'd18;
parameter PREFRESH_commend=5'd19;
parameter WAIT_TRFC_commend=5'd20;


reg [4:0]state_commend;

always @(posedge clk or negedge rst_n)
if(!rst_n)
  begin
    state_commend<=IDLE_commend_1;
	 clr_cnt<=1;
	 CKE<=0;
	 {CS,RAS,CAS,WE}<=`INHIBIT;
	 
	 start_row_wr<=0;
	 start_row_rd<=0;
	 start_column_wr<=0;
	 start_column_rd<=0;
	 
  end
else
  case(state_commend)
  IDLE_commend_1:if(flag_60us)
						  begin
							 state_commend<=IDLE_commend_2;
							 clr_cnt<=1;
							 CKE<=1;
							 {CS,RAS,CAS,WE}<=`NOP;
							 
							 start_row_wr<=0;
	                   start_row_rd<=0;
	                   start_column_wr<=0;
	                   start_column_rd<=0;
							 
						  end
                 else
					    begin
						   state_commend<=IDLE_commend_1;
							clr_cnt<=0;
							CKE<=0;
							{CS,RAS,CAS,WE}<=`INHIBIT;
							
							 start_row_wr<=0;
	                   start_row_rd<=0;
	                   start_column_wr<=0;
	                   start_column_rd<=0;
							
						 end
	IDLE_commend_2:if(flag_60us_2)
	                 begin
						    state_commend<=PRECHARGE_commend;
							 clr_cnt<=1;
					       {CS,RAS,CAS,WE}<=`NOP;
						  end
						else
						  begin
						    state_commend<=IDLE_commend_2;
							 clr_cnt<=0;
					       {CS,RAS,CAS,WE}<=`NOP;
						  end
	PRECHARGE_commend:begin
	                    state_commend<=WAIT_TRP_commend;
							  clr_cnt<=1;
							  {CS,RAS,CAS,WE}<=`PRECHARGE;
	                  end
	WAIT_TRP_commend:if(flag_TRP)
	                   begin
	                     state_commend<=PREFRESH_commend_1;
								{CS,RAS,CAS,WE}<=`NOP;
								clr_cnt<=1;
							 end
						  else
						    begin
							   state_commend<=WAIT_TRP_commend;
								{CS,RAS,CAS,WE}<=`NOP;
								clr_cnt<=0;
							 end
	PREFRESH_commend_1:begin
					  state_commend<=WAIT_TRFC_commend_1;
					  clr_cnt<=1;
					  {CS,RAS,CAS,WE}<=`PREFRESH;
	           end
	WAIT_TRFC_commend_1:if(flag_TRFC)
	              begin
	                state_commend<=PREFRESH_commend_2;
	                clr_cnt<=1;
						 {CS,RAS,CAS,WE}<=`NOP;
					  end
				 else
	            begin
					  state_commend<=WAIT_TRFC_commend_1;
					  clr_cnt<=0;
					  {CS,RAS,CAS,WE}<=`NOP;
					end
	PREFRESH_commend_2:begin
					  state_commend<=WAIT_TRFC_commend_2;
					  clr_cnt<=1;
					  {CS,RAS,CAS,WE}<=`PREFRESH;
	           end
	WAIT_TRFC_commend_2:if(flag_TRFC_2)
	              begin
	                state_commend<=LOAD_MODE_commend;
	                clr_cnt<=1;
						 {CS,RAS,CAS,WE}<=`NOP;
					  end
				 else
	            begin
					  state_commend<=WAIT_TRFC_commend_2;
					  clr_cnt<=0;
					  {CS,RAS,CAS,WE}<=`NOP;
					end
	LOAD_MODE_commend:begin
	                    state_commend<=WAIT_TMRD_commend;
							  clr_cnt<=1;
							  {CS,RAS,CAS,WE}<=`LMR;
	                  end
	WAIT_TMRD_commend:if(flag_TMRD)
	                    begin
							    state_commend<=WAIT_commend;
								 clr_cnt<=1;
								 {CS,RAS,CAS,WE}<=`NOP;
							  end
							else
							  begin
							    state_commend<=WAIT_TMRD_commend;
								 clr_cnt<=0;
								 {CS,RAS,CAS,WE}<=`NOP;
							  end										  
	 WAIT_commend:if(quest_refresh)
	                 begin
						    state_commend<=PREFRESH_commend;
						  end
					  else if((rdempty_front==0) && (read_write==1))
					     begin
						    state_commend<=ACTIVE_WRITE_commend;
							 start_row_wr<=1;
						  end
					  else if( (wrfull_back==0) && (empty_sdram==0) )
					    begin
						   state_commend<=ACTIVE_READ_commend;
							start_row_rd<=1;
						 end
					  else
					    begin
						   state_commend<=WAIT_commend;
						 end
	ACTIVE_WRITE_commend:begin
	                       start_row_wr<=0;
								  start_column_wr<=0;
								  state_commend<=WAIT_TRCD_wr;
								  {CS,RAS,CAS,WE}<=`ACTIVE;
	                     end
	WAIT_TRCD_wr:begin
	            state_commend<=WRITE_commend;
               start_column_wr<=1;	
	            {CS,RAS,CAS,WE}<=`NOP;				
	          end
								
	WRITE_commend:begin
	                start_column_wr<=0;
						 state_commend<=WAIT_TRC_commend;
						 {CS,RAS,CAS,WE}<=`WRITE;
	              end
	
	WAIT_TRC_commend:if(flag_TRC)
	                    begin
						       state_commend<=WAIT_commend;
								 {CS,RAS,CAS,WE}<=`NOP;
								 clr_cnt<=1;
	                    end
							else
							  begin
								 state_commend<=WAIT_TRC_commend;
								 {CS,RAS,CAS,WE}<=`NOP;
								 clr_cnt<=0;
							  end
	ACTIVE_READ_commend:begin
	                      start_column_rd<=0;
								 start_row_rd<=0;
								 state_commend<=WAIT_TRCD_rd;
								 {CS,RAS,CAS,WE}<=`ACTIVE;
	                    end
	WAIT_TRCD_rd:begin
	               state_commend<=READ_commend;
						{CS,RAS,CAS,WE}<=`NOP;
						start_column_rd<=1;
	             end
   READ_commend:begin
	               start_column_rd<=0;
						state_commend<=WAIT_READEND_commend;
						{CS,RAS,CAS,WE}<=`READ;
	             end
	WAIT_READEND_commend:if(flag_readend)
	                       begin
								    state_commend<=WAIT_commend;
									 clr_cnt<=1;
									 {CS,RAS,CAS,WE}<=`NOP;
								  end
	                     else
								  begin
								    state_commend<=WAIT_READEND_commend;
									 clr_cnt<=0;
									 {CS,RAS,CAS,WE}<=`NOP;
								  end
	
	PREFRESH_commend:begin
					  state_commend<=WAIT_TRFC_commend;
					  clr_cnt<=1;
					  {CS,RAS,CAS,WE}<=`PREFRESH;
	           end
	WAIT_TRFC_commend:if(flag_TRFC)
	              begin
	                state_commend<=WAIT_commend;
	                clr_cnt<=1;
						 {CS,RAS,CAS,WE}<=`NOP;
					  end
				 else
	            begin
					  state_commend<=WAIT_TRFC_commend;
					  clr_cnt<=0;
					  {CS,RAS,CAS,WE}<=`NOP;
					end
  endcase


always @(posedge clk or negedge rst_n)
if(!rst_n) clr_refresh<=1;
else if(state_commend==PREFRESH_commend) clr_refresh<=1;
else clr_refresh<=0;
  
  
always @(posedge clk or negedge rst_n)
if(!rst_n)
  begin
    wraddress<=0;
	 rdaddress<=0;
  end  
else if(state_commend==WRITE_commend)
  begin
    wraddress<=wraddress+1'b1;
	 rdaddress<=rdaddress;
  end
else if(state_commend==READ_commend)
  begin
    wraddress<=wraddress;
	 rdaddress<=rdaddress+1'b1;
  end
else
  begin
    wraddress<=wraddress;
	 rdaddress<=rdaddress;
  end
 
always @(posedge clk or negedge rst_n)
if(!rst_n) empty_sdram<=0;
else if(wraddress==rdaddress) empty_sdram<=1;
else empty_sdram<=0; 
 
  
reg [2:0] state_addr;

parameter IDLE_addr=3'd0;
parameter LOAD_MODE_addr=3'd1;
parameter ACTIVE_addr=3'd2;
parameter WRITE_addr=3'd3;
parameter READ_addr=3'd4;

always @(posedge clk or negedge rst_n)
if(!rst_n)
  begin
    state_addr<=IDLE_addr;
	 address<=0;
	 BA0<=0;
	 BA1<=0;
  end
else
  case(state_addr)
  IDLE_addr:if(start_precharge)
              begin
				    state_addr<=LOAD_MODE_addr;
					 address[10]<=1;
				  end
            else
				  begin 
				    state_addr<=IDLE_addr;
				  end
	LOAD_MODE_addr:if(start_lmr)
	                 begin
						    state_addr<=ACTIVE_addr;
							 address<=13'b000_0_00_011_0_011;
						  end
						else
						  begin
						    state_addr<=LOAD_MODE_addr;
						  end
											  
	ACTIVE_addr:if(start_row_wr)
	             begin
					   state_addr<=WRITE_addr;
						address<=wraddress[21:9];
						BA0<=wraddress[0];
						BA1<=wraddress[1];
					 end
				  else if(start_row_rd)
				    begin
				      state_addr<=READ_addr;
						address<=rdaddress[21:9];
						BA0<=rdaddress[0];
				      BA1<=rdaddress[1]; 
					 end
				  else
				    begin
					   state_addr<=ACTIVE_addr;
					 end
	WRITE_addr:if(start_column_wr)
	             begin
					   state_addr<=ACTIVE_addr;
						address[9:0]<={wraddress[8:2],3'b000};
						address[10]<=1;
					 end
				  else
					 begin
					   state_addr<=WRITE_addr;
				    end	
   READ_addr: if(start_column_rd)
					 begin
						state_addr<=ACTIVE_addr;
						address[9:0]<={rdaddress[8:2],3'b000};
						address[10]<=1;
					 end
				  else
					 begin
						state_addr<=READ_addr;
					 end
  endcase


///////state of data bus/////////////////////////
always @(posedge clk or negedge rst_n)
if(!rst_n) DQ_r<=0;
else DQ_r<=data_in[15:0];

reg state_datain;

parameter IDLE_datain=1'b0;
parameter SHIFT_datain=1'b1; 

always @(posedge clk or negedge rst_n)
if(!rst_n) 
  begin
	 state_datain<=IDLE_datain;
	 num_wr<=0;
	 DQ_EN<=0;
  end
else 
  case(state_datain)
  IDLE_datain:if(start_column_wr)
                begin
					   state_datain<=SHIFT_datain;
						num_wr<=0;
						DQ_EN<=1;
						data_in<=data_in>>16;
					 end
				  else
				    begin
					   state_datain<=IDLE_datain;
						data_in<=q_front;
						num_wr<=0;
						DQ_EN<=0;
					 end
	SHIFT_datain:if(num_wr==7)
	               begin
						  state_datain<=IDLE_datain;
						  num_wr<=0;
						  DQ_EN<=0;
						end
	             else
					   begin
						  data_in<=data_in>>16;
						  state_datain<=SHIFT_datain;
						  num_wr<=num_wr+1'b1;
						  DQ_EN<=1;
						end
  endcase
 
always @(posedge clk or negedge rst_n)
if(!rst_n)  rdreq_front<=0;
else if(num_wr==3'd7) rdreq_front<=1;
else rdreq_front<=0;

reg start_column_rd_1q,start_column_rd_2q,start_column_rd_3q,start_column_rd_4q;

always @(posedge clk or negedge rst_n)
if(!rst_n) 
  begin
    start_column_rd_1q<=0;
	 start_column_rd_2q<=0;
	 start_column_rd_3q<=0;
	 start_column_rd_4q<=0;
  end
else
  begin
    start_column_rd_1q<=start_column_rd;
	 start_column_rd_2q<=start_column_rd_1q;
	 start_column_rd_3q<=start_column_rd_2q;
	 start_column_rd_4q<=start_column_rd_3q;
  end

reg flag_data;
reg [2:0] num_read;
  
always @(posedge clk or negedge rst_n)
if(!rst_n) 
  begin
    data_back<=0;
	 flag_data<=0;
	 num_read<=0;
  end
else 
  case(flag_data)
  0:if(start_column_rd_4q)
      begin
		  data_back[127:112]<=DQ;
		  flag_data<=1;
		end
	  else
	    begin
		   flag_data<=0;
			num_read<=0;
		 end
  1:if(num_read==7)
      begin
		  flag_data<=0;
		  num_read<=0;
		end
    else
	   begin
		  flag_data<=1;
		  data_back<=data_back>>16;
		  data_back[127:112]<=DQ;
		  num_read<=num_read+1'b1;
		end
  endcase	
	
always @(posedge clk or negedge rst_n)
if(!rst_n) wrreq_back<=0;
else if(num_read==7) wrreq_back<=1;
else wrreq_back<=0;
		
endmodule

