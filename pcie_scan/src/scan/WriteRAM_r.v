module WriteRAM_r 
(
input clk,
input rst_n,
input CSEN,
input wr_trigger,
input [12:0] HoriPixNum,
input [15:0] st_sp,
output reg [13:0] addra
);
////////////////////////////////////////////////
parameter   IDLE           = 4'd0,
		    CHECK_BW 	   = 4'd1,
		    DELAY_BW 	   = 4'd2,
		    WRDATA_BW 	   = 4'd3;

reg [3:0] CS,NS;
reg delay_f;
reg wr_ack;	
reg [15:0] CNT;	
reg [13:0] addr;
reg enr_r;
reg enr,enrb;
reg CS_r;







reg[15:0] st_sp_d0, st_sp_d1, st_sp_d2;


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
		CS   <= IDLE;
		CS_r <= 1'b0;
	end 	
	else 
	begin
		CS   <= NS;
		CS_r <= CSEN;
	end 	
end 

always @ (*)
begin
	case (CS) 
		IDLE      : NS = CHECK_BW;
		CHECK_BW  : NS = (wr_trigger == 1) ? DELAY_BW : CHECK_BW;
		DELAY_BW  : NS = (delay_f == 1) ? WRDATA_BW : DELAY_BW;
		WRDATA_BW : NS = (wr_ack == 1) ? IDLE : WRDATA_BW;
		default   : NS = IDLE;
	endcase	
end

always @ (posedge clk or negedge rst_n ) 
begin 
	if(!rst_n) 
		begin 
			wr_ack   <= 1'b0;
			delay_f <= 1'b0;
			CNT <= 16'd0;
			addr <= (HoriPixNum * 3 - 1);//1295
			enr_r <= 1'b0; 
		end 	
	else 
		begin 	
			case (CS) 
				IDLE : begin 
							wr_ack   <= 1'b0;
							delay_f <= 1'b0;
							CNT <= 16'd0;
							addr <= (HoriPixNum * 3 - 1);//1295
							enr_r <= 1'b0; 
						end
				DELAY_BW : begin 
							//if (CNT == 257)//251,254,257
 `ifdef HUAGAO_SIM_CIS
							if (CNT == 258)//251,254,257
 `else 
							//if (CNT == 201)//251,254,257
							if (CNT == st_sp_d2)//251,254,257
 `endif
							   begin
								   delay_f <= 1'b1;
								   enr_r <= 1'b0;
							   end
							else
								CNT <= CNT + 16'd1;
						   end 
				WRDATA_BW : begin
									delay_f <= 1'b0;
								if (addr == 0)//0
									begin
										enr_r <= 1'b0;
										wr_ack <= 1'b1;
									end
								else if((addr == (HoriPixNum * 3 - 1)) & (enr_r == 1'b0))//1295
										enr_r <= 1'b1; 		
								else
									begin 
										if (addr < HoriPixNum)//432
											addr <= addr + (HoriPixNum * 2 - 1);//863
										else
											addr <= addr - HoriPixNum;//432
									end
							end
				endcase
		end
end

always @ (posedge clk or negedge rst_n) begin
if (!rst_n)
   addra <= 0;
else
   addra <= addr;
end 

	
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
