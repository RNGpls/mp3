import lc3b_types::*;

module IFID_latch
(
	input clk,
	input reset,
	input load,
	input lc3b_word pc_in,
	input lc3b_word instruction_in,
	input lc3b_control_word control_in,
	output lc3b_word pc_out,
	output lc3b_word instruction_out,
	output lc3b_control_word control_out
);

lc3b_word pc_data;
lc3b_word instruction_data;
lc3b_control_word control_data;

initial begin
	pc_data = 16'h0000;
	instruction_data = 16'h0000;
	control_data = 1'b0;
end

always_ff @ (posedge clk or posedge reset) begin
	if (reset == 1) begin
		pc_data <= 16'h0000;
		instruction_data <= 16'h0000;
		control_data <= 1'b0;
	end
	else if (load == 1) begin
		pc_data <= pc_in;
		instruction_data <= instruction_in;
		control_data <= control_in;
	end
end

always_comb begin
	pc_out = pc_data;
	instruction_out = instruction_data;
	control_out = control_data;
end

endmodule : IFID_latch