`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 07/22/2025 01:42:25 PM
// Design Name: 
// Module Name: wb_stage
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


module wb_stage #(

    WORD_SIZE = 32,
    NUM_REGS = 32,
    REG_SEL = $clog2(NUM_REGS)

    )(

    input [WORD_SIZE - 1 : 0] memory_data,
    input [WORD_SIZE - 1 : 0] alu_data,
    input [REG_SEL - 1 : 0] rd,

    input mem_read,
    input reg_write,

    output [WORD_SIZE - 1 : 0] write_data,
    output [REG_SEL - 1 : 0] rd_out,

    output reg_write_out

    );

    assign reg_write_out = reg_write;
    assign rd_out = rd;


    mux_gen #(
        .NUM_INPUTS(2),
        .DATA_WIDTH(32)
    ) write_select_mux(
        .data({alu_data, memory_data}),
        .sel(mem_read),
        .out(write_Data)
    )
    
endmodule
