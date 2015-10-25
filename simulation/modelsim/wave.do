onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -radix hexadecimal /mp3_tb/clk
add wave -noupdate -radix hexadecimal /mp3_tb/dut/resp_a
add wave -noupdate -radix hexadecimal /mp3_tb/dut/rdata_a
add wave -noupdate -radix hexadecimal /mp3_tb/dut/address_a
add wave -noupdate -radix hexadecimal /mp3_tb/dut/resp_b
add wave -noupdate -radix hexadecimal /mp3_tb/dut/rdata_b
add wave -noupdate -radix hexadecimal /mp3_tb/address_b
add wave -noupdate -radix hexadecimal /mp3_tb/dut/read_b
add wave -noupdate -radix hexadecimal /mp3_tb/dut/write_b
add wave -noupdate -radix hexadecimal /mp3_tb/dut/wdata_b
add wave -noupdate -radix hexadecimal /mp3_tb/dut/instruction
add wave -noupdate -radix hexadecimal /mp3_tb/dut/control
add wave -noupdate -radix hexadecimal /mp3_tb/dut/datapath/IF_ID/reset
add wave -noupdate -radix hexadecimal /mp3_tb/dut/datapath/IF_ID/load
add wave -noupdate -radix hexadecimal /mp3_tb/dut/datapath/IF_ID/pc_in
add wave -noupdate -radix hexadecimal /mp3_tb/dut/datapath/IF_ID/instruction_in
add wave -noupdate -radix hexadecimal /mp3_tb/dut/datapath/IF_ID/control_in
add wave -noupdate -radix hexadecimal /mp3_tb/dut/datapath/IF_ID/pc_out
add wave -noupdate -radix hexadecimal /mp3_tb/dut/datapath/IF_ID/instruction_out
add wave -noupdate -radix hexadecimal /mp3_tb/dut/datapath/IF_ID/control_out
add wave -noupdate -radix hexadecimal /mp3_tb/dut/datapath/ID_EX/reset
add wave -noupdate -radix hexadecimal /mp3_tb/dut/datapath/ID_EX/load
add wave -noupdate -radix hexadecimal /mp3_tb/dut/datapath/ID_EX/pc_in
add wave -noupdate -radix hexadecimal /mp3_tb/dut/datapath/ID_EX/instruction_in
add wave -noupdate -radix hexadecimal /mp3_tb/dut/datapath/ID_EX/sr1_in
add wave -noupdate -radix hexadecimal /mp3_tb/dut/datapath/ID_EX/sr2_in
add wave -noupdate -radix hexadecimal /mp3_tb/dut/datapath/ID_EX/control_in
add wave -noupdate -radix hexadecimal /mp3_tb/dut/datapath/ID_EX/pc_out
add wave -noupdate -radix hexadecimal /mp3_tb/dut/datapath/ID_EX/instruction_out
add wave -noupdate -radix hexadecimal /mp3_tb/dut/datapath/ID_EX/sr1_out
add wave -noupdate -radix hexadecimal /mp3_tb/dut/datapath/ID_EX/sr2_out
add wave -noupdate -radix hexadecimal /mp3_tb/dut/datapath/ID_EX/control_out
add wave -noupdate -radix hexadecimal /mp3_tb/dut/datapath/ID_EX/pc_data
add wave -noupdate -radix hexadecimal -childformat {{{/mp3_tb/dut/datapath/ID_EX/instruction_data[15]} -radix hexadecimal} {{/mp3_tb/dut/datapath/ID_EX/instruction_data[14]} -radix hexadecimal} {{/mp3_tb/dut/datapath/ID_EX/instruction_data[13]} -radix hexadecimal} {{/mp3_tb/dut/datapath/ID_EX/instruction_data[12]} -radix hexadecimal} {{/mp3_tb/dut/datapath/ID_EX/instruction_data[11]} -radix hexadecimal} {{/mp3_tb/dut/datapath/ID_EX/instruction_data[10]} -radix hexadecimal} {{/mp3_tb/dut/datapath/ID_EX/instruction_data[9]} -radix hexadecimal} {{/mp3_tb/dut/datapath/ID_EX/instruction_data[8]} -radix hexadecimal} {{/mp3_tb/dut/datapath/ID_EX/instruction_data[7]} -radix hexadecimal} {{/mp3_tb/dut/datapath/ID_EX/instruction_data[6]} -radix hexadecimal} {{/mp3_tb/dut/datapath/ID_EX/instruction_data[5]} -radix hexadecimal} {{/mp3_tb/dut/datapath/ID_EX/instruction_data[4]} -radix hexadecimal} {{/mp3_tb/dut/datapath/ID_EX/instruction_data[3]} -radix hexadecimal} {{/mp3_tb/dut/datapath/ID_EX/instruction_data[2]} -radix hexadecimal} {{/mp3_tb/dut/datapath/ID_EX/instruction_data[1]} -radix hexadecimal} {{/mp3_tb/dut/datapath/ID_EX/instruction_data[0]} -radix hexadecimal}} -subitemconfig {{/mp3_tb/dut/datapath/ID_EX/instruction_data[15]} {-height 16 -radix hexadecimal} {/mp3_tb/dut/datapath/ID_EX/instruction_data[14]} {-height 16 -radix hexadecimal} {/mp3_tb/dut/datapath/ID_EX/instruction_data[13]} {-height 16 -radix hexadecimal} {/mp3_tb/dut/datapath/ID_EX/instruction_data[12]} {-height 16 -radix hexadecimal} {/mp3_tb/dut/datapath/ID_EX/instruction_data[11]} {-height 16 -radix hexadecimal} {/mp3_tb/dut/datapath/ID_EX/instruction_data[10]} {-height 16 -radix hexadecimal} {/mp3_tb/dut/datapath/ID_EX/instruction_data[9]} {-height 16 -radix hexadecimal} {/mp3_tb/dut/datapath/ID_EX/instruction_data[8]} {-height 16 -radix hexadecimal} {/mp3_tb/dut/datapath/ID_EX/instruction_data[7]} {-height 16 -radix hexadecimal} {/mp3_tb/dut/datapath/ID_EX/instruction_data[6]} {-height 16 -radix hexadecimal} {/mp3_tb/dut/datapath/ID_EX/instruction_data[5]} {-height 16 -radix hexadecimal} {/mp3_tb/dut/datapath/ID_EX/instruction_data[4]} {-height 16 -radix hexadecimal} {/mp3_tb/dut/datapath/ID_EX/instruction_data[3]} {-height 16 -radix hexadecimal} {/mp3_tb/dut/datapath/ID_EX/instruction_data[2]} {-height 16 -radix hexadecimal} {/mp3_tb/dut/datapath/ID_EX/instruction_data[1]} {-height 16 -radix hexadecimal} {/mp3_tb/dut/datapath/ID_EX/instruction_data[0]} {-height 16 -radix hexadecimal}} /mp3_tb/dut/datapath/ID_EX/instruction_data
add wave -noupdate -radix hexadecimal /mp3_tb/dut/datapath/ID_EX/sr1_data
add wave -noupdate -radix hexadecimal /mp3_tb/dut/datapath/ID_EX/sr2_data
add wave -noupdate -radix hexadecimal /mp3_tb/dut/datapath/ID_EX/control_data
add wave -noupdate -radix hexadecimal /mp3_tb/dut/datapath/EX_MEM/reset
add wave -noupdate -radix hexadecimal /mp3_tb/dut/datapath/EX_MEM/load
add wave -noupdate -radix hexadecimal /mp3_tb/dut/datapath/EX_MEM/instruction_in
add wave -noupdate -radix hexadecimal /mp3_tb/dut/datapath/EX_MEM/sr1_in
add wave -noupdate -radix hexadecimal /mp3_tb/dut/datapath/EX_MEM/aluval_in
add wave -noupdate -radix hexadecimal /mp3_tb/dut/datapath/EX_MEM/control_in
add wave -noupdate -radix hexadecimal /mp3_tb/dut/datapath/EX_MEM/instruction_out
add wave -noupdate -radix hexadecimal /mp3_tb/dut/datapath/EX_MEM/sr1_out
add wave -noupdate -radix hexadecimal /mp3_tb/dut/datapath/EX_MEM/aluval_out
add wave -noupdate -radix hexadecimal /mp3_tb/dut/datapath/EX_MEM/control_out
add wave -noupdate -radix hexadecimal /mp3_tb/dut/datapath/MEM_WB/reset
add wave -noupdate -radix hexadecimal /mp3_tb/dut/datapath/MEM_WB/load
add wave -noupdate -radix hexadecimal /mp3_tb/dut/datapath/MEM_WB/instruction_in
add wave -noupdate -radix hexadecimal /mp3_tb/dut/datapath/MEM_WB/rdata_in
add wave -noupdate -radix hexadecimal /mp3_tb/dut/datapath/MEM_WB/aluval_in
add wave -noupdate -radix hexadecimal /mp3_tb/dut/datapath/MEM_WB/control_in
add wave -noupdate -radix hexadecimal /mp3_tb/dut/datapath/MEM_WB/instruction_out
add wave -noupdate -radix hexadecimal /mp3_tb/dut/datapath/MEM_WB/rdata_out
add wave -noupdate -radix hexadecimal /mp3_tb/dut/datapath/MEM_WB/aluval_out
add wave -noupdate -radix hexadecimal /mp3_tb/dut/datapath/MEM_WB/control_out
add wave -noupdate -radix hexadecimal /mp3_tb/dut/datapath/MEM_WB/instruction_data
add wave -noupdate -radix hexadecimal /mp3_tb/dut/datapath/MEM_WB/rdata_data
add wave -noupdate -radix hexadecimal /mp3_tb/dut/datapath/MEM_WB/aluval_data
add wave -noupdate -radix hexadecimal /mp3_tb/dut/datapath/MEM_WB/control_data
add wave -noupdate -radix hexadecimal /mp3_tb/dut/datapath/pc/load
add wave -noupdate -radix hexadecimal /mp3_tb/dut/datapath/pc/in
add wave -noupdate -radix hexadecimal /mp3_tb/dut/datapath/pc/out
add wave -noupdate -radix hexadecimal /mp3_tb/dut/datapath/pcmux/sel
add wave -noupdate -radix hexadecimal /mp3_tb/dut/datapath/pcmux/a
add wave -noupdate -radix hexadecimal /mp3_tb/dut/datapath/pcmux/b
add wave -noupdate -radix hexadecimal /mp3_tb/dut/datapath/pcmux/f
add wave -noupdate -radix hexadecimal /mp3_tb/dut/datapath/pc/data
add wave -noupdate -radix hexadecimal /mp3_tb/dut/datapath/alu/aluop
add wave -noupdate -radix hexadecimal -childformat {{{/mp3_tb/dut/datapath/alu/a[15]} -radix hexadecimal} {{/mp3_tb/dut/datapath/alu/a[14]} -radix hexadecimal} {{/mp3_tb/dut/datapath/alu/a[13]} -radix hexadecimal} {{/mp3_tb/dut/datapath/alu/a[12]} -radix hexadecimal} {{/mp3_tb/dut/datapath/alu/a[11]} -radix hexadecimal} {{/mp3_tb/dut/datapath/alu/a[10]} -radix hexadecimal} {{/mp3_tb/dut/datapath/alu/a[9]} -radix hexadecimal} {{/mp3_tb/dut/datapath/alu/a[8]} -radix hexadecimal} {{/mp3_tb/dut/datapath/alu/a[7]} -radix hexadecimal} {{/mp3_tb/dut/datapath/alu/a[6]} -radix hexadecimal} {{/mp3_tb/dut/datapath/alu/a[5]} -radix hexadecimal} {{/mp3_tb/dut/datapath/alu/a[4]} -radix hexadecimal} {{/mp3_tb/dut/datapath/alu/a[3]} -radix hexadecimal} {{/mp3_tb/dut/datapath/alu/a[2]} -radix hexadecimal} {{/mp3_tb/dut/datapath/alu/a[1]} -radix hexadecimal} {{/mp3_tb/dut/datapath/alu/a[0]} -radix hexadecimal}} -subitemconfig {{/mp3_tb/dut/datapath/alu/a[15]} {-height 16 -radix hexadecimal} {/mp3_tb/dut/datapath/alu/a[14]} {-height 16 -radix hexadecimal} {/mp3_tb/dut/datapath/alu/a[13]} {-height 16 -radix hexadecimal} {/mp3_tb/dut/datapath/alu/a[12]} {-height 16 -radix hexadecimal} {/mp3_tb/dut/datapath/alu/a[11]} {-height 16 -radix hexadecimal} {/mp3_tb/dut/datapath/alu/a[10]} {-height 16 -radix hexadecimal} {/mp3_tb/dut/datapath/alu/a[9]} {-height 16 -radix hexadecimal} {/mp3_tb/dut/datapath/alu/a[8]} {-height 16 -radix hexadecimal} {/mp3_tb/dut/datapath/alu/a[7]} {-height 16 -radix hexadecimal} {/mp3_tb/dut/datapath/alu/a[6]} {-height 16 -radix hexadecimal} {/mp3_tb/dut/datapath/alu/a[5]} {-height 16 -radix hexadecimal} {/mp3_tb/dut/datapath/alu/a[4]} {-height 16 -radix hexadecimal} {/mp3_tb/dut/datapath/alu/a[3]} {-height 16 -radix hexadecimal} {/mp3_tb/dut/datapath/alu/a[2]} {-height 16 -radix hexadecimal} {/mp3_tb/dut/datapath/alu/a[1]} {-height 16 -radix hexadecimal} {/mp3_tb/dut/datapath/alu/a[0]} {-height 16 -radix hexadecimal}} /mp3_tb/dut/datapath/alu/a
add wave -noupdate -radix hexadecimal /mp3_tb/dut/datapath/alu/b
add wave -noupdate -radix hexadecimal /mp3_tb/dut/datapath/alu/f
add wave -noupdate -radix hexadecimal /mp3_tb/dut/datapath/adj6/in
add wave -noupdate -radix hexadecimal /mp3_tb/dut/datapath/adj6/out
add wave -noupdate -radix hexadecimal /mp3_tb/dut/datapath/regfilemux/sel
add wave -noupdate -radix hexadecimal /mp3_tb/dut/datapath/regfilemux/a
add wave -noupdate -radix hexadecimal /mp3_tb/dut/datapath/regfilemux/b
add wave -noupdate -radix hexadecimal /mp3_tb/dut/datapath/regfilemux/f
add wave -noupdate -radix hexadecimal /mp3_tb/dut/datapath/regfile/load
add wave -noupdate -radix hexadecimal /mp3_tb/dut/datapath/regfile/in
add wave -noupdate -radix hexadecimal /mp3_tb/dut/datapath/regfile/src_a
add wave -noupdate -radix hexadecimal /mp3_tb/dut/datapath/regfile/src_b
add wave -noupdate -radix hexadecimal /mp3_tb/dut/datapath/regfile/dest
add wave -noupdate -radix hexadecimal /mp3_tb/dut/datapath/regfile/reg_a
add wave -noupdate -radix hexadecimal /mp3_tb/dut/datapath/regfile/reg_b
add wave -noupdate -radix hexadecimal -childformat {{{/mp3_tb/dut/datapath/regfile/data[7]} -radix hexadecimal} {{/mp3_tb/dut/datapath/regfile/data[6]} -radix hexadecimal} {{/mp3_tb/dut/datapath/regfile/data[5]} -radix hexadecimal} {{/mp3_tb/dut/datapath/regfile/data[4]} -radix hexadecimal} {{/mp3_tb/dut/datapath/regfile/data[3]} -radix hexadecimal} {{/mp3_tb/dut/datapath/regfile/data[2]} -radix hexadecimal} {{/mp3_tb/dut/datapath/regfile/data[1]} -radix hexadecimal} {{/mp3_tb/dut/datapath/regfile/data[0]} -radix hexadecimal}} -expand -subitemconfig {{/mp3_tb/dut/datapath/regfile/data[7]} {-height 16 -radix hexadecimal} {/mp3_tb/dut/datapath/regfile/data[6]} {-height 16 -radix hexadecimal} {/mp3_tb/dut/datapath/regfile/data[5]} {-height 16 -radix hexadecimal} {/mp3_tb/dut/datapath/regfile/data[4]} {-height 16 -radix hexadecimal} {/mp3_tb/dut/datapath/regfile/data[3]} {-height 16 -radix hexadecimal} {/mp3_tb/dut/datapath/regfile/data[2]} {-height 16 -radix hexadecimal} {/mp3_tb/dut/datapath/regfile/data[1]} {-height 16 -radix hexadecimal} {/mp3_tb/dut/datapath/regfile/data[0]} {-height 16 -radix hexadecimal}} /mp3_tb/dut/datapath/regfile/data
add wave -noupdate -radix hexadecimal /mp3_tb/dut/datapath/cc/load
add wave -noupdate -radix hexadecimal /mp3_tb/dut/datapath/cc/in
add wave -noupdate -radix hexadecimal /mp3_tb/dut/datapath/cc/out
add wave -noupdate -radix hexadecimal /mp3_tb/dut/datapath/cc/data
add wave -noupdate -radix hexadecimal /mp3_tb/dut/datapath/cccomp/in
add wave -noupdate -radix hexadecimal /mp3_tb/dut/datapath/cccomp/cc
add wave -noupdate -radix hexadecimal /mp3_tb/dut/datapath/cccomp/branch_enable
add wave -noupdate -radix hexadecimal /mp3_tb/dut/datapath/adj9/in
add wave -noupdate -radix hexadecimal /mp3_tb/dut/datapath/adj9/out
add wave -noupdate -radix hexadecimal /mp3_tb/dut/datapath/alumux_srca/sel
add wave -noupdate -radix hexadecimal -childformat {{{/mp3_tb/dut/datapath/alumux_srca/a[15]} -radix hexadecimal} {{/mp3_tb/dut/datapath/alumux_srca/a[14]} -radix hexadecimal} {{/mp3_tb/dut/datapath/alumux_srca/a[13]} -radix hexadecimal} {{/mp3_tb/dut/datapath/alumux_srca/a[12]} -radix hexadecimal} {{/mp3_tb/dut/datapath/alumux_srca/a[11]} -radix hexadecimal} {{/mp3_tb/dut/datapath/alumux_srca/a[10]} -radix hexadecimal} {{/mp3_tb/dut/datapath/alumux_srca/a[9]} -radix hexadecimal} {{/mp3_tb/dut/datapath/alumux_srca/a[8]} -radix hexadecimal} {{/mp3_tb/dut/datapath/alumux_srca/a[7]} -radix hexadecimal} {{/mp3_tb/dut/datapath/alumux_srca/a[6]} -radix hexadecimal} {{/mp3_tb/dut/datapath/alumux_srca/a[5]} -radix hexadecimal} {{/mp3_tb/dut/datapath/alumux_srca/a[4]} -radix hexadecimal} {{/mp3_tb/dut/datapath/alumux_srca/a[3]} -radix hexadecimal} {{/mp3_tb/dut/datapath/alumux_srca/a[2]} -radix hexadecimal} {{/mp3_tb/dut/datapath/alumux_srca/a[1]} -radix hexadecimal} {{/mp3_tb/dut/datapath/alumux_srca/a[0]} -radix hexadecimal}} -subitemconfig {{/mp3_tb/dut/datapath/alumux_srca/a[15]} {-height 16 -radix hexadecimal} {/mp3_tb/dut/datapath/alumux_srca/a[14]} {-height 16 -radix hexadecimal} {/mp3_tb/dut/datapath/alumux_srca/a[13]} {-height 16 -radix hexadecimal} {/mp3_tb/dut/datapath/alumux_srca/a[12]} {-height 16 -radix hexadecimal} {/mp3_tb/dut/datapath/alumux_srca/a[11]} {-height 16 -radix hexadecimal} {/mp3_tb/dut/datapath/alumux_srca/a[10]} {-height 16 -radix hexadecimal} {/mp3_tb/dut/datapath/alumux_srca/a[9]} {-height 16 -radix hexadecimal} {/mp3_tb/dut/datapath/alumux_srca/a[8]} {-height 16 -radix hexadecimal} {/mp3_tb/dut/datapath/alumux_srca/a[7]} {-height 16 -radix hexadecimal} {/mp3_tb/dut/datapath/alumux_srca/a[6]} {-height 16 -radix hexadecimal} {/mp3_tb/dut/datapath/alumux_srca/a[5]} {-height 16 -radix hexadecimal} {/mp3_tb/dut/datapath/alumux_srca/a[4]} {-height 16 -radix hexadecimal} {/mp3_tb/dut/datapath/alumux_srca/a[3]} {-height 16 -radix hexadecimal} {/mp3_tb/dut/datapath/alumux_srca/a[2]} {-height 16 -radix hexadecimal} {/mp3_tb/dut/datapath/alumux_srca/a[1]} {-height 16 -radix hexadecimal} {/mp3_tb/dut/datapath/alumux_srca/a[0]} {-height 16 -radix hexadecimal}} /mp3_tb/dut/datapath/alumux_srca/a
add wave -noupdate -radix hexadecimal /mp3_tb/dut/datapath/alumux_srca/b
add wave -noupdate -radix hexadecimal /mp3_tb/dut/datapath/alumux_srca/f
add wave -noupdate -radix hexadecimal /mp3_tb/dut/datapath/alumux_srcb/sel
add wave -noupdate -radix hexadecimal /mp3_tb/dut/datapath/alumux_srcb/a
add wave -noupdate -radix hexadecimal /mp3_tb/dut/datapath/alumux_srcb/b
add wave -noupdate -radix hexadecimal /mp3_tb/dut/datapath/alumux_srcb/f
add wave -noupdate /mp3_tb/dut/datapath/sr1mux/sel
add wave -noupdate /mp3_tb/dut/datapath/sr1mux/a
add wave -noupdate /mp3_tb/dut/datapath/sr1mux/b
add wave -noupdate /mp3_tb/dut/datapath/sr1mux/f
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {949683 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 332
configure wave -valuecolwidth 217
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
WaveRestoreZoom {390720 ps} {523984 ps}
