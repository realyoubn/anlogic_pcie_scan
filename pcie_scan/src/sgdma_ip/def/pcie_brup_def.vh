//-----------------------------------------------------------------------------
// Title         : PCIe Bring Up define
// Project       : AL006
//-----------------------------------------------------------------------------
// File          : pcie_brup_define.v
// Author        :   <jqzhou@R888E>
// Created       : 10.03.2020
// Last modified : 10.03.2020
//-----------------------------------------------------------------------------
// Description :
// 
//-----------------------------------------------------------------------------
// Copyright (c) 2020 by anlogic This model is the confidential and
// proprietary property of anlogic and the possession or use of this
// file requires a written license from anlogic.
//------------------------------------------------------------------------------
// Modification history :
// 10.03.2020 : created
//-----------------------------------------------------------------------------

//PCIe Controller orignal register 
 `define DEVICE_ID_VENDOR_ID_REG 32'h0 					// DWC_PCIE_USP_PF0_TYPE0_HDR
 `define AER_EXT_CAP_HDR_OFF 32'h100 					// DWC_PCIE_USP_PF0_AER_CAP
 `define UNCORR_ERR_STATUS_OFF 32'h104 					// DWC_PCIE_USP_PF0_AER_CAP
 `define UNCORR_ERR_MASK_OFF 32'h108 					// DWC_PCIE_USP_PF0_AER_CAP
 `define BAR0_REG 32'h10 						// DWC_PCIE_USP_PF0_TYPE0_HDR
 `define CORR_ERR_STATUS_OFF 32'h110 					// DWC_PCIE_USP_PF0_AER_CAP
 `define BAR1_REG 32'h14 						// DWC_PCIE_USP_PF0_TYPE0_HDR
 `define LANE_ERR_STATUS_REG 32'h170 					// DWC_PCIE_USP_PF0_SPCIE_CAP
 `define BAR2_REG 32'h18 						// DWC_PCIE_USP_PF0_TYPE0_HDR
 `define STATUS_CONTROL_REG 32'h1b4 					// DWC_PCIE_USP_PF0_SRIOV_CAP
 `define TOTAL_VFS_INITIAL_VFS_REG 32'h1b8 				// DWC_PCIE_USP_PF0_SRIOV_CAP
 `define SRIOV_VF_OFFSET_POSITION 32'h1c0 				// DWC_PCIE_USP_PF0_SRIOV_CAP
 `define BAR4_REG 32'h20 						// DWC_PCIE_USP_PF0_TYPE0_HDR
 `define EXP_ROM_BASE_ADDR_REG 32'h30 					// DWC_PCIE_USP_PF0_TYPE0_HDR
 `define IATU_UPPER_TARGET_ADDR_OFF_INBOUND_1 32'h318 			// DWC_PCIE_USP_PF0_ATU_CAP
 `define DATA_LINK_FEATURE_EXT_HDR_OFF 32'h408 				// DWC_PCIE_USP_PF0_DLINK_CAP
 `define CAP_ID_NXT_PTR_REG 32'h40 					// DWC_PCIE_USP_PF0_PM_CAP
 `define STATUS_COMMAND_REG 32'h4 					// DWC_PCIE_USP_PF0_TYPE0_HDR
 `define PCIE_CAP_ID_PCIE_NEXT_CAP_PTR_PCIE_CAP_REG 32'h70 		// DWC_PCIE_USP_PF0_PCIE_CAP
 `define PORT_LINK_CTRL_OFF 32'h710 					// DWC_PCIE_USP_PF0_PORT_LOGIC
 `define MISC_CONTROL_1_OFF 32'h8bc 					// DWC_PCIE_USP_PF0_PORT_LOGIC
 `define SHADOW_MSIX_TABLE_OFFSET_REG 32'hb4 				// DWC_PCIE_USP_PF0_MSIX_CAP_DBI2
 `define MSIX_TABLE_OFFSET_REG 32'hb4 					// DWC_PCIE_USP_PF0_MSIX_CAP
 `define SHADOW_MSIX_PBA_OFFSET_REG 32'hb8 				// DWC_PCIE_USP_PF0_MSIX_CAP_DBI2
 `define MSIX_PBA_OFFSET_REG 32'hb8 					// DWC_PCIE_USP_PF0_MSIX_CAP
 `define LINK_CAPABILITIES_REG 32'h7c					// PF0_PCIE_CAP 
 `define LINK_CONTROL2_LINK_STATUS2_REG 32'ha0				// PF0_PCIE_CAP  




//PHY Registers
`define RAWLANEN_DIG_FSM_FW_STATES_1 16'h303f 
`define RAWLANEN_DIG_AON_RX_CONT_ALGO_CTL 16'h3052 
`define RAWLANEN_DIG_AON_RX_ADPT_REF_ERR 16'h305d 
`define RAWLANEN_DIG_AON_RX_ADPT_DFE_TAP5_B1 16'h3066 
`define RAWLANEN_DIG_AON_FAST_FLAGS 16'h306a 
`define RAWLANEN_DIG_AON_ADPT_CTL_2 16'h30e0 
`define RAWLANEN_DIG_AON_ADPT_CTL_5 16'h30e3 

//Control Access seperate Interface or not
`define DBI_IF_EN 1'b1
`define CR_IF_EN 1'b0
`define DATA_IF_EN 1'b1
`define SII_IF_EN 1'b1
`define MIX_IF_EN 1'b1

//Time delay for each interface
`define DBI_IF_CNT 32'd20
`define CR_IF_CNT 32'd320
`define DATA_IF_CNT 12'd1520
`define SII_IF_CNT 32'd20
`define MIX_IF_CNT 32'd20

//Access Data length for each infertace
`define CFG_DBI_NUM 10
`define CFG_CR_NUM 7
`define CFG_DATA_NUM 7

`ifndef TP
	`define TP 0.2
`endif
