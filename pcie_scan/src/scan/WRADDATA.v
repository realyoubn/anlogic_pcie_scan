module WRADDATA
(
input  clk,
input  rst_n,
input  CSEN,


input  SI,       //the signal is coming from the module:signal . its' frequency is defined by the paramerter:sp_time[15£º0]£¬which is set by the PS 
input  [12:0] HoriPixNum,
input  [15:0] st_sp,
input  [7:0] din1,din2,
input  [7:0] din3,din4,
 
output reg [14:0] addra1,     //HIGH BYTE of ADC data
output reg [14:0] addra2,     //LOW  BYTE of ADC data
output reg enr,enrb,
output wr_clk,
output reg [7:0] dout1,dout2,
output reg [7:0] dout3,dout4
);
////////////////////////////////////////////////

parameter   IDLE           = 4'd0,
		    CHECK_BW 	   = 4'd1,
		    DELAY_BW 	   = 4'd2,
		    WRDATA_BW 	   = 4'd3;
reg[12:0] HoriPixNum_d0,HoriPixNum_d1;
reg[3:0] CS,NS;	
reg delay_f;
reg wr_ack;	
reg [15:0] CNT;	
reg[14:0] addr1, addr2,addra_r;
reg CS_N;
reg enr_r;
reg CS_r;
reg [7:0] dout1_r,dout2_r;
reg [7:0] dout3_r,dout4_r;
reg[15:0] st_sp_d0, st_sp_d1, st_sp_d2;

always @ (posedge clk or negedge rst_n) 
begin 
	if (!rst_n) 
	begin
    HoriPixNum_d0<=0;
    HoriPixNum_d1<=0;
	end 	
	else 
	begin
       HoriPixNum_d0<=HoriPixNum;
       HoriPixNum_d1<=HoriPixNum_d0;
	end 	
end


always @ (posedge clk or negedge rst_n) 
begin 
	if (!rst_n) 
	begin
       st_sp_d0 <= 16'd0;
       st_sp_d1 <= 16'd0;
       st_sp_d2 <= 16'd0;
	end 	
	else 
	begin
      st_sp_d0 <= st_sp;
      st_sp_d1 <= st_sp_d0;
      if ( st_sp_d1 == st_sp_d0)
      st_sp_d2 <= st_sp_d1;
	end 	
end

always @ (posedge clk or negedge rst_n) 
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

always @ (*)
begin
	case (CS) 
		IDLE 		 : NS = CHECK_BW;
		CHECK_BW  : NS = (SI == 1) ? DELAY_BW : CHECK_BW;
		DELAY_BW  : NS = (delay_f == 1) ? WRDATA_BW : DELAY_BW;
		WRDATA_BW : NS = (wr_ack == 1) ? IDLE : WRDATA_BW;
		default   : NS = IDLE;
	endcase	
end

//always @ (posedge clk or negedge rst_n )
always @ (posedge clk  ) 
begin 
	if (!rst_n) 
		begin 
			wr_ack   <= 1'b0;
			delay_f <= 1'b0;
			CNT <= 16'd0;
			addr2 <= (HoriPixNum_d1 * 3 - 1);//1295
            addr1 <= (HoriPixNum_d1 - 1);
			enr_r <= 1'b0; 
		end 	
	else 
		begin 	
			case (CS) 
				IDLE : begin 
							wr_ack   <= 1'b0;
							delay_f <= 1'b0;
							CNT <= 16'd0;
							addr2 <= (HoriPixNum_d1 * 3 - 1);//1295
                            addr1 <= (HoriPixNum_d1 - 1);
							enr_r <= 1'b0; 
						end
						
				CHECK_BW : begin
				         addr2 <= (HoriPixNum_d1 * 3 - 1);//1295
                         addr1 <= (HoriPixNum_d1 - 1);		
                         end
				DELAY_BW : begin 

//							if (CNT == 251)//251,254,257
							if (CNT == st_sp_d2)//251,254,257
							   begin
								   delay_f <= 1'b1;
//								   enr_r <= 1'b0;
                                   enr_r <= 1'b0;//20230905
							   end 	
							else 
								CNT <= CNT + 16'd1;	
						   end 
				WRDATA_BW : begin
				////////////addr2///////////////this code to realize the mirror image for whole CIS//////////////////
									delay_f <= 1'b0;
									////////addr2////////
//								if (addr2 == 0 & addr1==2*HoriPixNum_d1)//0
                                if (addr2 == 0 & addr1==2*HoriPixNum_d1)		
							       begin
							       enr_r <= 1'b0;
								   wr_ack <= 1'b1;
							       end
								else if (addr2 == HoriPixNum_d1 & addr1==HoriPixNum_d1)
									begin
										enr_r <= 1'b1;
										wr_ack <= 1'b0;
										addr2 <= 0;
										addr1 <= 2*HoriPixNum_d1 ;
									end 
								else if(  (   addr2 == (HoriPixNum_d1 * 3 - 1) ) & (enr_r == 1'b0)  &  (addr1 == (HoriPixNum_d1  - 1))  )//1295
										enr_r <= 1'b1; 		
								else
									begin 
										if (  (addr2 < HoriPixNum_d1) & (addr1 > 2*HoriPixNum_d1) ) begin //432
											addr2 <= addr2 + (HoriPixNum_d1 * 2 - 1);//863
											addr1 <= addr1 - (HoriPixNum_d1 * 2 + 1 );//865
										end
										else begin
											addr2 <= addr2 - HoriPixNum_d1;//432
											addr1 <= addr1 + HoriPixNum_d1;
									    end
									end
												

                       ///////////
                       ///////////this code to realize the mirror image for each CHANNEL///////////////////
//                                      delay_f <= 1'b0;
//								if (addr == 864)//0
//									begin
//										enr_r <= 1'b0;
//										wr_ack <= 1'b1;
//									end
//								else if((addr == (HoriPixNum  - 1)) & (enr_r == 1'b0))//431
//										enr_r <= 1'b1; 		
//								else
//									begin 
//										if (addr > 2*HoriPixNum )//864
//											addr <= addr - (HoriPixNum * 2 + 1 );//865
//										else
//											addr <= addr + HoriPixNum;//432
//									end
					
							end
							         
				endcase				
		end 
end



always @ (posedge wr_clk or negedge rst_n)
begin
 if (~rst_n)
   begin
    dout1_r <= 8'b0;
    dout2_r <= 8'b0;
    dout3_r <= 8'b0;
    dout4_r <= 8'b0;
   end

 else
   begin
    dout1_r <= din1; 		
    dout2_r <= din2;
    dout3_r <= din3; 		
    dout4_r <= din4;
   end
//  dout1_r <= 40; 		
//  dout2_r <= 80; 	
end   
always @ (posedge clk or negedge rst_n) begin
if (!rst_n)
begin 
    addra1 <= 0;
    addra2 <= 0;
	dout1 <= 0;
	dout2 <= 0;
	dout3 <= 0;
	dout4 <= 0;
end
else
begin
    addra1 <= addr1;
    addra2 <= addr2;
	dout1 <= dout1_r;
	dout2 <= dout2_r;
	dout3 <= dout3_r;
	dout4 <= dout4_r;
end 
end
assign wr_clk = clk; 	
always @ (posedge clk or negedge rst_n)
if (!rst_n)
begin
   enr <= 0;
	enrb <= 0;
end
else
begin
	  if (CS_r == 0)
	   begin
	     enr <= enr_r;
		  enrb <= 0;
		end
	  else
	   begin
		  enr <= 0;
	     enrb <= enr_r;
		end	
end
endmodule						
