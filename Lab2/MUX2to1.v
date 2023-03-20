module MUX2to1(
	input      src1,
	input      src2,
	input	   select,
	output reg result
	);
/* Write your code HERE */
	always @(*) begin
		if (select) begin
			result <= src2;
		end else begin
			result <= src1;
		end
	end
endmodule