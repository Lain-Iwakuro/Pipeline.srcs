`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2022/07/05 15:34:12
// Design Name: 
// Module Name: RegisterFile
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


module RegisterFile(reset, clk, RegWrite, Read_register1, Read_register2, Write_register, Write_data, Read_data1, Read_data2/*, Vv0, Va0, Vsp, Vra*/);
	input reset, clk;
	input RegWrite;
	input [4:0] Read_register1, Read_register2, Write_register;
	input [31:0] Write_data;
	output [31:0] Read_data1, Read_data2/*, Vv0, Va0, Vsp, Vra*/;
	
	reg [31:0] RF_data[31:1];
	
	assign Read_data1 = (RegWrite & (Read_register1 == Write_register))? Write_data: (Read_register1 == 5'b00000)? 32'h00000000: RF_data[Read_register1];
	assign Read_data2 = (RegWrite & (Read_register2 == Write_register))? Write_data: (Read_register2 == 5'b00000)? 32'h00000000: RF_data[Read_register2];
	/*
	assign Vv0 = RF_data[2];
	assign Va0 = RF_data[4];
	assign Vsp = RF_data[29];
	assign Vra = RF_data[31];
	*/
	
	integer i;
	always @(posedge reset or posedge clk)
		if (reset)
			for (i = 1; i < 32; i = i + 1)
				RF_data[i] <= 32'h00000000;
		else if (RegWrite && (Write_register != 5'b00000))
			RF_data[Write_register] <= Write_data;

endmodule
