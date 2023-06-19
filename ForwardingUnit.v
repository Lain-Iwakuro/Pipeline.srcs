`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2022/07/05 15:34:12
// Design Name: 
// Module Name: ForwardingUnit
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


module ForwardingUnit(IDEX_Rs, IDEX_Rt, EXMEM_RegWr, EXMEM_RegWrAddr, 
        MEMWB_RegWr, MEMWB_MemtoReg, MEMWB_RegWrAddr, EXMEM_Rt, Forwarding);
    input [4:0] IDEX_Rs;
    input [4:0] IDEX_Rt;
    input EXMEM_RegWr;
    input [4:0] EXMEM_RegWrAddr;
    input MEMWB_RegWr;
    input [1:0] MEMWB_MemtoReg;
    input [4:0] MEMWB_RegWrAddr;
    input [4:0] EXMEM_Rt;
    output reg [4:0] Forwarding;

    always @(*) begin
        if(EXMEM_RegWr && (EXMEM_RegWrAddr == IDEX_Rs)) Forwarding[1:0] <= 2'b01;
        else if(MEMWB_RegWr && (MEMWB_RegWrAddr == IDEX_Rs)) Forwarding[1:0] <= 2'b10;
        else Forwarding[1:0] <= 2'b00;
        if(EXMEM_RegWr && (EXMEM_RegWrAddr == IDEX_Rt)) Forwarding[3:2] <= 2'b01;
        else if(MEMWB_RegWr && (MEMWB_RegWrAddr == IDEX_Rt)) Forwarding[3:2] <= 2'b10;
        else Forwarding[3:2] <= 2'b00;
        if((MEMWB_MemtoReg == 2'b01) && (MEMWB_RegWrAddr == EXMEM_Rt)) Forwarding[4] <= 1'b1;
        else Forwarding[4] <= 1'b0;
    end

endmodule
