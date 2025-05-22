`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/22/2025 10:28:31 AM
// Design Name: 
// Module Name: if_stage_tb
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


module if_stage_tb(
    input clk,
    input rst,
    input [31:0] pc_branch,
    output [31:0] instr,
    output [31:0] pc_added,
    input pcsrc,
    input en
    );


    if_stage dut(
        .clk(clk),
        .rst(rst),
        .pc_branch(pc_branch),
        .instr(instr),
        .pc_added(pc_added),
        .pcsrc(pcsrc),
        .en(en)
    )

    initial clk = 0;
    always #5 clk = ~clk;

    


endmodule
