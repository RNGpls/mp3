module mp3_tb;

timeunit 1ns;
timeprecision 1ns;

logic clk;

/* Port A */
logic [15:0] address_a;
logic resp_a;
logic [15:0] rdata_a;

/* Port B */
logic read_b;
logic write_b;
logic [15:0] address_b;
logic [15:0] wdata_b;
logic resp_b;
logic [15:0] rdata_b;

/* Clock generator */
initial clk = 0;
always #5 clk = ~clk;

mp3 dut
(
    .clk,
    .address_a,
    .resp_a,
    .rdata_a,
    .read_b,
    .write_b,
    .address_b,
    .wdata_b,
    .resp_b,
    .rdata_b
);

magic_memory_dp memory
(
    .clk,
    .read_a(1'b1),
    .write_a(1'b0),
    .address_a,
    .wmask_a(2'b00),
    .wdata_a(16'h0000),
    .resp_a,
    .rdata_a,
    .read_b,
    .write_b,
    .wmask_b(2'b11),
    .address_b,
    .wdata_b,
    .resp_b,
    .rdata_b
);

endmodule : mp3_tb
