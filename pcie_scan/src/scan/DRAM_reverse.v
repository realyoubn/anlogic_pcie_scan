module DRAM_reverse
(
   input  clk_sys,
   input  rst_n,
   input  CSEN,
   input  dpi200,
   input  [1:0]dpi_mode,
   input [7:0] din1,din1b,
   input [7:0] din2,din2b,
   input [7:0] din3,din3b,
   input [7:0] din4,din4b,
   input [11:0] wrdwfront,
   input  rd_triger,
   input  S_AXIS_S2MM_0_tready,
   output rd_clk,
   output reg rden1,rden1b,
//   output reg rden2,rden2b,
   output  rden2,rden2b,  //20230909
   output reg rden3,rden3b,
//   output reg rden4,rden4b,
   output  rden4,rden4b,  //20230909
   input  [12:0] HoriPixNum,
   output  frontrd_out_axi, //axi valid signal  20230923
//   output reg[7:0] douta,doutb,
   output [7:0]dout,
   output  reg fifo_act,//this signal is set to make "tvalid" signal right
   output reg[14:0] addrb1,
   output reg[14:0] addrb2,
   //output [13:0] addrb,
   output reg      rd_ack,
   output tl_last,
   output reg [7:0]dout_test
);
reg [4:0]data_cnt;

always@(posedge clk_sys)
begin
	if(frontrd_out_axi)begin
    if(data_cnt==5'd19)
    begin
    	data_cnt <= 5'd0;
        dout_test <= dout_test + 1'b1;
    end
    else
    begin
    	data_cnt <= data_cnt + 1'b1;
        dout_test <= dout_test;
    end
    end
    else
    begin
    	data_cnt <= 5'd0;
        dout_test <= 8'd0;
    end
end

//always@(posedge clk_sys)
//begin
//	if(frontrd_out_axi)
//    begin
//    	dout_test = dout_test + 1;
//    end
//    else
//    begin
//    	dout_test = 0;
//    end
//end

parameter 			    IDLE     = 8'd0,
						CHECK_BW = 8'd1,
						DELAY_BW = 8'd2,
						RAM_BW1  = 8'd3,
						RAM_BW2  = 8'd4,
						FIFO_BW  = 8'd5;
reg[7:0] douta,doutb;	
wire[7:0] dataout;					
reg[7:0] CS;   
reg[7:0] CS_d0 , CS_d1 , CS_d2 ,  CS_d3,CS_d4,CS_d5;  
reg[7:0] NS;
reg[3:0] delay_shift; 		  
reg rd_req,frontfull;
reg delay_f;
reg [14:0] addr_cntA1;
reg [14:0] addr_cntB1;
reg [14:0] addr_cnt2;
reg [14:0] addr_cntA1_d0,addr_cntA1_d1;
reg [14:0] addr_cntB1_d0,addr_cntB1_d1;
reg [1:0] cnt_circle;
reg [11:0]cnt_fifo;
 //reg [14:0] addr_cnt2_d0,addr_cnt2_d1;
wire rd_en; 	
reg[7:0] dout_200dpi;
reg[7:0] dataout_d0;
reg rden2_r0,rden2b_r0,rden4_r0,rden4b_r0;
reg rden2_r,rden2b_r,rden4_r,rden4b_r;
reg            CS_r;
//reg            fifo_act;   //this signal is set to make "tvalid" signal right

wire                 wr_en;
reg                  wr_en_mix;
wire                 rd_fifo;
reg                  rd_fifo_mix;
wire                 full,full_mix ;
wire                 empty,empty_mix;
wire                  firstline_down;
//reg [14:0]           addr_cnt1; 
//reg [14:0]           addr_cnt2;  
reg                  tlast   ;  
wire                 sign1   ;  
reg                  rd_fifo_d,rd_fifo_d_mix ;
reg                  rd_fifo_d1,rd_fifo_d1_mix;
reg  wr_en_d;   
reg  wr_en_d0,wr_en_d1;
wire frontrd_out;
reg frontrd_out_d1;
reg frontrd_out_d0;

wire valid_dpi;
reg  valid_dpi_d0,valid_dpi_d1,valid_dpi_d2;

//fifo 
wire[7:0] dinb_w,dinb_w_mix;


assign rden2=rden2_r;
assign rden2b=rden2b_r;
assign rden4=rden4_r;
assign rden4b=rden4b_r;

fifo_generator_0 fifo0 (
  .clk(clk_sys),                // input wire clk
  .rst(~rst_n),              // input wire srst
  .di(doutb),                // input wire [7 : 0] din
  .we(wr_en),            // input wire wr_en
  .re(rd_fifo),            // input wire rd_en
  .dout(dinb_w),              // output wire [7 : 0] dout
  .full_flag(full),              // output wire full
  .empty_flag(empty)            // output wire empty
);

assign dataout =  douta    ;
//assign dataout =   firstline_down ?    dinb_w   :  douta    ;
assign dout    = (dpi_mode[0]&dpi200)?    dinb_w_mix : dataout ;
assign rd_fifo =  (!empty)& rd_fifo_d ;
//assign wr_en = frontrd_out_d1&(!rd_fifo);
assign wr_en = frontrd_out_d0&(!rd_fifo);
assign firstline_down=rd_fifo;
//assign rd_fifo=  (!empty)& rd_fifo_d1 ;


fifo_generator_0 fifo1 (
  .clk(clk_sys),                // input wire clk
  .rst(~rst_n),              // input wire srst
  .di(dout_200dpi),                // input wire [7 : 0] din
  .we(wr_en_mix),            // input wire wr_en
  .re(rd_fifo_d_mix),            // input wire rd_en
  .dout(dinb_w_mix),              // output wire [7 : 0] dout
  .full_flag(full_mix),              // output wire full
  .empty_flag(empty_mix)            // output wire empty
);

always @ (posedge clk_sys or negedge rst_n) //
begin
	if (!rst_n) 
	begin
		dout_200dpi<=0;
		dataout_d0    <=0;
		end 
	else
	begin 
	    dataout_d0    <=dataout;
	   if(cnt_circle==1)
		dout_200dpi<=(2*dataout_d0/3)+(dataout/3);
	   else if(cnt_circle==2)
		dout_200dpi<=(dataout_d0/3)+(2*dataout/3);
	end 	
end 

always @ (posedge clk_sys or negedge rst_n) //
begin
	if (!rst_n) 
	begin
		CS <= IDLE;
		CS_r <= 1'b0;
		end 
	else
	begin 
		CS <= NS;
		CS_r <= CSEN;
	end 	
end 

always @ (posedge clk_sys or negedge rst_n) //
begin
	if (!rst_n) 
	 begin
		CS_d0 <= IDLE;
		CS_d1 <= IDLE;
		CS_d2 <= IDLE;
		CS_d3 <= IDLE;
		CS_d4 <= IDLE;
		CS_d5 <= IDLE;
     end 
	else
	 begin 
        CS_d0 <= CS;
        CS_d1 <= CS_d0;
        CS_d2 <= CS_d1;
        CS_d3 <= CS_d2;
        CS_d4 <= CS_d3;
        CS_d5 <= CS_d4;
	 end 	
end 











reg [3:0] rden1_td;
reg [3:0] rden2_td;
reg [3:0] rden1b_td;
reg [3:0] rden2b_td;
reg [3:0] rden3_td;
reg [3:0] rden4_td;
reg [3:0] rden3b_td;
reg [3:0] rden4b_td;
reg [3:0] tlast_td;
reg [3:0] rd_fifo_td;




always @ (posedge clk_sys or negedge rst_n ) //
begin
	if (!rst_n) 
	begin
		frontrd_out_d1  <= 0;
		frontrd_out_d0  <= 0;
		end 
	else
	begin 
//		frontrd_out_d0 <= (rden1_td[2] | rden1b_td[2] | rden2 | rden2b|rden3_td[2] | rden3b_td[2] | rden4 | rden4b|firstline_down);
//        frontrd_out_d0 <= (rden1_td[0] | rden1b_td[0] | rden2 | rden2b|rden3_td[0] | rden3b_td[0] | rden4 | rden4b|fifo_act);
//        frontrd_out_d0 <= (rden1 | rden1b | rden2 | rden2b|rden3 | rden3b | rden4 | rden4b|fifo_act);
		frontrd_out_d0    <= frontrd_out;
		frontrd_out_d1 <= frontrd_out_d0;
	end 	
end 

always @ (posedge clk_sys or negedge rst_n ) //
begin
	if (!rst_n) 
	begin
		valid_dpi_d0  <= 0;
		valid_dpi_d1  <= 0;
		end 
	else
	begin 
		valid_dpi_d0  <=valid_dpi;
		valid_dpi_d1  <=valid_dpi_d0;
	end 	
end

assign frontrd_out =(rden1_td[3] | rden1b_td[3] | rden2_r0 | rden2b_r0);
//assign frontrd_out =(rden1_td[3] | rden1b_td[3] | rden2_r0 | rden2b_r0|rden3_td[3] | rden3b_td[3] | rden4_r0 | rden4b_r0|fifo_act);        
assign frontrd_out_axi =dpi200   ?   valid_dpi_d1     :  (frontrd_out_d0 || frontrd_out);  //20230906
assign valid_dpi    = rd_fifo_d_mix&!(CS_d2==1);
assign tlast_dpi    = (CS_d4==0)&frontrd_out_axi;

always @ (*) 
begin 
	if (!rst_n) 
		NS = IDLE;
	else 
		case (CS) 
			IDLE     :  NS = CHECK_BW;
			CHECK_BW : 	NS = (rd_triger == 1)  ?    DELAY_BW  : CHECK_BW;
			DELAY_BW :  NS = (delay_f == 1)	   ?    RAM_BW1   : DELAY_BW;
			RAM_BW1  :  NS = (rd_ack == 1)     ?    RAM_BW2   : RAM_BW1;  //ramADCFIFO
			RAM_BW2  :  NS = (rd_ack == 1)     ?    FIFO_BW   : RAM_BW2;
			FIFO_BW  :  NS = (empty ==1 )      ?    IDLE      : FIFO_BW;  //FIFO§Ö
		default : NS  = IDLE;
		endcase
end 
/////////////////////////////////////////////////
always @ (posedge clk_sys or negedge rst_n) 	
begin
	if (!rst_n) 
	begin 
		rd_req      <= 1'b0;
		delay_shift <= 4'd0; 
		delay_f     <= 1'b0;
        rden1       <= 1'b0;
        rden2_r0       <= 1'b0;
        rden2_r       <= 1'b0;
        rden1b      <= 1'b0;
        rden2b_r0      <= 1'b0;
        rden2b_r      <= 1'b0;
        rden3       <= 1'b0;
        rden4_r0       <= 1'b0;
        rden4_r       <= 1'b0;
        rden3b      <= 1'b0;
        rden4b_r0      <= 1'b0;
        rden4b_r      <= 1'b0;
//        rd_fifo     <= 1'b0;
//        wr_en       <= 1'b0;
      
	end 
	else begin
		case (CS) 
			IDLE : 
				begin
					delay_shift <= 4'b1000;
					rd_req <= 1'b0;
//					rd_fifo<= 1'b0;
//					wr_en  <= 1'b0;
				end 
				
			DELAY_BW : 
				begin
					delay_shift <= {1'b0,delay_shift[3:1]};
					delay_f <= delay_shift[0];	
					rd_req <= 1'b0;
//					wr_en  <= 1'b0;
				end
				
			RAM_BW1  : 
			      begin
			      rd_req <= 1'b1;
//			      rd_fifo<=1'b0;
//			      wr_en <= wr_en_d ; 
					   if (CS_r)
						  begin
					        rden1 <= rd_en;
							rden2_r0 <= 0;
							rden2_r<=0;
							rden3 <= rd_en;
							rden4_r0 <= 0;
							rden4_r <= 0;
						  end
						else
						  begin
						    rden1b <= rd_en;
							rden2b_r0 <= 0;
							rden2b_r <= 0;
							rden3b <= rd_en;
							rden4b_r0 <= 0;
							rden4b_r <= 0;
						  end 
					end 

			RAM_BW2  : 
			      begin 
//			      rd_fifo<=1'b0;
//			      wr_en <= wr_en_d ;
					   if (CS_r)
						  begin
					        rden1 <= 0;
							rden2_r0 <= rd_en;
							rden2_r<=rden2_r0;
							rden3 <= 0;
							rden4_r0 <= rd_en;
							rden4_r<=rden4_r0;
						  end
						else
						  begin
					    	rden1b <= 0;
							rden2b_r0 <= rd_en;
							rden2b_r <= rden2b_r0;
							rden3b <= 0;
							rden4b_r0 <= rd_en;
							rden4b_r<=rden4b_r0;
						  end   	
					end
					
		     FIFO_BW:
		          begin
		          
//		          rd_fifo<=1'b1;
//		          wr_en  <=1'b0;
		                   rden1   <= 1'b0;
                           rden2_r0   <= 1'b0;
                           rden2_r   <= 1'b0;
                           rden1b  <= 1'b0;
                           rden2b_r0  <= 1'b0;
                           rden2b_r  <= 1'b0;
                           rden3   <= 1'b0;
                           rden4_r0   <= 1'b0;
                           rden4_r   <= 1'b0;
                           rden3b  <= 1'b0;
                           rden4b_r0  <= 1'b0;
                           rden4b_r  <= 1'b0;
		          
		          
		          
		          end
              default: 
                 begin
                           rden1   <= 1'b0;
                           rden2_r0   <= 1'b0;
                           rden2_r   <= 1'b0;
                           rden1b  <= 1'b0;
                           rden2b_r0  <= 1'b0;
                           rden2b_r  <= 1'b0;
                           rden3   <= 1'b0;
                           rden4_r0   <= 1'b0;
                           rden4_r   <= 1'b0;
                           rden3b  <= 1'b0;
                           rden4b_r0  <= 1'b0;
                           rden4b_r  <= 1'b0;
//                           rd_fifo <= 1'b0;
//                           wr_en   <= 1'b0;

                 end
		endcase		
	end 	
end	
/////////////////////////////////////////////////////////////
wire addr_valid;


//assign addr_valid = ((addr_cnt1 > 0)&(addr_cnt1 <= (HoriPixNum*3+1))) ? 1'b1 : 1'b0;//7630
assign addr_valid = ((addr_cntA1 >= 0)&(addr_cntA1 <= (HoriPixNum*3+1))) ? 1'b1 : 1'b0;//20230718

//always @ (posedge clk_sys or negedge rst_n )
//begin
//    if (!rst_n)begin
//	    rd_en <= 0;
////	    wr_en_d <= 0;
//	end
//    else if ((rd_req == 1) & (frontfull == 0) & addr_valid & S_AXIS_S2MM_0_tready) begin
//	    rd_en <= 1;
////	    wr_en_d <= 1;
//	    end
//	 else begin 
//	    rd_en <= 0;
////	    wr_en_d <= 0;
//	    end
//end

assign rd_en=(rd_req == 1) & (frontfull == 0) & addr_valid & S_AXIS_S2MM_0_tready;


always @(posedge clk_sys or negedge rst_n)
begin
if(!rst_n)
frontfull <= 0;
else if (wrdwfront >= 1900)
frontfull <= 1;
else 
frontfull <= 0;	
end



//always @ (posedge clk_sys or negedge rst_n) 	 
always @ (posedge clk_sys )
begin 
	if (!rst_n) begin 
		rd_ack   <= 1'b0;
		addr_cntA1 <= 1'b0;
		addr_cntB1 <= HoriPixNum*3 - 1;
		addr_cnt2 <= 1'b0;
        tlast    <= 1'b0; 
//        wr_en    <= 1'b0;
        rd_fifo_d  <= 1'b0;
//        firstline_down   <= 1'b0;
        fifo_act  <=1'b0;
	end 	
	else 
   case(CS)
   
           IDLE: begin
//           firstline_down<=0;
//           wr_en    <= 1'b0;
//           rd_fifo_d<= 1'b0;
           rd_fifo_d  <= 1'b0;
           fifo_act  <=1'b0;
           end
           
            RAM_BW1: 
//                  if ( addr_cntA1 == (HoriPixNum*3 - 1) ) 
//                   if ( addr_cntA1 == (HoriPixNum*3+1 ) )    //20230906 
                 if ( addr_cntA1 == (HoriPixNum*3 ) )
                   begin
                     addr_cntA1 <= 1'b0; 
                     addr_cntB1 <= HoriPixNum*3 - 1;
                     rd_ack   <= 1'b0;
//                     wr_en    <= 1'b0;
                     rd_fifo_d  <= 1'b0;
                     fifo_act <= 1'b0;
                     tlast    <= 1'b0;
//                     firstline_down   <= 1'b0;
                   end
                  else  if ( addr_cntA1 == (HoriPixNum*3-1 ) )
                   begin
//                     addr_cntA1 <= 1'b0; 
//                     addr_cntB1 <= HoriPixNum*3 - 1;
                     addr_cntA1 <= addr_cntA1 + 1'b1;    //20230909
                     addr_cntB1 <= 0;
                     rd_ack   <= 1'b1;
//                     wr_en    <= 1'b0;
                     rd_fifo_d  <= 1'b0;
                     fifo_act <= 1'b0;
                     tlast    <= 1'b0;
//                     firstline_down   <= 1'b0;
                   end
//                  else if( addr_cntA1 == (HoriPixNum*3-1 ) ) 
                    else if( addr_cntA1 == (HoriPixNum*3-2 )) 
                  begin
                     addr_cntA1 <= addr_cntA1 + 1'b1; 
                     addr_cntB1 <= 0;
                     rd_ack   <= 1'b0;
//                     wr_en    <= 1'b0;
                     rd_fifo_d  <= 1'b0;
                     fifo_act <= 1'b0;
                     tlast    <= 1'b0;
//                     firstline_down   <= 1'b0;
                   end
                  else 
                   begin   
                     addr_cntA1 <= addr_cntA1 + 1'b1; 
                     addr_cntB1 <= addr_cntB1 - 1'b1; 
                     rd_ack   <= 1'b0;
//                     wr_en    <= 1'b1;
                     fifo_act <= 1'b0;
                     rd_fifo_d  <= 1'b0;
                     tlast    <= 1'b0;
//                     firstline_down   <= 1'b0;
                   end

            RAM_BW2: 
                  if ( addr_cntA1 == (HoriPixNum*3)-1 ) 
//                    if ( addr_cntA1 == (HoriPixNum*3) )  //20230906 rd_ack
                   begin
                     addr_cntA1 <= 1'b0;
                     addr_cntB1 <= HoriPixNum*3 - 1; 
                     rd_ack    <= 1'b1;
//                     wr_en    <= 1'b0;
                     fifo_act  <= 1'b1;
                     tlast     <= 1'b0;
//                     firstline_down   <= 1'b1;
                     rd_fifo_d  <= 1'b0;
                   end
                  else 
                   begin 
//                   if(NS==RAM_BW2)
//                     if(CS_d0==RAM_BW2)   //20230909   
//                     begin  
                     addr_cntA1 <= addr_cntA1 + 1'b1; 
                     addr_cntB1 <= addr_cntB1 - 1'b1;
                     rd_ack   <= 1'b0;
                     fifo_act <= 1'b0;
                     rd_fifo_d  <= 1'b0;
//                     wr_en    <= 1'b1;
                     tlast    <= 1'b0;
//                     firstline_down   <= 1'b0;
                   end
             FIFO_BW:
             if ( empty ) 
                   begin
                       addr_cnt2 <= 1'b0;
                       tlast    <= 1'b1;
                       fifo_act <= 1'b0;
//                     rd_en     <=1'b0;
                       rd_fifo_d <=1'b0; 
//                       wr_en     <= 1'b0;
//                       firstline_down   <= 1'b0;
//                       rd_fifo  <= 1'b0;
                   end
//                  else if(addr_cnt2 >= (HoriPixNum*6)+1)
//                    else if(addr_cnt2 >= (HoriPixNum*6)-1)  //20230906
//                           begin
//                           tlast    <= 1'b1;
//                           rd_fifo_d <=1'b1;
////                           firstline_down   <= 1'b1;
//                           fifo_act  <=1'b0;
//                           end
                       else if(addr_cnt2 >= (HoriPixNum*6)+1)  //20230906
                           begin
                           tlast    <= 1'b1;
                           rd_fifo_d <=1'b1;
//                           firstline_down   <= 1'b1;
                           fifo_act  <=1'b0;
                           end
                           else if(addr_cnt2 == (HoriPixNum*6))  //20230906
                           begin
                           tlast    <= 1'b1;
                           rd_fifo_d <=1'b1;
//                           firstline_down   <= 1'b1;
                           fifo_act  <=1'b1;
                           addr_cnt2 <= addr_cnt2 + 1'b1;
                           end
                  else if( addr_cnt2 >= 2  )
                           begin
                           addr_cnt2 <= addr_cnt2 + 1'b1; 
//                           tlast     <= 1'b0;
//                           fifo_ack <= 1'b0;;
                           rd_fifo_d <=1'b1;  
                           fifo_act  <=1'b1;
//                           firstline_down   <= 1'b1;
                           end
                  else         
                   begin  
                       addr_cnt2 <= addr_cnt2 + 1'b1;
                       fifo_act  <=1'b1; 
//                       firstline_down   <= 1'b1;
//                       rd_fifo  <= 1'b1;
                   end
             
               default : begin     
		             rd_ack   <= 1'b0;
		             addr_cntA1 <= 1'b0;
		             addr_cntB1 <= HoriPixNum*3 - 1;
		             addr_cnt2 <= 1'b0;
		             fifo_act <= 1'b0;
                     tlast    <= 1'b0; 
//                     firstline_down   <= 1'b0;
                     rd_fifo_d  <= 1'b0;
                   end
    endcase
end 	


always @ (posedge clk_sys or negedge rst_n ) 
begin 
		if (!rst_n) 
         begin
		  addr_cntA1_d0 <= 0;
		  addr_cntA1_d1 <= 0;
         end
		else
         begin
		  addr_cntA1_d0 <= addr_cntA1; 
		  addr_cntA1_d1 <= addr_cntA1_d0; 
         end
end
 
 
always @ (posedge clk_sys or negedge rst_n ) 
begin 
		if (!rst_n) 
         begin
		  addr_cntB1_d0 <= 0;
		  addr_cntB1_d1 <= 0;
         end
		else
         begin
		  addr_cntB1_d0 <= addr_cntB1; 
		  addr_cntB1_d1 <= addr_cntB1_d0; 
         end
end 

always @ (posedge clk_sys or negedge rst_n) 
begin 
		if (!rst_n) begin
		addrb1 <= 0;
		addrb2 <= 0;
		            end
		else        begin
		addrb1 <= addr_cntA1_d0; 
		addrb2 <= addr_cntB1_d0; 
		            end
end



//assign  addrb = addr_cnt; 

assign rd_clk = clk_sys;    

reg [7:0] din1_td0 ,din1_td1;

always @ (posedge clk_sys or negedge rst_n) 	
begin
	if (!rst_n) 
     begin
       din1_td0 <= 8'h0;
       din1_td1 <= 8'h0;
     end
	else 
     begin
       din1_td0 <= din1;
       din1_td1 <= din1_td0;
     end
end    

reg [7:0] din1b_td0 ,din1b_td1;

always @ (posedge clk_sys or negedge rst_n) 	
begin
	if (!rst_n) 
     begin
       din1b_td0 <= 8'h0;
       din1b_td1 <= 8'h0;
     end
	else 
     begin
       din1b_td0 <= din1b;
       din1b_td1 <= din1b_td0;
     end
end    

reg [7:0] din3_td0 ,din3_td1;

always @ (posedge clk_sys or negedge rst_n) 	
begin
	if (!rst_n) 
     begin
       din3_td0 <= 8'h0;
       din3_td1 <= 8'h0;
     end
	else 
     begin
       din3_td0 <= din3;
       din3_td1 <= din3_td0;
     end
end    

reg [7:0] din3b_td0 ,din3b_td1;

always @ (posedge clk_sys or negedge rst_n) 	
begin
	if (!rst_n) 
     begin
       din3b_td0 <= 8'h0;
       din3b_td1 <= 8'h0;
     end
	else 
     begin
       din3b_td0 <= din3b;
       din3b_td1 <= din3b_td0;
     end
end

    
//§Õfiforamrd_en1

//always @ (posedge clk_sys or negedge rst_n) 	
//begin
//	if (!rst_n) 
//     begin
//       wr_en_d0 <= 1'h0;
//       wr_en_d1 <= 1'h0;
//     end
//	else 
//     begin
//       wr_en_d0 <= wr_en;
//       wr_en_d1 <= wr_en_d0;
//     end
//end   



always @ (posedge clk_sys or negedge rst_n) 	
begin
	if (!rst_n) 
	begin 
      douta     <= 8'h0;
      doutb     <= 8'h0;
      cnt_circle<= 2'h0;
      cnt_fifo  <= 12'd0;
//      wr_en <= 1'b0;
	end 
	else begin
		case (CS_d3) 
			RAM_BW1  : 
			begin
			      begin
			      
			         if(cnt_circle==2)begin
			         cnt_circle<=0;
			         end  
			         else begin
			         cnt_circle<=cnt_circle+1;
			         end
			         
			         if(cnt_circle==0)begin
			         wr_en_mix<=0;
			         end
			         else 
			         wr_en_mix<=1;
			         
			         if(cnt_fifo>=1735) begin
//                     if(cnt_fifo>=2590) begin
			         cnt_fifo<=cnt_fifo;
			         rd_fifo_d_mix<=1;
			         end
			         else begin
			         cnt_fifo<=cnt_fifo+1;
			         rd_fifo_d_mix<=0;
			         end
			           		            
					   if (CS_r)
						  begin
							douta <= din1_td1;
							doutb <= din3_td1;
//							wr_en <= 1'b1;
						  end
						else
						  begin
							douta  <= din1b_td1;
							doutb  <= din3b_td1;
//							wr_en <= 1'b1;
						  end 
					end 
				end
			RAM_BW2  : 
			      begin 
			      
			      
			         if(cnt_circle==2)begin
			           cnt_circle<=0;
			         end  
			         else begin
			         cnt_circle<=cnt_circle+1;
			         end
			         
			         if(cnt_circle==0)begin
			         wr_en_mix<=0;
			         end
			         else 
			         wr_en_mix<=1;
			         
			         
			         if(cnt_fifo>=1735) begin
//			         if(cnt_fifo>=2590) begin
			         cnt_fifo<=cnt_fifo;
			         rd_fifo_d_mix<=1;
			         end
			         else begin
			         cnt_fifo<=cnt_fifo+1;
			         rd_fifo_d_mix<=0;
			         end
			         
			         
			         if(empty_mix) begin
			         cnt_fifo<=0;
			         rd_fifo_d_mix<=0;
			         end
//			         else begin
////			         cnt_fifo<=cnt_fifo;
//			         rd_fifo_d_mix<=1;
//			         end
			              
					   if (CS_r)
						  begin
							douta <= din2;
							doutb <= din4;
//							wr_en <= 1'b1;
						  end
						else
						  begin
							douta  <= din2b;
							doutb  <= din4b;
//							wr_en <= 1'b1;
						  end   	
					end
					
			FIFO_BW:  
			begin
			        if(cnt_circle==2)begin
			           cnt_circle<=0;
			         end  
			         else begin
			         cnt_circle<=cnt_circle+1;
			         end
			         
			         
			         if(empty_mix)begin
			         wr_en_mix<=0;
			         end
			         else begin
			         if(cnt_circle==0)begin
			         wr_en_mix<=0;
			         end
			         else 
			         wr_en_mix<=1;
			         end
			         
			         if(empty_mix) begin
			         cnt_fifo<=0;
			         rd_fifo_d_mix<=0;
			         end
			         else begin
			         cnt_fifo<=cnt_fifo;
			         rd_fifo_d_mix<=1;
			         end

			end
					
				
              default: 
                 begin
                            douta <= 8'h0;
                            doutb <= 8'h0;
                            wr_en_mix<=0;
                            cnt_circle<=0;
//                            rd_fifo_d_mix<=0;
                     if(empty_mix) begin
			         cnt_fifo<=0;
			         rd_fifo_d_mix<=0;
			         end
			         else begin
			         cnt_fifo<=cnt_fifo;
			         rd_fifo_d_mix<=1;
			         end
//                            wr_en <= 1'b0;
                 end
                 
                 
                 
                 
		endcase		
	end 	
end	




always @ (posedge clk_sys or negedge rst_n) 	
begin
	if (!rst_n) begin
        rden1_td <= 4'b0;
        rden3_td <= 4'b0;
        end
	else begin
        rden1_td<= {rden1_td[2:0] , rden1};
        rden3_td<= {rden3_td[2:0] , rden3};
        end
end	

always @ (posedge clk_sys or negedge rst_n) 	
begin
	if (!rst_n) begin
        rden2_td <= 4'b0;
        rden4_td <= 4'b0;
        end
	else begin
        rden2_td<= {rden2_td[2:0] , rden2_r0};
        rden4_td<= {rden4_td[2:0] , rden4_r0};
        end
end	


always @ (posedge clk_sys or negedge rst_n) 	
begin
	if (!rst_n) begin
        rden1b_td <= 4'b0;
        rden3b_td <= 4'b0;
        rd_fifo_td<= 4'b0;
        end
	else begin
        rden1b_td<= {rden1b_td[2:0] , rden1b};
        rden3b_td<= {rden3b_td[2:0] , rden3b};
        rd_fifo_td<= {rd_fifo_td[2:0] , rd_fifo};
        end
end	

always @ (posedge clk_sys or negedge rst_n) 	
begin
	if (!rst_n) begin
        rden2b_td <= 4'b0;
        rden4b_td <= 4'b0;
        end
	else begin
        rden2b_td<= {rden2b_td[2:0] , rden2b_r0};
        rden4b_td<= {rden4b_td[2:0] , rden4b_r0};
        end
end	



always @ (posedge clk_sys or negedge rst_n) 	
begin
	if (!rst_n) 
        tlast_td <= 4'b0;
	else 
        tlast_td <= {tlast_td[2:0] , tlast};
end	

always @ (posedge clk_sys or negedge rst_n) 	
begin
	if (!rst_n) 
        rd_fifo_d1 <= 1'b0;
	else 
        rd_fifo_d1 <= rd_fifo_d;
end	

//assign tl_last =  tlast_td[3];
assign tl_last =  dpi200  ? tlast_dpi :  tlast_td;



endmodule 
