module AD_Clock
(
input VSMP,MCLK,RSMP,

output VSMP1,MCLK1,RSMP1,
output VSMP2,MCLK2,RSMP2,
input  [31:0] vsp_config
);


reg[31:0] vsp_config_d0,vsp_config_d1;
wire[31:0] vsp_config_in;

assign RSMP1 = RSMP;
assign MCLK1 = MCLK;

assign RSMP2 = RSMP;
assign MCLK2 = MCLK;

always@(posedge VSMP)begin
vsp_config_d0<=vsp_config;
vsp_config_d1<=vsp_config_d0;
end


assign vsp_config_in=vsp_config_d1;

delay_chain u0_delay_chain (
    .out(VSMP1  ),
    .in (VSMP),
    .delay_line_rx(vsp_config_in[7:0])
);

delay_chain u1_delay_chain (
    .out(VSMP2  ),
    .in (VSMP),
    .delay_line_rx(vsp_config_in[15:8])
);

//delay_chain u2_delay_chain (
//    .out(VSMP3  ),
//    .in (VSMP),
//    .delay_line_rx(vsp_config[23:16])
//);
//
//delay_chain u3_delay_chain (
//    .out(VSMP4  ),
//    .in (VSMP),
//    .delay_line_rx(vsp_config[31:24])
//);







endmodule 
