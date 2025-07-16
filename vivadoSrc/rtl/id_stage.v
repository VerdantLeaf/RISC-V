`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/17/2025 11:06:51 PM
// Design Name: 
// Module Name: id_stage
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

module id_stage #(

    WORD_SIZE = 32,
    NUM_REGS = 32,
    REG_SEL = 5,
    ADDR_SIZE = 10

    )(
    input clk, 
    input rst,

    input [WORD_SIZE - 1 : 0] instr,            // Instruction to be decoded
    input reg_write,                            // Enable writing to the register file
    input [WORD_SIZE - 1 : 0] rd_data,          // Data to be written to the register file
    input [REG_SEL - 1 : 0] rd_select,          // The select bits for the write back

    output [WORD_SIZE - 1 : 0] immd,            // Immediate extracted from immediate decode
    output [WORD_SIZE - 1 : 0] data1,           // First data from the register file
    output [WORD_SIZE - 1 : 0] data2,           // Second data from register file (alu_src determines valid)
    output reg [3:0] alu_op,                    // Tells the ALU which operation to do 
    output [REG_SEL - 1 : 0] rd,       // The rd register for the instruction

    output mem_read,                            // Instruction reads from memory
    output mem_write,                           // Instruction writes to memory
    output mem_to_reg,                          // Instruction writes to regfile from memory
    output reg_write_out,                       // Instruction writes to regfile
    output alu_src,                             // Instruction uses immd or not
    output branch,                              // Instruction is branch
    output jump                                 // Instruction is jump
    
    );

    wire [REG_SEL - 1 : 0] rs1;
    wire [REG_SEL - 1 :0] rs2;
    wire [4:0] opcode;
    wire [2:0] func3;
    reg [2:0] instr_type;

    regfile registerfile(
        .clk(clk),
        .rst(rst),
        
        .rs1(rs1),
        .rs1Data(data1),
        .rs2(rs2),
        .rs2Data(data2),

        .wCtrl(reg_write),
        .wSel(rd_select),
        .wData(rd_data)
    );

    immd_gen immediategenerator(
        .instr(instr),
        .instr_type(instr_type),
        .immd_out(immd)
    );
    
    assign opcode   = instr[6:2];
    assign func3    = instr[14:12];
    assign rs1      = instr[19:15];
    assign rs2      = instr[24:20];
    assign rd       = instr[11:7];
    
    always @(*) begin
        
        // Decode the opcode to select the correct if statement

        // rd = {REG_SEL{1'b0}};
        // rs1         = {REG_SEL{1'b0}};
        // rs2         = {REG_SEL{1'b0}};
        alu_op      = `ALU_OP_ADD;
        instr_type  = `NOP_TYPE;

        case(opcode)
            // ------------------------------ R-TYPE -----------------------------
            `OPCODE_R: begin // R-type
                instr_type  = `R_TYPE;
                // rd = instr[11:7]; 
                // rs1         = instr[19:15];
                // rs2         = instr[24:20];

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
            end
            // ----------------------------- I-TYPE ------------------------------
            `OPCODE_I, `OPCODE_JALR: begin
                instr_type  = `I_TYPE;
                // rd = instr[11:7];
                // rs1         = instr[19:15];

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
            end
            // ----------------------------- LOADS -------------------------------
            `OPCODE_L: begin
                instr_type  = `I_TYPE;
                // rd = instr[11:7];
                // rs1         = instr[19:15];
                alu_op      = `ALU_OP_ADD; // Is always addition, no matter what
            end
            // ----------------------------- STORES ------------------------------
            `OPCODE_S: begin
                instr_type  = `S_TYPE;
                alu_op      = {1'b0, instr[14:12]};
                // rs1         = instr[19:15];
                // rs2         = instr[24:20];
                alu_op      = `ALU_OP_ADD; // Saves are always additions
            end
            // ----------------------------- BRANCH ------------------------------
            `OPCODE_B: begin // B-type
                instr_type  = `B_TYPE;
                alu_op      = {1'b0, instr[14:12]};
                // rs1         = instr[19:15];
                // rs2         = instr[24:20];

                case (func3)
                    3'b000, 3'b001: alu_op = `ALU_OP_SUB;   // BEQ/BNE
                    3'b100, 3'b101: alu_op = `ALU_OP_SLT;   // BLT/BGE
                    3'b110, 3'b111: alu_op = `ALU_OP_SLTU;  // BLTU/BGEU
                endcase
            end
            // ---------------------------- LUI/AUIPC ----------------------------
            `OPCODE_U_LUI, `OPCODE_U_AUIPC: begin // LUI, AUIPC
                instr_type  = `U_TYPE;
                // rd = instr[11:7];
                alu_op      = `ALU_OP_PASS;
            end
            // ---------------------------- JUMP ---------------------------------
            `OPCODE_JAL: begin // JAL
                instr_type  = `J_TYPE;
                // rd = instr[11:7];
                alu_op      = `ALU_OP_ADD;
            end
            // ---------------------------- NOP ----------------------------------
            default: begin
                instr_type  = `NOP_TYPE;  // NOP encoded as ADDI x0, x0, 0
                alu_op      = `ALU_OP_ADD;    
            end
        endcase
    end

    // Set control signals for output
    assign mem_read         = (opcode == `OPCODE_L);
    assign mem_write        = (instr_type == `S_TYPE);
    assign mem_to_reg       = (opcode == `OPCODE_L);    // For future use
    assign reg_write_out    = ((rd != 5'd0) && ((instr_type != `S_TYPE) && (instr_type != `B_TYPE))); 
    
    assign alu_src          = (instr_type == `I_TYPE || instr_type == `U_TYPE ||
                                instr_type == `S_TYPE || instr_type == `NOP_TYPE);
    assign branch           = (instr_type == `B_TYPE);
    assign jump             = (instr_type == `J_TYPE || opcode == `OPCODE_JALR);

endmodule
