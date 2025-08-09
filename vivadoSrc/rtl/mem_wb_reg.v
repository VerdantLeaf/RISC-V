`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/20/2025 10:10:11 AM
// Design Name: 
// Module Name: mem_wb_reg
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


module mem_wb_reg #(

    WORD_SIZE = 32,
    NUM_WORDS = 1024,
    NUM_REGS = 32,
    REG_SEL = $clog2(NUM_REGS),
    ADDR_SIZE = $clog2(NUM_WORDS)

    )(

    input clk,
    input rst,
    input flush,
    input stall,

    input [ADDR_SIZE - 1 : 0] pc,

    input [WORD_SIZE - 1 : 0] read_data,
    input [WORD_SIZE - 1 : 0] result,
    input [REG_SEL - 1 : 0] rd,

    input mem_to_reg,
    input jump,
    input reg_write,

    output reg [ADDR_SIZE - 1 : 0] pc_out,
    output reg [WORD_SIZE - 1 : 0] read_data_out,
    output reg [WORD_SIZE - 1 : 0] result_out,
    output reg [REG_SEL - 1 : 0] rd_out,

    output reg mem_to_reg_out,
    output reg jump_out,
    output reg reg_write_out

    );

    always @(posedge clk or posedge rst) begin
        if(rst || flush) begin
            pc_out <= {ADDR_SIZE{1'b0}};
            read_data_out <= {WORD_SIZE{1'b0}};
            result_out <= {WORD_SIZE{1'b0}};
            rd_out <= {REG_SEL{1'b0}};
            mem_to_reg_out <= 1'b0;
            jump <= 1'b0;
            reg_write_out <= 1'b0;

        end else if (!stall) begin
            pc_out <= pc;
            read_data_out <= read_data;
            result_out <= result;
            rd_out <= rd;
            mem_to_reg_out <= mem_to_reg;
            jump <= jump_out;
            reg_write_out <= reg_write;
        end
    end

endmodule