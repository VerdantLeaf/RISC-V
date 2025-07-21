`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: myself
// Engineer: kyle
// 
// Create Date: 05/17/2025 10:55:15 PM
// Design Name: 
// Module Name: mux2
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

module mux_gen
    #(
    NUM_INPUTS = 2,
    DATA_WIDTH = 32
    )(
    // data is concatenated to each other
    input wire [DATA_WIDTH * NUM_INPUTS - 1 : 0] data,
    input wire [$clog2(NUM_INPUTS) - 1:0] sel,
    output reg [DATA_WIDTH - 1:0] out
    );
    always @(*) begin
        if (sel < NUM_INPUTS) out = data[sel * DATA_WIDTH +: DATA_WIDTH]; // Start selection slice at sel * width
        else out = {DATA_WIDTH{1'b0}}; // Output all zeros for out of range selections
    end
    
endmodule
