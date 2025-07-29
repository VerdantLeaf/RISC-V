`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 07/22/2025 01:42:25 PM
// Design Name: 
// Module Name: wb_stage
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


module wb_stage #(

    WORD_SIZE = 32

    )(

    input [WORD_SIZE - 1 : 0] memory_data,
    input [WORD_SIZE - 1 : 0] alu_data,
    input mem_to_reg,

    output [WORD_SIZE - 1 : 0] write_data

    );

    mux_2_to_1 #(
        .DATA_WIDTH(32)
    ) write_select_mux(
        .data0(alu_data),
        .data1(memory_data),
        .sel(mem_to_reg),
        .out(write_Data)
    );
    
endmodule
