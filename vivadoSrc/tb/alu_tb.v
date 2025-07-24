`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: myself
// Engineer: kyle
// 
// Create Date: 07/24/2025 11:48:14 AM
// Design Name: 
// Module Name: alu_tb
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


module alu_tb #(

    WORD_SIZE = 32,
    NUM_REGS = 32,
    REG_SEL = $clog2(NUM_REGS)

    )();

    reg [3:0] alu_op;
    reg [WORD_SIZE - 1 : 0] arg1;
    reg [WORD_SIZE - 1 : 0] arg2;

    wire [WORD_SIZE - 1 : 0] result;
    wire zero;

    alu dut(
        .alu_op(alu_op),
        .A(arg1),
        .B(arg2),
        .result(result),
        .zero(zero)
    );

    task checkresults;
        input integer line_num;
        input [WORD_SIZE - 1 : 0] e_result;
        input e_zero;
        
        begin
            if(e_result !== result) begin
                $display("***RESULT FAIL @ line %0d***\nExp: %d\tGot: %d",
                    line_num, e_result, result);
            end else begin
                $display("***RESULT PASS @ line %0d***\n", line_num);
            end

            if(e_zero !== zero) begin
                $display("***ZERO FAIL @ line %0d***\nExp: %d\tGot: %d",
                    line_num, e_zero, zero);
            end else begin
                $display("***ZERO PASS @ line %0d***\n", line_num);
            end
        end
    endtask

    initial begin
        // ==================== TEST PROCEDURE ====================
        arg1 = 32'd0;
        arg2 = 32'd1;
        alu_op = `ALU_OP_ADD;   // 0 + 1 = 1
        #5;
        checkresults(`__LINE__, 32'd1, 0);
        #1;

        arg1 = 32'd3425;
        arg2 = 32'd12314325;
        alu_op = `ALU_OP_ADD;   // 3,425 + 12,314,325 = 12,317,750
        #5;
        checkresults(`__LINE__, 32'd12317750, 0);
        #1;

        arg1 = 32'd2;
        arg2 = 32'd1;
        alu_op = `ALU_OP_SUB;   // 2 - 1 = 1
        #5;
        checkresults(`__LINE__, 32'd1, 0);
        #1;

        arg1 = 32'd439;
        arg2 = 32'd137;
        alu_op = `ALU_OP_SUB;   // 439 - 137 = 302
        #5;
        checkresults(`__LINE__, 32'd302, 0);
        #1;

        arg1 = 32'd0;
        arg2 = 32'd1;
        alu_op = `ALU_OP_SUB;   // 0 - 1 = -1
        #5;
        checkresults(`__LINE__, -32'd1, 0);
        #1;

        // NOT COMPLETE

        arg1 = 32'd0;
        arg2 = 32'd1;
        alu_op = `ALU_OP_ADD;       // 0 + 1 = 1
        #5;
        checkresults(`__LINE__, 32'd1, 0);
        #1;

        arg1 = 32'd0;
        arg2 = 32'd1;
        alu_op = `ALU_OP_ADD;       // 0 + 1 = 1
        #5;
        checkresults(`__LINE__, 32'd1, 0);
        #1;

        arg1 = 32'd0;
        arg2 = 32'd1;
        alu_op = `ALU_OP_ADD;       // 0 + 1 = 1
        #5;
        checkresults(`__LINE__, 32'd1, 0);
        #1;

    end

endmodule
