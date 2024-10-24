module xiaodou (
          clk_cis,
			 rst_n,
			 switch,
			 switch_out
			 );
input clk_cis;
input rst_n;
input switch;
output  reg switch_out;

reg [31:0]cnt_switch;


always @ (posedge clk_cis or negedge rst_n) 
if (!rst_n) 
		cnt_switch <= 0;
	else if(switch & (cnt_switch <= 200000))
		cnt_switch <= cnt_switch + 1;
	else if (switch == 0)
      cnt_switch <= 0;
		
always @(posedge clk_cis or negedge rst_n)
if(!rst_n)
switch_out <= 0;
else if ((cnt_switch >= 199960) &(cnt_switch <= 199999))
switch_out <= 1;
else 
switch_out <= 0;		

endmodule	