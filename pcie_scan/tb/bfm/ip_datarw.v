`timescale 1ns/1ps
`include "dt_para.vh"
`include "tlp_fmt_type.vh"
module ip_datarw(

	input    wire   [32*`CFG_NUM-1:0]        cfg_idt,
	input    wire   [`DT_WD*`IDT_NUM-1:0]    c2h_fm_idt,//Feature map
	input    wire   [`DT_WD*`IDT_NUM-1:0]    h2c_fm_idt,//Feature map
	input    wire   [32*`PMODE_NUM-1:0]      c2h_pmode_idt,
	input    wire   [32*`PMODE_NUM-1:0]      h2c_pmode_idt,
	input    wire   [32*`INT_NUM-1:0]        int_idt,
	input    wire   casen_test_done,

	output   wire   [32*`CFG_NUM-1:0]        cfg_oaddr,
	output   wire   [32*`CFG_NUM-1:0]        cfg_odt,
	output   wire   [`DT_WD*`ODT_NUM-1:0]    c2h_fm_odt,
	output   wire   [`DT_WD*`ODT_NUM-1:0]    h2c_fm_odt,
	output   wire   [`DT_WD*`WDSCP_NUM-1:0]  wdscp_odt,
	output   wire   [`DT_WD*`RDSCP_NUM-1:0]  rdscp_odt
);
reg   [31:0]       cfg_oaddr_x[`CFG_NUM-1:0];
reg   [31:0]       cfg_odt_x[`CFG_NUM-1:0];
wire  [31:0]       cfg_idt_x[`CFG_NUM-1:0];	
reg   [`DT_WD-1:0] c2h_fm_odt_x[`ODT_NUM-1:0];
reg   [`DT_WD-1:0] h2c_fm_odt_x[`ODT_NUM-1:0];
wire  [`DT_WD-1:0] c2h_fm_idt_x[`IDT_NUM-1:0];
wire  [`DT_WD-1:0] h2c_fm_idt_x[`IDT_NUM-1:0];
reg   [`DT_WD-1:0] wdscp_odt_x[`WDSCP_NUM-1:0];
reg   [`DT_WD-1:0] rdscp_odt_x[`RDSCP_NUM-1:0];
wire  [31:0]       c2h_pmode_idt_x[`PMODE_NUM-1:0];
wire  [31:0]       h2c_pmode_idt_x[`PMODE_NUM-1:0];
wire  [31:0]       int_idt_x[`INT_NUM-1:0];
initial
begin
	`ifdef CASE0
		$readmemh("../data/case0/case_cfg_oaddr.dat",cfg_oaddr_x);
		$readmemh("../data/case0/case_cfg_odt.dat",cfg_odt_x);
	//---C2H channel;
	`elsif CASE1
		$readmemh("../data/case1/case_cfg_oaddr.dat",cfg_oaddr_x);
		$readmemh("../data/case1/case_cfg_odt.dat",cfg_odt_x);
		$readmemh("../data/case1/case_c2h_fm_odt.dat",c2h_fm_odt_x);
		$readmemh("../data/case1/case_wdscp_odt.dat",wdscp_odt_x);

	`elsif CASE2
		$readmemh("../data/case2/case_cfg_oaddr.dat",cfg_oaddr_x);
		$readmemh("../data/case2/case_cfg_odt.dat",cfg_odt_x);
		$readmemh("../data/case2/case_c2h_fm_odt.dat",c2h_fm_odt_x);
		$readmemh("../data/case2/case_wdscp_odt.dat",wdscp_odt_x);

	`elsif CASE3
		$readmemh("../data/case3/case_cfg_oaddr.dat",cfg_oaddr_x);
		$readmemh("../data/case3/case_cfg_odt.dat",cfg_odt_x);
		$readmemh("../data/case3/case_c2h_fm_odt.dat",c2h_fm_odt_x);
		$readmemh("../data/case3/case_wdscp_odt.dat",wdscp_odt_x);

	`elsif CASE4
		$readmemh("../data/case4/case_cfg_oaddr.dat",cfg_oaddr_x);
		$readmemh("../data/case4/case_cfg_odt.dat",cfg_odt_x);
		$readmemh("../data/case4/case_c2h_fm_odt.dat",c2h_fm_odt_x);
		$readmemh("../data/case4/case_wdscp_odt.dat",wdscp_odt_x);

	`elsif CASE5
		$readmemh("../data/case5/case_cfg_oaddr.dat",cfg_oaddr_x);
		$readmemh("../data/case5/case_cfg_odt.dat",cfg_odt_x);
		$readmemh("../data/case5/case_c2h_fm_odt.dat",c2h_fm_odt_x);
		$readmemh("../data/case5/case_wdscp_odt.dat",wdscp_odt_x);
		
	`elsif CASE6
		$readmemh("../data/case6/case_cfg_oaddr.dat",cfg_oaddr_x);
		$readmemh("../data/case6/case_cfg_odt.dat",cfg_odt_x);
		$readmemh("../data/case6/case_c2h_fm_odt.dat",c2h_fm_odt_x);
		$readmemh("../data/case6/case_wdscp_odt.dat",wdscp_odt_x);

	`elsif CASE7
		$readmemh("../data/case7/case_cfg_oaddr.dat",cfg_oaddr_x);
		$readmemh("../data/case7/case_cfg_odt.dat",cfg_odt_x);
		$readmemh("../data/case7/case_c2h_fm_odt.dat",c2h_fm_odt_x);
		$readmemh("../data/case7/case_wdscp_odt.dat",wdscp_odt_x);

	`elsif CASE9
		$readmemh("../data/case9/case_cfg_oaddr.dat",cfg_oaddr_x);
		$readmemh("../data/case9/case_cfg_odt.dat",cfg_odt_x);
		$readmemh("../data/case9/case_c2h_fm_odt.dat",c2h_fm_odt_x);
		$readmemh("../data/case9/case_wdscp_odt.dat",wdscp_odt_x);

	`elsif CASE11
		$readmemh("../data/case11/case_cfg_oaddr.dat",cfg_oaddr_x);
		$readmemh("../data/case11/case_cfg_odt.dat",cfg_odt_x);
		$readmemh("../data/case11/case_c2h_fm_odt.dat",c2h_fm_odt_x);
		$readmemh("../data/case11/case_wdscp_odt.dat",wdscp_odt_x);

	`elsif CASE12
		$readmemh("../data/case12/case_cfg_oaddr.dat",cfg_oaddr_x);
		$readmemh("../data/case12/case_cfg_odt.dat",cfg_odt_x);

	`elsif CASE13
		$readmemh("../data/case13/case_cfg_oaddr.dat",cfg_oaddr_x);
		$readmemh("../data/case13/case_cfg_odt.dat",cfg_odt_x);
		$readmemh("../data/case13/case_c2h_fm_odt.dat",c2h_fm_odt_x);
		$readmemh("../data/case13/case_wdscp_odt.dat",wdscp_odt_x);

    `elsif CASE18
		$readmemh("../data/case18/case_cfg_oaddr.dat",cfg_oaddr_x);
		$readmemh("../data/case18/case_cfg_odt.dat",cfg_odt_x);
		$readmemh("../data/case18/case_h2c_fm_odt.dat",h2c_fm_odt_x);
		$readmemh("../data/case18/case_rdscp_odt.dat",rdscp_odt_x);

    `elsif CASE19
		$readmemh("../data/case19/case_cfg_oaddr.dat",cfg_oaddr_x);
		$readmemh("../data/case19/case_cfg_odt.dat",cfg_odt_x);
		$readmemh("../data/case19/case_h2c_fm_odt.dat",h2c_fm_odt_x);
		$readmemh("../data/case19/case_rdscp_odt.dat",rdscp_odt_x);

    `elsif CASE41
		$readmemh("../data/case41/case_cfg_oaddr.dat",cfg_oaddr_x);
		$readmemh("../data/case41/case_cfg_odt.dat",cfg_odt_x);
		$readmemh("../data/case41/case_h2c_fm_odt.dat",h2c_fm_odt_x);	
		$readmemh("../data/case41/case_rdscp_odt.dat",rdscp_odt_x);
        $readmemh("../data/case41/case_wdscp_odt.dat",wdscp_odt_x);

	`else //---Do not appear;
		$display("The CASE_NUM is error!");
	`endif
	
end


generate 
	genvar ncfg;
	genvar c2h_nodt;
	genvar h2c_nodt;
	genvar c2h_nidt;
	genvar h2c_nidt;
	genvar nwdscp;
//	genvar naxi4s;
	genvar c2h_npmode;
	genvar h2c_npmode;
	genvar nint;
	genvar nrdscp;
	for(ncfg=0;ncfg<`CFG_NUM;ncfg=ncfg+1) 
	begin:CFG_PACK
		assign cfg_oaddr[ncfg*32+31:ncfg*32] = cfg_oaddr_x[ncfg];
		assign cfg_odt[ncfg*32+31:ncfg*32] = cfg_odt_x[ncfg];
		assign cfg_idt_x[ncfg] = cfg_idt[ncfg*32+31:ncfg*32];
	end

	for(c2h_nodt=0;c2h_nodt<`ODT_NUM;c2h_nodt=c2h_nodt+1) 
	begin:C2H_ODT_PACK
		assign c2h_fm_odt[c2h_nodt*`DT_WD+127:c2h_nodt*`DT_WD] = c2h_fm_odt_x[c2h_nodt];
	end
	for(h2c_nodt=0;h2c_nodt<`ODT_NUM;h2c_nodt=h2c_nodt+1) 
	begin:H2C_ODT_PACK
		assign h2c_fm_odt[h2c_nodt*`DT_WD+127:h2c_nodt*`DT_WD] = h2c_fm_odt_x[h2c_nodt];
	end

	for(c2h_nidt=0;c2h_nidt<`IDT_NUM;c2h_nidt=c2h_nidt+1) 
	begin:C2H_IDT_UNPACK
		assign c2h_fm_idt_x[c2h_nidt] = c2h_fm_idt[c2h_nidt*`DT_WD+`DT_WD-1:c2h_nidt*`DT_WD];
	end
	for(h2c_nidt=0;h2c_nidt<`IDT_NUM;h2c_nidt=h2c_nidt+1) 
	begin:H2C_IDT_UNPACK
		assign h2c_fm_idt_x[h2c_nidt] = h2c_fm_idt[h2c_nidt*`DT_WD+`DT_WD-1:h2c_nidt*`DT_WD];
	end

	for(nwdscp=0;nwdscp<`WDSCP_NUM;nwdscp=nwdscp+1) 
	begin:WDSCP_PACK
		assign wdscp_odt[nwdscp*`DT_WD+`DT_WD-1:nwdscp*`DT_WD] = wdscp_odt_x[nwdscp];
	end
	for(nrdscp=0;nrdscp<`RDSCP_NUM;nrdscp=nrdscp+1) 
	begin:RDSCP_PACK
		assign rdscp_odt[nrdscp*`DT_WD+`DT_WD-1:nrdscp*`DT_WD] = rdscp_odt_x[nrdscp];
	

	end
/*	for(naxi4s=0;naxi4s<`AXI4S_NUM;naxi4s=naxi4s+1) 
	begin:AXI4S_PACK
		assign axi4s_idt_x[naxi4s] = axi4s_idt[naxi4s*`DT_WD+63:naxi4s*`DT_WD];
	end*/
	for(c2h_npmode=0;c2h_npmode<`PMODE_NUM;c2h_npmode=c2h_npmode+1) 
	begin:C2H_PMODE_UNPACK
		assign c2h_pmode_idt_x[c2h_npmode] = c2h_pmode_idt[c2h_npmode*32+31:c2h_npmode*32];
	end
	for(h2c_npmode=0;h2c_npmode<`PMODE_NUM;h2c_npmode=h2c_npmode+1) 
	begin:H2C_PMODE_UNPACK
		assign h2c_pmode_idt_x[h2c_npmode] = h2c_pmode_idt[h2c_npmode*32+31:h2c_npmode*32];
	end
	for(nint=0;nint<`INT_NUM;nint=nint+1) 
	begin:INT_UNPACK
		assign int_idt_x[nint] = int_idt[nint*32+31:nint*32];
	end
endgenerate
integer   case_cfg_file;
integer   case_c2h_ofm_file;
integer   case_h2c_ofm_file;
integer   case_c2h_pmodewb_file;
integer   case_h2c_pmodewb_file;
//integer   case_axi4swb_file;
integer   case_int_file;
integer   i,j,m,n;

initial 
begin
	`ifdef CASE0 //---Read and write user registers;
		case_cfg_file = $fopen("../data/case0/case_cfg_sim.txt","w");
	`elsif CASE1
		case_c2h_pmodewb_file = $fopen("../data/case1/case_c2h_pmodewb_sim.txt","w");
		
	`elsif CASE2
		case_c2h_ofm_file = $fopen("../data/case2/case_c2h_ofm_sim.txt","w");

	`elsif CASE3
		case_c2h_ofm_file = $fopen("../data/case3/case_c2h_ofm_sim.txt","w");
		
	`elsif CASE4
		case_c2h_ofm_file = $fopen("../data/case4/case_c2h_ofm_sim.txt","w");

	`elsif CASE5
		case_c2h_ofm_file = $fopen("../data/case5/case_c2h_ofm_sim.txt","w");

	`elsif CASE6
		case_c2h_ofm_file = $fopen("../data/case6/case_c2h_ofm_sim.txt","w");

	`elsif CASE7
		case_c2h_ofm_file = $fopen("../data/case7/case_c2h_ofm_sim.txt","w");

	`elsif CASE9
		case_c2h_ofm_file = $fopen("../data/case9/case_c2h_ofm_sim.txt","w");

	`elsif CASE11
		case_c2h_ofm_file = $fopen("../data/case11/case_c2h_ofm_sim.txt","w");

	`elsif CASE12
		case_int_file = $fopen("../data/case12/case_int_sim.txt","w");

	`elsif CASE13
		case_c2h_ofm_file = $fopen("../data/case13/case_c2h_ofm_sim.txt","w");

	`elsif CASE18
		case_h2c_ofm_file = $fopen("../data/case18/case_h2c_ofm_sim.txt","w");

	`elsif CASE19
		case_h2c_ofm_file = $fopen("../data/case19/case_h2c_ofm_sim.txt","w");

    `elsif CASE41
		case_c2h_ofm_file = $fopen("../data/case41/case_c2h_ofm_sim.txt","w");
	`endif
end

initial 
begin
	#200 ;
	@(casen_test_done);
	$display("CaseN write back done!");
	$display("Start to save data, and compare results!");
`ifdef CASE0
	for (i=0;i<`CFG_NUM;i=i+1)
	begin
		$fdisplay(case_cfg_file,"%h",cfg_idt_x[i]);
	end

`elsif CASE1
	for (i=0;i<`PMODE_NUM;i=i+1)
	begin
		$fdisplay(case_c2h_pmodewb_file,"%h",c2h_pmode_idt_x[i]);
	end

`elsif CASE2
	for (i=0;i<`IDT_NUM;i=i+1)
	begin
		$fdisplay(case_c2h_ofm_file,"%h",c2h_fm_idt_x[i]);
	end
	
`elsif CASE3 
	for (i=0;i<`IDT_NUM;i=i+1)
	begin
		$fdisplay(case_c2h_ofm_file,"%h",c2h_fm_idt_x[i]);
	end
	
`elsif CASE4
	for (i=0;i<`IDT_NUM;i=i+1)
	begin
		$fdisplay(case_c2h_ofm_file,"%h",c2h_fm_idt_x[i]);
	end

`elsif CASE5 
	for (i=0;i<`IDT_NUM;i=i+1)
	begin
		$fdisplay(case_c2h_ofm_file,"%h",c2h_fm_idt_x[i]);
	end

`elsif CASE6 
	for (i=0;i<`IDT_NUM;i=i+1)
	begin
		$fdisplay(case_c2h_ofm_file,"%h",c2h_fm_idt_x[i]);
	end

`elsif CASE7 
	for (i=0;i<`IDT_NUM;i=i+1)
	begin
		$fdisplay(case_c2h_ofm_file,"%h",c2h_fm_idt_x[i]);
	end

`elsif CASE9
	for (i=0;i<`IDT_NUM;i=i+1)
	begin
		$fdisplay(case_c2h_ofm_file,"%h",c2h_fm_idt_x[i]);
	end

`elsif CASE11
	for (i=0;i<`IDT_NUM;i=i+1)
	begin
		$fdisplay(case_c2h_ofm_file,"%h",c2h_fm_idt_x[i]);
	end

`elsif CASE12
	for (i=0;i<`INT_NUM;i=i+1)
	begin
		$fdisplay(case_int_file,"%h",int_idt_x[i]);
	end
`elsif CASE13
	for (i=0;i<`IDT_NUM;i=i+1)
	begin
		$fdisplay(case_c2h_ofm_file,"%h",c2h_fm_idt_x[i]);
	end
`elsif CASE18
	for (i=0;i<`IDT_NUM;i=i+1)
	begin
		$fdisplay(case_h2c_ofm_file,"%h",h2c_fm_idt_x[i]);
	end
`elsif CASE19
	for (i=0;i<`IDT_NUM;i=i+1)
	begin
		$fdisplay(case_h2c_ofm_file,"%h",h2c_fm_idt_x[i]);
	end
`elsif CASE41 
	for (i=0;i<`IDT_NUM;i=i+1)
	begin
		$fdisplay(case_c2h_ofm_file,"%h",c2h_fm_idt_x[i]);
	end

`endif
	$display("Data dump end!");
    #1000
	$fclose(case_int_file);
//	$fclose(case_axi4swb_file);
	$fclose(case_c2h_ofm_file);
	$fclose(case_h2c_ofm_file);
	$fclose(case_c2h_pmodewb_file);
	$fclose(case_h2c_pmodewb_file);
	$fclose(case_cfg_file);
	#1000 $finish;
	
end

endmodule




