`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: myself
// Engineer: kyle
// 
// Create Date: 05/19/2025 11:29:30 AM
// Design Name: 
// Module Name: regfile_tb
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


module regfile_tb;

    reg rst;
    reg clk;
    // Read port 1
    reg [4:0] rSel1;
    wire [31:0] rs1Data;
    // Read port 2
    reg [4:0] rSel2;
    wire [31:0] rs2Data;
    // Write port
    reg wCtrl;
    reg [4:0] wSel;
    reg [31:0] wData;
    
    regfile dut(
        .clk(clk),
        .rst(rst),
        .rSel1(rSel1),
        .rs1Data(rs1Data),
        .rSel2(rSel2),
        .rs2Data(rs2Data),
        .wCtrl(wCtrl),
        .wSel(wSel),
        .wData(wData)
     );
     
     // clk gen
     initial clk = 0;
     always #5 clk = ~clk;
     
     
     // Write value to a register
    task write_reg(input [4:0] regnum, input [31:0] data);
        begin
            @(posedge clk);
            wCtrl <= 1;
            wSel <= regnum;
            wData <= data;
            @(posedge clk);
            wCtrl <= 0;
            wSel <= 0;
            wData <= 0;
        end
    endtask
    
    task write_regs_b2b(input [4:0] regnum1,
                        input [4:0] regnum2,
                        input [31:0] data1,
                        input [31:0] data2);
        begin
            @(posedge clk);
            wCtrl <= 1;
            wSel <= regnum1;
            wData <= data1;
            @(posedge clk);
            wSel <= regnum2;
            wData <= data2;
        end
    endtask

    // Read values from two registers
    task read_regs(input [4:0] reg1, input [4:0] reg2);
        begin
            rSel1 <= reg1;
            rSel2 <= reg2;
            @(posedge clk);
            $display("Read rs1[%0d] = 0x%08x, rs2[%0d] = 0x%08x", reg1, rs1Data, reg2, rs2Data);
        end
    endtask
     
     // TB
    initial begin
        $display("Starting register file testbench");
        
        rst = 1;
        wCtrl = 0;
        rSel1 = 0;
        rSel2 = 0;
        wSel = 0;
        wData = 0;
        
        @(posedge clk);
        rst = 0;
        
        // Write values to registers
        write_reg(5'd12, 32'hDEADBEEF);
        write_reg(5'd3, 32'hABCDABCD);
        write_reg(5'd0, 32'h87654321); // Should not modify
        
        // Read values from registers that we just wrote to
        read_regs(5'd12, 5'd3);
        read_regs(5'd3, 5'd0);
        
        write_reg(5'd12, 32'h01010101);
        write_reg(5'd31, 32'hFFFFFFFF);
        
        read_regs(5'd12, 5'd31);
        
        // Write two registers and then immediately read them after
        // writing them without the one clk cycle break of write tasks
        write_regs_b2b(5'd16, 5'd19, 32'hFEFEFE00, 32'h00088800);
        @(posedge clk);
        wCtrl <= 0;
        wSel <= 0;
        wData <= 0;
        rSel1 <= 5'd16;
        rSel2 <= 5'd19;
        
        #20;
        $display("TB completed");
        $finish;
    end 
        
endmodule
