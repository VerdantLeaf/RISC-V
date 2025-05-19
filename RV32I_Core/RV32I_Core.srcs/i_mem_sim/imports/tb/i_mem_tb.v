`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/19/2025 01:40:36 PM
// Design Name: 
// Module Name: i_mem_tb
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


module i_mem_tb;

    reg clk;
    reg [31:0] addr;
    wire [31:0] instr;
    
    i_mem dut(
        .clk(clk),
        .addr(addr),
        .instr(instr)
    ); 
    
    initial clk = 0;
    always #5 clk = ~clk;
    
    // idk if there is a great/better way to do this
    initial begin
        @(posedge clk);
        addr <= 32'h00000000;
        @(posedge clk);
        addr <= 32'h00000004;
        @(posedge clk);
        addr <= 32'h00000008;
        @(posedge clk);
        addr <= 32'h0000000c;
        @(posedge clk);
        addr <= 32'h00000010;
        @(posedge clk);
        addr <= 32'h00000014;
        @(posedge clk);
        addr <= 32'h00000018;
        @(posedge clk);
        addr <= 32'h0000001c;
        @(posedge clk);
        addr <= 32'h00000020;
        $finish;
    end
    
endmodule
