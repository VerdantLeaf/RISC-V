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


module id_ex_reg #(
    
    WORD_SIZE = 32,
    NUM_REGS = 32

    )(
    input clk,
    input rst,
    // Data
    input [WORD_SIZE - 1:0] pc,            // PC needed for branch/jump target
    input [WORD_SIZE - 1:0] rdata1,        // register file data
    input [WORD_SIZE - 1:0] rdata2,
    input [WORD_SIZE - 1:0] immd,

    // func 3?? other info? - This is a large register

    output reg [WORD_SIZE - 1:0] pc_out,
    output reg [WORD_SIZE - 1:0] rdata1_out,
    output reg [WORD_SIZE - 1:0] rdata2_out,
    output reg [WORD_SIZE - 1:0] immd_out,

    // Ctrl signals
    input [$clog2(NUM_REGS) - 1:0] sel_dest_reg,   // Select register to write to
    input en_write_reg,         // Enable writing to register
    input en_mem_read,          // Enable mem read
    input en_mem_write,         // Enable mem write
    input sel_alu_op,           // Select alu operation
    input sel_alu_src,          // Select alu source for second arg
    input sel_write_src,        // Select write from data memory or ALU result
    input branch,
    input jump,    

    output reg [$clog2(NUM_REGS) - 1:0] sel_dest_reg_out,
    output reg en_write_reg_out,
    output reg en_mem_read_out,
    output reg en_mem_write_out,
    output reg sel_alu_op_out,
    output reg sel_alu_src_out,
    output reg sel_write_src_out,
    output reg branch_out,
    output reg jump_out

    );

    always @(posedge clk or posedge rst)
        if (rst) begin
            pc_out <= {WORD_SIZE{1'b0}};
            rdata1_out <= {WORD_SIZE{1'b0}};
            rdata2_out <= {WORD_SIZE{1'b0}};
            immd_out <= {WORD_SIZE{1'b0}};
            
            sel_dest_reg_out <= {$clog2(NUM_REGS){1'b0}};
            en_write_reg_out <= 0;
            en_mem_read_out <= 0;
            en_mem_write_out <= 0;
            sel_alu_op_out <= 0;
            sel_alu_src_out <= 0;
            sel_write_src_out <= 0;
            branch_out <= 0;
            jump_out <= 0;
        end else begin
            pc_out <= pc;
            rdata1_out <= rdata1;
            rdata2_out <= rdata2;
            immd_out <= immd;
            
            sel_dest_reg_out <= sel_dest_reg;
            en_write_reg_out <= en_write_reg;
            en_mem_read_out <= en_mem_read;
            en_mem_write_out <= en_mem_write;
            sel_alu_op_out <= sel_alu_op;
            sel_alu_src_out <= sel_alu_src;
            sel_write_src_out <= sel_write_src;
            branch_out <= branch;
            jump_out <= jump;
        end

endmodule
