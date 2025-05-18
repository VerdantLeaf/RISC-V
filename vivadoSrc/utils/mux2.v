`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/17/2025 10:55:15 PM
// Design Name: 
// Module Name: mux2
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


module mux2
    #(parameter DATA_WIDTH = 32)
    (
    input sel,
    input [DATA_WIDTH:0] a,
    input [DATA_WIDTH:0] b,
    output [DATA_WIDTH:0] out
    );
    
    always @(*)
        if(sel) out <= a;
        else out <= b;
    
endmodule
