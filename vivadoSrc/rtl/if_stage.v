`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: myself
// Engineer: kyle
// 
// Create Date: 05/17/2025 11:06:51 PM
// Design Name: 
// Module Name: if_stage
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


module if_stage(

    input clk,
    input rst,
    // data 
    input [31:0] pc_branch,
    output [31:0] instr,
    output [31:0] pc_added,
    // ctrl signals
    input pcsrc,
    input en // Use for stall cycles on hazard resolution?
    );

    wire [31:0] addr;
    wire [31:0] pc_in;
    wire [31:0] pc_next;

    assign pc_in = (pcsrc) ? pc_branch : pc_next;
    assign pc_next = addr + 4; // Future: Check for PC overflow
    assign pc_added = pc_next;

    register32 pc_reg(.clk(clk), .rst(rst), .en(en), .d(pc_in), .q(addr));
    i_mem instruction_memory(.clk(clk), .addr(addr), .instr(instr));

endmodule
