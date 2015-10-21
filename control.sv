import lc3b_types::*; /* Import types defined in lc3b_types.sv */

module control
(
   /* Input and output port declarations */
	input clk,
	
	input lc3b_opcode opcode,
	input logic imm5_enable,
	input logic jsr_enable,
	input logic branch_enable,
	input logic [1:0] byte_enable,
	input logic dshf,
	input logic ashf,
	output logic [1:0] pcmux_sel,
	output logic storemux_sel,
	output logic [2:0] alumux_sel,
	output logic [1:0] regfilemux_sel,
	output logic [1:0] marmux_sel,
	output logic [1:0] mdrmux_sel,
	output logic adjmux_sel,
	output logic destmux_sel,
	output logic load_pc,
	output logic load_ir,
	output logic load_mdr,
	output logic load_mar,
	output logic load_cc,
	output logic load_regfile,
	output lc3b_aluop aluop,
	output logic byte_check,
	
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
	 s_check_jsr,
	 s_jsr,
	 s_jsrr,
	 calc_byte_addr,
	 s_ldb1,
	 s_ldb2,
	 calc_addr,
	 s_ldi1,
	 s_ldi2,
	 s_ldi3,
	 s_ldi4,
	 s_ldr1,
	 s_ldr2,
	 s_lea,
	 s_shf,
	 s_stb1,
	 s_stb2,
	 s_sti1,
	 s_sti2,
	 s_sti3,
	 s_sti4,
	 s_str1,
	 s_str2,
	 s_trap1,
	 s_trap2,
	 s_trap3
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
	 alumux_sel = 3'b000;
	 regfilemux_sel = 2'b00;
	 marmux_sel = 2'b00;
	 mdrmux_sel = 1'b0;
	 adjmux_sel = 1'b0;
	 destmux_sel = 1'b0;
	 aluop = alu_add;
	 byte_check = 1'b0;
	 mem_read = 1'b0;
	 mem_write = 1'b0;
	 mem_byte_enable = 2'b11;
    /* Actions for each state */
	 
	 case(state)
		fetch1: begin
			/* MAR <- PC */
			marmux_sel = 2'b01;
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
			alumux_sel = 3'b010;
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
			alumux_sel = 3'b010;
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
		
		s_check_jsr: begin
			destmux_sel = 1'b1;
			regfilemux_sel = 2'b11;
			load_regfile = 1;
		end
		
		s_jsr: begin
			adjmux_sel = 1;
			pcmux_sel = 2'b01;
			load_pc = 1;
		end
		
		s_jsrr: begin
			pcmux_sel = 2'b10;
			load_pc = 1;
		end
		
		calc_byte_addr: begin
			alumux_sel = 3'b011;
			aluop = alu_add;
			load_mar = 1;
		end
		
		s_ldb1: begin
			mdrmux_sel = 1;
			load_mdr = 1;
			mem_read = 1;
		end
		
		s_ldb2: begin
			byte_check = 1;
			regfilemux_sel = 2'b01;
			load_regfile = 1;
			load_cc = 1;
		end
		
		calc_addr: begin
			/* MAR <- A + SEXT(IR[5:0] << 1) */
			alumux_sel = 3'b001;
			aluop = alu_add;
			load_mar = 1;
		end
		
		s_ldi1: begin
			mem_read = 1;
			mdrmux_sel = 1;
			load_mdr = 1;
		end
		
		s_ldi2: begin
			marmux_sel = 2'b10;
			load_mar = 1;
		end
		
		s_ldi3: begin
			mem_read = 1;
			mdrmux_sel = 1;
			load_mdr = 1;
		end
		
		s_ldi4: begin
			regfilemux_sel = 2'b01;
			load_regfile = 1;
			load_cc = 1;
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
		
		s_shf: begin
			alumux_sel = 3'b100;
			regfilemux_sel = 2'b00;
			load_regfile = 1;
			load_cc = 1;
			case(dshf)
				0: begin
					aluop = alu_sll;
				end
				1: begin
					if (ashf)
						aluop = alu_sra;
					else
						aluop = alu_srl;
				end
			endcase
		end
		
		s_stb1: begin
			storemux_sel = 1;
			aluop = alu_pass;
			load_mdr = 1;
			byte_check = 1;			
		end
		
		s_stb2: begin
			mem_byte_enable  = byte_enable;
			mdrmux_sel = 2'b10;
			load_mdr = 1;
			mem_write = 1;
		end
		
		s_sti1: begin
			mem_read = 1;
			mdrmux_sel = 2'b01;
			load_mdr = 1;
		end
		
		s_sti2: begin
			marmux_sel = 2'b10;
			load_mar = 1;
		end
		
		s_sti3: begin
			storemux_sel = 1;
			aluop = alu_pass;
			load_mdr = 1;
		end
		
		s_sti4: begin
			mem_write = 1;
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
		
		s_trap1: begin
			destmux_sel = 1;
			regfilemux_sel = 2'b11;
			load_regfile = 1;
			
			marmux_sel = 2'b11;
			load_mar = 1;
		end
		
		s_trap2: begin
			mem_read = 1;
			mdrmux_sel = 2'b01;
			load_mdr = 1;
		end
		
		s_trap3: begin
			pcmux_sel = 2'b11;
			load_pc = 1;
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
				op_br:  next_state <= s_br;
				op_jmp: next_state <= s_jmp;
				op_jsr: next_state <= s_check_jsr;
				op_ldb: next_state <= calc_byte_addr;
				op_ldi: next_state <= calc_addr;
				op_ldr: next_state <= calc_addr;
				op_lea: next_state <= s_lea;
				op_shf: next_state <= s_shf;
				op_stb: next_state <= calc_byte_addr;
				op_sti: next_state <= calc_addr;
				op_str: next_state <= calc_addr;
				op_trap: next_state <= s_trap1;
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
		
		s_check_jsr: begin
			if (jsr_enable == 1)
				next_state <= s_jsr;
			else
				next_state <= s_jsrr;
		end
		
		s_jsr: next_state <= fetch1;
		s_jsrr: next_state <= fetch1;
		
		calc_byte_addr: begin
			if (opcode == op_ldb)
				next_state <= s_ldb1;
			else
				next_state <= s_stb1;
		end
		
		s_ldb1: begin
			if (mem_resp == 0)
				next_state <= s_ldb1;
			else
				next_state <= s_ldb2;
		end
		
		s_ldb2: next_state <= fetch1;
		
		calc_addr: begin
			if (opcode == op_ldr)
				next_state <= s_ldr1;
			else if (opcode == op_str)
				next_state <= s_str1;
			else if (opcode == op_ldi)
				next_state <= s_ldi1;
			else if (opcode == op_sti)
				next_state <= s_sti1;
			else
				next_state <= state;
		end
		
		s_ldi1: begin
			if (mem_resp == 0)
				next_state <= s_ldi1;
			else
				next_state <= s_ldi2;
		end
		
		s_ldi2: next_state <= s_ldi3;
		
		s_ldi3: begin
			if (mem_resp == 0)
				next_state <= s_ldi3;
			else
				next_state <= s_ldi4;
		end
		
		s_ldi4: next_state <= fetch1;
		
		s_ldr1: begin
			if (mem_resp == 0)
				next_state <= s_ldr1;
			else
				next_state <= s_ldr2;
		end
		
		s_ldr2: next_state <= fetch1;
		
		s_lea: next_state <= fetch1;
		
		s_shf: next_state <= fetch1;
		
		s_stb1: next_state <= s_stb2;
		s_stb2: begin
			if (mem_resp == 0)
				next_state <= s_stb2;
			else
				next_state <= fetch1;
		end
		
		s_sti1: begin
			if (mem_resp == 0)
				next_state <= s_sti1;
			else
				next_state <= s_sti2;
		end
		
		s_sti2: begin
			next_state <= s_sti3;
		end
		
		s_sti3: next_state <= s_sti4;
		
		s_sti4: begin
			if (mem_resp == 0)
				next_state <= s_sti4;
			else
				next_state <= fetch1;
		end
		
		s_str1: next_state <= s_str2;
		
		s_str2: begin
			if (mem_resp == 0)
				next_state <= s_str2;
			else
				next_state <= fetch1;
		end
		
		s_trap1: next_state <= s_trap2;
		
		s_trap2: begin
			if (mem_resp == 0)
				next_state <= s_trap2;
			else
				next_state <= s_trap3;
		end
		
		s_trap3: next_state <= fetch1;
		
		default: next_state <= fetch1;
	endcase
end

always_ff @(posedge clk)
begin: next_state_assignment
    /* Assignment of next state on clock edge */
	 state <= next_state;
end

endmodule : control
