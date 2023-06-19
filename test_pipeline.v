`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2022/07/10 10:20:37
// Design Name: 
// Module Name: test_pipeline
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


module test_pipeline();
    reg reset;
	reg clk;
	
	Pipeline pipeline1(.reset(reset),.clk(clk));
	
	initial begin
		reset = 1;
		clk = 1;
		#100 reset = 0;
	end
	
	always #50 clk = ~clk;
endmodule
