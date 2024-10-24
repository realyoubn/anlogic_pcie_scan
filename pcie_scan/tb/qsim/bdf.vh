	parameter  	RC_BUS_NUM = 8'h00,
		    	RC_DEV_NUM = 5'h00,
				RC_FUN_NUM = 3'h0;
	parameter	RC_BDF  = {RC_BUS_NUM, RC_DEV_NUM, RC_FUN_NUM};
	parameter	EP_BUS_NUM = 8'h01,//???
				EP_DEV_NUM = 5'h00,
				EP_FUN_NUM = 3'h0; // PF0
	parameter	EP_BDF     = {EP_BUS_NUM, EP_DEV_NUM, EP_FUN_NUM}; //16'h0100
	
	parameter	FUNCTION_NUMBER_PF0 = 1'b0,
				FUNCTION_NUMBER_PF1 = 1'b1,
				FUNCTION_NUMBER_VF1 = 2'b00,
				FUNCTION_NUMBER_VF2 = 2'b01;

	parameter BAR0_SIZE    = 1024*1024    ;
	parameter BAR1_SIZE    = 64*1024      ;
	parameter BAR2_SIZE    = 1024*1024    ;
	parameter BAR3_SIZE    = 64*1024      ;
	parameter BAR4_SIZE    = 16           ;//here
	
	parameter BAR0_VALUE   = 32'hFFF0_0000;
	parameter BAR1_VALUE   = 32'hFFFF_0000;
	parameter BAR2_VALUE   = 32'hFFF0_0000;
	parameter BAR3_VALUE   = 32'hFFFF_0000;
	parameter BAR4_VALUE   = 32'hFFFF_FFF0;
	
	parameter BAR0_MASK    = 32'h000F_FFFF;//32'h0000_07FF
	parameter BAR1_MASK    = 32'h0000_FFFF;//32'h0000_07FF
	parameter BAR2_MASK    = 32'h000F_FFFF;
	parameter BAR3_MASK    = 32'h0000_FFFF;
	parameter BAR4_MASK    = 32'h0000_000F;
	
	parameter ADDR_BAR0_BA = 32'h8000_0000; // Memory
	parameter ADDR_BAR1_BA = 32'h6000_0000; // Memory
	parameter ADDR_BAR2_BA = 32'h4000_0000; // Memory
	parameter ADDR_BAR3_BA = 32'h2000_0000; // Memory
	parameter ADDR_BAR4_BA = 32'h0000_8000; // IO
	
	parameter BRIDGE_BA    = 32'hFFFFFF00;

	parameter   ADDRESS_MD_SWITCH = 32'h0000_FFF0;
	parameter   ADDRESS_WR_PROT = 32'h0000_08BC;
	parameter   BIT_WR_PROT = 0;
	
	// ?????
	parameter   MSI_CTRL_ADDR = 64'h0000_0000_9000_0000,
	            MSI_CTRL_DATA = 16'h0500,
	            MSI_CTRL_INT_0_EN_OFF = 32'hFFFF_FFFF,
	            MSI_CTRL_INT_0_MASK_OFF = 32'h0000_0000;
