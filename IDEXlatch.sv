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
    input br_enable,
    output lc3b_word pc_out,
    output lc3b_word instruction_out,
    output lc3b_word sr1_out,
    output lc3b_word sr2_out,
    output lc3b_control_word control_out,
    output logic br_enableOut
);

always_ff @ (posedge clk or posedge reset) begin
    if (reset == 1) begin
        pc_out <= 16'h0000;
        instruction_out <= 16'h0000;
        sr1_out <= 16'h0000;
        sr2_out <= 16'h0000;
        control_out <= 1'b0;
        br_enableOut <= 1'b0;
    end
    else if (load == 1) begin
        pc_out <= pc_in;
        instruction_out <= instruction_in;
        sr1_out <= sr1_in;
        sr2_out <= sr2_in;
        control_out <= control_in;
        br_enableOut <= br_enable;
    end
end

endmodule