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


module ex_mem_reg(
 
    input clk,
    input rst,
    // Data
    input [31:0] branch_target,     // PC of branch address
    input [31:0] rdata2,            // Data written to memory
    
    // Ctrl signals
    input [4:0] rd,                 // Select register to write to
    input en_write_reg,             // enable register writing in regfile

    input alu_zero,                 // is alu result zero
    
    input branch,                   // is operation a branch operation
    input en_mem_read,              // enable mem read
    input en_mem_write,             // enable mem write
    input write_source              // Select write from data memory or ALU result
    
    );
    
    

endmodule