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
    REG_SEL = $clog2(NUM_REGS),
    ADDR_SIZE = 10

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
    reg branch;
    reg jump;
    reg alu_src;

    wire zero;
    wire [ADDR_SIZE - 1 : 0] branch_target;
    wire [WORD_SIZE - 1 : 0] result;
    wire [WORD_SIZE - 1 : 0] write_data;

    ex_stage dut(
        .pc(pc),

        .data1(data1),
        .mem_forward1(mem_forward1),
        .wb_forward1(wb_forward1),

        .data2(data2),
        .mem_forward2(mem_forward2),
        .wb_forward2(wb_forward2),

        .immd(immd),

        .sel_forward1(sel_forward1),
        .sel_forward2(sel_forward2),

        .alu_op(alu_op),
        .alu_src(alu_src),
        .branch(branch),
        .jump(jump),

        .zero(zero),
        .branch_target(branch_target),
        .result(result),
        .write_data(write_data)

    );

    integer pass_count = 0, fail_count = 0;

    task check_test;
        input integer line_num;
        input [WORD_SIZE - 1 : 0] t_data1, t_data2, t_mem_f1, t_wb_f1, t_mem_f2, t_wb_f2;
        input [1:0] t_f1_sel, t_f2_sel;
        input [3:0] t_alu_op;
        input t_alu_src;
        input [WORD_SIZE - 1 : 0] t_immd;
        input [ADDR_SIZE - 1 : 0] t_pc;
        input t_jump;

        input [WORD_SIZE - 1 : 0] e_result, e_branch_target;
        input e_zero;

        begin
            // Apply inputs
            data1 = t_data1; data2 = t_data2;
            wb_forward1 = t_wb_f1; mem_forward1 = t_mem_f1;
            wb_forward2 = t_wb_f2; mem_forward2 = t_mem_f2;
            sel_forward1 = t_f1_sel; sel_forward2 = t_f2_sel;
            alu_op = t_alu_op;
            alu_src = t_alu_src;
            immd = t_immd;
            pc = t_pc;
            jump = t_jump;
            #5;

            // Compare
            if ((result === e_result) && (zero === e_zero) && (branch_target === e_branch_target)) begin
               $display("PASS @ line %0d", line_num);
                pass_count = pass_count + 1;
            end else begin
                $display("***FAIL @ line %0d***\nGot: Result=%h, Zero=%b, Branch_Target=%d\nExp: Result=%h, Zero=%b, Branch_Target=%d\n",
                         line_num, result, zero, branch_target, e_result, e_zero, e_branch_target);
                fail_count = fail_count + 1;
            end
        end
    endtask



    initial begin
        $display("---- Starting EX Stage Self-Checking Testbench ----");
        pc = 0; // init signals to add zero and zero from the first selection of the muxes
        data1 = 0 ;
        wb_forward1 = 0;
        mem_forward1 = 0;
        data2 = 0;
        wb_forward2 = 0;
        mem_forward2 = 0;
        immd = 0;
        sel_forward1 = 0;
        sel_forward2 = 0;
        alu_op = `ALU_OP_ADD;
        branch = 0;
        jump = 0;
        alu_src = 0;

        #10;

        // ---- Basic ALU Tests ---- (ALU has testbench, so don't need to test everything)
        check_test(`__LINE__,
            10, 5, 0, 0, 0, 0,                  // td1, td2, tmem1, twb1, tmem2, twb2
            2'b00, 2'b00, `ALU_OP_ADD,          // t1sel, t2sel, alu_op
            0, 0, 100, 0,                       // talusrc, t_immd, t_pc, t_jump
            15, 100, 0);                        // eresult, e_branch_target, e_zero

        check_test(`__LINE__,
            255, 255, 0, 0, 0, 0,               // td1, td2, tmem1, twb1, tmem2, twb2
            2'b00, 2'b00, `ALU_OP_SUB,          // t1sel, t2sel, alu_op
            0, 0, 100, 0,                       // talusrc, t_immd, t_pc, t_jump
            0, 100, 1);                         // eresult, e_branch_target, e_zero

        check_test(`__LINE__, 
            32'hFEDCBA98, 24, 0,0,0,0,          // td1, td2, tmem1, twb1, tmem2, twb2
            2'b00, 2'b00, `ALU_OP_SRL,          // t1sel, t2sel, alu_op
            0, 0, 100, 0,                       // talusrc, t_immd, t_pc, t_jump
            32'h000000FE, 100, 0);              // eresult, e_branch_target, e_zero

        check_test(`__LINE__, 
            32'h0123CDEF, 32'h00000000, 0,0,0,0,    // td1, td2, tmem1, twb1, tmem2, twb2
            2'b00, 2'b00, `ALU_OP_AND,              // t1sel, t2sel, alu_op
            0, 0, 100, 0,                           // talusrc, t_immd, t_pc, t_jump
            0, 100, 1);                             // eresult, e_branch_target, e_zero

        // ---- Forwarding Tests ----
        check_test(`__LINE__,
            324, 2, 4, 6, 8, 16,                // td1, td2, tmem1, twb1, tmem2, twb2
            2'b00, 2'b01, `ALU_OP_SUB,          // t1sel, t2sel, alu_op
            0, 0, 100, 0,                       // talusrc, t_immd, t_pc, t_jump
            (324 - 8), 100, 0);                 // eresult, e_branch_target, e_zero

        check_test(`__LINE__,
            32'h01234567, 0, 0, 0, 0, 12,       // td1, td2, tmem1, twb1, tmem2, twb2
            2'b00, 2'b10, `ALU_OP_SLL,          // t1sel, t2sel, alu_op
            0, 0, 100, 0,                       // talusrc, t_immd, t_pc, t_jump
            (32'h01234567 << 12), 100, 0);              // eresult, e_branch_target, e_zero

        check_test(`__LINE__,
            0, 5, 5, 0, 0, 0,                   // td1, td2, tmem1, twb1, tmem2, twb2
            2'b01, 2'b00, `ALU_OP_SLT,          // t1sel, t2sel, alu_op
            0, 0, 100, 0,                       // talusrc, t_immd, t_pc, t_jump
            0, 100, 0);                         // eresult, e_branch_target, e_zero

        check_test(`__LINE__,
            32'h81111111, 5, 0, 0, 32'hA2000000, 0,     // td1, td2, tmem1, twb1, tmem2, twb2
            2'b00, 2'b01, `ALU_OP_SLTU,                 // t1sel, t2sel, alu_op
            0, 0, 100, 0,                               // talusrc, t_immd, t_pc, t_jump
            1, 100, 1);                                 // eresult, e_branch_target, e_zero

        check_test(`__LINE__,                   
            1, 1, 1, 22342334, 1, 4308902,              // td1, td2, tmem1, twb1, tmem2, twb2
            2'b10, 2'b10, `ALU_OP_OR,                   // t1sel, t2sel, alu_op
            0, 0, 100, 0,                               // talusrc, t_immd, t_pc, t_jump
            (22342334 | 4308902), 100, 0);              // eresult, e_branch_target, e_zero

        // ---- Immediate ALU Src ----
        check_test(`__LINE__,
            -47, 2127, 0, 0, 0, 0,          // td1, td2, tmem1, twb1, tmem2, twb2
            2'b00, 2'b00, `ALU_OP_ADD,      // t1sel, t2sel, alu_op
            1, 47, 100, 0,                  // talusrc, t_immd, t_pc, t_jump
            0, 100, 1);                     // eresult, e_branch_target, e_zero

        check_test(`__LINE__,                   
            32'hA050A050, 1, 321, 123, 2, 4,           // td1, td2, tmem1, twb1, tmem2, twb2
            2'b00, 2'b10, `ALU_OP_XOR,                 // t1sel, t2sel, alu_op
            1, 32'h462ABC4F, 100, 0,                   // talusrc, t_immd, t_pc, t_jump
            (32'hA050A050 ^ 32'h462ABC4F), 100, 0);    // eresult, e_branch_target, e_zero

        // ---- Branch Target ----
        check_test(`__LINE__,                   
            32'hA050A050, 1, 321, 123, 2, 32'hA050A050, // td1, td2, tmem1, twb1, tmem2, twb2
            2'b00, 2'b10, `ALU_OP_SUB,                  // t1sel, t2sel, alu_op
            0, 16, 100, 1,                              // talusrc, t_immd, t_pc, t_jump
            32'h00000000, (100 + (16 << 2)), 1);        // eresult, e_branch_target, e_zero

        check_test(`__LINE__,                   
            421, 231, 0, 0, 0, 0,                       // td1, td2, tmem1, twb1, tmem2, twb2
            2'b00, 2'b00, `ALU_OP_SLT,                  // t1sel, t2sel, alu_op
            0, 196, 84, 1,                              // talusrc, t_immd, t_pc, t_jump
            0, (84 + (196 << 2)), 0);                   // eresult, e_branch_target, e_zero

        check_test(`__LINE__,                   
            32'hFFFF0000, 32'hFFFF1111, 0, 0, 0, 0,     // td1, td2, tmem1, twb1, tmem2, twb2
            2'b00, 2'b00, `ALU_OP_SLTU,                 // t1sel, t2sel, alu_op
            0, 40, 636, 1,                              // talusrc, t_immd, t_pc, t_jump
            1, (636 + (40 << 2)), 1);                   // eresult, e_branch_target, e_zero

        $display("---- TESTS FINISHED ----");
        $display("TOTAL: %0d PASSED | %0d FAILED ", pass_count, fail_count);
        $finish;
    end
endmodule
