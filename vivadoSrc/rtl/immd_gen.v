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


module immd_gen #(

    WORD_SIZE = 32

    )(

    input clk,
    input rst,

    input [WORD_SIZE - 1 : 0] immd,

    output [WORD_SIZE - 1 : 0] generated_immd

    );
endmodule
