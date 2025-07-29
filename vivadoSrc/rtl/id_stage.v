`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/17/2025 11:06:51 PM
// Design Name: 
// Module Name: id_stage
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

module id_stage #(

    WORD_SIZE = 32,
    NUM_REGS = 32,
    NUM_WORDS = 1024,
    REG_SEL = $clog2(NUM_REGS),
    ADDR_SIZE = $clog2(NUM_WORDS)

    )(
    input clk, 
    input rst,

    input [WORD_SIZE - 1 : 0] instr,            // Instruction to be decoded

    input reg_write,                            // Enable writing to the register file
    input [WORD_SIZE - 1 : 0] rd_data,          // Data to be written to the register file
    input [REG_SEL - 1 : 0] rd_select,          // The select bits for the write back


    output [WORD_SIZE - 1 : 0] immd,            // Immediate extracted from immediate decode
    output [WORD_SIZE - 1 : 0] data1,           // First data from the register file
    output [WORD_SIZE - 1 : 0] data2,           // Second data from register file (alu_src determines valid)
    output [3:0] alu_op,                        // Tells the ALU which operation to do 
    output [REG_SEL - 1 : 0] rd,                // The rd register for the instruction
    output [REG_SEL - 1 : 0] rs1,               // The rs1 register for the instruction
    output [REG_SEL - 1 : 0] rs2,               // The rs2 register for the instruction

    output mem_read,                            // Instruction reads from memory
    output mem_write,                           // Instruction writes to memory
    output mem_to_reg,                          // Instruction writes to regfile from memory
    output reg_write,                           // Instruction writes to regfile
    output alu_src,                             // Instruction uses immd or not
    output branch,                              // Instruction is branch
    output jump,                                // Instruction is jump

    output [1:0] data_size,                     // Size of the data to load/save
    output data_sign                            // Signedness of the data to load
    );

    wire [REG_SEL - 1 : 0] rs1_sel;
    wire [REG_SEL - 1 : 0] rs2_sel;

    assign rs1 = rs1_sel;
    assign rs2 = rs2_sel;

    regfile registerfile(
        .clk(clk),
        .rst(rst),
        // Input selects and data outputs
        .rs1(rs1_sel),
        .rs1Data(data1),
        .rs2(rs2_sel),
        .rs2Data(data2),
        // WRite inputs
        .wCtrl(reg_write),
        .wSel(rd_select),
        .wData(rd_data)
    );

    immd_gen immediategenerator(
        .instr(instr),
        .immd_out(immd)
    );

    i_decoder instructiondecoder(
        .instr(instr),
        // outputs
        .alu_op(alu_op),
        .rs1(rs1_sel),
        .rs2(rs2_sel),
        .rd(rd),
        // ctrl signals
        .mem_read(mem_read),
        .mem_write(mem_write),
        .mem_to_reg(mem_to_reg),
        .reg_write(reg_write),
        .alu_src(alu_src),
        .branch(branch),
        .jump(jump),
        .data_size(data_size),
        .data_sign(data_sign)
    );
    
endmodule
