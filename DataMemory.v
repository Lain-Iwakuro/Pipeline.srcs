`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2022/07/05 15:34:12
// Design Name: 
// Module Name: DataMemory
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


module DataMemory(reset, clk, Address, Write_data, Read_data, MemRead, MemWrite, led, digi);
	input reset, clk;
	input [31:0] Address, Write_data;
	input MemRead, MemWrite;
	output [31:0] Read_data;
	output reg [7:0] led;
	output reg [11:0] digi; 
	
	parameter RAM_SIZE = 256;
	parameter RAM_SIZE_BIT = 8;
	
	reg [31:0] RAM_data[RAM_SIZE - 1: 0];
	assign Read_data = MemRead? ((Address == 32'h4000000c)? {24'b0, led}: 
		(Address == 32'h40000010)? {20'b0, digi}: 
		RAM_data[Address[RAM_SIZE_BIT + 1:2]]): 32'h00000000;
	
	integer i;
	always @(posedge reset or posedge clk)
		if (reset) begin
			for (i = 0; i < RAM_SIZE; i = i + 1)
				RAM_data[i] <= 32'h00000000;
			led <= 7'b0;
			digi <= 12'b0;
		end
		else if (MemWrite)
		case (Address)
		32'h4000000c: led <= Write_data[7:0];
		32'h40000010: digi <= Write_data[11:0];
		default: RAM_data[Address[RAM_SIZE_BIT + 1:2]] <= Write_data;
		endcase
endmodule
