`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: myself
// Engineer: kyle
// 
// Create Date: 05/20/2025 10:10:11 AM
// Design Name: 
// Module Name: ex_mem_reg
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


module ex_mem_reg #(

    WORD_SIZE = 32,
    NUM_REGS = 32,
    REG_SEL = $clog2(NUM_REGS),
    ADDR_SIZE = 10

    )(
 
    input clk,
    input rst,
    input flush,
    input stall,

    input [ADDR_SIZE - 1 : 0] branch_target,    // PC of branch target
    input [WORD_SIZE - 1 : 0] alu_result,       // The result of the ALU operation
    input [REG_SEL - 1 : 0] rd,                 // Select register to write to

    input alu_zero,             // is alu result zero (if it is, we branch)
    input branch,               // is instruction a branch instruction
    input jump,                 // is instruction a jump instruction
    input mem_read,             // enable mem read
    input mem_write,            // enable mem write
    input reg_write,            // enable write back for memory

    input [WORD_SIZE - 1 : 0] write_data,   // Data written to memory
    input [1:0] data_size,                  // Tells the size of the data 00->byte, 01->halfword, 10->word
    input data_sign,                        // Says if the data is signed or not
    
    output reg [ADDR_SIZE - 1 : 0] branch_target_out,    
    output reg [WORD_SIZE - 1 : 0] alu_result_out,       
    output reg [REG_SEL - 1 : 0] rd_out,  

    output reg alu_zero_out,             
    output reg branch_out,   
    output reg jump_out,            
    output reg mem_read_out,             
    output reg mem_write_out,            
    output reg reg_write_out,

    output reg [WORD_SIZE - 1 : 0] write_data_out,       
    output reg data_sign_out,
    output reg [1:0] data_size_out

    );
    
    always @(posedge clk or posedge rst) begin
        if (rst || flush) begin
            branch_target_out <= {ADDR_SIZE{1'b0}};
            alu_result_out <= {WORD_SIZE{1'b0}};
            write_data_out <= {WORD_SIZE{1'b0}};
            rd_out <= {REG_SEL{1'b0}};

            alu_zero_out <= 1'b0; 
            branch_out <= 1'b0;
            jump_out <= 1'b0;
            mem_read_out <= 1'b0;
            mem_write_out <= 1'b0;
            reg_write_out <= 1'b0;

            data_sign_out <= 1'b0;
            data_size_out <= 2'b00;
            
        end else if(!stall) begin
            branch_target_out <= branch_target;
            alu_result_out <= alu_result;
            write_data_out <= write_data;
            rd_out <= rd;

            alu_zero_out <= alu_zero; 
            branch_out <= branch;
            jump_out <= jump;
            mem_read_out <= mem_read;
            mem_write_out <= mem_write;
            reg_write_out <= reg_write;

            data_sign_out <= data_sign;
            data_size_out <= data_size;
        end
    end
endmodule