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

module mux_3_to_1 #(
    DATA_WIDTH = 32

    )(
        input [DATA_WIDTH - 1 : 0] data0,
        input [DATA_WIDTH - 1 : 0] data1,
        input [DATA_WIDTH - 1 : 0] data2,
        input [1:0]sel,
        output reg [DATA_WIDTH - 1 : 0] out
    );

    always @(*) begin
        case (sel)
            2'b00: out = data0;
            2'b01: out = data1;
            2'b10: out = data2;
            default: out = {DATA_WIDTH{1'b0}};
        endcase
    end
endmodule
