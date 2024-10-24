

`timescale 1ns / 1ps

module ep_cfg_rom ( doa, addra, clka );

	output [67:0] doa;

	input  [6:0] addra;
	input  clka;



	PH1_LOGIC_ERAM #( .DATA_WIDTH_A(68),
				.ADDR_WIDTH_A(7),
				.DATA_DEPTH_A(128),
				.DATA_WIDTH_B(68),
				.ADDR_WIDTH_B(7),
				.DATA_DEPTH_B(128),
				.MODE("SP"),
				.REGMODE_A("NOREG"),
				.IMPLEMENT("20K"),
				.DEBUGGABLE("NO"),
				.PACKABLE("NO"),
				.INIT_FILE("pcie_ep_core.dat"),
				.FILL_ALL("NONE"))
			inst(
				.dia({68{1'b0}}),
				.dib({68{1'b0}}),
				.addra(addra),
				.addrb({7{1'b0}}),
				.cea(1'b1),
				.ceb(1'b0),
				.ocea(1'b0),
				.oceb(1'b0),
				.clka(clka),
				.clkb(1'b0),
				.wea(1'b0),
				.web(1'b0),
				.bea(1'b0),
				.beb(1'b0),
				.rsta(1'b0),
				.rstb(1'b0),
				.doa(doa),
				.dob());


endmodule