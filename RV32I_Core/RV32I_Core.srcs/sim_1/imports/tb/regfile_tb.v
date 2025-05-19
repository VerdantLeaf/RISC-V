`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/19/2025 11:20:56 AM
// Design Name: 
// Module Name: tb_regfile
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


module tb_regfile;

input rst,
    input clk,
    // Read port 1
    input reg [4:0] rSel1,
    output reg [31:0] rs1Data,
    // Read port 2
    input [4:0] rSel2,
    output [31:0] rs2Data,
    // Write port
    input wCtrl,
    input [4:0] wSel,
    input  wire [31:0] wData



endmodule
