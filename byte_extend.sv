import lc3b_types::*;

module byte_extend #(parameter width = 16)
(
    input lc3b_word address, in,
	 input logic byte_check,
	 output logic [1:0] byte_enable,
    output lc3b_word out
);

always_comb
begin
	if(byte_check == 0)
		begin
			out = in;
			byte_enable = 2'b11;
		end
	else
		begin
			if(address[0] == 1)
				begin
					out = {in[15:8], 8'h00};
					byte_enable = 2'b10;
				end
			else
				begin
					out = {8'h00, in[7:0]};
					byte_enable = 2'b01;
				end
		end
end

endmodule : byte_extend
