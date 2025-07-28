`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 07/28/2025 02:01:37 PM
// Design Name: 
// Module Name: mux_gen_tb
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


module mux_gen_tb #(

    NUM_INPUTS = 2,
    DATA_WIDTH = 32

    )();

    reg [DATA_WIDTH * NUM_INPUTS - 1 : 0] data;
    reg [$clog2(NUM_INPUTS) - 1:0] sel;
    wire [DATA_WIDTH - 1:0] out;

    mux_gen dut(
        .data(data),
        .sel(sel),
        .out(out)
    )

endmodule
