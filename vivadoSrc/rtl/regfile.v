`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: myself
// Engineer: Kyle
// 
// Create Date: 05/17/2025 10:55:15 PM
// Design Name: 
// Module Name: regfile
// Project Name: RISC-V Implementation
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


module regfile #(
    
    WORD_SIZE = 32,
    NUM_REGS = 32,
    REG_SEL = $clog2(NUM_REGS)
    
    )(
    input rst,
    input clk,
    // Read port 1
    input [REG_SEL - 1:0] rs1,
    output [WORD_SIZE - 1:0] rs1Data,
    // Read port 2
    input [REG_SEL - 1:0] rs2,
    output [WORD_SIZE - 1:0] rs2Data,
    // Write port
    input wCtrl,
    input [REG_SEL - 1:0] wSel,
    input  wire [WORD_SIZE - 1:0] wData
    );
    
    wire [WORD_SIZE - 1:0] regOutput [0: NUM_REGS - 1];
    wire [NUM_REGS - 1:0] wEnable;

    // Generate enable signals for registers
    genvar i;
    generate
        // wEnable[0] == 0 and wEnable[i] == 1 when write control and selection are valid for each i
        for (i = 0; i < NUM_REGS; i= i + 1) begin : gen_wEnable
            assign wEnable[i] = (wCtrl && (wSel == i) && (i != 0));
        end
    endgenerate
    
    // Generate NUM_REGS registers
    generate
        for (i = 0; i < NUM_REGS; i = i + 1) begin : gen_registers
            register32 reg_i (
                .clk(clk),
                .rst(rst),
                .en(wEnable[i]),
                .d(wData),
                .q(regOutput[i])
            );
        end
    endgenerate

    // If the selected reg is 0, then give zero, else give reg value
    assign rs1Data = (rs1 == {$clog2(NUM_REGS){1'b0}}) ? {WORD_SIZE{1'b0}} : regOutput[rs1];
    assign rs2Data = (rs2 == {$clog2(NUM_REGS){1'b0}}) ? {WORD_SIZE{1'b0}} : regOutput[rs2];
    
endmodule
