module MUX4to1(
	input			src1,
	input			src2,
	input			src3,
	input			src4,
	input   [2-1:0] select,
	output reg		result
	);
	
	always @(*) begin
		case(select[1:0])
			2'b00: result = src1;
			2'b01: result = src2;
			2'b10: result = src3;
			2'b11: result = src4;
		endcase
	end
endmodule
