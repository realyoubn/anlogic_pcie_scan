// -----------------------------------------------------------------
// Base address for PF0/1, VF1
// -----------------------------------------------------------------
// 
parameter 	BASE_ADDR_PF0        = 32'h0000_0000,
            BASE_ADDR_PF1        = 32'h0001_0000,
			BASE_ADDR_VF1_PF0    = 32'h0020_0000,
			BASE_ADDR_VF1_PF1    = 32'h0021_0000;
// -----------------------------------------------------------------
// Offset address for PF0/1
// -----------------------------------------------------------------
// Capability
parameter 	ADDR_PF_TYPE0_HDR    = 32'h0000_0000,
			ADDR_PF_PM_CAP       = 32'h0000_0040,
			ADDR_PF_MSI_CAP      = 32'h0000_0050,
			ADDR_PF_PCIE_CAP     = 32'h0000_0070,
			ADDR_PF_MSIX_CAP     = 32'h0000_00B0,
			ADDR_PF_AER_CAP      = 32'h0000_0100,
			ADDR_PF_SN_CAP       = 32'h0000_0148,
			ADDR_PF_ARI_CAP      = 32'h0000_0158,
			ADDR_PF_SPCIE_CAP    = 32'h0000_0168,
			ADDR_PF_SRIOV_CAP    = 32'h0000_01AC,
			ADDR_PF_TPH_CAP      = 32'h0000_01EC,
			ADDR_PF_ATS_CAP      = 32'h0000_0278,
			ADDR_PF_ACS_CAP      = 32'h0000_0288,
			ADDR_PF_PRS_EXT_CAP  = 32'h0000_0294,
			ADDR_PF_LTR_CAP      = 32'h0000_02A4,
			ADDR_PF_L1SUB_CAP    = 32'h0000_02AC,
			ADDR_PF_DPA_CAP      = 32'h0000_02BC,
			ADDR_PF_FRSQ_CAP     = 32'h0000_02EC,
			ADDR_PF_RTR_CAP      = 32'h0000_02FC,
			ADDR_PF_RAS_DES_CAP  = 32'h0000_0308,
			ADDR_PF_DLINK_CAP    = 32'h0000_0408,
			ADDR_PF_PORT_LOGIC   = 32'h0000_0700;
// PF0_TYPE1_HDR
parameter 	RC_ADDR_TYPE1_DEV_ID_VEND_ID_REG               = 32'h0000_0000,
			RC_ADDR_TYPE1_STATUS_COMMAND_REG               = 32'h0000_0004,
			RC_ADDR_TYPE1_CLASS_CODE_REV_ID_REG            = 32'h0000_0008,
			RC_TYPE1_BIST_HDR_TYPE_LAT_CACHE_LINE_SIZE_REG = 32'h0000_000C,
			RC_BAR0_REG                                    = 32'h0000_0010,
			RC_BAR1_REG                                    = 32'h0000_0014,
			RC_SEC_LAT_TIMER_SUB_BUS_SEC_BUS_PRI_BUS_REG   = 32'h0000_0018,
			RC_SEC_STAT_IO_LIMIT_IO_BASE_REG               = 32'h0000_001C,
			RC_MEM_LIMIT_MEM_BASE_REG                      = 32'h0000_0020,
			RC_PREF_MEM_LIMIT_PREF_MEM_BASE_REG            = 32'h0000_0024,
			RC_PREF_BASE_UPPER_REG                         = 32'h0000_0028,
			RC_PREF_LIMIT_UPPER_REG                        = 32'h0000_002C,
			RC_IO_LIMIT_UPPER_IO_BASE_UPPER_REG            = 32'h0000_0030,
			RC_TYPE1_CAP_PTR_REG                           = 32'h0000_0034,
			RC_TYPE1_EXP_ROM_BASE_REG                      = 32'h0000_0038,
			RC_BRIDGE_CTRL_INT_PIN_INT_LINE_REG            = 32'h0000_003C;
parameter 	EP_DEVICE_ID_VENDOR_ID_REG                                = 32'h0000_0000,
			EP_STATUS_COMMAND_REG                                     = 32'h0000_0004,
			EP_CLASS_CODE_REVISION_ID                                 = 32'h0000_0008,
			EP_BIST_HEADER_TYPE_LATENCY_CACHE_LINE_SIZE_REG           = 32'h0000_000C,
			EP_BAR0_REG                                               = 32'h0000_0010,
			EP_BAR1_REG                                               = 32'h0000_0014,
			EP_BAR2_REG                                               = 32'h0000_0018,
			EP_BAR3_REG                                               = 32'h0000_001C,
			EP_BAR4_REG                                               = 32'h0000_0020,
			EP_BAR5_REG                                               = 32'h0000_0024,
			EP_CARDBUS_CIS_PTR_REG                                    = 32'h0000_0028,
			EP_SUBSYSTEM_ID_SUBSYSTEM_VENDOR_ID_REG                   = 32'h0000_002C,
			EP_EXP_ROM_BASE_ADDR_REG                                  = 32'h0000_0030,
			EP_PCI_CAP_PTR_REG                                        = 32'h0000_0034,
			EP_MAX_LATENCY_MIN_GRANT_INTERRUPT_PIN_INTERRUPT_LINE_REG = 32'h0000_003C;
// PF0_PM_CAP
parameter 	CAP_ID_NXT_PTR_REG                          = 32'h0000_0000,
			CON_STATUS_REG                              = 32'h0000_0004;
// PF0_MSI_CAP
parameter 	PCI_MSI_CAP_ID_NEXT_CTRL_REG                = 32'h0000_0000,
			MSI_CAP_OFF_04H_REG                         = 32'h0000_0004,
			MSI_CAP_OFF_08H_REG                         = 32'h0000_0008,
			MSI_CAP_OFF_0CH_REG                         = 32'h0000_000C,
			MSI_CAP_OFF_10H_REG                         = 32'h0000_0010,
			MSI_CAP_OFF_14H_REG                         = 32'h0000_0014;
// PF0_PCIE_CAP
parameter 	PCIE_CAP_ID_PCIE_NEXT_CAP_PTR_PCIE_CAP_REG  = 32'h0000_0000,
			DEVICE_CAPABILITIES_REG                     = 32'h0000_0004,
			DEVICE_CONTROL_DEVICE_STATUS                = 32'h0000_0008,
			LINK_CAPABILITIES_REG                       = 32'h0000_000C,
			LINK_CONTROL_LINK_STATUS_REG                = 32'h0000_0010,
			SLOT_CAPABILITIES_REG                       = 32'h0000_0014,
			SLOT_CONTROL_SLOT_STATUS                    = 32'h0000_0018,
			ROOT_CONTROL_ROOT_CAPABILITIES_REG          = 32'h0000_001C,
			ROOT_STATUS_REG                             = 32'h0000_0020,
			DEVICE_CAPABILITIES2_REG                    = 32'h0000_0024,
			DEVICE_CONTROL2_DEVICE_STATUS2_REG          = 32'h0000_0028,
			LINK_CAPABILITIES2_REG                      = 32'h0000_002C,
			LINK_CONTROL2_LINK_STATUS2_REG              = 32'h0000_0030;
// PF0_MSIX_CAP
parameter 	PCI_MSIX_CAP_ID_NEXT_CTRL_REG 	            = 32'h0000_0000,
			MSIX_TABLE_OFFSET_REG                       = 32'h0000_0004,
			MSIX_PBA_OFFSET_REG                         = 32'h0000_0008;
// PF0_AER_CAP
parameter 	AER_EXT_CAP_HDR_OFF                         = 32'h0000_0000,
			UNCORR_ERR_STATUS_OFF                       = 32'h0000_0004,
			UNCORR_ERR_MASK_OFF                         = 32'h0000_0008,
			UNCORR_ERR_SEV_OFF                          = 32'h0000_000C,
			CORR_ERR_STATUS_OFF                         = 32'h0000_0010,
			CORR_ERR_MASK_OFF                           = 32'h0000_0014,
			ADV_ERR_CAP_CTRL_OFF                        = 32'h0000_0018,
			HDR_LOG_0_OFF                               = 32'h0000_001C,
			HDR_LOG_1_OFF                               = 32'h0000_0020,
			HDR_LOG_2_OFF                               = 32'h0000_0024,
			HDR_LOG_3_OFF                               = 32'h0000_0028,
			ROOT_ERR_CMD_OFF                            = 32'h0000_002C,
			ROOT_ERR_STATUS_OFF                         = 32'h0000_0030,
			ERR_SRC_ID_OFF                              = 32'h0000_0034,
			TLP_PREFIX_LOG_1_OFF                        = 32'h0000_0038,
			TLP_PREFIX_LOG_2_OFF                        = 32'h0000_003C,
			TLP_PREFIX_LOG_3_OFF                        = 32'h0000_0040,
			TLP_PREFIX_LOG_4_OFF                        = 32'h0000_0044;
// PF0_SN_CAP
parameter 	SN_BASE                                     = 32'h0000_0000,
			SER_NUM_REG_DW_1 	                        = 32'h0000_0004,
			SER_NUM_REG_DW_2                            = 32'h0000_0008;
// PF0_ARI_CAP
parameter 	ARI_BASE                                    = 32'h0000_0000,
			CAP_REG            	                        = 32'h0000_0004;
// PF0_SPCIE_CAP
parameter 	SPCIE_CAP_HEADER_REG                        = 32'h0000_0000,
			LINK_CONTROL3_REG                           = 32'h0000_0004,
			LANE_ERR_STATUS_REG                         = 32'h0000_0008,
			SPCIE_CAP_OFF_0CH_REG                       = 32'h0000_000C;
// PF0_PL16G_CAP
// PF0_MARGIN_CAP
// PF0_SRIOV_CAP
parameter 	SRIOV_BASE_REG                              = 32'h0000_0000,
			CAPABILITIES_REG                            = 32'h0000_0004,
			STATUS_CONTROL_REG                          = 32'h0000_0008,
			TOTAL_VFS_INITIAL_VFS_REG                   = 32'h0000_000C,
			SRIOV_NUM_VFS                               = 32'h0000_0010,
			SRIOV_VF_OFFSET_POSITION                    = 32'h0000_0014,
			VF_DEVICE_ID_REG                            = 32'h0000_0018,
			SUP_PAGE_SIZES_REG                          = 32'h0000_001C,
			SYSTEM_PAGE_SIZE_REG                        = 32'h0000_0020,
			SRIOV_BAR0_REG                              = 32'h0000_0024,
			SRIOV_BAR1_REG                              = 32'h0000_0028,
			SRIOV_BAR2_REG                              = 32'h0000_002C,
			SRIOV_BAR3_REG                              = 32'h0000_0030,
			SRIOV_BAR4_REG                              = 32'h0000_0034,
			SRIOV_BAR5_REG                              = 32'h0000_0038,
			VF_MIGRATION_STATE_ARRAY_REG                = 32'h0000_003C;
// PF0_TPH_CAP
parameter 	TPH_EXT_CAP_HDR_REG                         = 32'h0000_0000,
			TPH_REQ_CAP_REG_REG                         = 32'h0000_0004,
			TPH_REQ_CONTROL_REG_REG                     = 32'h0000_0008,
			TPH_ST_TABLE_REG_0                          = 32'h0000_000C;
// PF0_ATS_CAP
parameter 	ATS_CAP_HDR_REG                             = 32'h0000_0000,
			ATS_CAPABILITIES_CTRL_REG                   = 32'h0000_0004;
// PF0_ACS_CAP
parameter 	ACS_CAP_HDR_REG                             = 32'h0000_0000,
			ACS_CAPABILITIES_CTRL_REG                   = 32'h0000_0004,
			ACS_EGRESS_CTRL_VECTOR_REG0                 = 32'h0000_0008;
// PF0_PRS_EXT_CAP
parameter 	PRS_EXT_CAP_HDR_REG                         = 32'h0000_0000,
			PRS_CONTROL_STATUS_REG                      = 32'h0000_0004,
			PRS_REQ_CAPACITY_REG                        = 32'h0000_0008,
			PRS_REQ_ALLOCATION_REG                      = 32'h0000_000C;
// PF0_LTR_CAP
parameter 	LTR_CAP_HDR_REG                             = 32'h0000_0000,
			LTR_LATENCY_REG                             = 32'h0000_0004;
// PF0_L1SUB_CAP
parameter 	L1SUB_CAP_HEADER_REG                        = 32'h0000_0000,
			L1SUB_CAPABILITY_REG                        = 32'h0000_0004,
			L1SUB_CONTROL1_REG                          = 32'h0000_0008,
			L1SUB_CONTROL2_REG                          = 32'h0000_000C;
// PF0_DPA_CAP
parameter 	DPA_EXT_CAP_HDR_REG                         = 32'h0000_0000,
			DPA_CAP_REG                                 = 32'h0000_0004,
			DPA_LAT_IND_REG                             = 32'h0000_0008,
			DPA_STATUS_CNTRL_REG                        = 32'h0000_000C,
			DPA_PWR_ALLOC_ARRAY0                        = 32'h0000_0010,
			DPA_PWR_ALLOC_ARRAY4                        = 32'h0000_0014,
			DPA_PWR_ALLOC_ARRAY8                        = 32'h0000_0018,
			DPA_PWR_ALLOC_ARRAY12                       = 32'h0000_001C,
			DPA_PWR_ALLOC_ARRAY16                       = 32'h0000_0020,
			DPA_PWR_ALLOC_ARRAY20 	                    = 32'h0000_0024,
			DPA_PWR_ALLOC_ARRAY24                       = 32'h0000_0028,
			DPA_PWR_ALLOC_ARRAY28                       = 32'h0000_002C;
// PF0_FRSQ_CAP
parameter 	FRSQ_EXT_CAP_HDR_OFF                        = 32'h0000_0000,
			FRSQ_CAP_OFF                                = 32'h0000_0004,
			FRSQ_CONTROL_FRSQ_STATUS_OFF                = 32'h0000_0008,
			FRS_MESSAGE_QUEUE_OFF                       = 32'h0000_000C;
// PF0_RTR_CAP
parameter 	RTR_EXT_CAP_HDR_OFF                         = 32'h0000_0000,
			READI_TIME_REPORTING1_OFF                   = 32'h0000_0004,
			READI_TIME_REPORTING2_OFF                   = 32'h0000_0008;
// PF0_RAS_DES_CAP
parameter 	RAS_DES_CAP_HEADER_REG                      = 32'h0000_0000,
			VENDOR_SPECIFIC_HEADER_REG                  = 32'h0000_0004,
			EVENT_COUNTER_CONTROL_REG                   = 32'h0000_0008,
			EVENT_COUNTER_DATA_REG                      = 32'h0000_000C,
			TIME_BASED_ANALYSIS_CONTROL_REG             = 32'h0000_0010,
			TIME_BASED_ANALYSIS_DATA_REG                = 32'h0000_0014,
			TIME_BASED_ANALYSIS_DATA_63_32_REG          = 32'h0000_0018,
			EINJ_ENABLE_REG                             = 32'h0000_0030,
			EINJ0_CRC_REG                               = 32'h0000_0034,
			EINJ1_SEQNUM_REG                            = 32'h0000_0038,
			EINJ2_DLLP_REG                              = 32'h0000_003C,
			EINJ3_SYMBOL_REG                            = 32'h0000_0040,
			EINJ4_FC_REG                                = 32'h0000_0044,
			EINJ5_SP_TLP_REG                            = 32'h0000_0048,
			EINJ6_COMPARE_POINT_H0_REG                  = 32'h0000_004C,
			EINJ6_COMPARE_POINT_H1_REG                  = 32'h0000_0050,
			EINJ6_COMPARE_POINT_H2_REG                  = 32'h0000_0054,
			EINJ6_COMPARE_POINT_H3_REG                  = 32'h0000_0058,
			EINJ6_COMPARE_VALUE_H0_REG                  = 32'h0000_005C,
			EINJ6_COMPARE_VALUE_H1_REG                  = 32'h0000_0060,
			EINJ6_COMPARE_VALUE_H2_REG                  = 32'h0000_0064,
			EINJ6_COMPARE_VALUE_H3_REG                  = 32'h0000_0068,
			EINJ6_CHANGE_POINT_H0_REG                   = 32'h0000_006C,
			EINJ6_CHANGE_POINT_H1_REG                   = 32'h0000_0070,
			EINJ6_CHANGE_POINT_H2_REG                   = 32'h0000_0074,
			EINJ6_CHANGE_POINT_H3_REG                   = 32'h0000_0078,
			EINJ6_CHANGE_VALUE_H0_REG                   = 32'h0000_007C,
			EINJ6_CHANGE_VALUE_H1_REG                   = 32'h0000_0080,
			EINJ6_CHANGE_VALUE_H2_REG                   = 32'h0000_0084,
			EINJ6_CHANGE_VALUE_H3_REG                   = 32'h0000_0088,
			EINJ6_TLP_REG                               = 32'h0000_008C,
			SD_CONTROL1_REG                             = 32'h0000_00A0,
			SD_CONTROL2_REG                             = 32'h0000_00A4,
			SD_STATUS_L1LANE_REG                        = 32'h0000_00B0,
			SD_STATUS_L1LTSSM_REG                       = 32'h0000_00B4,
			SD_STATUS_PM_REG                            = 32'h0000_00B8,
			SD_STATUS_L2_REG                            = 32'h0000_00BC,
			SD_STATUS_L3FC_REG                          = 32'h0000_00C0,
			SD_STATUS_L3_REG                            = 32'h0000_00C4,
			SD_EQ_CONTROL1_REG                          = 32'h0000_00D0,
			SD_EQ_CONTROL2_REG                          = 32'h0000_00D4,
			SD_EQ_CONTROL3_REG                          = 32'h0000_00D8,
			SD_EQ_STATUS1_REG                           = 32'h0000_00E0,
			SD_EQ_STATUS2_REG                           = 32'h0000_00E4,
			SD_EQ_STATUS3_REG                           = 32'h0000_00E8;
// PF0_DLINK_CAP
parameter 	DATA_LINK_FEATURE_EXT_HDR_OFF               = 32'h0000_0000,
			DATA_LINK_FEATURE_CAP_OFF                   = 32'h0000_0004,
			DATA_LINK_FEATURE_STATUS_OFF                = 32'h0000_0008;
// PF0_PORT_LOGIC
parameter 	ACK_LATENCY_TIMER_OFF                       = 32'h0000_0000,
			VENDOR_SPEC_DLLP_OFF                        = 32'h0000_0004,
			PORT_FORCE_OFF                              = 32'h0000_0008,
			ACK_F_ASPM_CTRL_OFF                         = 32'h0000_000C,
			PORT_LINK_CTRL_OFF                          = 32'h0000_0010,
			LANE_SKEW_OFF                               = 32'h0000_0014,
			TIMER_CTRL_MAX_FUNC_NUM_OFF                 = 32'h0000_0018,
			SYMBOL_TIMER_FILTER_1_OFF                   = 32'h0000_001C,
			FILTER_MASK_2_OFF                           = 32'h0000_0020,
			PL_DEBUG0_OFF                               = 32'h0000_0028,
			PL_DEBUG1_OFF                               = 32'h0000_002C,
			TX_P_FC_CREDIT_STATUS_OFF                   = 32'h0000_0030,
			TX_NP_FC_CREDIT_STATUS_OFF                  = 32'h0000_0034,
			TX_CPL_FC_CREDIT_STATUS_OFF                 = 32'h0000_0038,
			QUEUE_STATUS_OFF                            = 32'h0000_003C,
			VC_TX_ARBI_1_OFF                            = 32'h0000_0040,
			VC_TX_ARBI_2_OFF                            = 32'h0000_0044,
			VC0_P_RX_Q_CTRL_OFF                         = 32'h0000_0048,
			VC0_NP_RX_Q_CTRL_OFF                        = 32'h0000_004C,
			VC0_CPL_RX_Q_CTRL_OFF                       = 32'h0000_0050,
			GEN2_CTRL_OFF                               = 32'h0000_010C,
			PHY_STATUS_OFF                              = 32'h0000_0110,
			PHY_CONTROL_OFF                             = 32'h0000_0114,
			TRGT_MAP_CTRL_OFF                           = 32'h0000_011C,
			CLOCK_GATING_CTRL_OFF                       = 32'h0000_018C,
			GEN3_RELATED_OFF                            = 32'h0000_0190,
			GEN3_EQ_CONTROL_OFF                         = 32'h0000_01A8,
			GEN3_EQ_FB_MODE_DIR_CHANGE_OFF              = 32'h0000_01AC,
			ORDER_RULE_CTRL_OFF                         = 32'h0000_01B4,
			PIPE_LOOPBACK_CONTROL_OFF                   = 32'h0000_01B8,
			MISC_CONTROL_1_OFF                          = 32'h0000_01BC,
			MULTI_LANE_CONTROL_OFF                      = 32'h0000_01C0,
			PHY_INTEROP_CTRL_OFF                        = 32'h0000_01C4,
			TRGT_CPL_LUT_DELETE_ENTRY_OFF               = 32'h0000_01C8,
			PCIE_VERSION_NUMBER_OFF                     = 32'h0000_01F8,
			PCIE_VERSION_TYPE_OFF                       = 32'h0000_01FC,
			PL_APP_BUS_DEV_NUM_STATUS_OFF               = 32'h0000_0410,
			PCIPM_TRAFFIC_CTRL_OFF                      = 32'h0000_041C,
			PL_LTR_LATENCY_OFF                          = 32'h0000_0430,
			AUX_CLK_FREQ_OFF                            = 32'h0000_0440,
			L1_SUBSTATES_OFF                            = 32'h0000_0444,
			POWERDOWN_CTRL_STATUS_OFF                   = 32'h0000_0448,
			GEN4_LANE_MARGINING_1_OFF                   = 32'h0000_0480,
			GEN4_LANE_MARGINING_2_OFF                   = 32'h0000_0484,
			PIPE_RELATED_OFF                            = 32'h0000_0490;

// -----------------------------------------------------------------
// Offset address for VF1
// -----------------------------------------------------------------
parameter   ADDR_VF1_PF_TYPE0_HDR = 32'h0000_0000,
            ADDR_VF1_PF_PCIE_CAP  = 32'h0000_0070,
			ADDR_VF1_PF_MSIX_CAP  = 32'h0000_00B0,
			ADDR_VF1_PF_ARI_CAP   = 32'h0000_0100,
			ADDR_VF1_PF_ACS_CAP   = 32'h0000_0110,
			ADDR_VF1_PF_RTR_CAP   = 32'h0000_011C;

// Offset address for PF0 Shadow
parameter   ADDR_PF_TYPE0_HDR_DBI2  = 32'h0000_0000,
            ADDR_PF_PCIE_CAP_DBI2   = 32'h0000_0070,
            ADDR_PF_MSIX_CAP_DBI2   = 32'h0000_00B0,
			ADDR_PF_SRIOV_CAP_DBI2  = 32'h0000_01AC,
			ADDR_PF_TPH_CAP_DBI2    = 32'h0000_01EC,
			ADDR_PF_RTR_CAP_DBI2    = 32'h0000_02FC;

