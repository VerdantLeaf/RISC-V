`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/17/2025 11:06:51 PM
// Design Name: 
// Module Name: immd_gen
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

`include "defines.vh"


module immd_gen #(

    WORD_SIZE = 32

    )(
    
    input [WORD_SIZE - 1 : 0] instr,
    output reg [WORD_SIZE - 1 : 0] immd_out

    );

    wire [4:0] opcode = instr[6:2];
    wire [2:0] func3 = instr[14:12];

    always @(*) begin
        case(opcode)
            // Handle shift amounts for SRAI, SLLI, SRLI - Need to ignore upper bits
            `OPCODE_I: immd_out = (func3 == 3'b001 || func3 == 3'b101) ? {{27{1'b0}}, instr[24:20]} : {{20{instr[31]}}, instr[31:20]};
            `OPCODE_S: immd_out = {{20{instr[31]}}, instr[31:25], instr[11:7]};
            `OPCODE_B: immd_out = {{19{instr[31]}}, instr[31], instr[7], instr[30:25], instr[11:8], 1'b0};
            `OPCODE_U_LUI, `OPCODE_U_AUIPC : immd_out = {instr[31:12], 12'b0};
            `OPCODE_JAL: immd_out = {{11{instr[31]}}, instr[31], instr[19:12], instr[20], instr[30:21], 1'b0};
            default: immd_out = {WORD_SIZE{1'b0}};
        endcase
    end
endmodule
