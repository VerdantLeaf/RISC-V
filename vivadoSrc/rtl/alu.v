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


module alu #(

    WORD_SIZE = 32

    )(
    input clk,
    input rst,

    input [2:0] alu_op,
    input [WORD_SIZE - 1 : 0] arg1,
    input [WORD_SIZE - 1 : 0] arg2,

    output [WORD_SIZE - 1 : 0] result,
    output zero,
    output pos
    );

    // Don't worry about for the moment
    // // ALU operations: and, or, xor, shift L, shift R, add, sub
    // localparam op_and = 3'd0, op_or = 3'd1, op_xor = 3'd2, op_shift_L = 3'd3;
    // localparam op_shift_R = 3'd4, op_add = 3'd5, op_sub = 3'd6;

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
