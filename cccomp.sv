import lc3b_types::*;

module cccomp #(parameter width = 3)
(
	input lc3b_nzp in,
	input lc3b_nzp cc,
	output logic branch_enable
);

always_comb
begin
	branch_enable = (in[0] && cc[0]) || (in[1] && cc[1]) || (in[2] && cc[2]);
end

endmodule : cccomp