import lc3b_types::*;

module datapath
(
   /* inputs */
	input clk,
	input imem_resp,
	input lc3b_word imem_rdata,
	input dmem_resp,
	input lc3b_word dmem_rdata,
	input lc3b_control_word control,

	/* outputs */
	//output lc3b_mem_wmask mem_byte_enable,
	output lc3b_word imem_address,
	output lc3b_word dmem_address,
	output lc3b_word dmem_wdata,
	output lc3b_word instruction,
	output logic dmem_read,
	output logic dmem_write
);

/* mini control signals */
logic isbr;
logic resetPreNZP;

/*IF signals*/
lc3b_word pc_plus2_out;
lc3b_word br_add_out;
lc3b_word pcmux_out;
lc3b_word pc_out;

logic nextLoad;
logic br_enable;

assign nextLoad = imem_resp; //TODO
assign imem_address = pc_out;


/*ID signals*/
lc3b_word id_instruction;
lc3b_control_word id_control;
lc3b_reg id_sr1;
lc3b_reg id_sr2;
lc3b_reg id_dest;
lc3b_reg sr2mux_out;
lc3b_word id_sr1_out;
lc3b_word id_sr2_out;
lc3b_word id_pc;
lc3b_nzp gencc_out;
lc3b_nzp cc_out;

logic cccomp_out;

assign instruction = imem_rdata;
assign id_sr1 = id_instruction[8:6];
assign id_dest = id_instruction[11:9];
assign id_sr2 = id_instruction[2:0];
assign br_enable = cccomp_out & isbr;

/*EX signals*/
lc3b_word ex_instruction;
lc3b_control_word ex_control;
lc3b_word alumuxa_out;
lc3b_word alumuxb_out;
lc3b_offset6 ex_offset6;
lc3b_word adj6_out;
//lc3b_opcode ex_opcode;
logic resetEX2;
lc3b_word ex_pc;
lc3b_word ex_sr1_out;
lc3b_word ex_sr2_out;
lc3b_word alu_out;

assign ex_offset6 = ex_instruction[5:0];
//assign ex_opcode = lc3b_opcode'(ex_instruction[15:12]);

/*MEM signals*/
lc3b_word mem_instruction;
lc3b_control_word mem_control;
lc3b_word mem_sr2_out;
lc3b_word mem_alu_out;
lc3b_opcode mem_opcode;
lc3b_word mem_pc;

assign dmem_address = mem_alu_out;
assign dmem_wdata = mem_sr2_out;
assign dmem_read = mem_control.mem_read;
assign dmem_write = mem_control.mem_write;

assign mem_opcode = lc3b_opcode'(mem_instruction[15:12]);

/*WB signals*/
lc3b_word wb_instruction;
lc3b_control_word wb_control;
lc3b_opcode wb_opcode;
lc3b_word wb_alu_out;
lc3b_word wb_rdata;
lc3b_reg wb_dest;
lc3b_word regfilemux_out;
lc3b_offset9 wb_offset9;
lc3b_word adj9_out;
lc3b_word wb_pc;

assign wb_opcode = lc3b_opcode'(wb_instruction[15:12]);
assign wb_dest = wb_instruction[11:9];
assign wb_offset9 = wb_instruction[8:0];

/*mini control*/
always_comb
begin 
	
	if(wb_opcode == op_br && wb_instruction != 16'h0000) begin
		isbr = 1;
		resetPreNZP = 1;
	end
	else begin
		isbr = 0;
		resetPreNZP = 0;
	end
/*
	if(e_opcode == op_br && br_enable == 1 && id_instruction != 16'h0000)
		resetPreNZP = 1;
	else
		resetPreNZP = 0;
*/
	if(mem_opcode == op_jmp && ex_instruction != 16'h0000)
		resetEX2 = 1;
	else
		resetEX2 = 0;

end

/* Starting Datapath */

mux2 pcmux
(
	.sel(br_enable),
	.a(pc_plus2_out),
	.b(br_add_out),
	.f(pcmux_out)
);

register #(.width(16)) pc
(
	.clk,
	.load(nextLoad),
	.in(pcmux_out),
	.out(pc_out)
);

plus2 #(.width(16)) plus2
(
	.in(pc_out),
	.out(pc_plus2_out)
);

br_add br_add
(
	.a(wb_pc),
	.b(adj9_out),
	.out(br_add_out)
);



/* Not needed. Instruction memory feeds directly into IF_ID latch.
ir ir
(
);
*/

/* 
 * IF/ID
 */
IFID_latch IF_ID
(
	.clk,
	.reset(1'b0),
	.load(nextLoad),
	.pc_in(pc_out),
	.instruction_in(imem_rdata),
	.control_in(control),
	.pc_out(id_pc),
	.instruction_out(id_instruction),
	.control_out(id_control)
);

mux2 #(.width(3)) sr2mux
(
	.sel(id_control.sr2mux_sel),
	.a(id_sr2),
	.b(id_dest),
	.f(sr2mux_out)
);

regfile regfile
(
	.clk,
	.load(wb_control.load_regfile), //we need the write signal for value we are writing and not that of current instruction
	.in(regfilemux_out),
	.src_a(id_sr1),
	.src_b(sr2mux_out),
	.dest(wb_dest),
	.reg_a(id_sr1_out),
	.reg_b(id_sr2_out)
);

gencc gencc
(
    .in(regfilemux_out),
    .out(gencc_out)
);

register #(.width(3)) cc
(
    .clk,
    .load(wb_control.load_cc),
    .in(gencc_out),
    .out(cc_out)
);

cccomp cccomp
(
	.in(cc_out),
	.cc(wb_dest),
	.branch_enable(cccomp_out)
);

/* 
 * ID/EX
 */
IDEX_latch ID_EX
(
	.clk,
	.reset(resetPreNZP),
	.load(nextLoad),
	.pc_in(id_pc),
	.instruction_in(id_instruction), 
	.sr1_in(id_sr1_out), 
	.sr2_in(id_sr2_out), 
	.control_in(id_control), 
	.pc_out(ex_pc), 
	.instruction_out(ex_instruction),
	.sr1_out(ex_sr1_out),
	.sr2_out(ex_sr2_out),
	.control_out(ex_control)
);

adj #(.width(6)) adj6
(
	.in(ex_offset6),
	.out(adj6_out)
);

mux2 alumux_srca
(
	.sel(ex_control.alumux_sela[0]),
	.a(ex_sr1_out),
	.b(ex_pc),
	.f(alumuxa_out)
);

mux2 alumux_srcb
(
	.sel(ex_control.alumux_selb[0]),
	.a(ex_sr2_out),
	.b(adj6_out),
	.f(alumuxb_out)
);

alu alu
(
	.aluop(ex_control.aluop),
	.a(alumuxa_out),
	.b(alumuxb_out),
	.f(alu_out)
);


/* 
 * EX/MEM
 */
EXMEM_latch EX_MEM
(
	.clk,
	.reset(resetPreNZP),
	.load(nextLoad),
	.pc_in(ex_pc),
	.instruction_in(ex_instruction),
	.sr2_in(ex_sr2_out),
   .aluval_in(alu_out),
	.control_in(ex_control),
	.pc_out(mem_pc),
   .instruction_out(mem_instruction),
   .sr2_out(mem_sr2_out),
   .aluval_out(mem_alu_out),
   .control_out(mem_control)
);


/* 
 * MEM/WB
 */
MEMWB_latch MEM_WB
(
	.clk,
	.reset(1'b0),
	.load(nextLoad),
	.pc_in(mem_pc),
	.instruction_in(mem_instruction),
	.rdata_in(dmem_rdata),
	.aluval_in(mem_alu_out),
	.control_in(mem_control),
	.pc_out(wb_pc),
	.instruction_out(wb_instruction),
	.rdata_out(wb_rdata),
	.aluval_out(wb_alu_out),
	.control_out(wb_control)
);

adj #(.width(9)) adj9
(
	.in(wb_offset9),
	.out(adj9_out)
);


mux2 regfilemux
(
	.sel(wb_control.regfilemux_sel[0]),
	.a(wb_alu_out),
	.b(wb_rdata),
	.f(regfilemux_out)
);

endmodule : datapath