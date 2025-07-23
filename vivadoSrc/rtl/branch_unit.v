`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/17/2025 11:06:51 PM
// Design Name: 
// Module Name: branch_unit
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

/// @brief Place holder for more complex branch prediciton in the future
module branch_unit #(

    WORD_SIZE = 32,
    NUM_REGS = 32,
    REG_SEL = $clog2(NUM_REGS)

    )(

    input branch,
    input jump,
    input zero,

    output flush_ifid,
    output flush_idex,
    output flush_exmem,
    output flush_memwb,

    output pc_src

    );

    // In the future, this can be much more complicated, but for now, I just need it
    // to flush the instructions in the pipeline when we resolve that we're jumping/branching
    always @(*) begin
        if(jump || (branch && zero))  begin
            
        end else begin
            
        end
    end

endmodule
