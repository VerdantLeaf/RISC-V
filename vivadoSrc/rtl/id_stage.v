`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/17/2025 11:06:51 PM
// Design Name: 
// Module Name: id_stage
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


module id_stage #(

    WORD_SIZE = 32,
    NUM_REGS = 32,
    ADDR_SIZE = 10

    )(
    
    input clk, 
    input rst,

    input [WORD_SIZE - 1 : 0] instr,    // Instruction to be decoded
    
    output [WORD_SIZE - 1 : 0] immd, 
    output alu_op,                      // Tells the ALU which operation to do
    output reg_write,                   // Says if instruction writes to register
    output mem_read                     // Says if instruction reads from memory

    );

    wire [$clog2(NUM_REGS) - 1 : 0] rs1, rs2;
    wire [WORD_SIZE - 1 : 0] rs1Data, rs2Data;

    regfile registerfile(
        .clk(clk),
        .rst(rst),
        .rs1(rs1),
        .rs1Data(rs1Data),
        .rs2(rs2),
        .rs2Data(rs2Data),
        .wCtrl(wCtrl),
        .wSel(wSel),
        .wData(wData)
    );

    immd_gen immediategenerator();

endmodule
