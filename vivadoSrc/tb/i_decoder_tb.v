`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: myself
// Engineer: kyle
// 
// Create Date: 07/17/2025 03:02:22 PM
// Design Name: 
// Module Name: i_decoder_tb
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

module i_decoder_tb #(

    WORD_SIZE = 32,
    NUM_REGS = 32,
    REG_SEL = $clog2(NUM_REGS),
    ADDR_SIZE = 10

    )();

    reg [WORD_SIZE - 1 : 0] instr;

    wire [3:0] alu_op;
    wire [REG_SEL - 1 : 0] rs1;
    wire [REG_SEL - 1 : 0] rs2;
    wire [REG_SEL - 1 : 0] rd;

    wire mem_read;   
    wire mem_write;   
    wire mem_to_reg;
    wire reg_write_out;
    wire alu_src;
    wire branch;
    wire jump;

    i_decoder dut(
        .instr(instr),
        .alu_op(alu_op),
        .rs1(rs1),
        .rs2(rs2),
        .rd(rd),
        .mem_read(mem_read),
        .mem_write(mem_write),
        .mem_to_reg(mem_to_reg),
        .reg_write_out(reg_write_out),
        .alu_src(alu_src),
        .branch(branch),
        .jump(jump)
    );

    // =====================================
    // RESULTS CHECKER
    // =====================================
    task check_signals;
        input integer line_num;
        input [REG_SEL - 1 : 0] e_rd, e_rs1, e_rs2;
        input [3 : 0] e_alu_op;
        input e_mem_read, e_mem_write, e_mem_to_reg, e_reg_write_out, e_alu_src, e_branch, e_jump;
        begin
            
            if (rd !== e_rd || rs1 !== e_rs1 || rs2 !== e_rs2) begin 
                $display("REG FAIL @ line %0d:\nExp: rd= %d, rs1= %d, rs2= %d\nGot: rd= %d, rs1= %d, rs2= %d",
                    line_num, e_rd, e_rs1, e_rs2, rd, rs1, rs2);
            end else begin
                $display("REG PASS @ line %0d", line_num);
            end

            if (alu_op        !== e_alu_op        ||
                mem_read      !== e_mem_read      ||
                mem_write     !== e_mem_write     ||
                mem_to_reg    !== e_mem_to_reg    ||
                reg_write_out !== e_reg_write_out ||
                alu_src       !== e_alu_src       ||
                branch        !== e_branch        ||
                jump          !== e_jump) begin
            // Vivado prefers this all on one line lol
            $display("LINE FAIL @ line %0d:\nExp: alu= %b, mem_read= %b, mem_write= %b, mem_to_reg= %b, reg_write_out= %b, alu_src= %b, branch= %b, jump= %b\nGot: alu= %b, mem_read= %b, mem_write= %b, mem_to_reg= %b, reg_write_out= %b, alu_src= %b, branch= %b, jump= %b",
                line_num, e_alu_op, e_mem_read, e_mem_write, e_mem_to_reg, e_reg_write_out, e_alu_src, e_branch, e_jump, alu_op, mem_read, mem_write, mem_to_reg, reg_write_out, alu_src, branch, jump);
            end else begin
                $display("LINE PASS @ line %0d", line_num);
            end
        end
    endtask

    // =====================================
    // TEST PROCEDURE
    // =====================================
    initial begin
        
        instr = 32'h00ee8c33; // add x24, x29, x14
        #10;
        check_signals(`__LINE__, 5'd24, 5'd29, 5'd14, `ALU_OP_ADD,
            0, 0, 0, 1, 0, 0, 0);
        #10;
        instr = 32'h400bd633; // sra x12, x23, x0
        #10;
        check_signals(`__LINE__, 5'd12, 5'd23, 5'd0, `ALU_OP_SRA,
            0, 0, 0, 1, 0, 0, 0);
        #10;
        instr = 32'h00eb9013; // slli x0, x23, 14
        check_signals(`__LINE__, 5'd0, 5'd23, 5'd0, `ALU_OP_SLL,
            0, 0, 0, 0, 1, 0, 0);
        #10;
        // check signals
        #10;
        // instr
        #10;
        // check signals
        #10;
        // instr
        #10;
        // check signals
        #10;
        // instr
        #10;
        // check signals
        #10;

        $finish;
    end

endmodule
