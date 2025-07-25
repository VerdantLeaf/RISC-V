`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 07/24/2025 11:45:21 AM
// Design Name: 
// Module Name: ex_stage_tb
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

module ex_stage_tb #(

    WORD_SIZE = 32,
    NUM_REGS = 32,
    REG_SEL = $clog2(NUM_REGS)

    )();
    reg [ADDR_SIZE - 1 : 0] pc;
    
    reg [WORD_SIZE - 1 : 0] data1;
    reg [WORD_SIZE - 1 : 0] wb_forward1;
    reg [WORD_SIZE - 1 : 0] mem_forward1;

    reg [WORD_SIZE - 1 : 0] data2;
    reg [WORD_SIZE - 1 : 0] wb_forward2;
    reg [WORD_SIZE - 1 : 0] mem_forward2;

    reg [WORD_SIZE - 1 : 0] immd;

    reg [1 : 0] sel_forward1;
    reg [1 : 0] sel_forward2;
    reg [3:0] alu_op;

    reg alu_src;

    reg [1:0] data_size;
    reg data_sign;

    wire [ADDR_SIZE - 1 : 0] branch_target;
    wire [WORD_SIZE - 1 : 0] result;
    wire [WORD_SIZE - 1 : 0] write_data;
    wire zero;

    ex_stage dut(
        .pc(pc),

        .data1(data1),
        .wb_forward1(wb_forward1),
        .mem_forward1(mem_forward1),

        .data2(data2),
        .wb_forward2(wb_forward2),
        .mem_forward2(mem_forward2),

        .rs1(rs1),
        .rs2(rs2),
        .rd(rd),

        .immd(immd),

        .sel_forward1(sel_forward1),
        .sel_forward2(sel_forward2),

        .alu_op(alu_op),
        .zero(zero),
        .alu_src(alu_src),

        .write_data(write_data),
        .data_size(data_size),
        .data_sign(data_sign),

        .branch_target(branch_target),

        .result(result)

    );

    integer pass_count = 0, fail_count = 0;

    task check_test;
        input integer line_num;
        input [WORD_SIZE - 1 : 0] t_data1, t_data2, t_wb_f1, t_mem_f1, t_wb_f2, t_mem_f2;
        input [1:0] t_f1_sel, t_f2_sel;
        input [3:0] t_alu_op;
        input t_alu_src;
        input [WORD_SIZE - 1 : 0] t_immd;
        input [WORD_SIZE - 1 : 0] t_pc;
        input [4:0] t_rs1, t_rs2, t_rd;

        input [WORD_SIZE - 1 : 0] e_result, e_branch_target;
        input e_zero;

        begin
            // Apply inputs
            data1 = t_data1; data2 = t_data2;
            wb_forward1 = t_wb_f1; mem_forward1 = t_mem_f1;
            wb_forward2 = t_wb_f2; mem_forward2 = t_mem_f2;
            sel_forward1 = t_f1_sel; sel_forward = t_f2_sel;
            alu_op = t_alu_op;
            alu_src = t_alu_src;
            immd = t_immd;
            pc = t_pc;
            rs1 = t_rs1; rs2 = t_rs2; rd = t_rd;
            #5;

            // Compare
            if ((result === e_result) && (zero === e_zero) && (branch_target === e_branch_target)) begin
               $display("PASS @ line %0d", line_num);
                pass_count = pass_count + 1;
            end else begin
                $display("FAIL @ line %0d | PC=%0d | ALU_OP=%b | Got: Result=%h, Zero=%b, Branch_Target=%h | Expected: Result=%h, Zero=%b, Branch_Target=%h",
                         line_num, pc, alu_op, result, zero, branch_target, e_result, e_zero, e_branch_target);
                fail_count = fail_count + 1;
            end
        end
    endtask



    initial begin
        $display("---- Starting EX Stage Self-Checking Testbench ----");
        
        // ---- Basic ALU Tests ----
        check_test(`__LINE__,
            10, 5, 0, 0, 0, 0,                  // td1, td2, twb1, tmem1, twb2, tmem2
            2'b00, 2'b00, `ALU_OP_ADD,          // t1sel, t2sel, alu_op
            0, 0, 100,                          // talusrc, t_immd, t_pc
            1, 2, 3,                            // trs1, trs2, trd 
            15, 100, 0);                        // eresult, e_branch_target, e_zero

        check_test(`__LINE__,
            1, 5, 0, 0, 0, 0,                  // td1, td2, twb1, tmem1, twb2, tmem2
            2'b00, 2'b00, `ALU_OP_ADD,          // t1sel, t2sel, alu_op
            0, 0, 100,                          // talusrc, t_immd, t_pc
            1, 2, 3,                            // trs1, trs2, trd 
            15, 100, 0);                        // eresult, e_branch_target, e_zero

        check_test(`__LINE__,
            10, 5, 0, 0, 0, 0,                  // td1, td2, twb1, tmem1, twb2, tmem2
            2'b00, 2'b00, `ALU_OP_ADD,          // t1sel, t2sel, alu_op
            0, 0, 100,                          // talusrc, t_immd, t_pc
            1, 2, 3,                            // trs1, trs2, trd 
            15, 100, 0);                        // eresult, e_branch_target, e_zero

        check_test(`__LINE__,
            10, 5, 0, 0, 0, 0,                  // td1, td2, twb1, tmem1, twb2, tmem2
            2'b00, 2'b00, `ALU_OP_ADD,          // t1sel, t2sel, alu_op
            0, 0, 100,                          // talusrc, t_immd, t_pc
            1, 2, 3,                            // trs1, trs2, trd 
            15, 100, 0);                        // eresult, e_branch_target, e_zero

        check_test(`__LINE__,
            10, 5, 0, 0, 0, 0,                  // td1, td2, twb1, tmem1, twb2, tmem2
            2'b00, 2'b00, `ALU_OP_ADD,          // t1sel, t2sel, alu_op
            0, 0, 100,                          // talusrc, t_immd, t_pc
            1, 2, 3,                            // trs1, trs2, trd 
            15, 100, 0);                        // eresult, e_branch_target, e_zero

        check_test(`__LINE__, 10, 5, 0,0,0,0, 2'b00,2'b00, 4'b1000,0,0,100,1,2,3, 5,    100,0);    // SUB
        check_test(`__LINE__, 5,  5, 0,0,0,0, 2'b00,2'b00, 4'b1000,0,0,100,1,2,3, 0,    100,1);     // SUB -> zero=1

        // ---- Forwarding Tests ----
        check_test(`__LINE__, 99, 0, 123,456,77,88, 2'b01,2'b10, 4'b0000,0,0,100,1,2,3, 123+456,0,100);

        // ---- Immediate ALU Src ----
        check_test(`__LINE__, 20, 5, 0,0,0,0, 2'b00,2'b00, 4'b0000,1,32'd100,200,4,5,6, 120,0,200);

        // ---- Branch Target ----
        check_test(`__LINE__, 0, 0, 0,0,0,0, 2'b00,2'b00, 4'b0000,0,32'd16,32'd100,1,2,3, 0,0,(100 + (16 << 2)));


        $display("---- TESTS FINISHED ----");
        $display("TOTAL: %0d PASSED | %0d FAILED ", pass_count, fail_count);
        $finish;
    end
endmodule
