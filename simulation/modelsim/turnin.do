onerror {resume}
add list -hex -notrig -width 21 /mp1_tb/mem_address
add list -hex -width 10 /mp1_tb/mem_write
add list -hex -notrig -width 10 /mp1_tb/mem_byte_enable
add list -hex -notrig -width 10 /mp1_tb/mem_wdata
configure list -usestrobe 0
configure list -strobestart {0 ps} -strobeperiod {0 ps}
configure list -usesignaltrigger 1
configure list -delta all
configure list -signalnamewidth 0
configure list -datasetprefix 0
configure list -namelimit 5
