import lc3b_types::*;

module mp1
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

/* Instantiate MP 0 top level blocks here */
logic [1:0] pcmux_sel;
logic load_pc;

logic load_ir;
logic load_regfile;
logic load_mar;
logic load_mdr;
logic load_cc;
logic storemux_sel;
logic [1:0] alumux_sel;
logic [1:0] regfilemux_sel;
logic marmux_sel;
logic mdrmux_sel;
logic branch_enable;
logic imm5_enable;

lc3b_opcode opcode;
lc3b_aluop aluop;


datapath datapath
(
	.clk,
	/* control signals */
   .pcmux_sel,
   .load_pc,

    /* declare more ports here */
	.load_ir,
	.load_regfile,
	.load_mar,
	.load_mdr,
	.load_cc,
	
	.storemux_sel,
	.alumux_sel,
	.regfilemux_sel,
	.marmux_sel,
	.mdrmux_sel,
	
	.mem_rdata,
	.aluop,
	
	.mem_address,
	.mem_wdata,
	
	.opcode,
	.imm5_enable,
	.branch_enable
);

control control
(
	.clk,
	.opcode,
	.imm5_enable,
	.branch_enable,
	.pcmux_sel,
	.storemux_sel,
	.alumux_sel,
	.regfilemux_sel,
	.marmux_sel,
	.mdrmux_sel,
	.load_pc,
	.load_ir,
	.load_mdr,
	.load_mar,
	.load_cc,
	.load_regfile,
	.aluop,
	
	.mem_resp,
	.mem_read,
	.mem_write,
	.mem_byte_enable
);

endmodule : mp1
