`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/22/2025 10:28:31 AM
// Design Name: 
// Module Name: if_stage_tb
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


module if_stage_tb;
    
    // regs for inputs, wires for outputs
    reg clk;
    reg rst;
    reg [31:0] pc_branch;
    wire [31:0] instr;
    wire [31:0] pc_next;
    reg pcsrc;
    reg en;

    if_stage dut(
        .clk(clk),
        .rst(rst),
        .pc_branch(pc_branch),
        .instr(instr),
        .pc_next(pc_next),
        .pcsrc(pcsrc),
        .en(en)
    );

    initial clk = 0;
    always #5 clk = ~clk;

    initial begin
        rst = 1;
        en = 1;
        pcsrc = 1;
        pc_branch = 32'b0;

        @(posedge clk);
        pcsrc = 0;

        @(posedge clk);
        rst = 0;

        // Increment through instructions, showing mem addr increasing
        #60

        @(posedge clk);
        pc_branch = 32'b0; // Grab instruction number 7
        pcsrc = 1;

        @(posedge clk);
        pcsrc = 0;

        #60

        // Then change pc branch without setting src to branch
        @(posedge clk);
        pc_branch = 32'h94; // Grabs the 38th instr (in program.mem it's 0x00000025)

        #20

        // and then jump to 0x14
        @(posedge clk);
        pcsrc = 1;
        @(posedge clk);
        pcsrc = 0;
        pc_branch = 32'b0;
        
        // Progress through that a few times
        #60
        
        $finish;
    end
endmodule
