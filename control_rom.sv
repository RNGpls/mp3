import lc3b_types::*;

module control_rom
(
	input lc3b_word instruction,
	output lc3b_control_word  control
);


logic bit5; 
/*logic bit11; 
logic bit0; 
logic bit4;*/
lc3b_opcode opcode;

assign opcode = lc3b_opcode'(instruction[15:12]);
/*assign bit0 = instruction[0];
assign bit4 = instruction[4];*/
assign bit5 = instruction[5];
/*assign bit11 = instruction[11];*/

always_comb
begin
	// IF
	// ID
	control.sr2mux_sel = 0;
	// EX
	control.aluop = alu_pass;
	control.alumux_sela = 0;
	control.alumux_selb = 3'b000;
	// MEM
	control.mem_read = 0;
	control.mem_write = 0;
	/*control.wdatamux_sel = 2'b00;
	control.mem_byte_enable = 2'b11;
	control.load_mdr = 0;
	control.tempRegLoad = 0;*/
	// WB
	control.regfilemux_sel = 3'b000;
	control.load_regfile = 0;
	control.load_cc = 0;
	
	/*//JUMPING
	control.jumpSignal = 0;
	control.backUpPC = 0;
	
	//TRAP
	control.isTrap = 0;
	
	//MEM SKIP
	control.forcedNOP = 0;*/
		
	case(opcode)
		op_add: begin
			control.alumux_sela = 3'b000;
			control.aluop = alu_add;
			control.load_regfile = 1;
			control.regfilemux_sel = 3'b000;
			control.load_cc = 1;
			
			if(bit5 == 0) begin
				control.alumux_selb = 3'b000;
			end
			else begin
				control.alumux_selb = 3'b010;
			end
		end
		
		op_and: begin
			control.alumux_sela = 3'b000;
			control.aluop = alu_and;
			control.load_regfile = 1;
			control.regfilemux_sel = 3'b000;
			control.load_cc = 1;
			
			if(bit5 == 0) begin
				control.alumux_selb = 3'b000;
			end
			else begin
				control.alumux_selb = 3'b010;
			end
		end
		
		op_not: begin
			control.alumux_sela = 3'b000;
			control.aluop = alu_not;
			control.regfilemux_sel = 3'b000;
			control.load_regfile = 1;
			control.load_cc = 1;
		end
/*		
		op_ldb:begin
			control.alumux_sela = 3'b000;
			control.alumux_selb = 3'b110; 
			control.aluop = alu_add;			
			control.mem_read = 1;
			control.regfilemux_sel = 3'b001; 
			control.load_regfile = 1;
			control.load_cc = 1;
			if(bit0 == 0)
				control.mem_byte_enable = 2'b01;
			else
				control.mem_byte_enable = 2'b10;
		end
*/		
		op_ldr: begin
			control.alumux_sela = 3'b000;
			control.alumux_selb = 3'b001; 
			control.aluop = alu_add;			
			control.mem_read = 1;
			control.regfilemux_sel = 3'b001; 
			control.load_regfile = 1;
			control.load_cc = 1;
		end
		
		op_str: begin
			control.alumux_sela = 3'b000;
			control.alumux_selb = 3'b001; 
			control.aluop = alu_add;
			control.sr2mux_sel = 1; 
			control.mem_write = 1;
			control.wdatamux_sel = 3'b001;
		end
		
		/*op_stb: begin
			control.alumux_sela = 3'b000;
			control.alumux_selb = 3'b110; 
			control.aluop = alu_add;
			control.sr2mux_sel = 1; 
			control.mem_write = 1;
			control.wdatamux_sel = 3'b001;
			if(bit0 == 0)
				control.mem_byte_enable = 2'b01;
			else
				control.mem_byte_enable = 2'b10;
		end
		
		op_jmp: begin
			control.alumux_sela = 3'b000;
			control.aluop = alu_pass;
			control.jumpSignal = 1;
		end
		
		op_jsr: begin
			control.backUpPC = 1;
			if(bit11 == 0)
			begin
				control.alumux_sela = 3'b000;
				control.aluop = alu_pass;
				control.jumpSignal = 1;
				control.regfilemux_sel = 3'b010;
				control.load_regfile = 1;			
			end
			else
			begin
				control.aluop = alu_add;
				control.alumux_sela = 3'b100;
				control.jumpSignal = 1;
				control.regfilemux_sel = 3'b010;
				control.alumux_selb = 3'b011;
				control.load_regfile = 1;
			end
		end
		
		op_lea: begin
			control.aluop = alu_add;
			control.alumux_sela = 3'b100;
			control.alumux_selb = 3'b100;
			control.load_regfile = 1;
			control.regfilemux_sel = 3'b000;
		end
		
		op_shf: begin
		
		control.load_regfile = 1;
		control.regfilemux_sel = 0;
		control.load_cc = 1;
		control.alumux_selb = 3'b101;
		
			if(bit4 == 0)
				control.aluop = alu_sll;
			else if(bit5 == 0)
				control.aluop = alu_srl;
			else
				control.aluop = alu_sra;
		end
		
		op_trap: begin
			control.alumux_sela = 3'b010;
			control.aluop = alu_pass;
			control.regfilemux_sel = 3'b010;
			control.load_regfile = 1;
			control.backUpPC = 1;
			control.isTrap = 1;
			control.mem_read = 1;
		end
		
		op_ldi: begin
			control.alumux_sela = 3'b000;
			control.alumux_selb = 3'b001; 
			control.aluop = alu_add;			
			control.mem_read = 1;
			control.tempRegLoad = 1;
			//control.regfilemux_sel = 3'b001; 
			//control.load_regfile = 1;
			//control.load_cc = 1;
		end
		
		op_sti: begin
			control.alumux_sela = 3'b000;
			control.alumux_selb = 3'b001; 
			control.aluop = alu_add;
			//control.sr2mux_sel = 1; 
			control.mem_read = 1;
			control.tempRegLoad = 1;
			//control.wdatamux_sel = 1;
		end*/
		
		default: 
		begin
			control = 0; 
		end
		
	endcase
end
endmodule : control_rom