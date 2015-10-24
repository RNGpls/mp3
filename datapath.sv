import lc3b_types::*;

module datapath
(
   /* inputs */
	input clk,
	input imem_resp,
	//input lc3b_word imem_rdata,
	input dmem_resp,
	input lc3b_word dmem_rdata,
	input lc3b_control_word control,

	/* outputs */
	//output lc3b_mem_wmask mem_byte_enable,
	output lc3b_word imem_address,
	output lc3b_word dmem_address,
	output lc3b_word dmem_wdata,
	output lc3b_word instruction
);

/*IF signals*/
lc3b_word pc_plus2_out;
lc3b_word br_add_out;
lc3b_word pcmux_out;
lc3b_word pc_out;
lc3b_word adj9_out;
lc3b_offset9 id_offset9;
logic nextLoad;
logic br_enable;

assign nextLoad = iResp; //TODO
assign imem_address = pc_out;


/*ID signals*/
lc3b_word id_instruction;
lc3b_control_word id_control;
lc3b_opcode id_opcode;
lc3b_reg id_sr1;
lc3b_reg id_dest;
lc3b_reg sr1mux_out;
lc3b_reg id_nzp;
lc3b_reg id_sr1_out;
lc3b_offset9 id_offset9;
lc3b_reg id_sr2_out;
lc3b_word id_pc;
logic cccomp_out;

//lc3b_word idexInstruction;
//lc3b_control_word idexControlWord; 

assign instruction = id_instruction;
assign id_opcode = lc3b_opcode'(id_instruction[15:12]);
assign id_sr1 = id_instruction[8:6];
assign id_dest = id_instruction[11:9];
assign id_nzp = id_instruction[11:9];
assign id_offset9 = id_instruction[8:0];
assign id_sr2 = id_instruction[2:0];
assign br_enable = cccomp_out & isbr;

/*EX signals*/
lc3b_word ex_instruction;
lc3b_control_word ex_control;
lc3b_word alumuxa_out;
lc3b_word alumuxb_out;
lc3b_offset6 ex_offset6;
lc3b_word adj6_out;
logic br_enableOut;
lc3b_word regfilemux_out;
lc3b_word ex_rdata;

assign ex_offset6 = ex_instruction[5:0];

/*MEM signals*/
lc3b_word mem_insutruction;
lc3b_reg mem_sr1_out;
lc3b_word mem_alu_out;
lc3b_control_word mem_control;
lc3b_word mem_regfile;

assign dmem_address = mem_alu_out;
assign dmem_wdata = mem_sr1_out;
assign instruction = mem_instruction;

/*WB signals*/
lc3b_word wb_alu_out;
lc3b_word wb_regfile;
lc3b_word wb_rdata;

/*mini control*/
always_comb
begin 
	if(mem_opcode == op_str || mem_opcode == op_ldr || mem_opcode == op_ldi || mem_opcode == op_sti || mem_opcode == op_ldb || mem_opcode == op_stb || mem_opcode == op_trap)
		ismem = 1;
	else
		ismem = 0;
	
	if(id_opcode == op_br && id_instruction != 16'b0000000000000000)
		isbr = 1;
	else
		isbr = 0;
	
	if(mem_opcode == op_ldb || mem_opcode == op_stb)
	begin
		if(mem_alu_out[0] == 1)
			newMask = 2'b10;
		else
			newMask = 2'b01;
	end
	else	
		newMask = 2'b11;
	

	if(ex_opcode == op_br && br_enableOut == 1 && id_instruction != 16'b0000000000000000)
		resetID2 = 1;
	else
		resetID2 = 0;
		
	if(mem_opcode == op_jmp && ex_instruction != 16'b00000000000000000)
		resetEX2 = 1;
	else
		resetEX2 = 0;
	
	if(skipMemory == 1 && nextLoad == 0)
		temp = 1;
	else
		temp = 0;

end

/* Starting Datapath */

mux2 #(.width(1)) pcmux
(
	.sel(br_enableOut),
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

adder br_add
(
	.pc(pc_out),
	.brAddr(adj9_out),
	.newPC(br_add_out)
);



/* Not needed. Instruction memory feeds directly into IF_ID latch.
ir ir
(
);
*/

/* 
 * IF/ID
 */
IFIDlatch IF_ID
(
	.clk
	.reset(resetID2),
	.load(nextLoad)
	.pc_in(pc_out),
	.instruction_in(imem_rdata),
	.control_in(control),
	.pc_out(id_pc),
	.instruction_out(id_instruction),
	.control_out(id_control)
);

mux2 #(.width(3)) sr1mux
(
	.sel(id_control.sr1mux_sel),
	.a(id_sr1),
	.b(id_dest),
	.f(sr1mux_out)
);


adj #(.width(9)) adj9
(
	.in(id_offset9),
	.out(adj9_out)
);

regfile regfile
(
	.clk,
	.load(load_regfile),
	.in(wb_regfile),
	.src_a(sr1mux_out),
	.src_b(id_sr2),
	.dest(id_dest),
	.reg_a(id_sr1_out),
	.reg_b(id_sr2_out)
);

gencc gencc
(
    .in(regfilemux_out),
    .out(gencc_out)
);

registercc cc
(
    .clk,
    .load(wb_control.load_cc),
    .in(gencc_out),
    .out(cc_out)
);

cccomp cccomp
(
	.in(cc_out),
	.cc(id_nzp),
	.branch_enable(cccomp_out)
);

/* 
 * ID/EX
 */
IDEXlatch ID_EX
(
	.clk,
	.reset(resetEX2),
	.load(nextLoad),
	.pc_in(id_pc),
	.instruction_in(id_instruction), 
	.sr1_in(id_sr1_out), 
	.sr2_in(id_sr2_out), 
	.rdata_in(wb_rdata),
	.control_in(id_control), 
	.br_enable(br_enable), 
	.pc_out(ex_pc), 
	.instruction_out(ex_instruction),
	.sr1_out(ex_sr1_out),
	.sr2_out(ex_sr2_out),
	.rdata_out(ex_rdata),
	.control_out(ex_control),
	.br_enableOut(br_enableOut)
);

adj #(.width(6)) adj6
(
	.in(ex_offset6),
	.out(adj6_out)
);

mux2 alumux_srca
(
	.sel(ex_control.alumux_sela),
	.a(ex_sr1_out),
	.b(ex_pc),
	.f(alumuxa_out)
);

mux2 alumux_srcb
(
	.sel(ex_control.alumux_selb),
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

mux2 #(.width((3)),) regfilemux
(
	.sel(ex_control.regfilemux_sel),
	.a(alu_out),
	.b(ex_rdata),
	.f(regfilemux_out)
);

/* 
 * EX/MEM
 */
EXMEMlatch EX_MEM
(
	.clk,
	.reset,
	.load,
	.instruction_in(ex_instruction),
    .sr1_in(ex_sr1_out),
    .aluval_in(alu_out),
    .regfile_in(regfilemux_out),
	.control_in(ex_control),
    .instruction_out(mem_insutruction),
    .sr1_out(mem_sr1_out),
    .aluval_out(mem_alu_out),
    .regfile_out(mem_regfile),
    .control_out(mem_control)
);


/* 
 * MEM/WB
 */
MEMWBlatch MEM_WB
(
	.clk,
	.reset,
	.load,
	.rdata_in(dmem_rdata),
	.aluval_in(mem_alu_out),
	.regfile_in(mem_regfile),
	.rdata_out(wb_rdata)
	.aluval_out(wb_alu_out),
	.regfile_out(wb_regfile)
);

endmodule : datapath