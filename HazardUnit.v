`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2022/07/05 15:34:12
// Design Name: 
// Module Name: HazardUnit
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


module HazardUnit(rs, rt, MemWr, IDEX_MemRd, IDEX_Rt, Jump, IDEX_Branch, Zero, PCKeep, IFIDKeep, IDEXKeep);
    input [4:0] rs;
    input [4:0] rt;
    input MemWr;
    input IDEX_MemRd;
    input [4:0] IDEX_Rt;
    input [1:0] Jump;
    input IDEX_Branch;
    input Zero;
    output reg PCKeep;
    output reg [1:0] IFIDKeep;
    output reg [1:0] IDEXKeep;

    always@(*) begin
        // load-use
        if(IDEX_MemRd && ((IDEX_Rt == rs) || (~MemWr && (IDEX_Rt == rt)))) begin
            PCKeep <= 1'b1;
            IFIDKeep <= 2'b01;
            IDEXKeep <= 2'b10;
        end
        // Jump
        else if(Jump != 2'b0) begin
            PCKeep <= 1'b0;
            IFIDKeep <= 2'b10;
            IDEXKeep <= 2'b00;
        end
        // Branch
        else if(IDEX_Branch & Zero) begin
            PCKeep <= 1'b0;
            IFIDKeep <= 2'b10;
            IDEXKeep <= 2'b10;
        end
        else begin
            PCKeep <= 1'b0;
            IFIDKeep <= 2'b00;
            IDEXKeep <= 2'b00;
        end
    end

endmodule
