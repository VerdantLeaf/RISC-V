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


module if_stage #(
    
    WORD_SIZE = 32,
    NUM_WORDS = 1024,
    ADDR_SIZE = $clog2(NUM_WORDS)

    )(
    input clk,
    input rst,

    input [ADDR_SIZE - 1 : 0] branch_target,
    inout [ADDR_SIZE - 1 : 0] pc_next,

    input pc_src,
    input en, // Use for stall cycles on hazard resolution? (yes, get to that eventually)

    output [WORD_SIZE - 1:0] instr
    );

    wire [ADDR_SIZE - 1 : 0] addr;
    wire [ADDR_SIZE - 1 : 0] pc_in;

    assign pc_in = (pc_src) ? branch_target : pc_next;

    assign pc_next = addr + 4; // Future: Check for PC overflow

    register32 pc_reg(.clk(clk), .rst(rst), .en(en), .d(pc_in), .q(addr));

    i_mem instruction_memory(.clk(clk), .addr(addr), .instr(instr));

endmodule
