`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: myself
// Engineer: kyle
// 
// Create Date: 05/17/2025 10:55:15 PM
// Design Name: 
// Module Name: top
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

/// @brief Connects cpu_core to external I/O and interactable elements
module top(

    );
    // Set up different external I/o connectivity to ARTY board

    // Parameters to pass down
    localparam WORD_SIZE = 32;
    localparam NUM_REGS = 32;
    localparam NUM_WORDS = 1024;
    localparam ADDR_SIZE = $clog2(NUM_WORDS);
    localparam REG_SEL = $clog2(NUM_REGS);

    cpu_core rv32i_core();


endmodule
