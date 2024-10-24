module op (
          clk24m,
			 rst_n,
			 SI,
			 csen
			 );
input clk24m;
input SI;
input rst_n;
output csen;

reg SI_r,SI_r1;
wire SI_pos;
reg  CS_N;

assign csen = CS_N;
always @ (posedge clk24m or negedge rst_n) 
begin
	if (!rst_n) 
	begin
		SI_r <= 0;
		SI_r1 <= 0;
	end
	else begin 
		SI_r <= SI;
		SI_r1 <= SI_r;
	end 	
end
assign SI_pos = (SI_r)&(!SI_r1);
always @(posedge clk24m or negedge rst_n) begin
if (!rst_n) 
	CS_N <= 1'b0;
else if (SI_pos == 1)
	begin
		CS_N <= !CS_N;
	end 	
end  
endmodule	