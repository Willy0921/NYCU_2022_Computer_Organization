
`timescale 1ns/1ps

module Decoder(
    input   [7-1:0]     instr_i,
    output              RegWrite,
    output              Branch,
    output              Jump,
    output              WriteBack1,
    output              WriteBack0,
    output              MemRead,
    output              MemWrite,
    output              ALUSrcA,
    output              ALUSrcB,
    output  [2-1:0]     ALUOp
);

/* Write your code HERE */
reg alusrc_A, alusrc_B, branch, regwrite, jump, write_back0, write_back1, mem_read, mem_write;
reg [1:0] aluop;
assign RegWrite = regwrite;
assign Branch = branch;
assign Jump = jump;
assign WriteBack1 = write_back1;
assign WriteBack0 = write_back0;
assign MemRead = mem_read;
assign MemWrite = mem_write;
assign ALUSrcA = alusrc_A;
assign ALUSrcB = alusrc_B;
assign ALUOp = aluop;
always@ (*) begin
	case(instr_i)
		7'b0110011: begin   //R-type
			regwrite <= 1;
			branch <= 0;
            jump <= 0;
            write_back1 <= 0;
            write_back0 <= 0;
            mem_read <= 0;
            mem_write <= 0;
            alusrc_A <= 0;
            alusrc_B <= 0;
			aluop <= 2'b10;
		end
        7'b0010011: begin   //addi
			regwrite <= 1;
			branch <= 0;
            jump <= 0;
            write_back1 <= 0;
            write_back0 <= 0;
            mem_read <= 0;
            mem_write <= 0;
            alusrc_A <= 0;
            alusrc_B <= 1;
			aluop <= 2'b00;
		end
		7'b0000011: begin   //lw
			regwrite <= 1;
			branch <= 0;
            jump <= 0;
            write_back1 <= 0;
            write_back0 <= 1;
            mem_read <= 1;
            mem_write <= 0;
            alusrc_A <= 0;
            alusrc_B <= 1;
			aluop <= 2'b00;
		end
		7'b0100011: begin   //sw
			regwrite <= 0;
			branch <= 0;
            jump <= 0;
            write_back1 <= 0;
            write_back0 <= 0;
            mem_read <= 0;
            mem_write <= 1;
            alusrc_A <= 0;
            alusrc_B <= 1;
			aluop <= 2'b00;
		end
		7'b1100011: begin   //branch
			regwrite <= 0;
			branch <= 1;
            jump <= 0;
            write_back1 <= 0;
            write_back0 <= 0;
            mem_read <= 0;
            mem_write <= 0;
            alusrc_A <= 0;
            alusrc_B <= 0;
			aluop <= 2'b01;
		end
        7'b1101111: begin   //jal
			regwrite <= 1;
			branch <= 0;
            jump <= 1;
            write_back1 <= 1;
            write_back0 <= 0;
            mem_read <= 0;
            mem_write <= 0;
            alusrc_A <= 0;
            alusrc_B <= 0;
			aluop <= 2'b00;
		end
        7'b1100111: begin   //jalr
			regwrite <= 1;
			branch <= 0;
            jump <= 1;
            write_back1 <= 1;
            write_back0 <= 0;
            mem_read <= 0;
            mem_write <= 0;
            alusrc_A <= 1;
            alusrc_B <= 0;
			aluop <= 2'b00;
		end
        default: begin
            regwrite <= 0;
			branch <= 0;
            jump <= 0;
            write_back1 <= 0;
            write_back0 <= 0;
            mem_read <= 0;
            mem_write <= 0;
            alusrc_A <= 0;
            alusrc_B <= 0;
			aluop <= 2'b00;
        end
	endcase
end

endmodule

