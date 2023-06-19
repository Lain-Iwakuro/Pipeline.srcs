`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2022/07/05 15:34:12
// Design Name: 
// Module Name: ALU
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


module ALU(in1, in2, ALUOp, Sign, out, zero);
	input [31:0] in1, in2;
	input [3:0] ALUOp;
	input Sign;
	output [31:0] out;
	output zero;
	
    wire [31:0] o_sum;
    wire [31:0] o_dif;
    wire [31:0] o_and;
    wire [31:0] o_or;
    wire [31:0] o_xor;
    wire [31:0] o_sll;
    wire [31:0] o_srl;
    wire [31:0] o_sra;
    wire [31:0] o_slt;

    assign o_sum = in1 + in2;
    assign o_dif = in1 - in2;
    assign o_and = in1 & in2;
    assign o_or = in1 | in2;
    assign o_xor = in1 ^ in2;
    assign o_sll = in2 << in1;
    assign o_srl = in2 >> in1;
    assign o_sra = ($signed(in2)) >>> in1;
    assign o_slt = {31'b0, (Sign & ((~o_xor[31] & o_dif[31]) | (o_xor[31] & in1[31])))
        | (~Sign & ((~o_xor[31] & o_dif[31]) | (o_xor[31] & in2[31])))};

    assign out = (ALUOp == 4'b1)?o_sum:
        (ALUOp == 4'b0010)?o_dif:
        (ALUOp == 4'b0011)?o_and:
        (ALUOp == 4'b0100)?o_or:
        (ALUOp == 4'b0101)?o_xor:
        (ALUOp == 4'b0110)?~o_or:
        (ALUOp == 4'b0111)?o_sll:
        (ALUOp == 4'b1000)?o_srl:
        (ALUOp == 4'b1001)?o_sra:
        (ALUOp == 4'b1010)?o_slt: 
        (ALUOp == 4'b1011)?{31'b0, ~(|o_xor)}: 32'b0;

    assign zero = ~(|out);
	
endmodule
