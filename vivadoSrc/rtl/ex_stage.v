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
    NUM_WORDS = 1024,
    REG_SEL = $clog2(NUM_REGS),
    ADDR_SIZE = $clog2(NUM_WORDS)

    )(
        
    input [ADDR_SIZE - 1 : 0] pc,   // According to the RISC-V standard, this is the pc 
                                    // after the instruction in this stage of the pipeline
    input [WORD_SIZE - 1 : 0] data1,
    input [WORD_SIZE - 1 : 0] mem_forward1,
    input [WORD_SIZE - 1 : 0] wb_forward1,

    input [WORD_SIZE - 1 : 0] data2,
    input [WORD_SIZE - 1 : 0] mem_forward2,
    input [WORD_SIZE - 1 : 0] wb_forward2,

    input [WORD_SIZE - 1 : 0] immd,
    
    input [1 : 0] sel_forward1,
    input [1 : 0] sel_forward2,

    input [3:0] alu_op,
    input alu_src,
    input branch, 
    input jump,

    output zero,    // If output of ALU is zero. Used for branching
    output [ADDR_SIZE - 1 : 0] branch_target,   // addr of branch target
    output [WORD_SIZE - 1 : 0] result,          // also address for saving data
    output [WORD_SIZE - 1 : 0] write_data       // data to write to memory

    );

    wire [WORD_SIZE - 1 : 0] alu1, alu2, alu_src2, alu_res;
    wire alu_zero;

    assign write_data = alu_src2;
    assign result = alu_res;

    // Translate immd to bytes and add to pc to get branch target
    assign branch_target = (branch || jump) ? (pc - 4) + (immd << 2) : (pc - 4);
    // Mux where to pull zero from based on the alu_op
    assign zero = (alu_op == `ALU_OP_SLT || alu_op == `ALU_OP_SLTU) ? alu_res : alu_zero;

    mux_3_to_1 #(
        .DATA_WIDTH(WORD_SIZE)
    ) data1_mux (
        .data0(data1),
        .data1(mem_forward1),
        .data2(wb_forward1),
        .sel(sel_forward1),
        .out(alu1)
    );

    mux_3_to_1 #(
        .DATA_WIDTH(WORD_SIZE)
    ) data2_mux (
        .data0(data2),
        .data1(mem_forward2),
        .data2(wb_forward2),
        .sel(sel_forward2),
        .out(alu_src2)
    );

    mux_2_to_1 #(
        .DATA_WIDTH(WORD_SIZE)
    ) alu_src_mux (
        .data0(alu_src2),
        .data1(immd),
        .sel(alu_src),
        .out(alu2)
    );

    alu alu(
        .alu_op(alu_op),
        .A(alu1),
        .B(alu2),
        .result(alu_res),
        .zero(alu_zero)
    );

endmodule
