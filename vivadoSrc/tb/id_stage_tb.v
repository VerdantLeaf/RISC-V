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

    reg [ADDR_SIZE - 1:0] pc;

    reg [WORD_SIZE - 1:0] instr;

    reg reg_write;
    reg [WORD_SIZE - 1:0] rd_data;
    reg [REG_SEL - 1:0] rd_select;

    wire [ADDR_SIZE - 1:0] pc_out;


    wire [WORD_SIZE - 1:0] immd;
    wire [WORD_SIZE - 1:0] data1;
    wire [WORD_SIZE - 1:0] data2;
    wire [3:0] alu_op;
    wire [REG_SEL - 1:0] rd;
    wire [REG_SEL - 1:0] rs1;
    wire [REG_SEL - 1:0] rs2;

    wire mem_read;   
    wire mem_write;   
    wire mem_to_reg;
    wire reg_write_out;
    wire alu_src;
    wire branch;
    wire jump;

    id_stage dut(
        .clk(clk),
        .rst(rst),

        .pc(pc),

        .instr(instr),

        .reg_write(reg_write),
        .rd_data(rd_data),
        .rd_select(rd_select),

        .pc_out(pc_out),

        .immd(immd),
        .data1(data1),
        .data2(data2),
        .alu_op(alu_op),
        .rd(rd),
        .rs1(rs1),
        .rs2(rs2),

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

    // =====================================
    // RESULTS CHECKER
    // =====================================
    task check_data_and_regs;
        input integer line_num;
        input [REG_SEL - 1 : 0] e_rd, e_rs1, e_rs2;
        input [WORD_SIZE - 1 : 0] e_data1, e_data2, e_immd;
        begin
            if (rd !== e_rd || rs1 !== e_rs1 || rs2 !== e_rs2) begin 
                $display("***REG FAIL @ line %0d***\nExp: rd= %d, rs1= %d, rs2= %d\nGot: rd= %d, rs1= %d, rs2= %d",
                    line_num, e_rd, e_rs1, e_rs2, rd, rs1, rs2);
            end else begin
                $display("REG PASS @ line %0d", line_num);
            end
            if (data1 !== e_data1 || data2 !== e_data2 || immd !== e_immd) begin 
                $display("***DATA FAIL @ line %0d***\nExp: d1= %d, d2= %d, im= %d\nGot: d1= %d, d2= %d, im= %d",
                    line_num, e_data1, e_data2, e_immd, data1, data2, immd);
            end else begin
                $display("DATA PASS @ line %0d", line_num);
            end
        end
    endtask

    task check_ctrl_signals;
        input integer line_num;
        input e_mem_read, e_mem_write, e_mem_to_reg, e_reg_write_out, e_alu_src, e_branch, e_jump;
        input [3 : 0] e_alu_op;
        begin
            if (alu_op        !== e_alu_op        ||
                mem_read      !== e_mem_read      ||
                mem_write     !== e_mem_write     ||
                mem_to_reg    !== e_mem_to_reg    ||
                reg_write_out !== e_reg_write_out ||
                alu_src       !== e_alu_src       ||
                branch        !== e_branch        ||
                jump          !== e_jump) begin
            // Vivado prefers this all on one line lol
            $display("***CTRL FAIL @ line %0d***\nExp: alu= %b, mem_read= %b, mem_write= %b, mem_to_reg= %b, reg_write_out= %b, alu_src= %b, branch= %b, jump= %b\nGot: alu= %b, mem_read= %b, mem_write= %b, mem_to_reg= %b, reg_write_out= %b, alu_src= %b, branch= %b, jump= %b",
                line_num, e_alu_op, e_mem_read, e_mem_write, e_mem_to_reg, e_reg_write_out, e_alu_src, e_branch, e_jump, alu_op, mem_read, mem_write, mem_to_reg, reg_write_out, alu_src, branch, jump);
            end else begin
                $display("CTRL PASS @ line %0d", line_num);
            end
        end
    endtask

    // --------------------------- TEST PROCEDURE ----------------------
    integer i;

    initial begin
        
        rst = 1;
        pc = {ADDR_SIZE{1'b0}};
        instr = {WORD_SIZE{1'b0}};
        reg_write = 0;
        rd_data = {WORD_SIZE{1'b0}};
        rd_select = {REG_SEL{1'b0}};

        // --------------------- LOAD REG FILE --------------------------
        @(posedge clk);
        rst = 0;
        reg_write = 1;
        for (i=0; i< NUM_REGS; i=i+1) begin
            rd_data = i;        // reg[i] := i
            rd_select = i + 1;  // this is not an issue with the regfile, I am just
                                // bad at a for loop apparently...
            @(posedge clk);
        end
        
        rd_data = 0;
        rd_select = 0;
        reg_write = 0;
        @(posedge clk);

        // --------------------- 1) ADD x24, x29, x14 ------------------
        instr = 32'h00ee8c33; 
        @(posedge clk);
        #1;
        check_data_and_regs(
            `__LINE__, 5'd24, 5'd29, 5'd14, // rd, rs1, rs2
            32'd29, 32'd14, 32'd0              // data1, data2, immd    
        );
        // mem_read, mem_write, mem_to_reg, reg_write_out, alu_src, branch, jump
        check_ctrl_signals(`__LINE__, 0, 0, 0, 1, 0, 0, 0, `ALU_OP_ADD);

        // --------------------- 2) SRA x12, x23, x0 --------------------
        instr = 32'h400bd633;   
        @(posedge clk);
        #1;
        check_data_and_regs(
            `__LINE__, 5'd12, 5'd23, 5'd0,  // rd, rs1, rs2
            32'd23, 32'd0, 32'd0               // data1, data2, immd    
        );
        // mem_read, mem_write, mem_to_reg, reg_write_out, alu_src, branch, jump
        check_ctrl_signals(`__LINE__, 0, 0, 0, 1, 0, 0, 0, `ALU_OP_SRA);


        // --------------------- 3) SLLI x0, x23, 14 -------------------
        instr = 32'h00eb9013;
        @(posedge clk);     
        #1;
        check_data_and_regs(
            `__LINE__, 5'd0, 5'd23, 5'd0,       // rd, rs1, rs2
            32'd23, 32'd0, 32'd14               // data1, data2, immd    
        );
        // mem_read, mem_write, mem_to_reg, reg_write_out, alu_src, branch, jump
        // reg_write_out should be zero because the destination reg is x0
        check_ctrl_signals(`__LINE__, 0, 0, 0, 0, 1, 0, 0, `ALU_OP_SLL);

        // --------------------- 4) SH x16, -292(x14) --------------------
        instr = 32'hed071e23; 
        @(posedge clk);         
        #1;
        check_data_and_regs(
            `__LINE__, 5'd0, 5'd14, 5'd16,  // rd, rs1, rs2
            32'd14, 32'd16, -32'd292        // data1, data2, immd
        );
        // mem_read, mem_write, mem_to_reg, reg_write_out, alu_src, branch, jump
        check_ctrl_signals(`__LINE__, 0, 1, 0, 0, 1, 0, 0, `ALU_OP_ADD);

        // --------------------- 5) BGE x24, x15, 304 --------------------
        instr = 32'h12fc5863;   
        @(posedge clk);         
        #1;
        check_data_and_regs(
            `__LINE__, 5'd0, 5'd24, 5'd15,  // rd, rs1, rs2
            32'd24, 32'd15, 32'd304         // data1, data2, immd
        );
        // mem_read, mem_write, mem_to_reg, reg_write_out, alu_src, branch, jump
        check_ctrl_signals(`__LINE__, 0, 0, 0, 0, 1, 1, 0, `ALU_OP_SLT);

        // --------------------- 6) JAL x1, 7936 --------------------------
        instr = 32'h701010ef;
        @(posedge clk);         
        #1;
        check_data_and_regs(
            `__LINE__, 5'd1, 5'd0, 5'd0,    // rd, rs1, rs2
            32'd0, 32'd0, 32'd7936          // data1, data2, immd
        );
        // mem_read, mem_write, mem_to_reg, reg_write_out, alu_src, branch, jump
        check_ctrl_signals(`__LINE__, 0, 0, 0, 1, 1, 0, 1, `ALU_OP_ADD);

        // --------------------- 7) LUI x21, 0x04321 ---------------------
        instr = 32'h04321ab7;    
        @(posedge clk);
        #1;
        check_data_and_regs(
            `__LINE__, 5'd21, 5'd0, 5'd0,   // rd, rs1, rs2
            32'd0, 32'd0, 32'h04321000      // data1, data2, immd
        );
        // mem_read, mem_write, mem_to_reg, reg_write_out, alu_src, branch, jump
        check_ctrl_signals(`__LINE__, 0, 0, 0, 1, 1, 0, 0, `ALU_OP_PASS);

        #20;

        $finish;

    end

endmodule
