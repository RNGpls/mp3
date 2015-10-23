module adder(input [15:0] pc, input [15:0] brAddr, output logic [15:0] newPC);
always_comb
begin
	newPC = pc + brAddr;
end
endmodule

