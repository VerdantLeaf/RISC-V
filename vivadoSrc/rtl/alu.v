`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: myself
// Engineer: kyle 
// 
// Create Date: 05/17/2025 10:35:55 PM
// Design Name: 
// Module Name: alu
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

module alu #(

    WORD_SIZE = 32

    )(
    input clk,
    input rst,

    input [3:0] alu_op,
    input [WORD_SIZE - 1 : 0] arg1,
    input [WORD_SIZE - 1 : 0] arg2,

    output [WORD_SIZE - 1 : 0] result,
    output zero
    );

    // Don't worry about for the moment
    // // ALU operations: and, or, xor, shift L, shift R, add, sub

    // BEQ/BNE -> Do subtraction of A - B
    // BLT/BGE -> Do signed compare and output 1 if A < B, 0 else
    // BLTU/BGEU -> Do unsigned compare and output 1 if A < B, 0 else
    // Double check this output





    // always @(posedge clk) begin
        
    //     if(rst)

    //     else
    //         case(alu_op)
    //             op_and:
    //             op_or:
    //             op_xor:
    //             op_shift_L:
    //             op_shift_R:
    //             op_add:
    //             op_sub:
    //         endcase
        
    // end



endmodule
