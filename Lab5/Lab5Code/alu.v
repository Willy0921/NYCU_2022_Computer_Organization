`timescale 1ns/1ps

module alu(
    input                   rst_n,         // negative reset            (input)
    input        [32-1:0]   src1,          // 32 bits source 1          (input)
    input        [32-1:0]   src2,          // 32 bits source 2          (input)
    input        [ 4-1:0]   ALU_control,   // 4 bits ALU control input  (input)
    output reg   [32-1:0]   result,        // 32 bits result            (output)
    output reg              zero         // 1 bit when the output is 0, zero must be set (output)
);

/* Write your code HERE */

wire less = 0;
wire [31:0] carry_out, res;
wire A31, B31;

assign A31 = (ALU_control[3]) ? ~src1[31] : src1[31];
assign B31 = (ALU_control[2]) ? ~src2[31] : src2[31];

alu_1bit bit0(src1[0], src2[0], A31 ^ B31 ^ carry_out[30], ALU_control[3], ALU_control[2], ALU_control[2], ALU_control[1:0], res[0], carry_out[0]);
alu_1bit bit31to1[31:1](src1[31:1], src2[31:1], less, ALU_control[3], ALU_control[2], carry_out[30:0], ALU_control[1:0], res[31:1], carry_out[31:1]);

always@ (*) begin
	
	case(ALU_control)
		4'b0011: result <= src1 ^ src2;		//xor
		4'b0100: result <= src1 << src2;	//sll
		4'b0101: result <= src1 >>> src2;	//sra
		default: result <= res;
	endcase

	if (result == 0) begin
		zero <= 1;
	end else begin
		zero <= 0;
	end
	
end
endmodule

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

module MUX2to1(
	input      src1,
	input      src2,
	input	   select,
	output reg result
	);
	always @(*) begin
		if (select) begin
			result <= src2;
		end else begin
			result <= src1;
		end
	end
endmodule