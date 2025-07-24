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

`include "defines.vh"

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
                $display("RSLT FAIL @ line %0d\tExp: %d\tGot: %d",
                    line_num, e_result, result);
            end else begin
                $display("RSLT PASS @ line %0d", line_num);
            end

            if(e_zero !== zero) begin
                $display("ZERO FAIL @ line %0d\tExp: %d\tGot: %d",
                    line_num, e_zero, zero);
            end else begin
                $display("ZERO PASS @ line %0d", line_num);
            end
        end
    endtask

    initial begin
        // ==================== TEST PROCEDURE ====================
        $display("*******Addition tests*******");
        arg1 = 32'd0;
        arg2 = 32'd0;
        alu_op = `ALU_OP_ADD;   // 0 + 0 = 0
        #5;
        checkresults(`__LINE__, 32'd0, 1);
        #1;
        
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

        arg1 = -32'd71;
        arg2 = -32'd29;
        alu_op = `ALU_OP_ADD;   // -71 + -29 = -100
        #5;
        checkresults(`__LINE__, -32'd100, 0);
        #1;
        // =================== SUBTRACTION ======================
        $display("*******Subtraction tests*******");
        arg1 = 32'd2;
        arg2 = 32'd1;
        alu_op = `ALU_OP_SUB;   // 2 - 1 = 1
        #5;
        checkresults(`__LINE__, 32'd1, 0);
        #1;

        arg1 = 32'd0;
        arg2 = 32'd1;
        alu_op = `ALU_OP_SUB;   // 0 - 1 = -1
        #5;
        checkresults(`__LINE__, -32'd1, 0);
        #1;

        arg1 = -32'd71;
        arg2 = -32'd29;
        alu_op = `ALU_OP_SUB;   // -71 - -29 = -42
        #5;
        checkresults(`__LINE__, -32'd42, 0);
        #1;

        arg1 = -32'd42;
        arg2 = -32'd100;
        alu_op = `ALU_OP_SUB;   // -42 - -100 = 58
        #5;
        checkresults(`__LINE__, 32'd58, 0);
        #1;

        arg1 = 32'd439;
        arg2 = 32'd137;
        alu_op = `ALU_OP_SUB;   // 439 - 137 = 302
        #5;
        checkresults(`__LINE__, 32'd302, 0);
        #1;

        $display("*******Shift left tests*******");

        arg1 = 32'h0000FFFF;
        arg2 = 32'd16;
        alu_op = `ALU_OP_SLL;       // 0xFFFF << 16 = 0xFFFF0000
        #5;
        checkresults(`__LINE__, 32'hFFFF0000, 0);
        #1;

        arg1 = 32'h00000001;
        arg2 = 32'd31;
        alu_op = `ALU_OP_SLL;       // 0x1 << 31 = 0x80000000
        #5;
        checkresults(`__LINE__, 32'h80000000, 0);
        #1;

        $display("*******Set less than tests*******");

        arg1 = 32'd12;
        arg2 = 32'd25;
        alu_op = `ALU_OP_SLT;       // (12 < 25) == 1
        #5;
        checkresults(`__LINE__, 32'd1, 0);
        #1;

        arg1 = -32'd39;
        arg2 = 32'd3;
        alu_op = `ALU_OP_SLT;       // (-39 < 3) == 1
        #5;
        checkresults(`__LINE__, 32'd1, 0);
        #1;

        arg1 = -32'd39;
        arg2 = -32'd300;
        alu_op = `ALU_OP_SLT;       // (-39 < -300) == 0
        #5;
        checkresults(`__LINE__, 32'd0, 1);
        #1;

        arg1 = 32'd329;
        arg2 = -32'd8;
        alu_op = `ALU_OP_SLT;       // (329 < -8) == 0
        #5;
        checkresults(`__LINE__, 32'd0, 1);
        #1;

        $display("*******Set less than (unsigned) tests*******");

        arg1 = 32'd29430;
        arg2 = 32'd125503;
        alu_op = `ALU_OP_SLTU;       // (29430 < 125503) == 1
        #5;
        checkresults(`__LINE__, 32'd1, 0);
        #1;

        arg1 = -32'd39;
        arg2 = 32'd324256;
        alu_op = `ALU_OP_SLTU;       // ((unsigned)-39 < 324256) == 0
        #5;
        checkresults(`__LINE__, 32'd0, 1);
        #1;

        arg1 = -32'd39;
        arg2 = -32'd300;
        alu_op = `ALU_OP_SLTU;       // ((unsigned)-39 < (unsigned)-300) == 0
        #5;
        checkresults(`__LINE__, 32'd0, 1);
        #1;

        arg1 = 32'd329;
        arg2 = -32'd8;
        alu_op = `ALU_OP_SLTU;       // (329 < (unsigned)-8) == 1
        #5;
        checkresults(`__LINE__, 32'd1, 0);
        #1;

        $display("*******XOR tests*******");

        arg1 = 32'hAAAAAAAA;
        arg2 = 32'h55555555;
        alu_op = `ALU_OP_XOR;       // 0xAAAAAAAA ^ 0x55555555 = FFFFFFFF
        #5;
        checkresults(`__LINE__, 32'hFFFFFFFF, 0);
        #1;

        arg1 = 32'he05320;
        arg2 = 32'h335907;
        alu_op = `ALU_OP_XOR;       // (e05320 ^ 335907) = d30a27
        #5;
        checkresults(`__LINE__, 32'hd30a27, 0);
        #1;

        $display("*******Logical Right Shift tests*******");

        arg1 = 32'h0A0A0A0A;
        arg2 = 32'd12;
        alu_op = `ALU_OP_SRL;       // 0x0A0A0A0A >> 12 = 0xa0a0
        #5;
        checkresults(`__LINE__, 32'ha0a0, 0);
        #1;

        arg1 = 32'h80123456;
        arg2 = 32'd20;
        alu_op = `ALU_OP_SRL;       // 0x80123456 >> 20 = 0x00000801
        #5;
        checkresults(`__LINE__, 32'h00000801, 0);
        #1;

        $display("*******Arithmetic Right Shift tests*******");

        arg1 = 32'h0A0A0A0A;
        arg2 = 32'd12;
        alu_op = `ALU_OP_SRA;       // 0x0A0A0A0A >>> 12 = 0xa0a0
        #5;
        checkresults(`__LINE__, 32'ha0a0, 0);
        #1;

        arg1 = 32'h80123456;
        arg2 = 32'd20;              // $signed(32'h80123456) >>> 20
        alu_op = `ALU_OP_SRA;       // 0x80123456 >>> 20 = 0xFFFFF801
        #5;
        checkresults(`__LINE__, 32'hFFFFF801 , 0);
        #1;

        $display("*******Bitwise OR tests*******");

        arg1 = 32'h0A0A0A0A;
        arg2 = 32'ha0a0a0a0;
        alu_op = `ALU_OP_OR;       // 0x0A0A0A0A | a0a0a0a0 = 0xAAAAAAAA
        #5;
        checkresults(`__LINE__, 32'hAAAAAAAA, 0);
        #1;

        arg1 = 32'hAAAAAAAA;
        arg2 = 32'h55555555;
        alu_op = `ALU_OP_OR;       // 0xAAAAAAAA | 0x55555555 = 0xFFFFFFFF
        #5;
        checkresults(`__LINE__, 32'hFFFFFFFF, 0);
        #1;

        arg1 = 32'h6A7A8A9A;
        arg2 = 32'h00000000;
        alu_op = `ALU_OP_OR;       // 0x6A7A8A9A | 0x00000000 = 0x6a7a8a9a
        #5;
        checkresults(`__LINE__, 32'h6a7a8a9a, 0);
        #1;

        $display("*******Bitwise AND tests*******");

        arg1 = 32'hAAAAAAAA;
        arg2 = 32'h55555555;
        alu_op = `ALU_OP_AND;       // 0xAAAAAAAA & 0x55555555 = 0x00000000
        #5;
        checkresults(`__LINE__, 32'h00000000, 1);
        #1;

        arg1 = 32'hFFFF0000;
        arg2 = 32'h1248FFFF;
        alu_op = `ALU_OP_AND;       // 0xFFFF0000 & 0x1248FFFF = ox12480000
        #5;
        checkresults(`__LINE__, 32'h12480000, 0);
        #1;

        $display("*******ALU tests*******");

        arg1 = -32'd5907356;
        arg2 = 32'd12;
        alu_op = `ALU_OP_PASS;       // Passes arg2
        #5;
        checkresults(`__LINE__, 32'd12, 0);
        #1;

        arg1 = 32'h0;
        arg2 = 32'd2340;
        alu_op = `ALU_OP_PASS;       // see above
        #5;
        checkresults(`__LINE__, 32'd2340, 0);
        #1;

        $finish();
    end

endmodule
