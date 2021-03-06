import lc3b_types::*;

/*
 * ZEXT[n << 1]
 */
module zextsh #(parameter width = 8)
(
    input [width-1:0] in,
    output lc3b_word out
);

assign out = {7'b0000000, in, 1'b0};

endmodule : zextsh
