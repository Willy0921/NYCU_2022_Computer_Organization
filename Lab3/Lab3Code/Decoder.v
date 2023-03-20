`timescale 1ns/1ps

module Decoder(
	input	[32-1:0] 	instr_i,
	output wire			ALUSrc,
	output wire			RegWrite,
	output wire			Branch,
	output wire [2-1:0]	ALUOp
	);
	
//Internal Signals
wire	[7-1:0]		opcode;
wire 	[3-1:0]		funct3;
wire	[3-1:0]		Instr_field;
wire	[9-1:0]		Ctrl_o;

/* Write your code HERE */
reg alusrc, branch, regwrite;
reg [1:0] aluop;
assign opcode = instr_i[6:0];
assign funct3 = instr_i[14:12];
assign ALUSrc = alusrc;
assign RegWrite = regwrite;
assign Branch = branch;
assign ALUOp = aluop;
always@ (*) begin
	case(opcode)
		7'b0110011: begin
			alusrc <= 0;
			regwrite <= 1;
			branch <= 0;
			aluop <= 2'b10;
			end
		7'b0000011: begin
			alusrc <= 1;
			regwrite <= 1;
			branch <= 0;
			aluop <= 2'b00;
			end
		7'b0100011: begin
			alusrc <= 1;
			regwrite <= 0;
			branch <= 0;
			aluop <= 2'b00;
			end
		7'b1100011: begin
			alusrc <= 0;
			regwrite <= 0;
			branch <= 1;
			aluop <= 2'b01;
			end
	endcase
end
endmodule






                    
                    
