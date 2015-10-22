import lc3b_types::*;

module EXMEM_latch
(
	input clk,
	input reset,
	input load,
	input lc3b_word pc_in,
	input lc3b_word instruction_in,
	input lc3b_word sr2_in,
	input lc3b_word aluval_in,
	input lc3b_control_word control_in,
	output lc3b_word pc_out,
	output lc3b_word instruction_out,
	output lc3b_word sr2_out,
	output lc3b_word aluval_out,
	output lc3b_control_word control_out
);

always_ff @ (posedge clk or posedge reset) begin
	if (reset == 1) begin
		pc_out <= 16'h0000;
		instruction_out <= 16'h0000;
		aluval_out <= 16'h0000;
		sr2_out <= 16'h0000;
		control_out <= 1'b0;
	end
	else if (load == 1) begin
		pc_out <= pc_in;
		instruction_out <= instruction_in;
		aluval_out <= aluval_in;
		sr2_out <= sr2_in;
		control_out <= control_in;
	end
end

endmodule // EXMEM_latch