module lvds_tx
#(
    parameter PROTOCOL = "VESA", // 协议：JEIDA、VESA
    parameter DEVICE = "PH1" ,// "AL3"  "EF1"  "EF2"  "EF3"  "EG4"  "PH1"
    parameter CLOCKINV = 0,      // 时钟极性反转
	parameter DATA0INV = 0,      // 数据0极性反转
	parameter DATA1INV = 0,      // 数据1极性反转
	parameter DATA2INV = 0,      // 数据2极性反转
	parameter DATA3INV = 0,      // 数据3极性反转
	parameter DATA4INV = 0       // 数据4极性反转 
)
(
    // lvds
    output  wire        lvds_clk,
    output  wire [3:0]  lvds_data,
	
    
    // pll
    input   wire        sclk, // sclk = pclk * 3.5
    input   wire        pclk, // sclk = lvds_clk
    input   wire        rst,
    input   wire        re,
    
    // video
    input   wire        vs,
    input   wire        hs,
    input   wire        de,
    input   wire [23:0] rgb
//	input   wire [29:0] rgb
);

localparam na = 0;

reg ren;
reg spen;
reg lvds_clk0;
reg lvds_clk1;
reg [2:0] wcnt;
reg [2:0] rcnt;
wire [7:0] r,g,b;
wire [27:0]	para0;
wire [27:0]	para1;
reg [27:0] para2;
reg [27:0] para3;

//wire [9:0] r,g,b;
//wire [34:0]	para0;
//wire [34:0]	para1;
//reg [34:0] para2;
//reg [34:0] para3;

reg [27:0] ram [0:7];
//reg [34:0] ram [0:7];
reg [6:0] lvds_clk_sft;
reg [6:0] lvds_syn_sft;
reg [13:0] serial_sft0;
reg [13:0] serial_sft1;
reg [13:0] serial_sft2;
reg [13:0] serial_sft3;
reg [13:0] serial_sft4;
reg [13:0] serial_sft5;
reg lvds_data0_0;
reg lvds_data0_1;
reg lvds_data1_0;
reg lvds_data1_1;
reg lvds_data2_0;
reg lvds_data2_1;
reg lvds_data3_0;
reg lvds_data3_1;
reg lvds_data4_0;
reg lvds_data4_1;
reg lvds_data5_0;
reg lvds_data5_1;

assign {r,g,b} = rgb;

// 协议处理
generate
     //VESA协议处理
    if(PROTOCOL == "VESA")
    begin
        assign para0[6:0] = {g[0],r[5:0]};
        assign para0[13:7] = {b[1:0],g[5:1]};
        assign para0[20:14] = {de,vs,hs,b[5:2]};
        assign para0[27:21] = {na,b[7:6],g[7:6],r[7:6]};
    end




//	if(PROTOCOL == "CameraLink")
//    begin
//assign para0[6:0] = {r[8],r[9],g[8],g[9],b[8],b[9],re};
//        assign para0[13:7] = {r[6],r[7],g[6],g[7],b[6],b[7],re};
//        assign para0[20:14] = {b[2],b[3],b[4],b[5],hs,vs,de};
//        assign para0[27:21] = {g[1],g[2],g[3],g[4],g[5],b[0],b[1]};
//        assign para0[34:28] = {r[0],r[1],r[2],r[3],r[4],r[5],g[0]};
//    end
    
    // JEIDA协议处理
    else if(PROTOCOL == "JEIDA")
    begin
        assign para0[6:0] = {g[2],r[7:2]};
        assign para0[13:7] = {b[3:2],g[7:3]};
        assign para0[20:14] = {de,vs,hs,b[7:4]};
        assign para0[27:21] = {na,b[1:0],g[1:0],r[1:0]};
    end
endgenerate

// 写数据地址错开
always@(posedge pclk, posedge rst)
begin
	if(rst)
		wcnt <= 0;
	else
		wcnt <= wcnt + 1;
end

// 数据写入
always@(posedge pclk)
begin
    ram[wcnt] <= para0;
end

// 读数据地址错开
always@(posedge sclk,posedge rst)
begin
	if(rst)
		rcnt <= 4;
	else if(ren)
		rcnt <= rcnt + 1;
end

// 数据输出
assign para1 = ram[rcnt];

// lvds时钟生成
always@(posedge sclk, posedge rst)
begin
	if(rst)
		lvds_clk_sft <= 7'b1100011;
	else
		lvds_clk_sft <= {lvds_clk_sft[4:0],lvds_clk_sft[6:5]};
end

// lvds时钟同步寄存器
always@(posedge sclk, posedge rst)
begin
	if(rst)
		lvds_syn_sft <= 7'b0000001;
	else
		lvds_syn_sft <= {lvds_syn_sft[5:0],lvds_syn_sft[6]};
end

// lvds时钟相位控制
always@(posedge sclk)
begin
	lvds_clk0 <= lvds_clk_sft[6];
	lvds_clk1 <= lvds_clk_sft[5];
end

// 串行时钟数据访问
always@(posedge sclk)
begin
	ren <= |lvds_syn_sft[3:2];
	spen <= lvds_syn_sft[5];
end

// lvds时钟输出
oddr
#(
    .DEVICE (DEVICE     )
)
u_oddr
(
	.clk	(sclk		),
	.rst	(1'b0		),
	.d0		(lvds_clk0	),
	.d1		(lvds_clk1	),
	.q		(lvds_clk	)
);

// 数据延时拼接
always@(posedge sclk)
begin
	para2 <= para1;
	para3 <= para2;
end

// 数据并串转换
always@(posedge sclk)
begin
	if(spen)
	begin
		serial_sft0 <= {para3[6:0],para2[6:0]};
	    serial_sft1 <= {para3[13:7],para2[13:7]};
	    serial_sft2 <= {para3[20:14],para2[20:14]};
	    serial_sft3 <= {para3[27:21],para2[27:21]};
//        serial_sft4 <= {para3[34:28],para2[34:28]};
	end
	else
	begin
		serial_sft0 <= (serial_sft0 << 2);
		serial_sft1 <= (serial_sft1 << 2);
		serial_sft2 <= (serial_sft2 << 2);
		serial_sft3 <= (serial_sft3 << 2);
//        serial_sft4 <= (serial_sft4 << 2);
	end
end

// 提取双边沿发送数据
always@(posedge sclk)
begin
	lvds_data0_0 <= serial_sft0[13];
	lvds_data0_1 <= serial_sft0[12];
	lvds_data1_0 <= serial_sft1[13];
	lvds_data1_1 <= serial_sft1[12];
	lvds_data2_0 <= serial_sft2[13];
	lvds_data2_1 <= serial_sft2[12];
	lvds_data3_0 <= serial_sft3[13];
	lvds_data3_1 <= serial_sft3[12];
  lvds_data4_0 <= serial_sft4[13];
	lvds_data4_1 <= serial_sft4[12];
end

// 双边沿数据输出
oddr
#(
    .DEVICE (DEVICE             )
)
u0_oddr
(
	.clk	(sclk				),
	.rst	(1'b0				),
	.d0		(lvds_data0_0		),
	.d1		(lvds_data0_1		),
	.q		(lvds_data[0]		)
);

// 双边沿数据输出
oddr
#(
    .DEVICE (DEVICE             )
)
u1_oddr
(
	.clk	(sclk				),
	.rst	(1'b0				),
	.d0		(lvds_data1_0		),
	.d1		(lvds_data1_1		),
	.q		(lvds_data[1]		)
);

// 双边沿数据输出
oddr
#(
    .DEVICE (DEVICE             )
)
u2_oddr
(
	.clk	(sclk				),
	.rst	(1'b0				),
	.d0		(lvds_data2_0		),
	.d1		(lvds_data2_1		),
	.q		(lvds_data[2]		)
);

// 双边沿数据输出
oddr
#(
    .DEVICE (DEVICE             )
)
u3_oddr
(
	.clk	(sclk				),
	.rst	(1'b0				),
	.d0		(lvds_data3_0		),
	.d1		(lvds_data3_1		),
	.q		(lvds_data[3]		)
);

// 双边沿数据输出
//oddr
//#(
//    .DEVICE (DEVICE             )
//)
//u4_oddr
//(
//	.clk	(sclk				),
//	.rst	(1'b0				),
//	.d0		(lvds_data4_0		),
//	.d1		(lvds_data4_1		),
//	.q		(lvds_data[4]		)
//);
endmodule

module oddr
#(
    parameter DEVICE = "EG4" // "AL3"  "EF1"  "EF2"  "EF3"  "EG4"  "PH1"
)
(
    input   wire        clk,
    input   wire        rst,
    input   wire        d0,
    input   wire        d1,
    output  wire        q
);

generate
    if(DEVICE == "AL3")
        AL_LOGIC_ODDR u_oddr
        (
            .clk	(clk        ),
            .rst	(rst        ),
            .d1		(d0	        ),
            .d2		(d1	        ),
            .q		(q	        )
        );
    else if(DEVICE == "EF1")
        ELF_LOGIC_ODDR u_oddr
        (
            .clk	(clk        ),
            .rst	(rst        ),
            .d1		(d0	        ),
            .d2		(d1	        ),
            .q		(q	        )
        );
    else if(DEVICE == "EF2")
        EF2_LOGIC_ODDR u_oddr
        (
            .clk	(clk        ),
            .rst	(rst        ),
            .d0		(d0	        ),
            .d1		(d1	        ),
            .q		(q	        )
        );
    else if(DEVICE == "EF3")
        EF3_LOGIC_ODDR u_oddr
        (
            .clk	(clk        ),
            .rst	(rst        ),
            .d0		(d0	        ),
            .d1		(d1	        ),
            .q		(q	        )
        );
    else if(DEVICE == "EG4")
        EG_LOGIC_ODDR u_oddr
        (
            .clk	(clk        ),
            .rst	(rst        ),
            .d0		(d0	        ),
            .d1		(d1	        ),
            .q		(q	        )
        );
    else if(DEVICE == "PH1")
        PH1_LOGIC_ODDR u_oddr
        (
            .clk	(clk        ),
            .rst	(rst        ),
            .d0		(d0	        ),
            .d1		(d1	        ),
            .q		(q	        )
        );
endgenerate

endmodule
