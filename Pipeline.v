`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2022/07/05 15:34:12
// Design Name: 
// Module Name: Pipeline
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


module Pipeline(reset, clk, sw, led, digi);
    input reset;
    input clk;
    input [3:0] sw;
    output [7:0] led;
    output [11:0] digi;

    //clk -> clk_o
    /*reg clk_o;
    always @(posedge reset or posedge clk) begin
        if(reset) begin 
            clk_o <= 1'b1;
        end
        else begin
            clk_o <= ~clk_o;
        end
    end*/
    wire clk_o;
    assign clk_o = clk;

    //--------------IF-----------------------
    reg [31:0] PC;
    wire [31:0] PCadd4;
    assign PCadd4 = PC + 32'd4;
    wire [1:0] Jump;
    wire [31:0] beq_addr;
    wire [31:0] j_addr;
    wire [31:0] jr_addr;
    wire [31:0] PC_new;
    wire IDEX_Branch;
    wire Zero;
    wire PCKeep;
    assign PC_new = (PCKeep == 1'b1)? PC: (Jump == 2'b10)? j_addr:
                    (Jump == 2'b01)? jr_addr: (IDEX_Branch & Zero)? beq_addr: PCadd4;
    wire [31:0] Inst;
    //InstructionMemory im(.Address(PC),.Instruction(Inst));
    //InstructionMemory2 im(.Address(PC),.Instruction(Inst));
    //InstructionMemory3 im(.Address(PC),.Instruction(Inst));
    InstructionMemory4 im(.Address(PC),.Instruction(Inst),.sw(sw));

    //--------------IF/ID-----------------------
    reg [63:0] IFID;
    wire [31:0] IFID_PCadd4;
    wire [31:0] IFID_Inst;
    assign IFID_PCadd4 = IFID[31:0];
    assign IFID_Inst = IFID[63:32];

    //--------------ID-----------------------
    wire [5:0] OpCode;
    assign OpCode = IFID_Inst[31:26];
    wire [4:0] rs;
    assign rs = IFID_Inst[25:21];
    wire [4:0] rt;
    assign rt = IFID_Inst[20:16];
    wire [4:0] rd;
    assign rd = IFID_Inst[15:11];
    wire [4:0] shamt;
    assign shamt = IFID_Inst[10:6];
    wire [5:0] Funct;
    assign Funct = IFID_Inst[5:0];
    wire [15:0] imm16;
    assign imm16 = IFID_Inst[15:0];

    // register file
    wire [31:0] Read_data1;
    wire [31:0] Read_data2;
    wire MEMWB_RegWr;
    wire [4:0] MEMWB_RegWrAddr;
    wire [31:0] WB_data;
    RegisterFile rf(.reset(reset),.clk(clk_o),.RegWrite(MEMWB_RegWr),.Read_register1(rs),.Read_register2(rt),
        .Write_register(MEMWB_RegWrAddr),.Write_data(WB_data),.Read_data1(Read_data1),.Read_data2(Read_data2)/*,.Vv0(v0v),.Va0(a0v),.Vsp(spv),.Vra(rav)*/);

    // Control
    //wire [1:0] Jump; // 00-normal/Branch 10-j_addr 01-jr_addr
	wire Branch; // 1-beq_addr
	wire RegWr; // 1-write
	wire [1:0] RegDst; // 00-rt 01-rd 10-ra
	wire MemRd; // 1-lw
    wire RdByte; // if MemRd == 1, 0-lw 1-lb
	wire MemWr; // 1-sw
	wire [1:0] MemtoReg; // 00-alu 01-mem 10-PC+4
	wire [1:0] ALUSrc; // 0:0-B 1-ImmExt // 1:0-A 1-shamt
	wire ExtOp; // 1-sign 0-zero
	wire LuOp;
    wire [3:0] ALUOp; // -------------------
    wire Sign;
    Control ct(.OpCode(OpCode),.Funct(Funct),.Jump(Jump),.Branch(Branch),
        .RegWr(RegWr),.RegDst(RegDst),.MemRd(MemRd),.RdByte(RdByte),.MemWr(MemWr),.MemtoReg(MemtoReg),
        .ALUSrc(ALUSrc),.ExtOp(ExtOp),.LuOp(LuOp),.ALUOp(ALUOp),.Sign(Sign));
    
    // jump target
    //wire [31:0] j_addr;
    assign j_addr = {IFID_PCadd4[31:28], IFID_Inst[25:0], 2'b0};
    //wire [31:0] jr_addr;
    assign jr_addr = Read_data1;

    // immediate extension
    wire [31:0] imm32;
    assign imm32 = (LuOp == 1'b1)? {imm16, 16'b0}: {{16{ExtOp & IFID_Inst[15]}}, imm16};

    //--------------ID/EX-----------------------
    reg [163:0] IDEX;
    wire [31:0] IDEX_PCadd4;
    wire [31:0] IDEX_Read_data1;
    wire [31:0] IDEX_Read_data2;
    wire [31:0] IDEX_ImmExt;
    wire [4:0] IDEX_Rs;
    wire [4:0] IDEX_Rt;
    wire [4:0] IDEX_Rd;
    wire [4:0] IDEX_shamt;
    wire IDEX_RegWr;
    wire [1:0] IDEX_MemtoReg;
    wire IDEX_MemWr;
    wire IDEX_MemRd;
    wire IDEX_RdByte;
    //wire IDEX_Branch;
    wire [1:0] IDEX_RegDst;
    wire [3:0] IDEX_ALUOp;
    wire [1:0] IDEX_ALUSrc;
    assign IDEX_PCadd4 = IDEX[31:0];
    assign IDEX_Read_data1 = IDEX[63:32];
    assign IDEX_Read_data2 = IDEX[95:64];
    assign IDEX_ImmExt = IDEX[127:96];
    assign IDEX_Rs = IDEX[132:128];
    assign IDEX_Rt = IDEX[137:133];
    assign IDEX_Rd = IDEX[142:138];
    assign IDEX_shamt = IDEX[147:143];
    assign IDEX_RegWr = IDEX[148];
    assign IDEX_MemtoReg = IDEX[150:149];
    assign IDEX_MemWr = IDEX[151];
    assign IDEX_MemRd = IDEX[152];
    assign IDEX_RdByte = IDEX[153];
    assign IDEX_Branch = IDEX[154];
    assign IDEX_RegDst = IDEX[156:155];
    assign IDEX_ALUOp = IDEX[160:157];
    assign IDEX_Sign = IDEX[161];
    assign IDEX_ALUSrc = IDEX[163:162];

    //--------------EX-----------------------
    // beq_addr
    //wire [31:0] beq_addr;
    assign beq_addr = IDEX_PCadd4 + {IDEX_ImmExt[29:0], 2'b0};

    // Forwarding
    wire EXMEM_RegWr;
    wire [4:0] EXMEM_RegWrAddr;
    //wire MEMWB_RegWr;
    //wire [4:0] MEMWB_RegWrAddr;
    wire [4:0] EXMEM_Rt;
    wire [1:0] MEMWB_MemtoReg;
    wire [4:0] Forwarding;
    ForwardingUnit fu(.IDEX_Rs(IDEX_Rs),.IDEX_Rt(IDEX_Rt),.EXMEM_RegWr(EXMEM_RegWr),.EXMEM_RegWrAddr(EXMEM_RegWrAddr),
        .MEMWB_RegWr(MEMWB_RegWr),.MEMWB_MemtoReg(MEMWB_MemtoReg),.MEMWB_RegWrAddr(MEMWB_RegWrAddr),.EXMEM_Rt(EXMEM_Rt),.Forwarding(Forwarding));

    // ALU
    wire [31:0] EXMEM_ALUOut;
    wire [31:0] MEMWB_ALUOut;
    wire [31:0] MEMWB_MEMOut;
    wire [31:0] A;
    assign A = (Forwarding[1:0] == 2'b00)? IDEX_Read_data1: 
                    (Forwarding[1:0] == 2'b01)? EXMEM_ALUOut: 
                    (Forwarding[1:0] == 2'b10)? WB_data: 32'b0;
    wire [31:0] B;
    assign B = (Forwarding[3:2] == 2'b00)? IDEX_Read_data2: 
                    (Forwarding[3:2] == 2'b01)? EXMEM_ALUOut: 
                    (Forwarding[3:2] == 2'b10)? WB_data: 32'b0;
    wire [31:0] ALUin1;
    assign ALUin1 = (IDEX_ALUSrc[1] == 1'b0)? A: {27'b0, IDEX_shamt};
    wire [31:0] ALUin2;
    assign ALUin2 = (IDEX_ALUSrc[0] == 1'b0)? B: IDEX_ImmExt;
    wire [31:0] ALUOut;
    //wire Zero;
    ALU alu(.in1(ALUin1),.in2(ALUin2),.ALUOp(IDEX_ALUOp),.Sign(IDEX_Sign),.out(ALUOut),.zero(Zero));

    // RegWrAddr
    wire [4:0] RegWrAddr;
    assign RegWrAddr = (IDEX_RegDst == 2'b00)? IDEX_Rt: 
                       (IDEX_RegDst == 2'b01)? IDEX_Rd: 
                       (IDEX_RegDst == 2'b10)? 5'b11111: 5'b0;

    //--------------EX/MEM-----------------------
    reg [111:0] EXMEM;
    wire [31:0] EXMEM_PCadd4;
    wire [31:0] EXMEM_B;
    //wire [31:0] EXMEM_ALUOut;
    //wire [4:0] EXMEM_RegWrAddr;
    //wire [4:0] EXMEM_Rt;
    //wire EXMEM_RegWr;
    wire [1:0] EXMEM_MemtoReg;
    wire EXMEM_MemWr;
    wire EXMEM_MemRd;
    wire EXMEM_RdByte;
    assign EXMEM_PCadd4 = EXMEM[31:0];
    assign EXMEM_B = EXMEM[63:32];
    assign EXMEM_ALUOut = EXMEM[95:64];
    assign EXMEM_RegWrAddr = EXMEM[100:96];
    assign EXMEM_Rt = EXMEM[105:101];
    assign EXMEM_RegWr = EXMEM[106];
    assign EXMEM_MemtoReg = EXMEM[108:107];
    assign EXMEM_MemWr = EXMEM[109];
    assign EXMEM_MemRd = EXMEM[110];
    assign EXMEM_RdByte = EXMEM[111];

    //--------------MEM-----------------------
    wire [31:0] MEM_read_data;
    wire [31:0] MEM_write_data;
    //wire [31:0] MEMWB_MEMOut;
    assign MEM_write_data = (Forwarding[4] == 1'b0)? EXMEM_B: MEMWB_MEMOut;
    wire [31:0] Address;
    assign Address = {EXMEM_ALUOut[31:2], 2'b0};
    wire [7:0] led;
    wire [11:0] digi;
    DataMemory dm(.reset(reset),.clk(clk_o),.Address(Address),.Write_data(MEM_write_data),
        .Read_data(MEM_read_data),.MemRead(EXMEM_MemRd),.MemWrite(EXMEM_MemWr),.led(led),.digi(digi));
    wire [31:0] MEMOut;
    assign MEMOut = (EXMEM_RdByte == 1'b1)? {24'b0, 
        (EXMEM_ALUOut[1:0] == 2'b00)? MEM_read_data[7:0]: 
        (EXMEM_ALUOut[1:0] == 2'b01)? MEM_read_data[15:8]: 
        (EXMEM_ALUOut[1:0] == 2'b10)? MEM_read_data[23:16]: MEM_read_data[31:24]}: MEM_read_data;

    //--------------MEM/WB-----------------------
    reg [103:0] MEMWB;
    wire [31:0] MEMWB_PCadd4;
    //wire [31:0] MEMWB_MEMOut;
    //wire [31:0] MEMWB_ALUOut;
    //wire [31:0] MEMWB_RegWrAddr;
    //wire MEMWB_RegWr;
    //wire [1:0] MEMWB_MemtoReg;
    assign MEMWB_PCadd4 = MEMWB[31:0];
    assign MEMWB_MEMOut = MEMWB[63:32];
    assign MEMWB_ALUOut = MEMWB[95:64];
    assign MEMWB_RegWrAddr = MEMWB[100:96];
    assign MEMWB_RegWr = MEMWB[101];
    assign MEMWB_MemtoReg = MEMWB[103:102];

    //--------------WB-----------------------
    //wire [31:0] WB_data;
    assign WB_data = (MEMWB_MemtoReg == 2'b00)? MEMWB_ALUOut:
                     (MEMWB_MemtoReg == 2'b01)? MEMWB_MEMOut:
                     (MEMWB_MemtoReg == 2'b10)? MEMWB_PCadd4: 32'b0;

    // HazardUnit
    //wire PCKeep;
    wire [1:0] IFIDKeep;
    wire [1:0] IDEXKeep;
    HazardUnit hu(.rs(rs),.rt(rt),.MemWr(MemWr),.IDEX_MemRd(IDEX_MemRd),.IDEX_Rt(IDEX_Rt),.Jump(Jump),
                  .IDEX_Branch(IDEX_Branch),.Zero(Zero),.PCKeep(PCKeep),.IFIDKeep(IFIDKeep),.IDEXKeep(IDEXKeep));

    //--------------Sequential-----------------------

    always @(posedge reset or posedge clk_o)
		if (reset) begin
			PC <= 32'h00000000;
            IFID <= 64'b0;
            IDEX <= 164'b0;
            EXMEM <= 112'b0;
            MEMWB <= 104'b0;
        end
		else begin
            // IF
			PC <= PC_new;
            case (IFIDKeep)
                2'b00: IFID <= {Inst, PCadd4};
                2'b01: IFID <= IFID;
                2'b10: IFID <= 64'b0;
                default: IFID <= 64'b0;
            endcase
            // ID
            case (IDEXKeep)
            2'b00: IDEX <= {ALUSrc,Sign,ALUOp,RegDst,Branch,RdByte,MemRd,MemWr,MemtoReg,RegWr,
                        shamt,rd,rt,rs,imm32,Read_data2,Read_data1,IFID_PCadd4};
            2'b01: IDEX <= IDEX;
            2'b10: IDEX <= 164'b0;
            default: IDEX <= 164'b0;
            endcase
            // EX
            EXMEM <= {IDEX_RdByte,IDEX_MemRd,IDEX_MemWr,IDEX_MemtoReg,IDEX_RegWr,IDEX_Rt,RegWrAddr,ALUOut,B,IDEX_PCadd4};
            // MEM
            MEMWB <= {EXMEM_MemtoReg,EXMEM_RegWr,EXMEM_RegWrAddr,EXMEM_ALUOut,MEMOut,EXMEM_PCadd4};
        end
endmodule
