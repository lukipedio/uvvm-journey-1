onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /axi4lite_tester_regs_tb/uut/axi_aclk
add wave -noupdate /axi4lite_tester_regs_tb/uut/axi_aresetn
add wave -noupdate /axi4lite_tester_regs_tb/uut/s_axi_awaddr
add wave -noupdate /axi4lite_tester_regs_tb/uut/s_axi_awprot
add wave -noupdate /axi4lite_tester_regs_tb/uut/s_axi_awvalid
add wave -noupdate /axi4lite_tester_regs_tb/uut/s_axi_awready
add wave -noupdate /axi4lite_tester_regs_tb/uut/s_axi_wdata
add wave -noupdate /axi4lite_tester_regs_tb/uut/s_axi_wstrb
add wave -noupdate /axi4lite_tester_regs_tb/uut/s_axi_wvalid
add wave -noupdate /axi4lite_tester_regs_tb/uut/s_axi_wready
add wave -noupdate /axi4lite_tester_regs_tb/uut/s_axi_araddr
add wave -noupdate /axi4lite_tester_regs_tb/uut/s_axi_arprot
add wave -noupdate /axi4lite_tester_regs_tb/uut/s_axi_arvalid
add wave -noupdate /axi4lite_tester_regs_tb/uut/s_axi_arready
add wave -noupdate /axi4lite_tester_regs_tb/uut/s_axi_rdata
add wave -noupdate /axi4lite_tester_regs_tb/uut/s_axi_rresp
add wave -noupdate /axi4lite_tester_regs_tb/uut/s_axi_rvalid
add wave -noupdate /axi4lite_tester_regs_tb/uut/s_axi_rready
add wave -noupdate /axi4lite_tester_regs_tb/uut/s_axi_bresp
add wave -noupdate /axi4lite_tester_regs_tb/uut/s_axi_bvalid
add wave -noupdate /axi4lite_tester_regs_tb/uut/s_axi_bready
add wave -noupdate /axi4lite_tester_regs_tb/uut/user2regs
add wave -noupdate /axi4lite_tester_regs_tb/uut/regs2user
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {0 ns} 0}
quietly wave cursor active 0
configure wave -namecolwidth 349
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
configure wave -timelineunits ns
update
WaveRestoreZoom {0 ns} {877 ns}
