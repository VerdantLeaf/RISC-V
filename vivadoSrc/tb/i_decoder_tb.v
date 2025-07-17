`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: myself
// Engineer: kyle
// 
// Create Date: 07/17/2025 03:02:22 PM
// Design Name: 
// Module Name: i_decoder_tb
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

module i_decoder_tb #(

    WORD_SIZE = 32,
    NUM_REGS = 32,
    REG_SEL = 5,
    ADDR_SIZE = 10

    )();

    reg [WORD_SIZE - 1 : 0] instr;

    wire [3:0] alu_op;
    wire [REG_SEL - 1 : 0] rs1;
    wire [REG_SEL - 1 : 0] rs2;
    wire [REG_SEL - 1 : 0] rd;

    wire mem_read;   
    wire mem_write;   
    wire mem_to_reg;
    wire reg_write_out;
    wire alu_src;
    wire branch;
    wire jump;


endmodule
