import lc3b_types::*;

module br_add #(parameter width = 16)
(
	input lc3b_word a,
	input lc3b_word b,
	output lc3b_word out
);

always_comb
begin
	out = a + b;
end

endmodule : br_add