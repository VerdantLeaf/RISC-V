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

module i_mem(
    input clk,
    input [31:0] addr,
    output reg [31:0] instr
    );
    
    // My orignal plan was to use a BRAM IP, but that got annoyingly complex,
    // and felt that it was distracting from what I want to do
    
    // 1024 word ROM
    reg [31:0] rom [0 : 1023]; // note: change for parameterization
    wire [9:0] index = addr[11:2];
    
    initial begin
        $readmemh("../../../../../programs/program.mem", rom);    
    end

    
    always @(posedge clk) begin
        instr <= rom[index];
    end

endmodule
