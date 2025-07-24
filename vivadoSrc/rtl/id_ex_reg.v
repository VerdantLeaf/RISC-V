`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: myself
// Engineer: kyle
// 
// Create Date: 05/20/2025 10:10:11 AM
// Design Name: 
// Module Name: id_ex_reg
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

module id_ex_reg #(
    
    WORD_SIZE = 32,
    NUM_REGS = 32,
    REG_SEL = $clog2(NUM_REGS),
    ADDR_SIZE = 10

    )(
    input clk,
    input rst,
    input flush,
    input stall,

    // ============================= INPUTS =========================
    input [ADDR_SIZE - 1 : 0] pc,

    input [WORD_SIZE - 1 : 0] immd,
    input [WORD_SIZE - 1 : 0] data1,
    input [WORD_SIZE - 1 : 0] data2,
    input [3:0] alu_op,
    input [REG_SEL - 1 : 0] rd,  
    input [REG_SEL - 1 : 0] rs1, 
    input [REG_SEL - 1 : 0] rs2,  

    input mem_read,     
    input mem_write,    
    input mem_to_reg,   
    input reg_write,

    input alu_src,      
    input branch,       
    input jump,         

    input [1:0] data_size,
    input data_sign,

    // =========================== OUTPUTS ==========================
    output reg [WORD_SIZE - 1:0] pc_out,

    output reg [WORD_SIZE - 1:0] data1_out,
    output reg [WORD_SIZE - 1:0] data2_out,
    output reg [WORD_SIZE - 1:0] immd_out,
    output reg [3:0] alu_op_out,
    output reg [REG_SEL - 1:0] rs1_out,
    output reg [REG_SEL - 1:0] rs2_out,
    output reg [REG_SEL - 1:0] rd_out,

    output reg mem_read_out,
    output reg mem_write_out,
    output reg mem_to_reg_out,
    output reg reg_write_out,

    output reg alu_src_out,
    output reg branch_out,
    output reg jump_out,

    output reg [1:0] data_size_out,
    output reg data_sign_out

    );

    always @(posedge clk or posedge rst) begin
        if (rst || flush) begin
            pc_out <= {WORD_SIZE{1'b0}};
            data1_out <= {WORD_SIZE{1'b0}};
            data2_out <= {WORD_SIZE{1'b0}};
            immd_out <= {WORD_SIZE{1'b0}};
            rd_out <= {REG_SEL{1'b0}};

            alu_op_out <= `ALU_OP_ADD; // ADD is all zeros + allows easy insert for NOP
            mem_read_out <= 1'b0;
            mem_write_out <= 1'b0;
            mem_to_reg_out <= 1'b0;
            reg_write_out <= 1'b0;

            alu_src_out <= 1'b1; // Set to 1 since default op is NOP. Can reset register to insert NOP into pipeline
            branch_out <= 1'b0;
            jump_out <= 1'b0;

            data_sign_out <= 2'd0;
            data_sign_out <= 1'b0;
    
        end else if (!stall) begin
            pc_out <= pc;
            data1_out <= data1;
            data2_out <= data2;
            immd_out <= immd;
            rd_out <= rd;
            alu_op_out <= alu_op;
            mem_read_out <= mem_read;
            mem_write_out <= mem_write;
            mem_to_reg_out <= mem_to_reg;
            reg_write_out <= reg_write;
            alu_src_out <= alu_src;
            branch_out <= branch;
            jump_out <= jump;
            data_sign_out <= data_size;
            data_sign_out <= data_sign;
        end
    end
endmodule
