`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2022/07/17 12:14:44
// Design Name: 
// Module Name: InstructionMemory3
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


module InstructionMemory3(Address, Instruction);
	input [31:0] Address;
	output reg [31:0] Instruction;
	
	always @(*)
		case (Address[9:2])
            8'd0:   Instruction <= 32'h3c016261;
            8'd1:   Instruction <= 32'h34246163;
            8'd2:   Instruction <= 32'hac040000;
            8'd3:   Instruction <= 32'h3c016161;
            8'd4:   Instruction <= 32'h34246261;
            8'd5:   Instruction <= 32'hac040004;
            8'd6:   Instruction <= 32'h3c016263;
            8'd7:   Instruction <= 32'h34246162;
            8'd8:   Instruction <= 32'hac040008;
            8'd9:   Instruction <= 32'h3c016162;
            8'd10:   Instruction <= 32'h34246161;
            8'd11:   Instruction <= 32'hac04000c;
            8'd12:   Instruction <= 32'h3c016261;
            8'd13:   Instruction <= 32'h34246162;
            8'd14:   Instruction <= 32'hac040010;
            8'd15:   Instruction <= 32'h3c016161;
            8'd16:   Instruction <= 32'h34246261;
            8'd17:   Instruction <= 32'hac040014;
            8'd18:   Instruction <= 32'h3c016462;
            8'd19:   Instruction <= 32'h34246162;
            8'd20:   Instruction <= 32'hac040018;
            8'd21:   Instruction <= 32'h3c016261;
            8'd22:   Instruction <= 32'h34246261;
            8'd23:   Instruction <= 32'hac04001c;
            8'd24:   Instruction <= 32'h3c016162;
            8'd25:   Instruction <= 32'h34246161;
            8'd26:   Instruction <= 32'hac040020;
            8'd27:   Instruction <= 32'h3c016261;
            8'd28:   Instruction <= 32'h34246162;
            8'd29:   Instruction <= 32'hac040024;
            8'd30:   Instruction <= 32'h3c016161;
            8'd31:   Instruction <= 32'h34246261;
            8'd32:   Instruction <= 32'hac040028;
            8'd33:   Instruction <= 32'h3c016162;
            8'd34:   Instruction <= 32'h34246162;
            8'd35:   Instruction <= 32'hac04002c;
            8'd36:   Instruction <= 32'h3c01000a;
            8'd37:   Instruction <= 32'h34246261;
            8'd38:   Instruction <= 32'hac040030;
            8'd39:   Instruction <= 32'h3c016161;
            8'd40:   Instruction <= 32'h34246261;
            8'd41:   Instruction <= 32'hac040100;
            8'd42:   Instruction <= 32'h3c016162;
            8'd43:   Instruction <= 32'h34246162;
            8'd44:   Instruction <= 32'hac040104;
            8'd45:   Instruction <= 32'h3c01000a;
            8'd46:   Instruction <= 32'h34246261;
            8'd47:   Instruction <= 32'hac040108;
            8'd48:   Instruction <= 32'h24040032;
            8'd49:   Instruction <= 32'h24050000;
            8'd50:   Instruction <= 32'h24060002; // 2406000a
            8'd51:   Instruction <= 32'h24070100;
            8'd52:   Instruction <= 32'h0c000036;
            8'd53:   Instruction <= 32'h08000035;
            8'd54:   Instruction <= 32'h240c0140;
            8'd55:   Instruction <= 32'h23bdffec;
            8'd56:   Instruction <= 32'hafbf0010;
            8'd57:   Instruction <= 32'hafa4000c;
            8'd58:   Instruction <= 32'hafa50008;
            8'd59:   Instruction <= 32'hafa60004;
            8'd60:   Instruction <= 32'hafa70000;
            8'd61:   Instruction <= 32'h000c2021;
            8'd62:   Instruction <= 32'h00062821;
            8'd63:   Instruction <= 32'h00073021;
            8'd64:   Instruction <= 32'h0c000065;
            8'd65:   Instruction <= 32'h8fa70000;
            8'd66:   Instruction <= 32'h8fa60004;
            8'd67:   Instruction <= 32'h8fa50008;
            8'd68:   Instruction <= 32'h8fa4000c;
            8'd69:   Instruction <= 32'h8fbf0010;
            8'd70:   Instruction <= 32'h23bd0014;
            8'd71:   Instruction <= 32'h00001024;
            8'd72:   Instruction <= 32'h00004024;
            8'd73:   Instruction <= 32'h00004824;
            8'd74:   Instruction <= 32'h0104782a;
            8'd75:   Instruction <= 32'h11e00018;
            8'd76:   Instruction <= 32'h00e95020;
            8'd77:   Instruction <= 32'h814b0000;
            8'd78:   Instruction <= 32'h00a85020;
            8'd79:   Instruction <= 32'h814a0000;
            8'd80:   Instruction <= 32'h154b0009;
            8'd81:   Instruction <= 32'h21080001;
            8'd82:   Instruction <= 32'h21290001;
            8'd83:   Instruction <= 32'h1526fff6;
            8'd84:   Instruction <= 32'h20420001;
            8'd85:   Instruction <= 32'h20c9ffff;
            8'd86:   Instruction <= 32'h00094880;
            8'd87:   Instruction <= 32'h01894820;
            8'd88:   Instruction <= 32'h8d290000;
            8'd89:   Instruction <= 32'h0800004a;
            8'd90:   Instruction <= 32'h20010000;
            8'd91:   Instruction <= 32'h0029782a;
            8'd92:   Instruction <= 32'h11e00005;
            8'd93:   Instruction <= 32'h2129ffff;
            8'd94:   Instruction <= 32'h00094880;
            8'd95:   Instruction <= 32'h01894820;
            8'd96:   Instruction <= 32'h8d290000;
            8'd97:   Instruction <= 32'h0800004a;
            8'd98:   Instruction <= 32'h21080001;
            8'd99:   Instruction <= 32'h0800004a;
            8'd100:   Instruction <= 32'h03e00008;
            8'd101:   Instruction <= 32'h00a01023;
            8'd102:   Instruction <= 32'h34010001;
            8'd103:   Instruction <= 32'h0041102b;
            8'd104:   Instruction <= 32'h1440001f;
            8'd105:   Instruction <= 32'h34080001;
            8'd106:   Instruction <= 32'h34090000;
            8'd107:   Instruction <= 32'hac800000;
            8'd108:   Instruction <= 32'h0105782a;
            8'd109:   Instruction <= 32'h11e0001a;
            8'd110:   Instruction <= 32'h00c85020;
            8'd111:   Instruction <= 32'h814b0000;
            8'd112:   Instruction <= 32'h00c95020;
            8'd113:   Instruction <= 32'h814a0000;
            8'd114:   Instruction <= 32'h016a7823;
            8'd115:   Instruction <= 32'h34010001;
            8'd116:   Instruction <= 32'h01e1782b;
            8'd117:   Instruction <= 32'h11e00006;
            8'd118:   Instruction <= 32'h21290001;
            8'd119:   Instruction <= 32'h00085080;
            8'd120:   Instruction <= 32'h008a5020;
            8'd121:   Instruction <= 32'had490000;
            8'd122:   Instruction <= 32'h21080001;
            8'd123:   Instruction <= 32'h0800006c;
            8'd124:   Instruction <= 32'h0009082a;
            8'd125:   Instruction <= 32'h10200005;
            8'd126:   Instruction <= 32'h212affff;
            8'd127:   Instruction <= 32'h000a5080;
            8'd128:   Instruction <= 32'h008a5020;
            8'd129:   Instruction <= 32'h8d490000;
            8'd130:   Instruction <= 32'h0800006c;
            8'd131:   Instruction <= 32'h00085080;
            8'd132:   Instruction <= 32'h008a5020;
            8'd133:   Instruction <= 32'had400000;
            8'd134:   Instruction <= 32'h21080001;
            8'd135:   Instruction <= 32'h0800006c;
            8'd136:   Instruction <= 32'h03e00008;
			default: Instruction <= 32'h00000000;
		endcase
		
endmodule
