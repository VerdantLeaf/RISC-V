`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 07/15/2025 12:41:30 PM
// Design Name: 
// Module Name: id_stage_tb
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

`include "defines.vh"

module id_stage_tb #(

    WORD_SIZE = 32,
    NUM_REGS = 32,
    REG_SEL = $clog2(NUM_REGS),
    ADDR_SIZE = 10

    )();

    reg clk;
    reg rst;

    reg [WORD_SIZE - 1:0] instr;
    reg reg_write;
    reg [WORD_SIZE - 1:0] rd_data;
    reg [WORD_SIZE - 1:0] rd_select;

    reg [WORD_SIZE - 1:0] immd;
    reg [WORD_SIZE - 1:0] data1;
    reg [WORD_SIZE - 1:0] data2;
    reg [3:0] alu_op;
    reg [REG_SEL - 1:0] destination;

    reg write_reg;
    reg mem_write;
    reg mem_read;
    reg src_immd;
    reg branch;

    id_stage dut(
        // inputs
        .clk(clk),
        .rst(rst),
        .instr(instr),
        .reg_write(reg_write),
        .rd_data(rd_data),
        .rd_select(rd_select),

        // outputs
        .immd(immd),
        .data1(data1),
        .data2(data2),
        .alu_op(alu_op),
        .destination(destination),

        .write_reg(write_reg),
        .mem_write(mem_write),
        .mem_read(mem_read),
        .src_immd(src_immd),
        .branch(branch)
    );

    initial clk = 0;
    always #5 clk = ~clk;

    initial begin
    
        rst = 1;
        instr = 32'b0;
        reg_write = 0;
        rd_data = 32'b0;
        rd_select = {REG_SEL{1'b0}};

        @posedge(Clk);
        rst = 0;

        #20 // SHow that all zeros shows no 

        @posedge(clk);          // Give ID an I type instruction
        instr = 32'h00c00713;   // addi x14, x0, 12 -> data1 = 0, data2 = 12
                                // Should see src_immd/write_reg = 1 &
                                // mem_write/mem_read/branch = 0, alu_op = 1000
        reg_write = 1;          
        rd_select = 5'd29;      
        rd_data = 32'h00011000; // x29 := 69632

        @posedge(clk);
        instr = 32'h00000000;   // Clear instruction

        reg_write = 1;          
        rd_select = 5'd14;      // write the 12 from to x14
        rd_data = 32'd12;       // x14 := 12

        @posedge(clk);          // Give ID an R-type instruction
        instr = 32'h00ee8c33;   // add x24, x29, x14 -> data1 = 69632 & data2 = 12
                                // Should see write_reg = 1 and mem_write = 0,
                                // mem_read/src_immd/branch = 0, alu_op = 0000

        reg_write = 1;          // Write the result to the 
        rd_select = 5'd24;      // x24 register, simulating the add instruction
        rd_data = 32'h00011000; // x24 := 69644

        @posedge(clk);          // Give ID a load instruction
        instr = 32'h200c2803;   // lw x18, 512(x24) -> data1 = 69644 & data2 = 512
                                // Should see write_reg/mem_read/src_immd = 1 &
                                // mem_write/branch = 0, alu_op = 1010

        reg_write = 1;          
        rd_select = 5'd18;      // Load a 71 from memory into x18 
        rd_data = 32'd71;       // x18 := 71

        @posedge(clk);          // Give ID an S type instruction
        instr = 32'hed071fa3;   // sh x16, -289(x14) -> data1 = 12 & data2 = -289
                                // Should see mem_write/src_immd = 1 &
                                // mem_read/write_reg/branch =0, alu_op = 

    end

endmodule
