`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 07/16/2025 04:43:39 PM
// Design Name: 
// Module Name: regfile_tb_new
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


module regfile_tb_new;

    // Parameters
    localparam WORD_SIZE = 32;
    localparam NUM_REGS  = 32;
    localparam REG_SEL   = $clog2(NUM_REGS);

    // DUT Signals
    reg clk, rst;
    reg [REG_SEL-1:0] rs1, rs2;
    wire [WORD_SIZE-1:0] rs1Data, rs2Data;
    reg wCtrl;
    reg [REG_SEL-1:0] wSel;
    reg [WORD_SIZE-1:0] wData;

    // Instantiate the DUT
    regfile #(
        .WORD_SIZE(WORD_SIZE),
        .NUM_REGS(NUM_REGS),
        .REG_SEL(REG_SEL)
    ) dut (
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

    // Clock
    initial clk = 0;
    always #5 clk = ~clk;

    // ---------------------- CHECK TASK ----------------------
    task check_reg;
        input integer line;
        input [REG_SEL-1:0] check_rs1;
        input [REG_SEL-1:0] check_rs2;
        input [WORD_SIZE-1:0] exp_rs1Data;
        input [WORD_SIZE-1:0] exp_rs2Data;
        begin
            if (rs1Data !== exp_rs1Data || rs2Data !== exp_rs2Data) begin
                $display("FAIL @ line %0d: rs1=%0d exp=%0d got=%0d | rs2=%0d exp=%0d got=%0d",
                    line, check_rs1, exp_rs1Data, rs1Data,
                    check_rs2, exp_rs2Data, rs2Data
                );
            end else begin
                $display("PASS @ line %0d: rs1=%0d=%0d | rs2=%0d=%0d",
                    line, check_rs1, rs1Data, check_rs2, rs2Data
                );
            end
        end
    endtask

    // ---------------------- TEST PROCEDURE ----------------------
    initial begin
        rst = 1;
        wCtrl = 0;
        rs1 = 0; rs2 = 0;
        wSel = 0; wData = 0;
        @(posedge clk);
        rst = 0;

        // ------------------ TEST 1: All reset to zero ------------------
        rs1 = 5'd5; rs2 = 5'd10;
        #1;
        check_reg(`__LINE__, 5, 10, 32'd0, 32'd0);

        // ------------------ TEST 2: Write to x5 ------------------------
        wCtrl = 1; wSel = 5'd5; wData = 32'd12345;
        @(posedge clk); // Wait for synchronous write
        wCtrl = 0;

        rs1 = 5'd5; rs2 = 5'd0;
        #1;
        check_reg(`__LINE__, 5, 0, 32'd12345, 32'd0);

        // ------------------ TEST 3: Write to x10 -----------------------
        wCtrl = 1; wSel = 5'd10; wData = 32'd54321;
        @(posedge clk);
        wCtrl = 0;

        rs1 = 5'd10; rs2 = 5'd5;
        #1;
        check_reg(`__LINE__, 10, 5, 32'd54321, 32'd12345);

        // ------------------ TEST 4: x0 always zero ---------------------
        wCtrl = 1; wSel = 5'd0; wData = 32'd99999;
        @(posedge clk);
        wCtrl = 0;

        rs1 = 5'd0; rs2 = 5'd0;
        #1;
        check_reg(`__LINE__, 0, 0, 32'd0, 32'd0);

        // ------------------ TEST 5: Overwrite value ---------------------
        wCtrl = 1; wSel = 5'd5; wData = 32'd11111;
        @(posedge clk);
        wCtrl = 0;

        rs1 = 5'd5; rs2 = 5'd10;
        #1;
        check_reg(`__LINE__, 5, 10, 32'd11111, 32'd54321);

        $display("All tests completed.");
        $finish;
    end

endmodule
