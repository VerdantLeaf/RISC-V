`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 07/28/2025 02:31:54 PM
// Design Name: 
// Module Name: mux_2_to_1
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


module mux_2_to_1 #(

    DATA_WIDTH = 32

    )(
        input [DATA_WIDTH - 1 : 0] data0,
        input [DATA_WIDTH - 1 : 0] data1,
        input sel,
        output reg [DATA_WIDTH - 1 : 0] out
    );

    always @(*) begin
        case (sel)
            1'b0: out = data0;
            1'b1: out = data1;
        endcase
    end
endmodule
