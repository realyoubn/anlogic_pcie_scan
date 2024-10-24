`ifdef CASE0
	`define CFG_NUM  42
	`define IDT_NUM  1
	`define ODT_NUM  1
    `define WDSCP_NUM 1
	`define RDSCP_NUM  1
    `define PMODE_NUM  1
	`define INT_NUM  1

`elsif CASE1
	`define CFG_NUM    10
    `define IDT_NUM    512
	`define ODT_NUM    512
	`define WDSCP_NUM  20
	`define RDSCP_NUM  1
	`define PMODE_NUM  2
	`define INT_NUM    2

`elsif CASE2
	`define CFG_NUM    10
	`define IDT_NUM    2560
	`define ODT_NUM    2560
    `define WDSCP_NUM  20
	`define RDSCP_NUM  1
    `define PMODE_NUM  1
	`define INT_NUM    2

`elsif CASE3
	`define CFG_NUM  20
	`define IDT_NUM  256
	`define ODT_NUM  512
	`define WDSCP_NUM  20 
	`define RDSCP_NUM  1
	`define PMODE_NUM  1
	`define INT_NUM  2
         
`elsif CASE4
	`define CFG_NUM  10
	`define IDT_NUM  512
	`define ODT_NUM  512
    `define WDSCP_NUM  20
	`define RDSCP_NUM  1
    `define PMODE_NUM  1
	`define INT_NUM  1

`elsif CASE5
	`define CFG_NUM    10
	`define IDT_NUM    512
	`define ODT_NUM    525
    `define WDSCP_NUM  20
	`define RDSCP_NUM  1
    `define PMODE_NUM  1
	`define INT_NUM    1

`elsif CASE6
	`define CFG_NUM  20
	`define IDT_NUM  512
	`define ODT_NUM  512
	`define WDSCP_NUM  20 
	`define RDSCP_NUM  1
	`define PMODE_NUM  1
	`define INT_NUM  1

`elsif CASE7
	`define CFG_NUM  10
	`define IDT_NUM  512
	`define ODT_NUM  512
    `define WDSCP_NUM  20
	`define RDSCP_NUM  1
    `define PMODE_NUM  1
	`define INT_NUM  1

`elsif CASE9
	`define CFG_NUM  10
	`define IDT_NUM  512
	`define ODT_NUM  512
    `define WDSCP_NUM  20
	`define RDSCP_NUM  1
    `define PMODE_NUM  1
	`define INT_NUM  1

`elsif CASE10
	`define CFG_NUM  12
	`define IDT_NUM  320
	`define ODT_NUM  320
	`define WDSCP_NUM  20
	`define RDSCP_NUM  1
    `define PMODE_NUM  1
	`define INT_NUM  1

`elsif CASE11
	`define CFG_NUM  10
	`define IDT_NUM  512
	`define ODT_NUM  512
	`define WDSCP_NUM  20
	`define RDSCP_NUM  1
	`define PMODE_NUM  1
	`define INT_NUM  2

`elsif CASE12
	`define CFG_NUM  3
	`define IDT_NUM  1
	`define ODT_NUM  1
	`define WDSCP_NUM  1
	`define RDSCP_NUM  1
	`define PMODE_NUM  1
	`define INT_NUM  1

`elsif CASE13
	`define CFG_NUM  10
	`define IDT_NUM  768
	`define ODT_NUM  768
	`define WDSCP_NUM  20
	`define RDSCP_NUM  1
	`define PMODE_NUM  1
	`define INT_NUM  2

`elsif CASE18
	`define CFG_NUM  10
	`define IDT_NUM  512
	`define ODT_NUM  512
	`define WDSCP_NUM  1
	`define RDSCP_NUM  20
	`define PMODE_NUM  1
	`define INT_NUM  1

`elsif CASE19
	`define CFG_NUM  8
	`define IDT_NUM  512
	`define ODT_NUM  512
	`define WDSCP_NUM  1
	`define RDSCP_NUM  20
	`define PMODE_NUM  1
	`define INT_NUM  1

`elsif CASE41
	`define CFG_NUM    16
	`define RDSCP_NUM  20
	`define WDSCP_NUM  20
	`define PMODE_NUM  1
	`define INT_NUM    2
	`define IDT_NUM    512
	`define ODT_NUM    512

`else
	`define CFG_NUM    1
	`define RDSCP_NUM  1
	`define WDSCP_NUM  1
	`define PMODE_NUM  1
	`define INT_NUM    2
	`define IDT_NUM    1
	`define ODT_NUM    1

`endif
