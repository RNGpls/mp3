import lc3b_types::*;

module datapath
(
   /* inputs */
	input clk,
	input mem_resp,
	input lc3b_word mem_rdata, 
	input lc3b_control_word control,

	/* outputs */
	output lc3b_mem_wmask mem_byte_enable,
	output lc3b_word mem_address,
	output lc3b_word mem_wdata,
	output lc3b_word instruction
);

/*IF signals*/
logic pcmux_sel;
lc3b_word pc_plus2_out;
lc3b_word br_add_out;
lc3b_word pcmux_out;
lc3b_word pc_out;
lc3b_word adj9_out;
lc3b_offset9 id_offset9;
logic nextLoad;
logic br_enable;

assign nextLoad = iResp & ( ~ (dResp ^ ismem) ); //TODO

assign mem_address = pc_out;

/*ID signals*/
lc3b_word id_instruction;
lc3b_opcode id_opcode;
lc3b_reg id_dest;
lc3b_reg id_nzp;
lc3b_reg sr1;
lc3b_offset9 id_offset9;
lc3b_reg sr2;
lc3b_word id_pc;
//lc3b_word idexInstruction;
//lc3b_control_word idexControlWord; 

assign instruction = id_instruction;
assign id_opcode = lc3b_opcode'(id_instruction[15:12]);
assign id_dest = id_instruction[11:9];
assign id_nzp = id_instruction[11:9];
assign id_sr1 = id_instruction[8:6];
assign id_offset9 = id_instruction[8:0];
assign id_sr2 = id_instruction[2:0];
assign br_enable = isbr & cccomp_out;

/*EX signals*/

/*MEM signals*/

/*WB signals*/

/*ALU control*/
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
		if(mem_aluval[0] == 1)
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
	.sel(pcmux_sel),
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
	.instruction_in(mem_rdata),
	.pc_out(id_pc),
	.instruction_out(id_instruction)
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
	.in(regfilemux_out),
	.src_a(storemux_out),
	.src_b(id_sr2),
	.dest(id_dest),
	.reg_a(id_sr1_out),
	.reg_b(id_sr2_out)
);

mux2 #(.width(3)) storemux
(
	.sel(storemux_sel),
	.a(id_sr1),
	.b(id_dest),
	.f(storemux_out)
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
	.control_in(control), 
	.br_enable(br_enable), 

	.pc_out(ex_pc), 
	.instruction_out(ex_instruction),
	.sr1_out(ex_sr1_out),
	.sr2_out(ex_sr2_out),
	.control_out(ex_control),
	.br_enableOut(br_enableOut),
);

/* 
 * EX/MEM
 */
EXMEMlatch EX_MEM
(

);

/* 
 * MEM/WB
 */
MEMWBlatch MEM_WB
(

);

endmodule : datapath