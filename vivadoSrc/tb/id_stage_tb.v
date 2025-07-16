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
    REG_SEL = 5,
    ADDR_SIZE = 10

    )();

    reg clk;
    reg rst;
    reg [WORD_SIZE - 1:0] instr;
    reg reg_write;
    reg [WORD_SIZE - 1:0] rd_data;
    reg [WORD_SIZE - 1:0] rd_select;

    wire [WORD_SIZE - 1:0] immd;
    wire [WORD_SIZE - 1:0] data1;
    wire [WORD_SIZE - 1:0] data2;
    wire [3:0] alu_op;
    wire [REG_SEL - 1:0] destination;

    wire mem_read;   
    wire mem_write;   
    wire mem_to_reg;
    wire reg_write_out;
    wire alu_src;
    wire branch;
    wire jump;

    id_stage dut(
        // inputs
        .clk(clk),
        .rst(rst),
        .instr(instr),
        .reg_write(reg_write),
        .rd_data(rd_data),
        .rd_select(rd_select),

        // outputs - data
        .immd(immd),
        .data1(data1),
        .data2(data2),
        .alu_op(alu_op),
        .destination(destination),
        // control signals
        .mem_read(mem_read),
        .mem_write(mem_write),
        .mem_to_reg(mem_to_reg),
        .reg_write_out(reg_write_out),
        .alu_src(alu_src),
        .branch(branch),
        .jump(jump)
    );

    // ----------------------- CLK GEN -------------------------------
    initial clk = 0;
    always #5 clk = ~clk;

    // ----------------------- PASS/FAIL CHECKER ---------------------
    task check_outputs;
        input integer line_num;
        input [31:0] exp_data1, exp_data2, exp_immd;
        input [3:0] exp_alu_op;
        input exp_reg_write_out, exp_mem_read, exp_mem_write, exp_mem_to_reg, exp_alu_src, exp_branch, exp_jump;
        begin
             if (immd         !== exp_immd          ||
                data1         !== exp_data1         ||
                data2         !== exp_data2         ||
                alu_op        !== exp_alu_op        ||
                mem_read      !== exp_mem_read      ||
                mem_write     !== exp_mem_write     ||
                mem_to_reg    !== exp_mem_to_reg    ||
                reg_write_out !== exp_reg_write_out ||
                alu_src       !== exp_alu_src       ||
                branch        !== exp_branch        ||
                jump          !== exp_jump) begin
                
                $display("FAIL @ line %0d: Expected data1=%d, data2=%d | Got Data1=%d, data2=%d",
                          line_num, exp_data1, exp_data2, data1, data2);
            end else begin
                $display("PASS @ line %0d", line_num);
            end
        end
    endtask

    // --------------------------- TEST PROCEDURE ----------------------
    initial begin
    
        rst = 1;
        instr = 32'b0;
        reg_write = 0;
        rd_data = 32'b0;
        rd_select = {REG_SEL{1'b0}};

        @(posedge clk);
        rst = 0;

        // ----------------------- LOAD REGISTERS ----------------------
        // x29 := 69632
        reg_write = 1;          
        rd_select = 5'd29;      
        rd_data = 32'd69632;    
        @(posedge clk);
        // x14 := 12
        rd_select = 5'd14;
        rd_data = 32'd12;       
        @(posedge clk); 
        // x24 := 69644
        rd_select = 5'd24;
        rd_data   = 32'd69644;
        @(posedge clk); 
        // x16 := 0
        rd_select = 5'd16;
        rd_data   = 32'd0;
        @(posedge clk);    
        // x15 := 134
        rd_select = 5'd15;       
        rd_data = 32'd134;      
        @(posedge clk);

        // Clear for decode only phase
        reg_write = 0;          
        rd_select = 5'd0;       
        rd_data = 32'd0; 

        // --------------------- 1) ADDI x14, x0, 12 --------------------
        instr = 32'h00c00713;   
        @(posedge clk);
        #1;
        check_outputs(
            `__LINE__,
            32'd0,              // data1 (x0)
            32'd0,              // data2 (x0)
            32'd12,             // immd_out
            `ALU_OP_ADD,        // alu_op (addi)
            1, 0, 0, 0,         // reg_write_out, mem_read, mem_write, mem_to_reg
            1, 0, 0             // alu_src, branch, jump
        );
        
        // --------------------- 2) ADD x24, x29, x14 --------------------
        instr = 32'h00ee8c33;   
        @(posedge clk);
        #1;
        check_outputs(
            `__LINE__,
            32'd69632,          // data1 (x29)
            32'd12,             // data2 (x14)
            32'd0,              // immd_out
            `ALU_OP_ADD,        // alu_op (add)
            1, 0, 0, 0,         // reg_write_out, mem_read, mem_write, mem_to_reg
            0, 0, 0             // alu_src, branch, jump
        );

        // --------------------- 3) LW x18, 512(x24) --------------------
        instr = 32'h200c2803;
        @(posedge clk);     
        #1;
        check_outputs(
            `__LINE__,
            32'd69644,          // data1 (x24)
            32'd0,              // data2 (x0)
            32'd512,            // immd_out
            `ALU_OP_ADD,        // alu_op (add)
            1, 1, 0, 1,         // reg_write_out, mem_read, mem_write, mem_to_reg
            1, 0, 0             // alu_src, branch, jump
        );

        // --------------------- 4) SH x16, -292(x14) --------------------
        instr = 32'hed071e23; 
        @(posedge clk);         
        #1;
        check_outputs(
            `__LINE__,
            32'd12,             // data1 (x14)
            32'd0,              // data2 (x16)
            -32'd292,           // immd_out
            `ALU_OP_ADD,        // alu_op (add)
            0, 0, 1, 0,         // reg_write_out, mem_read, mem_write, mem_to_reg
            1, 0, 0             // alu_src, branch, jump
        );

        // --------------------- 5) BGE x24, x15, 304 --------------------
        instr = 32'h12fc5863;   
        @(posedge clk);         
        #1;
        check_outputs(
            `__LINE__,
            32'd69644,          // data1 (x24)
            32'd134,            // data2 (x15)
            32'd304,            // immd_out
            `ALU_OP_SLT,        // alu_op (bge/set less than)
            0, 0, 0, 0,         // reg_write_out, mem_read, mem_write, mem_to_reg
            0, 1, 0             // alu_src, branch, jump
        );

        // --------------------- 6) JAL x1, 7936 --------------------------
        instr = 32'h701010ef;
        @(posedge clk);         
        #1;
        check_outputs(
            `__LINE__,
            32'd0,              // data1 (x0)
            32'd0,              // data2 (x0)
            32'd7936,           // immd_out
            `ALU_OP_ADD,        // alu_op (jal)
            1, 0, 0, 0,         // reg_write_out, mem_read, mem_write, mem_to_reg
            1, 0, 1             // alu_src, branch, jump
        );

        // --------------------- 7) LUI x21, 0x4321 ----------------------
        instr = 32'h04321ab7;    
        @(posedge clk);
        #1;
        check_outputs(
            `__LINE__,
            32'd0,              // data1 (x0)
            32'd0,              // data2 (x0)
            32'h04321000,       // immd_out
            `ALU_OP_PASS,       // alu_op (lui)
            1, 0, 0, 0,         // reg_write_out, mem_read, mem_write, mem_to_reg
            1, 0, 0             // alu_src, branch, jump
        );

        #20;

        $finish;

    end

endmodule
