
`timescale 1ns/1ps
/*instr[30,14:12]*/
module ALU_Ctrl(
    input       [4-1:0] instr,
    input       [2-1:0] ALUOp,
    output      [4-1:0] ALU_Ctrl_o
);
wire [2:0] func3;
assign func3 = instr[2:0];
/* Write your code HERE */
reg [4-1:0] ctl;
assign ALU_Ctrl_o = ctl;

always @(*) begin
	if(ALUOp == 2'b00) begin 			//lw,sw,addi
		ctl <= 4'b0010; 
	end	else if(ALUOp == 2'b01) begin 	//beq
		ctl <= 4'b0110; 
	end	else if(ALUOp == 2'b10) begin	//R-type
		case(func3)
			3'b000:begin				//add
				ctl <= 4'b0010;
				ctl[2] <= (instr[3] == 1 ? 1 : 0);//sub
			end
			3'b111: begin				//and
				ctl <= 4'b0000;
			end
			3'b110: begin				//or
				ctl <= 4'b0001;
			end	
			3'b010: begin				//slt
				ctl <= 4'b0111;	
			end
			default: begin
				ctl <= 4'b0000;
			end
		endcase
	end	
end	

endmodule

