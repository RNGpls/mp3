import lc3b_types::*; /* Import types defined in lc3b_types.sv */

module control
(
   /* Input and output port declarations */
	input clk,
	
	input lc3b_opcode opcode,
	input logic imm5_enable,
	input logic branch_enable,
	output logic [1:0] pcmux_sel,
	output logic storemux_sel,
	output logic [1:0] alumux_sel,
	output logic [1:0] regfilemux_sel,
	output logic marmux_sel,
	output logic mdrmux_sel,
	output logic load_pc,
	output logic load_ir,
	output logic load_mdr,
	output logic load_mar,
	output logic load_cc,
	output logic load_regfile,
	output lc3b_aluop aluop,
	
	input mem_resp,
	output logic mem_read,
	output logic mem_write,
	output lc3b_mem_wmask mem_byte_enable
);

enum int unsigned {
    /* List of states */
	 fetch1,
	 fetch2,
	 fetch3,
	 decode,
	 s_add,
	 s_add_imm,
	 s_add_reg,
	 s_and,
	 s_and_imm,
	 s_and_reg,
	 s_not,
	 s_br,
	 s_br_taken,
	 s_jmp,
	 calc_addr,
	 s_ldr1,
	 s_ldr2,
	 s_lea,
	 s_str1,
	 s_str2
} state, next_state;

always_comb
begin : state_actions
    /* Default output assignments */
	 load_pc = 1'b0;
	 load_ir = 1'b0;
	 load_regfile = 1'b0;
	 load_mar = 1'b0;
	 load_mdr = 1'b0;
	 load_cc = 1'b0;
	 pcmux_sel = 2'b00;
	 storemux_sel = 1'b0;
	 alumux_sel = 2'b00;
	 regfilemux_sel = 2'b00;
	 marmux_sel = 1'b0;
	 mdrmux_sel = 1'b0;
	 aluop = alu_add;
	 mem_read = 1'b0;
	 mem_write = 1'b0;
	 mem_byte_enable = 2'b11;
    /* Actions for each state */
	 
	 case(state)
		fetch1: begin
			/* MAR <- PC */
			marmux_sel = 1;
			load_mar = 1;
			
			/* PC <- PC + 2 */
			pcmux_sel = 2'b00;
			load_pc = 1;
		end
		fetch2: begin
			/* Read Memory */
			mem_read = 1;
			mdrmux_sel = 1;
			load_mdr = 1;
		end
		fetch3: begin
			load_ir = 1;
		end
		
		decode: /* Do nothing */;
		
		s_add_imm: begin
			aluop = alu_add;
			alumux_sel = 2'b10;
			load_regfile = 1;
			regfilemux_sel = 2'b00;
			load_cc = 1;
		end
		
		s_add_reg: begin
			/* DR <- SRA + SRB */
			aluop = alu_add;
			load_regfile = 1;
			regfilemux_sel = 2'b00;
			load_cc = 1;
		end
		
		s_and_imm: begin
			aluop = alu_and;
			alumux_sel = 2'b10;
			load_regfile = 1;
			load_cc = 1;
		end
		
		s_and_reg: begin
			/* DR <- A & B */
			aluop = alu_and;
			load_regfile = 1;
			load_cc = 1;
		end
		
		s_not: begin
			/* DR <- NOT(A) */
			aluop = alu_not;
			load_regfile = 1;
			load_cc = 1;
		end
		
		s_br: /*Do Nothing */;
		
		s_br_taken: begin
			/* PC <- PC + SEXT(IR[8:0] << 1) */
			pcmux_sel = 2'b01;
			load_pc = 1;
		end
		
		s_jmp: begin
			pcmux_sel = 2'b10;
			load_pc = 1;
		end
		
		calc_addr: begin
			/* MAR <- A + SEXT(IR[5:0] << 1) */
			alumux_sel = 2'b01;
			aluop = alu_add;
			load_mar = 1;
		end
		
		s_ldr1: begin
			/* MDR = M[MAR] */
			mdrmux_sel = 1;
			load_mdr = 1;
			mem_read = 1;
		end
		
		s_ldr2: begin
			/* DR <- MDR */
			regfilemux_sel = 2'b01;
			load_regfile = 1;
			load_cc = 1;
		end
		
		s_lea: begin
			regfilemux_sel= 2'b10;
			load_regfile = 1;
			load_cc = 1;
		end
		
		s_str1: begin
			/* MDR <- SR */
			storemux_sel = 1;
			aluop = alu_pass;
			load_mdr = 1;
		end
		
		s_str2: begin
			/* M[MAR] <- MDR */ 
			mem_write = 1;
		end
		
		default: /* Do Nothing */;
	endcase
end

always_comb
begin : next_state_logic
    /* Next state information and conditions (if any)
     * for transitioning between states */
	case(state)
		fetch1: next_state <= fetch2;

		fetch2: begin
			if (mem_resp == 0)
				next_state <= fetch2;
			else
				next_state <= fetch3;
		end
		
		fetch3: next_state <= decode;
		
		decode: begin
			case(opcode)
				op_add: next_state <= s_add;
				op_and: next_state <= s_and;
				op_not: next_state <= s_not;
				op_br: next_state <= s_br;
				op_jmp: next_state <= s_jmp;
				op_ldr: next_state <= calc_addr;
				op_lea: next_state <= s_lea;
				op_str: next_state <= calc_addr;
				default: next_state <= fetch1;
			endcase
		end
		
		s_add: begin
			if (imm5_enable)
				next_state <= s_add_imm;
			else
				next_state <= s_add_reg;
		end
		
		s_add_imm: next_state <= fetch1;
		s_add_reg: next_state <= fetch1;
		
		s_and: begin
			if	(imm5_enable)
				next_state <= s_and_imm;
			else
				next_state <= s_and_reg;
		end
		
		s_and_imm: next_state <= fetch1;
		s_and_reg: next_state <= fetch1;
		s_not: next_state <= fetch1;
		
		s_br: begin
			if(branch_enable == 1)
				next_state <= s_br_taken;
			else
				next_state <= fetch1;
		end
		
		s_br_taken: next_state <= fetch1;
		
		s_jmp: next_state <= fetch1;
		
		calc_addr: begin
			if (opcode == op_ldr)
				next_state <= s_ldr1;
			else
				next_state <= s_str1;
		end
		
		s_ldr1: begin
			if (mem_resp == 0)
				next_state <= s_ldr1;
			else
				next_state <= s_ldr2;
		end
		
		s_ldr2: next_state <= fetch1;
		
		s_lea: next_state <= fetch1;
		s_str1: next_state <= s_str2;
		
		s_str2: begin
			if (mem_resp == 0)
				next_state <= s_str2;
			else
				next_state <= fetch1;
		end
		default: next_state <= state;
	endcase
end

always_ff @(posedge clk)
begin: next_state_assignment
    /* Assignment of next state on clock edge */
	 state <= next_state;
end

endmodule : control
