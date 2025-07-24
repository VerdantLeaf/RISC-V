`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: myself
// Engineer: kyle
// 
// Create Date: 07/17/2025 01:29:28 PM
// Design Name: 
// Module Name: i_decoder
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

module i_decoder #(

    WORD_SIZE = 32,
    NUM_REGS = 32,
    REG_SEL = $clog2(NUM_REGS)

    )(

    input [WORD_SIZE - 1 : 0] instr,

    output reg [3:0] alu_op,
    output reg [REG_SEL - 1 : 0] rs1,
    output reg [REG_SEL - 1 : 0] rs2,
    output reg [REG_SEL - 1 : 0] rd,

    output reg mem_read,
    output reg mem_write,
    output reg mem_to_reg,
    output reg reg_write_out,
    output reg alu_src,
    output reg branch,
    output reg jump,

    output reg [1:0] data_size, // The size of the data 00-> byte, 01-> halfword, 10-> word
    output ref data_sign        // 0-> signed, 1-> unsigned

    );

    wire [4:0] opcode = instr[6:2];
    wire [2:0] func3 = instr[14:12];
    
    always @(*) begin
        
        // Set to NOP
        alu_op        = `ALU_OP_ADD; // if it's not an I or R it's usually an ADD
        rd            = 5'd0;
        rs1           = 5'd0;
        rs2           = 5'd0;
        mem_read      = 1'b0;
        mem_write     = 1'b0;
        mem_to_reg    = 1'b0;
        reg_write_out = 1'b0;
        alu_src       = 1'b1;
        branch        = 1'b0;
        jump          = 1'b0;
        data_size     = 2'd0;
        data_sign     = 1'b0;

        case (opcode)
            // -----------------------------
            // R-TYPE - ADD, SLL, SRA, etc...
            // -----------------------------
            `OPCODE_R: begin
                rd  = instr[11:7];
                rs1 = instr[19:15];
                rs2 = instr[24:20];

                case (func3)
                    3'b000: alu_op = (instr[30]) ? `ALU_OP_SUB : `ALU_OP_ADD;
                    3'b001: alu_op = `ALU_OP_SLL;
                    3'b010: alu_op = `ALU_OP_SLT;
                    3'b011: alu_op = `ALU_OP_SLTU;
                    3'b100: alu_op = `ALU_OP_XOR;
                    3'b101: alu_op = (instr[30]) ? `ALU_OP_SRA : `ALU_OP_SRL;
                    3'b110: alu_op = `ALU_OP_OR;
                    3'b111: alu_op = `ALU_OP_AND;
                endcase

                reg_write_out = (instr[11:7] != 5'd0); // rd, but be explicit
                alu_src       = 1'b0;
            end
            // -----------------------------
            // I-TYPE - ADDI, SLLI, and JALR
            // -----------------------------
            `OPCODE_I, `OPCODE_JALR: begin
                rd  = instr[11:7];
                rs1 = instr[19:15];

                case (func3)
                    3'b000: alu_op = `ALU_OP_ADD; // ADDI, but also JALR
                    3'b001: alu_op = `ALU_OP_SLL;
                    3'b010: alu_op = `ALU_OP_SLT;
                    3'b011: alu_op = `ALU_OP_SLTU;
                    3'b100: alu_op = `ALU_OP_XOR;
                    3'b101: alu_op = (instr[30]) ? `ALU_OP_SRA : `ALU_OP_SRL;
                    3'b110: alu_op = `ALU_OP_OR;
                    3'b111: alu_op = `ALU_OP_AND;
                endcase

                reg_write_out = (instr[11:7] != 5'd0);
                jump = (opcode == `OPCODE_JALR);
            end
            // -----------------------------
            // I-TYPE - LOADS
            // -----------------------------
            `OPCODE_L: begin
                rd  = instr[11:7];
                rs1 = instr[19:15];

                mem_read      = 1'b1;
                mem_to_reg    = 1'b1;
                reg_write_out = (instr[11:7] != 5'd0);

                data_size = func3[1:0];
                data_sign = func3[2];
            end
            // -----------------------------
            // S-TYPE - SAVE
            // -----------------------------
            `OPCODE_S: begin
                rs1 = instr[19:15];
                rs2 = instr[24:20];

                mem_write     = 1'b1;
                alu_src       = 1'b1;

                data_size = func3[1:0]; // Only need lower two bits, + encoding matches ISA
            end
            // -----------------------------
            // B-TYPE - BEQ, BLT, etc...
            // -----------------------------
            `OPCODE_B: begin
                rs1 = instr[19:15];
                rs2 = instr[24:20];

                case (func3)
                    3'b000, 3'b001: alu_op = `ALU_OP_SUB;   // BEQ/BNE
                    3'b100, 3'b101: alu_op = `ALU_OP_SLT;   // BLT/BGE
                    3'b110, 3'b111: alu_op = `ALU_OP_SLTU;  // BLTU/BGEU
                endcase

                branch = 1'b1;
            end
            // -----------------------------
            // U-TYPE - LUI/AUIPC
            // -----------------------------
            `OPCODE_U_LUI, `OPCODE_U_AUIPC: begin
                rd  = instr[11:7];

                alu_op = `ALU_OP_PASS;

                reg_write_out = (instr[11:7] != 5'd0);
            end
            // ---------------------- J-TYPE -------------------------------
            `OPCODE_JAL: begin
                rd  = instr[11:7];
        
                reg_write_out = (instr[11:7] != 5'd0);
                jump          = 1'b1;
            end
        endcase
    end

endmodule
