`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 07/22/2025 01:22:21 PM
// Design Name: 
// Module Name: mem_stage
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


module mem_stage #(

    WORD_SIZE = 32,
    NUM_REGS = 32,
    REG_SEL = $clog2(NUM_REGS),
    ADDR_SIZE = 10

    )(

    input clk,
    input rst,

    input [WORD_SIZE - 1 : 0] result,
    input [WORD_SIZE - 1 : 0] save_data,

    input [REG_SEL - 1 : 0] rd,

    input reg_write,
    input mem_read,
    input mem_write,
    input branch,
    input jump,
    input zero,

    input data_sign, // 0 for signed and 1 for unsigned
    input [1:0] data_size,

    output reg_write_out,

    output [WORD_SIZE - 1 : 0] read_data,
    output [WORD_SIZE - 1 : 0] result_out,

    output [REG_SEL - 1 : 0] rd_out

    output pc_src

    );

    assign pc_src = (branch && zero) || jump; // PC Src logic

    assign rd_out = rd;
    assign reg_write_out = reg_write;

    d_mem datamemory(
        .clk(clk),

        // Don't use port A for now
        .b_en_write(mem_write),
        .b_en_read(mem_read),
        
        .b_addr(result[ADDR_SIZE - 1 : 0]), // Splice bottom 10 bits of result for address
        .b_din(save_data), // Data to write into mem (rs2)
        .b_size(data_size),
        .b_unsigned(data_sign),
        .b_dout(read_data)
    )

endmodule
