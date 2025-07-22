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
    NUM_REGS = 32,
    REG_SEL = $clog2(NUM_REGS),
    ADDR_SIZE = 10

    )(

    input clk,
    input rst,
    input flush,
    input stall,

    input [WORD_SIZE - 1 : 0] read_data,
    input [WORD_SIZE - 1 : 0] result,
    input [REG_SEL - 1 : 0] rd,

    input mem_read,
    input reg_write,

    output [WORD_SIZE - 1 : 0] read_data_out,
    output [WORD_SIZE - 1 : 0] result_out,
    output [REG_SEL - 1 : 0] rd_out,

    output mem_read_out,
    output reg_write_out

    );

    always @(posedge clk or posedge rst) begin
        if(rst || flush) begin
            read_data_out <= {WORD_SIZE{1'b0}};
            result_out <= {WORD_SIZE{1'b0}};
            rd_out <= {REG_SEL{1'b0}};
            mem_read_out <= 1'b0;
            reg_write_out <= 1'b0;

        end else if (!stall) begin
            read_data_out <= read_data;
            result_out <= result;
            rd_out <= rd;
            mem_read_out <= mem_read;
            reg_write_out <= reg_write;
        end
    end

endmodule