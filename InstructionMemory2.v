`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2022/07/10 11:15:27
// Design Name: 
// Module Name: InstructionMemory2
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


module InstructionMemory2(Address, Instruction);
	input [31:0] Address;
	output reg [31:0] Instruction;
	
	always @(*)
		case (Address[9:2])
			// addi $a0[4], $zero[0], 5
			8'd0:    Instruction <= 32'b001000_00000_00100_0000000000000101;
			// xor $v0[2], $zero[0], $zero[0]
			8'd1:    Instruction <= 32'b000000_00000_00000_00010_00000_100110;
			// jal sum
			8'd2:    Instruction <= 32'b000011_00000000000000000000000100;
			// Loop:
			// beq $zero[0], $zero[0], Loop
			8'd3:    Instruction <= 32'b000100_00000_00000_1111111111111111;
			// sum:
			// addi $sp[29], $sp[29], -8
			8'd4:    Instruction <= 32'b001000_11101_11101_1111111111111000;
			// sw $ra[31], 4($sp[29])
			8'd5:    Instruction <= 32'b101011_11101_11111_0000000000000100;
			// sw $a0[4], 0($sp[29])
			8'd6:    Instruction <= 32'b101011_11101_00100_0000000000000000;
			// slti $t0[8], $a0[4], 1
			8'd7:    Instruction <= 32'b001010_00100_01000_0000000000000001;
			// beq $t0[8], $zero[0], L1
			8'd8:    Instruction <= 32'b000100_01000_00000_0000000000000010;
			// addi $sp[29], $sp[29], 8
			8'd9:    Instruction <= 32'b001000_11101_11101_0000000000001000;
			// jr $ra[31]
			8'd10:   Instruction <= 32'b000000_11111_00000_00000_00000_001000;
			// L1:
			// add $v0[4], $a0[2], $v0[4]
			8'd11:   Instruction <= 32'b000000_00100_00010_00010_00000_100000;
			// addi $a0[2], $a0[2], -1
			8'd12:   Instruction <= 32'b001000_00100_00100_1111111111111111;
			// jal sum
			8'd13:   Instruction <= 32'b000011_00000000000000000000000100;
			// lw $a0[2], 0($sp[29])
			8'd14:   Instruction <= 32'b100011_11101_00100_0000000000000000;
			// lw $ra[31], 4($sp[29])
			8'd15:   Instruction <= 32'b100011_11101_11111_0000000000000100;
			// addi $sp[29], $sp[29], 8
			8'd16:   Instruction <= 32'b001000_11101_11101_0000000000001000;
			// add $v0[2], $a0[4], $v0[2]
			8'd17:   Instruction <= 32'b000000_00100_00010_00010_00000_100000;
			// jr $ra[31]
			8'd18:   Instruction <= 32'b000000_11111_00000_00000_00000_001000;
			
			default: Instruction <= 32'h00000000;
		endcase
		
endmodule
