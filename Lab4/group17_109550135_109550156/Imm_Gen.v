
`timescale 1ns/1ps

module Imm_Gen(
    input  [31:0] instr_i,
    output reg[31:0] Imm_Gen_o
);

//Internal Signals
wire    [7-1:0] opcode;
wire    [2:0]   func3;
wire    [3-1:0] Instr_field;

assign opcode = instr_i[6:0];
assign func3  = instr_i[14:12];

integer i;

/* Write your code HERE */
always@(*) begin
    case(opcode)
        7'b0010011: begin                   //addi
            for (i = 11; i < 32; i++) begin
                if (instr_i[31] == 1) begin
                    Imm_Gen_o[i] <= 1;
                end else begin
                    Imm_Gen_o[i] <= 0;
                end
            end
            Imm_Gen_o[11:0] <= instr_i[31:20];
        end
        7'b0000011: begin                   //lw
            for (i = 11; i < 32; i++) begin
                if (instr_i[31] == 1) begin
                    Imm_Gen_o[i] <= 1;
                end else begin
                    Imm_Gen_o[i] <= 0;
                end
            end
            Imm_Gen_o[11:0] <= instr_i[31:20];
        end
        7'b0100011: begin                   //sw
            for (i = 12; i < 32; i++) begin
                if (instr_i[31] == 1) begin
                    Imm_Gen_o[i] <= 1;
                end else begin
                    Imm_Gen_o[i] <= 0;
                end
            end
            Imm_Gen_o[11:5] <= instr_i[31:25];
            Imm_Gen_o[4:0] <= instr_i[11:7];
        end
        7'b1100011: begin                   //branch
            for (i = 13; i < 32; i++) begin
                if (instr_i[31] == 1) begin
                    Imm_Gen_o[i] <= 1;
                end else begin
                    Imm_Gen_o[i] <= 0;
                end
            end
            Imm_Gen_o[12:0] <= {instr_i[31], instr_i[7], instr_i[30:25], instr_i[11:8], 1'b0};
        end
        7'b1101111: begin                   //jal
            for (i = 21; i < 32; i++) begin
                if (instr_i[31] == 1) begin
                    Imm_Gen_o[i] <= 1;
                end else begin
                    Imm_Gen_o[i] <= 0;
                end
            end
            Imm_Gen_o[20:0] <= {instr_i[31], instr_i[19:12], instr_i[20], instr_i[30:21], 1'b0};
        end
        7'b1100111: begin                   //jalr
            for (i = 11; i < 32; i++) begin
                if (instr_i[31] == 1) begin
                    Imm_Gen_o[i] <= 1;
                end else begin
                    Imm_Gen_o[i] <= 0;
                end
            end
            Imm_Gen_o[11:0] <= instr_i[31:20]; 
        end
    endcase
end

endmodule
