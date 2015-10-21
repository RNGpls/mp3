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
logic [2:0] alumux_sel;
logic [1:0] regfilemux_sel;
logic [1:0] marmux_sel;
logic [1:0] mdrmux_sel;
logic adjmux_sel;
logic destmux_sel;
logic zextmux_sel;
logic branch_enable;
logic imm5_enable;
logic jsr_enable;
logic [1:0] byte_enable;
logic dshf;
logic ashf;

lc3b_opcode opcode;
lc3b_aluop aluop;
logic byte_check;

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
	.adjmux_sel,
	.destmux_sel,

	.mem_rdata,
	.aluop,
	
	.byte_check,
	
	.mem_address,
	.mem_wdata,
	
	.opcode,
	.imm5_enable,
	.jsr_enable,
	.byte_enable,
	.dshf,
	.ashf,
	.branch_enable
);

control control
(
	.clk,
	.opcode,
	.imm5_enable,
	.jsr_enable,
	.branch_enable,
	.byte_enable,
	.dshf,
	.ashf,
	.pcmux_sel,
	.storemux_sel,
	.alumux_sel,
	.regfilemux_sel,
	.marmux_sel,
	.mdrmux_sel,
	.adjmux_sel,
	.destmux_sel,
	.load_pc,
	.load_ir,
	.load_mdr,
	.load_mar,
	.load_cc,
	.load_regfile,
	.aluop,
	.byte_check,
	
	.mem_resp,
	.mem_read,
	.mem_write,
	.mem_byte_enable
);

endmodule : mp1
