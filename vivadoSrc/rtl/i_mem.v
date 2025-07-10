`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/17/2025 11:06:51 PM
// Design Name: 
// Module Name: i_mem
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

// note: parameterize if you want to later

module i_mem #(
    parameter NUM_WORDS = 1024,     // 4KB mem
    parameter WORD_SIZE = 32,
    parameter ADDR_SIZE = 10
    )(
    input clk,
    input [ADDR_SIZE - 1:0] addr,
    output reg [WORD_SIZE - 1:0] instr
    );
    

    reg [WORD_SIZE - 1:0] rom [0 : NUM_WORDS - 1];
    wire [ADDR_SIZE - 1: $clog2(WORD_SIZE / 8)] index = addr[ADDR_SIZE - 1 : $clog2(WORD_SIZE / 8)];
    
    initial begin
        $readmemh("../../../../../programs/program.mem", rom);    
    end
    
    always @(posedge clk) begin
        instr <= rom[index];
    end

endmodule
