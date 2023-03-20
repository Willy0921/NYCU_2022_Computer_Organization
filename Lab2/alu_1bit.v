`timescale 1ns/1ps

module alu_1bit(
	input				src1,       //1 bit source 1  (input)
	input				src2,       //1 bit source 2  (input)
	input				less,       //1 bit less      (input)
	input 				Ainvert,    //1 bit A_invert  (input)
	input				Binvert,    //1 bit B_invert  (input)
	input 				cin,        //1 bit carry in  (input)
	input 	    [2-1:0] operation,  //2 bit operation (input)
	output reg          result,     //1 bit result    (output)
	output reg          cout        //1 bit carry out (output)
	);
		
/* Write your code HERE */
wire A, B, res;

MUX2to1 A_invert(
	.src1(src1),
	.src2(~src1),
	.select(Ainvert),
	.result(A)
);
MUX2to1 B_invert(
	.src1(src2),
	.src2(~src2),
	.select(Binvert),
	.result(B)
);
MUX4to1 op(
	.src1(A & B),
	.src2(A | B),
	.src3(A ^ B ^ cin),
	.src4(less),
	.select(operation),
	.result(res)
);
always@(*) begin
	result <= res;
	cout <= (A & B) | (A & cin) | (B & cin);
end
endmodule
