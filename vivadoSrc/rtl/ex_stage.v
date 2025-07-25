`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/17/2025 10:35:55 PM
// Design Name: 
// Module Name: ex_stage
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

`include "defines.vh"

module ex_stage #(

    WORD_SIZE = 32,
    NUM_REGS = 32,
    REG_SEL = $clog2(NUM_REGS),
    ADDR_SIZE = 10

    )(
        
    input [ADDR_SIZE - 1 : 0] pc,   // According to the RISC-V standard, this is the pc 
                                    // after the instruction in this stage of the pipeline
    input [WORD_SIZE - 1 : 0] data1,
    input [WORD_SIZE - 1 : 0] wb_forward1,
    input [WORD_SIZE - 1 : 0] mem_forward1,

    input [WORD_SIZE - 1 : 0] data2,
    input [WORD_SIZE - 1 : 0] wb_forward2,
    input [WORD_SIZE - 1 : 0] mem_forward2,

    input [WORD_SIZE - 1 : 0] immd,

    input [1 : 0] sel_forward1,
    input [1 : 0] sel_forward2,
    input [3:0] alu_op,
    input alu_src,

    output [ADDR_SIZE - 1 : 0] branch_target,   // addr of branch target
    output [WORD_SIZE - 1 : 0] result,          // also address for saving data
    output [WORD_SIZE - 1 : 0] write_data,      // data to write to memory
    output zero    // If output of ALU is zero. Used for branching

    );

    wire [WORD_SIZE - 1 : 0] alu1, alu2, alu_src1;

    assign write_data = alu_src2;

    // Translate immd to bytes and add to pc to get branch target
    assign branch_target = pc + (immd << 2);

    mux_gen #(
        .NUM_INPUTS(3),
        .DATA_WIDTH(WORD_SIZE)
    ) data1_mux (
        .data({data1, wb_forward1, mem_forward1}),
        .sel(sel_forward1),
        .out(alu1)
    );

    mux_gen #(
        .NUM_INPUTS(3),
        .DATA_WIDTH(WORD_SIZE)
    ) data2_mux (
        .data({data2, wb_forward2, mem_forward2}),
        .sel(sel_forward2),
        .out(alu_src2)
    );

    mux_gen #(
        .NUM_INPUTS(2),
        .DATA_WIDTH(WORD_SIZE)
    ) alu_src_mux (
        .data({alu_src2, immd}),
        .sel(alu_src),
        .out(alu2)
    );

    alu alu(
        .alu_op(alu_op),
        .arg1(data1),
        .arg2(data2),
        .result(result),
        .zero(zero)
    );

endmodule
