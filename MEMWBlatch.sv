import lc3b_types::*;

module MEMWB_latch
(
    input clk,
    input reset,
    input load,
    input lc3b_word pc_in,
    input lc3b_word instruction_in,
    input lc3b_word rdata_in,
    input lc3b_word aluval_in,
    input lc3b_control_word control_in,
    output lc3b_word pc_out,
    output lc3b_word instruction_out,
    output lc3b_word rdata_out,
    output lc3b_word aluval_out,
    output lc3b_control_word control_out
);

always_ff @ (posedge clk or posedge reset) begin
    if (reset == 1) begin
        pc_out <= 16'h0000;
        instruction_out <= 16'h0000;
        rdata_out <= 16'h0000;
        aluval_out <= 16'h0000;
        control_out <= 1'b0;
    end
    else if (load == 1) begin
        pc_out <= pc_in;
        instruction_out <= instruction_in;
        rdata_out <= rdata_in;
        aluval_out <= aluval_in;
        control_out <= control_in;
    end
end

endmodule // MEMWB_latch