onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /tb_sgdma_fsim/u_rc_exam/u_rx_bfm/*
add wave -noupdate /tb_sgdma_fsim/u_rc_exam/u_tx_bfm/*
#add wave -noupdate /tb_sgdma_fsim/u_rc_exam/u_rc_core/*
#add wave -noupdate /tb_sgdma_fsim/u_subsys_exam/u_sgdma_subsys/u_ep_core/*
#add wave -noupdate /tb_sgdma_fsim/u_subsys_exam/u_sgdma_subsys/u_sgdma_ip/u_dscp_cal/*
#add wave -noupdate /tb_sgdma_fsim/u_subsys_exam/u_sgdma_subsys/u_sgdma_ip/u_rdscp_cal/*
add wave -noupdate /tb_sgdma_fsim/u_subsys_exam/u_sgdma_subsys/u_sgdma_ip/u_mrd_rx/*
add wave -noupdate /tb_sgdma_fsim/u_subsys_exam/u_sgdma_subsys/u_sgdma_ip/u_mwr_tlp/*
add wave -noupdate /tb_sgdma_fsim/u_subsys_exam/u_sgdma_subsys/u_sgdma_ip/u_mrd_arb/*
add wave -noupdate /tb_sgdma_fsim/u_subsys_exam/u_sgdma_subsys/u_sgdma_ip/u_bypa_rx/*
add wave -noupdate /tb_sgdma_fsim/u_subsys_exam/u_sgdma_subsys/u_sgdma_ip/u_mwr_axi4s0/*
add wave -noupdate /tb_sgdma_fsim/u_subsys_exam/u_sgdma_app/u_usr_c2h0r/*


TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {2363793459 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 581
configure wave -valuecolwidth 100
configure wave -justifyvalue left
configure wave -signalnamewidth 0
configure wave -snapdistance 10
configure wave -datasetprefix 0
configure wave -rowmargin 4
configure wave -childrowmargin 2
configure wave -gridoffset 0
configure wave -gridperiod 1
configure wave -griddelta 40
configure wave -timeline 0
configure wave -timelineunits ps
update
WaveRestoreZoom {2361606253 ps} {2365447040 ps}
