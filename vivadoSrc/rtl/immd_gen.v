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
    input [2:0] instr_type, // R_TYPE, I_TYPE, etc...
    output reg [WORD_SIZE - 1 : 0] immd_out

    );

    always @(*) begin
        case(instr_type)
            
            `I_TYPE: immd_out = {{20{instr[31]}}, instr[31:20]};
            `S_TYPE: immd_out = {{20{instr[31]}}, instr[31:25], instr[11:7]};
            `B_TYPE: immd_out = {{19{instr[31]}}, instr[31], instr[7], instr[30:25], instr[11:8], 1'b0};
            `U_TYPE: immd_out = {instr[31:12], 12'b0};
            `J_TYPE: immd_out = {{11{instr[31]}}, instr[31], instr[19:12], instr[20], instr[30:21], 1'b0};
            default: immd_out = {WORD_SIZE{1'b0}};
        endcase
    end
endmodule
