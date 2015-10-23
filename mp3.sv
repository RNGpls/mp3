import lc3b_types::*;

module mp3
(
    input clk,

    /* Memory signals */
    input mem_resp,
    input lc3b_word mem_rdata,
    output mem_read,
    output mem_write,
    output lc3b_mem_wmask mem_byte_enable,
    output lc3b_word mem_address,
    output lc3b_word mem_wdata
);

lc3b_word instruction;

datapath datapath
(
	/* inputs */
	.clk,
	.mem_resp,
	.mem_rdata,

	/* outputs */
	.mem_byte_enable,
	.mem_address,
	.mem_wdata,
	.instruction
);

control control
(
	.clk,
	.instruction
);

endmodule : mp1