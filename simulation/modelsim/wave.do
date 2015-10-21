onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -radix hexadecimal /mp1_tb/clk
add wave -noupdate -radix hexadecimal /mp1_tb/mem_write
add wave -noupdate -radix hexadecimal /mp1_tb/mem_byte_enable
add wave -noupdate -radix hexadecimal /mp1_tb/mem_address
add wave -noupdate -radix hexadecimal /mp1_tb/mem_rdata
add wave -noupdate -radix hexadecimal /mp1_tb/mem_wdata
add wave -noupdate -radix hexadecimal /mp1_tb/dut/datapath/regfile/clk
add wave -noupdate -radix hexadecimal /mp1_tb/dut/datapath/regfile/load
add wave -noupdate -radix hexadecimal /mp1_tb/dut/datapath/regfile/in
add wave -noupdate -radix hexadecimal /mp1_tb/dut/datapath/regfile/src_a
add wave -noupdate -radix hexadecimal /mp1_tb/dut/datapath/regfile/src_b
add wave -noupdate -radix hexadecimal /mp1_tb/dut/datapath/regfile/dest
add wave -noupdate -radix hexadecimal /mp1_tb/dut/datapath/regfile/reg_a
add wave -noupdate -radix hexadecimal /mp1_tb/dut/datapath/regfile/reg_b
add wave -noupdate -radix hexadecimal -childformat {{{/mp1_tb/dut/datapath/regfile/data[7]} -radix hexadecimal} {{/mp1_tb/dut/datapath/regfile/data[6]} -radix hexadecimal} {{/mp1_tb/dut/datapath/regfile/data[5]} -radix hexadecimal} {{/mp1_tb/dut/datapath/regfile/data[4]} -radix hexadecimal} {{/mp1_tb/dut/datapath/regfile/data[3]} -radix hexadecimal} {{/mp1_tb/dut/datapath/regfile/data[2]} -radix hexadecimal} {{/mp1_tb/dut/datapath/regfile/data[1]} -radix hexadecimal} {{/mp1_tb/dut/datapath/regfile/data[0]} -radix hexadecimal}} -expand -subitemconfig {{/mp1_tb/dut/datapath/regfile/data[7]} {-height 16 -radix hexadecimal} {/mp1_tb/dut/datapath/regfile/data[6]} {-height 16 -radix hexadecimal} {/mp1_tb/dut/datapath/regfile/data[5]} {-height 16 -radix hexadecimal} {/mp1_tb/dut/datapath/regfile/data[4]} {-height 16 -radix hexadecimal} {/mp1_tb/dut/datapath/regfile/data[3]} {-height 16 -radix hexadecimal} {/mp1_tb/dut/datapath/regfile/data[2]} {-height 16 -radix hexadecimal} {/mp1_tb/dut/datapath/regfile/data[1]} {-height 16 -radix hexadecimal} {/mp1_tb/dut/datapath/regfile/data[0]} {-height 16 -radix hexadecimal}} /mp1_tb/dut/datapath/regfile/data
add wave -noupdate -radix hexadecimal /mp1_tb/dut/datapath/mar/data
add wave -noupdate -radix hexadecimal /mp1_tb/dut/datapath/mdr/data
add wave -noupdate -radix hexadecimal /mp1_tb/dut/control/state
add wave -noupdate -radix hexadecimal /mp1_tb/dut/datapath/pc_out
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {26267335 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 391
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
WaveRestoreZoom {25398384 ps} {27600544 ps}
