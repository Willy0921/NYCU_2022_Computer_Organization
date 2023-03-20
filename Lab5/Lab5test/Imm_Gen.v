`timescale 1ns/1ps

module Imm_Gen(
    input      [31:0] instr_i,
    output reg [31:0] Imm_Gen_o
);

wire    [7-1:0] opcode;
wire    [2:0]   func3;
wire    [3-1:0] Instr_field;

assign opcode = instr_i[6:0];

integer i;

/* Write your code HERE */
always@(*) begin
    case(opcode)
        7'b0110011:     // R-type
            Imm_Gen_o <= 0;
        7'b0010011,7'b0000011,7'b1100111: // I-type (addi,lw,jalr)
            Imm_Gen_o <= {{21{instr_i[31]}}, instr_i[30:20]};
        7'b0100011:     // S-type (sw)
            Imm_Gen_o <= {{21{instr_i[31]}}, instr_i[30:25], instr_i[11:7]};
        7'b1100011:     // B-type (branch)
            Imm_Gen_o <= {{21{instr_i[31]}}, instr_i[7],instr_i[30:25], instr_i[11:8]};
        7'b1101111:     // J-type (jal)
            Imm_Gen_o <= {{12{instr_i[31]}}, instr_i[19:12],instr_i[20], instr_i[30:21]};
    endcase
end

endmodule
