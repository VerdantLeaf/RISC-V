`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 07/22/2025 10:47:24 AM
// Design Name: 
// Module Name: forwarding_unit
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


module forwarding_unit #(

    NUM_REGS = 32,
    REG_SEL = $clog2(NUM_REGS)

    )(

    input [REG_SEL - 1 : 0] ex_rs1,
    input [REG_SEL - 1 : 0] ex_rs2,
    input [REG_SEL - 1 : 0] mem_rd,
    input [REG_SEL - 1 : 0] wb_rd,

    input mem_reg_write,
    input wb_reg_write,

    output [1 : 0] forward1, // 00 -> Don't forward, 01 -> Forward from WB
    output [1 : 0] forward2  // 10 -> Forward from MEM

    );

    always @(*) begin
        forward1 = 2'b00;
        forward2 = 2'b00;

        // if the mem instruction writes back to not x0 and the rd is the same as the rs1/2 of ex stage
        if(mem_reg_write && (mem_rd != 0) && (mem_rd == ex_rs1)) forward1 = 2'b10;
        if(mem_reg_write && (mem_rd != 0) && (mem_rd == ex_rs2)) forward2 = 2'b10;

        // if the writeback instruction writes back to not x0 and there's not a mem stage hazard, and if the
        // writeback destination register is the same as rs1/2 of ex stage
        if(wb_reg_write && (wb_rd != 0) && !(mem_reg_write && (mem_rd == ex_rs1)) && (wb_rd == ex_rs1)) forward1 = 2'b01;
        if(wb_reg_write && (wb_rd != 0) && !(mem_reg_write && (mem_rd == ex_rs2)) && (wb_rd == ex_rs2)) forward2 = 2'b01;

    end
endmodule
