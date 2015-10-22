import lc3b_types: *;

module IFID_latch
(
	input clk,
	input reset,
	input load,
	input lc3b_word pc_in,
	input lc3b_word instruction_in,
	output lc3b_word pc_out,
	output lc3b_reg id_sr2,
	output lc3b_reg id_sr1,
	output lc3b_reg id_dest,
	output lc3b_nzp id_nzp,
	output lc3b_offset9 id_offset9
);

logic lc3b_word instruction_out;

assign id_sr2 = instruction_out[2:0];
assign id_dest = instruction_out[11:9];
assign id_sr1 = instruction_out[8:6];
assign id_nzp = instruction_out[11:9];
assign id_offset9 = instruction_out[8:0];

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