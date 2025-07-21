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
                $display("*** DATA FAIL @ line %0d***\nExp: rs1= %0d, rs2= %0d\nGot: rs1= %0d, rs2= %0d",
                    line, exp_rs1Data, exp_rs2Data, rs1Data, rs2Data
                );
            end else begin
                $display("PASS @ line %0d: rs1= %0d | rs2= %0d",
                    line, rs1Data, rs2Data
                );
            end
        end
    endtask

    integer i;

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

        // ------ TEST: Fill regs with number of their index
        wCtrl = 1;
        for (i=0; i< NUM_REGS; i=i+1) begin
            wData = i;
            wSel = i + 1;  // reg[i] := i
            @(posedge clk);
        end

        // ------------------ TEST 1: Check registers and values ---------
        wCtrl = 0;
        rs1 = 5'd5; rs2 = 5'd10;
        #1;
        check_reg(`__LINE__, 5, 10, 32'd5, 32'd10);
        rs1 = 5'd24; rs2 = 5'd29;
        #1;
        check_reg(`__LINE__, 24, 29, 32'd24, 32'd29);
        rs1 = 5'd12; rs2 = 5'd22;
        #1;
        check_reg(`__LINE__, 12, 22, 32'd12, 32'd22);
        rs1 = 5'd6; rs2 = 5'd28;
        #1;
        check_reg(`__LINE__, 6, 28, 32'd6, 32'd28);


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
