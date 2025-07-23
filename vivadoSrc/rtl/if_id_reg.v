`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: myself
// Engineer: kyle
// 
// Create Date: 05/20/2025 10:10:11 AM
// Design Name: 
// Module Name: if_id_reg
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


module if_id_reg #(
    
    WORD_SIZE = 32

    )(
        
    input clk,
    input rst,
    input flush,
    input stall,

    input [WORD_SIZE - 1:0] instr,
    input [WORD_SIZE - 1:0] pc,

    output reg [WORD_SIZE - 1:0] instr_out,
    output reg [WORD_SIZE - 1:0] pc_out
    );

    // if rst flush, if not then update values
    always @(posedge clk or posedge rst) begin
        if(rst || flush) begin
            pc_out <= {WORD_SIZE{1'b0}};
            instr_out <= {WORD_SIZE{1'b0}};
        end else if (!stall) begin
            pc_out <= pc;
            instr_out <= instr;
        end
    end

endmodule 