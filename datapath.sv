import lc3b_types::*;

module datapath
(
    input clk,

    /* control signals */
    input logic [1:0] pcmux_sel,
    input load_pc,

    /* declare more ports here */
	 input load_ir,
	 input load_regfile,
	 input load_mar,
	 input load_mdr,
	 input load_cc,
	 
	 input storemux_sel,
	 input logic [1:0] alumux_sel,
	 input logic [1:0] regfilemux_sel,
	 input marmux_sel,
	 input mdrmux_sel,
	 
	 input lc3b_word mem_rdata,
	 input lc3b_aluop aluop,
	 
	 output lc3b_word mem_address,
	 output lc3b_word mem_wdata,
	 
	 output lc3b_opcode opcode,
	 output logic imm5_enable,
	 output logic branch_enable
);

/* declare internal signals */


lc3b_reg sr1;
lc3b_reg sr2;
lc3b_reg dest;
lc3b_reg storemux_out;

lc3b_word sr1_out;
lc3b_word sr2_out;

lc3b_imm5 imm5;
lc3b_offset6 offset6;
lc3b_offset9 offset9;

lc3b_word sext5_out;
lc3b_word adj6_out;
lc3b_word adj9_out;

lc3b_word pcmux_out;
lc3b_word alumux_out;
lc3b_word regfilemux_out;
lc3b_word marmux_out;
lc3b_word mdrmux_out;
lc3b_word alu_out;
lc3b_word pc_out;
lc3b_word br_add_out;
lc3b_word pc_plus2_out;

lc3b_nzp gencc_out;
lc3b_nzp cc_out;

/*
 * PC
 */
mux3 pcmux
(
    .sel(pcmux_sel),
    .a(pc_plus2_out),
    .b(br_add_out),
	 .c(sr1_out),
    .f(pcmux_out)
);

ir ir
(
	.clk(clk),
	.load(load_ir),
	.in(mem_wdata),
	.opcode(opcode),
	.dest(dest),
	.src1(sr1),
	.src2(sr2),
	.imm5_enable(imm5_enable),
	.imm5(imm5),
	.offset6(offset6),
	.offset9(offset9)
);

regfile regfile
(
	.clk,
   .load(load_regfile),
   .in(regfilemux_out),
   .src_a(storemux_out),
	.src_b(sr2),
	.dest,
   .reg_a(sr1_out),
	.reg_b(sr2_out)
);

/* Registers */

register pc
(
    .clk,
    .load(load_pc),
    .in(pcmux_out),	
    .out(pc_out)
);

register mar
(
	.clk,
	.load(load_mar),
	.in(marmux_out),
	.out(mem_address)
);

register mdr
(
	.clk,
	.load(load_mdr),
	.in(mdrmux_out),
	.out(mem_wdata)
);

register #(.width(3)) cc
(
	.clk,
	.load(load_cc),
	.in(gencc_out),
	.out(cc_out)
);

/* Mux */
mux2 #(.width(3)) storemux
(
	.sel(storemux_sel),
	.a(sr1),
	.b(dest),
	.f(storemux_out)
);

mux3 alumux
(
	.sel(alumux_sel),
	.a(sr2_out),
	.b(adj6_out),
	.c(sext5_out),
	.f(alumux_out)
);

mux3 regfilemux
(
	.sel(regfilemux_sel),
	.a(alu_out),
	.b(mem_wdata),
	.c(br_add_out),
	.f(regfilemux_out)
);

mux2 marmux
(
	.sel(marmux_sel),
	.a(alu_out),
	.b(pc_out),
	.f(marmux_out)
);

mux2 mdrmux
(
	.sel(mdrmux_sel),
	.a(alu_out),
	.b(mem_rdata),
	.f(mdrmux_out)
);

sext sext5
(
	.in(imm5),
	.out(sext5_out)
);

adj #(.width(6)) adj6
(
	.in(offset6),
	.out(adj6_out)
);

adj #(.width(9)) adj9
(
	.in(offset9),
	.out(adj9_out)
);

plus2 pc_plus2
(
	.in(pc_out),
	.out(pc_plus2_out)
);

gencc gencc
(
	.in(regfilemux_out),
	.out(gencc_out)
);

cccomp cccomp
(
	.in(dest),
	.cc(cc_out),
	.branch_enable(branch_enable)
);

br_add br_add
(
	.a(adj9_out),
	.b(pc_out),
	.out(br_add_out)
);

alu alu
(
	.aluop,
   .a(sr1_out),
	.b(alumux_out),
   .f(alu_out)
);

endmodule : datapath
