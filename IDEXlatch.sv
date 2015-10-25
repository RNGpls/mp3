import lc3b_types::*;

module IDEX_latch
(
    input clk,
    input reset,
    input load,
    input lc3b_word pc_in,
    input lc3b_word instruction_in,
    input lc3b_word sr1_in,
    input lc3b_word sr2_in,
    input lc3b_control_word control_in,
    //input br_enable,
    output lc3b_word pc_out,
    output lc3b_word instruction_out,
    output lc3b_word sr1_out,
    output lc3b_word sr2_out,
    output lc3b_control_word control_out
    //output logic br_enableOut
);

lc3b_word pc_data;
lc3b_word instruction_data;
lc3b_word sr1_data;
lc3b_word sr2_data;
lc3b_control_word control_data;
//logic br_enable_data;

initial begin
	pc_data = 16'h0000;
	instruction_data = 16'h0000;
	sr1_data = 16'h0000;
	sr2_data = 16'h0000;
	control_data = 1'b0;
	//br_enable_data = 1'b0;
end

always_ff @ (posedge clk or posedge reset) begin
    if (reset == 1) begin
        pc_data <= 16'h0000;
        instruction_data <= 16'h0000;
        sr1_data <= 16'h0000;
        sr2_data <= 16'h0000;
        control_data <= 1'b0;
        //br_enable_data <= 1'b0;
    end
    else if (load == 1) begin
        pc_data <= pc_in;
        instruction_data <= instruction_in;
        sr1_data <= sr1_in;
        sr2_data <= sr2_in;
        control_data <= control_in;
        //br_enable_data <= br_enable;
    end
end

always_comb begin
	pc_out = pc_data;
	instruction_out = instruction_data;
	sr1_out = sr1_data;
	sr2_out = sr2_data;
	control_out = control_data;
	//br_enableOut = br_enable_data;
end

endmodule : IDEX_latch