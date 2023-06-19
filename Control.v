`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2022/07/05 15:34:12
// Design Name: 
// Module Name: Control
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module Control(OpCode, Funct, 
	Jump, Branch, RegWr, RegDst, 
	MemRd, RdByte, MemWr, MemtoReg, ALUSrc, 
    ExtOp, LuOp, ALUOp, Sign);
	input [5:0] OpCode;
	input [5:0] Funct;
	output [1:0] Jump; // 00-normal 10-j 11-jr
	output Branch; // 1-beq
	output RegWr; // 1-write
	output [1:0] RegDst; // 00-rt 01-rd 10-ra
	output MemRd; // 1-lw
    output RdByte; // if MemRd == 1, 0-lw 1-lb
	output MemWr; // 1-sw
	output [1:0] MemtoReg; // 00-alu 01-mem 10-pc+4
	output [1:0] ALUSrc; // 0:0-B 1-ImmExt // 1:0-A 1-shamt
	output ExtOp; // 1-sign 0-zero
	output LuOp;
    output reg [3:0] ALUOp;
    output Sign;
	
	// Your code below
	assign Jump = (OpCode == 6'h2 || OpCode == 6'h3)? 2'b10:
		(OpCode == 6'h0 && (Funct == 6'h8 || Funct == 6'h9))? 2'b01: 2'b0;
	assign Branch = (OpCode == 6'h4 || OpCode == 6'h5)? 1'b1: 1'b0;
	assign RegWr = (OpCode == 6'h2b || OpCode == 6'h4 || OpCode == 6'h5 || OpCode == 6'h2
		|| (OpCode == 6'b0 && Funct == 6'h8))? 1'b0: 1'b1;
	assign RegDst = (OpCode == 6'h3 || (OpCode == 6'h0 && Funct == 6'h9))? 2'b10:
		(OpCode == 6'h0)? 2'b01: 2'b0;
	assign MemRd = (OpCode == 6'h23 || OpCode == 6'h20)? 1'b1: 1'b0;
    assign RdByte = (OpCode == 6'h20)? 1'b1: 1'b0;
	assign MemWr = (OpCode == 6'h2b)? 1'b1: 1'b0;
	assign MemtoReg = (OpCode == 6'h23 || OpCode == 6'h20)? 2'b01: (OpCode == 6'h3 || (OpCode == 6'h0 && Funct == 6'h9))? 2'b10: 2'b0;
	assign ALUSrc[0] = (OpCode == 6'h0 || OpCode == 6'h4 || OpCode == 6'h5)? 1'b0: 1'b1;
	assign ALUSrc[1] = (OpCode == 6'h0 && (Funct == 6'h0 || Funct == 6'h2 || Funct == 6'h3))? 1'b1: 1'b0;
	assign ExtOp = (OpCode == 6'hc)? 1'b0: 1'b1;
	assign LuOp = (OpCode == 6'hf)? 1'b1: 1'b0;
    always @(*) begin
        case (OpCode)
        6'b0: case(Funct)
            6'h20: ALUOp <= 4'b0001; // add
            6'h21: ALUOp <= 4'b0001; // addu
            6'h22: ALUOp <= 4'b0010; // sub
            6'h23: ALUOp <= 4'b0010; // subu
            6'h24: ALUOp <= 4'b0011; // and
            6'h25: ALUOp <= 4'b0100; // or
            6'h26: ALUOp <= 4'b0101; // xor
            6'h27: ALUOp <= 4'b0110; // nor
            6'h0: ALUOp <= 4'b0111; // sll
            6'h2: ALUOp <= 4'b1000; // srl
            6'h3: ALUOp <= 4'b1001; // sra
            6'h2a: ALUOp <= 4'b1010; // slt
            6'h2b: ALUOp <= 4'b1010; // sltu
            default: ALUOp <= 4'b0;
        endcase
        6'h20: ALUOp <= 4'b0001; // lb
        6'h23: ALUOp <= 4'b0001; // lw
        6'h2b: ALUOp <= 4'b0001; // sw
        6'h08: ALUOp <= 4'b0001; // addi
        6'h09: ALUOp <= 4'b0001; // addiu
        6'hd: ALUOp <= 4'b0100; // ori
        6'hf: ALUOp <= 4'b0100; // lui
        6'hc: ALUOp <= 4'b0011; // andi
        6'ha: ALUOp <= 4'b1010; // slti
        6'hb: ALUOp <= 4'b1010; // sltiu
        6'h4: ALUOp <= 4'b0101; // beq
        6'h5: ALUOp <= 4'b1011; // bne
        default: ALUOp <= 4'b0;
        endcase
    end
    assign Sign = ~(((OpCode == 6'h0) & (Funct == 6'h21 | Funct == 6'h23 | Funct == 6'h2b))
        | OpCode == 6'h9 | OpCode == 6'hb);
	
endmodule
