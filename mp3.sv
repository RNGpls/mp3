import lc3b_types::*;

module mp3
(
    input clk,

     /* Port A */
    input logic resp_a,
    input logic [15:0] rdata_a,
    output logic [15:0] address_a,

    /* Port B */
    input logic resp_b,
    input logic [15:0] rdata_b,
    output logic read_b,
    output logic write_b,
    output logic [15:0] address_b,
    output logic [15:0] wdata_b
);

lc3b_word instruction;
lc3b_control_word control;

datapath datapath
(
	/* inputs */
	.clk,
	.imem_resp(resp_a),
	.imem_rdata(rdata_a),
	.dmem_resp(resp_b),
	.dmem_rdata(rdata_b),
	.control,

	/* outputs */
	//.mem_byte_enable,
	.imem_address(address_a),
	.dmem_address(address_b),
	.dmem_wdata(wdata_b),
	.instruction,
	.dmem_read(read_b),
	.dmem_write(write_b)
);

control_rom control_rom
(
	.control,
	.instruction
);

endmodule : mp3