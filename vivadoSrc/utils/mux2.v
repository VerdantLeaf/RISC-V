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

// Variable data width selection MUX
module mux2
    #(parameter DATAWIDTH = 32)(
    input sel,
    input [DATAWIDTH - 1:0] a,
    input [DATAWIDTH - 1:0] b,
    output reg [DATAWIDTH - 1:0] out
    );
    // sel = 0 => a & sel = 1 => b 
    always @(*)
        if(sel) out <= b;
        else out <= a;
    
endmodule
