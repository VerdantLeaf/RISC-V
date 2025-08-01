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
    NUM_WORDS = 1024,
    REG_SEL = $clog2(NUM_REGS),
    ADDR_SIZE = $clog2(NUM_WORDS)

    )(
    input clk,
    input rst,

    input [WORD_SIZE - 1 : 0] save_addr,
    input [WORD_SIZE - 1 : 0] save_data,

    input mem_read,
    input mem_write,
    input branch,
    input jump,
    input zero,

    input data_sign, // 0 for signed and 1 for unsigned
    input [1:0] data_size,

    output [WORD_SIZE - 1 : 0] read_data,
    output pc_src,

    output flush_ifid,
    output flush_idex,
    output flush_exmem,
    output flush_memwb
    );

    assign pc_src = ((branch && zero ) || jump) ? 1'b1 : 1'b0;

    d_mem #(
        .NUM_WORDS(NUM_WORDS),
        .WORD_SIZE(WORD_SIZE),
        .ADDR_SIZE(ADDR_SIZE)
    ) datamemory (
        .clk(clk),

        // Don't use port A for now
        .b_en_write(mem_write),
        .b_en_read(mem_read),
        
        .b_addr(result[ADDR_SIZE - 1 : 0]), // Splice bottom 10 bits of result for address
        .b_din(save_data), // Data to write into mem (rs2)
        .b_size(data_size),
        .b_unsigned(data_sign),
        .b_dout(read_data)
    );

    
    branch_unit branch_unit(

    );

endmodule
