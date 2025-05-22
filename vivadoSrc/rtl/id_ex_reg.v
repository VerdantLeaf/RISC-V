`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
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


module id_ex_reg(
    input clk,
    input rst,
    // Data
    input [31:0] rs1, // register file source
    input [31:0] rs2,
    input [31:0] immd,
    input [31:0] pc, // PC needed for branch/jump target

    output reg [31:0] rs1_out,
    output reg [31:0] rs2_out,
    output reg [31:0] immd_out,
    output reg [31:0] pc_out,

    // Ctrl signals
    input reg_write,
    input read_mem,
    input write_mem,
    input alu_op,
    input alu_src,
    input mem_to_reg,
    input branch,
    input jump,    

    output reg reg_write_out,
    output reg read_mem_out,
    output reg write_mem_out,
    output reg alu_op_out,
    output reg alu_src_out,
    output reg mem_to_reg_out,
    output reg branch_out,
    output reg jump_out

    );

    always @(posedge clk or posedge rst)
        if (rst) begin
            rs1_out <= 32'b0;
            rs2_out <= 32'b0;
            immd_out <= 32'b0;
            pc_out <= 32'b0;
            reg_write_out <= 0;
            read_mem_out <= 0;
            write_mem_out <= 0;
            alu_op_out <= 0;
            alu_src_out <= 0;
            mem_to_reg_out <= 0;
            branch_out <= 0;
            jump_out <= 0;
        end else begin
            rs1_out <= rs1;
            rs2_out <= rs2;
            immd_out <= immd;
            pc_out <= pc;
            reg_write_out <= reg_write;
            read_mem_out <= read_mem;
            write_mem_out <= write_mem;
            alu_op_out <= alu_op;
            alu_src_out <= alu_src;
            mem_to_reg_out <= mem_to_reg;
            branch_out <= branch;
            jump_out <= jump;
        end

endmodule
