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
    integer i;
    initial begin
        addr = 0;
        for (i = 0; i < 32; i = i + 1) begin
            @(posedge clk);
            addr = i << 2; // Word-aligned addresses
            @(posedge clk);
            $display("addr = %h, instr = %h", addr, instr);
        end
        $finish;
    end
    
endmodule
