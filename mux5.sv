module mux5 #(parameter width = 16)
(
	input logic [2:0] sel,
	input [width-1:0] a, b, c, d, e,
	output logic [width-1:0] f
);

always_comb
begin
	if (sel == 2'b00)
		f = a;
	else if(sel == 2'b01)
		f = b;
	else if(sel == 2'b10)
		f = c;
	else if(sel == 2'b11)
		f = d;
	else
		f = e;
end

endmodule : mux5