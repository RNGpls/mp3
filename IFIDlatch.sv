import lc3b_types: *;

module IFID_latch
(
	input clk,
	input reset,
	input load,
	input lc3b_word pc_in,
	input lc3b_word instruction_in,
	output lc3b_word instruction_out
);

always_ff @ (posedge clk or posedge reset) begin
	if (reset == 1) begin
		pc_out <= 16'h0000;
		instruction_out <= 16'h0000;
	end
	else if (load == 1) begin
		pc_out <= pc_in;
		instruction_out <= instruction_in;
	end
end

endmodule