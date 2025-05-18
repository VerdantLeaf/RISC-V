`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/17/2025 10:55:15 PM
// Design Name: 
// Module Name: register32
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


module register32(
    input clk,
    input rst,
    input en,
    input [31:0] d,
    output reg [31:0] q
    );
    
    always @(posedge clk or posedge rst)
        if (rst) q <= 32'b0;
        else if (en) q <= d;
endmodule
