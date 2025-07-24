`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 07/24/2025 11:45:21 AM
// Design Name: 
// Module Name: ex_stage_tb
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

module ex_stage_tb #(

    WORD_SIZE = 32,
    NUM_REGS = 32,
    REG_SEL = $clog2(NUM_REGS)

    )();
    reg [ADDR_SIZE - 1 : 0] pc,
    
    reg [WORD_SIZE - 1 : 0] data1,
    reg [WORD_SIZE - 1 : 0] wb_forward1,
    reg [WORD_SIZE - 1 : 0] mem_forward1,

    reg [WORD_SIZE - 1 : 0] data2,
    reg [WORD_SIZE - 1 : 0] wb_forward2,
    reg [WORD_SIZE - 1 : 0] mem_forward2,

    reg [REG_SEL - 1 : 0] rs1, 
    reg [REG_SEL - 1 : 0] rs2, 
    reg [REG_SEL - 1 : 0] rd,  

    reg [WORD_SIZE - 1 : 0] immd,

    reg [1 : 0] sel_forward1,
    reg [1 : 0] sel_forward2,
    reg [3:0] alu_op,

    reg alu_src,

    reg [1:0] data_size,
    reg data_sign,

    wire [ADDR_SIZE - 1 : 0] branch_target,

    wire [REG_SEL - 1 : 0] rs1_out, 
    wire [REG_SEL - 1 : 0] rs2_out, 
    wire [REG_SEL - 1 : 0] rd_out,  

    wire [WORD_SIZE - 1 : 0] result,
    wire [WORD_SIZE - 1 : 0] save_data,
    wire [1 : 0] data_size, 

    wire zero,

    wire [1:0] data_size_out,
    wire data_sign_out 
    
    
    initial begin
                
    end


endmodule
