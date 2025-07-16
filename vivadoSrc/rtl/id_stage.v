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
    REG_SEL = $clog2(NUM_REGS),
    ADDR_SIZE = 10

    )(
    
    input clk, 
    input rst,

    input [WORD_SIZE - 1 : 0] instr,            // Instruction to be decoded
    input reg_write,                            // Enable writing to the register file
    input [WORD_SIZE - 1 : 0] rd_data,          // Data to be written to the register file
    input [REG_SEL - 1 : 0] rd_select,          // The select bits for the write back

    output reg [WORD_SIZE - 1 : 0] immd,        // Immediate extracted from immediate decode
    output reg [WORD_SIZE - 1 : 0] data1,       // First data from the register file
    output reg [WORD_SIZE - 1 : 0] data2,       // Second data from register file (src_immd determines valid)
    output reg [3:0] alu_op,                    // Tells the ALU which operation to do 
    output reg [REG_SEL - 1 : 0] destination,   // The destination register for the instruction

    output write_reg,                           // Says if instruction writes to a register
    output mem_write,                           // Says if instruction writes to memory
    output mem_read,                            // Says if instruction reads from memory
    output src_immd,                            // 1 => Use immd, 0 => Use data 2 (Selector for mux)
    output branch                               // Says if instruction branches            

    );

    reg [REG_SEL - 1 : 0] rs1, rs2;
    reg [4:0] opcode;
    reg [2:0] func3;
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
    
    always @(*) begin
        
        // Decode the opcode to select the correct if statement

        opcode      = instr[6:2];
        func3       = instr[14:12]; // Ignore for J and U types
        destination = {REG_SEL{1'b0}};
        rs1         = {REG_SEL{1'b0}};
        rs2         = {REG_SEL{1'b0}};
        alu_op      = `ALU_OP_ADD;
        instr_type  = `NOP_TYPE;

        case(opcode)
            // ------------------------------ R-TYPE ------------------------------
            `OPCODE_R: begin // R-type
                instr_type  = `R_TYPE;
                destination = instr[11:7]; // This you would have to change manually?
                rs1         = instr[19:15];
                rs2         = instr[24:20];

                alu_op = {instr[30], instr[14:12]}; // ALU operations are just func7[5] + func3

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
            // ----------------------------- I-TYPE -------------------------------
            `OPCODE_I, `OPCODE_JALR: begin
                instr_type  = `I_TYPE;
                destination = instr[11:7];
                rs1         = instr[19:15];

                case (func3)
                    3'b000: alu_op = `ALU_OP_ADD; // ADDI, but also JALR
                    3'b001: alu_op = `ALU_OP_SLL;
                    3'b010: alu_op = `ALU_OP_SLT;
                    3'b011: alu_op = `ALU_OP_SLTU;
                    3'b100: alu_op = `ALU_OP_XOR;
                    3'b101: alu_op = (instr[30]) ? `ALU_OP_SRA : `ALU_OP_SRL;
                    3'b110: alu_op = `ALU_OP_ORI;
                    3'b111: alu_op = `ALU_OP_ANDI;
                endcase
            end
            // ----------------------------- LOADS --------------------------------
            `OPCODE_L: begin
                instr_type  = `I_TYPE;
                destination = instr[11:7];
                rs1         = instr[19:15];
                alu_op      = `ALU_OP_ADD; // Is always addition, no matter what
            end
            // ----------------------------- STORES -------------------------------
            `OPCODE_S: begin
                instr_type  = `S_TYPE;
                alu_op      = {1'b0, instr[14:12]};
                rs1         = instr[19:15];
                rs2         = instr[24:20];
                alu_op      = `ALU_OP_ADD; // Saves are always additions
            end
            // ----------------------------- BRANCH ------------------------------
            `OPCODE_B: begin // B-type
                instr_type  = `B_TYPE;
                alu_op      = {1'b0, instr[14:12]};
                rs1         = instr[19:15];
                rs2         = instr[24:20];

                case (func3)
                    3'0000, 3'b001: alu_op = `ALU_OP_SUB;   // BEQ/BNE
                    3'b100, 3'b101: alu_op = `ALU_OP_SLT;   // BLT/BGE
                    3'b110, 3'b111: alu_op = `ALU_OP_SLTU;  // BLTU/BGEU
                    default: 
                endcase
            end
            // ---------------------------- LUI/AUIPC ----------------------------
            `OPCODE_U_LUI, `OPCODE_U_AUIPC: begin // LUI, AUIPC
                instr_type  = `U_TYPE;
                destination = instr[11:7];
                alu_op      = `ALU_OP_ADD;
            end
            // ---------------------------- JUMP ---------------------------------
            `OPCODE_JAL: begin // JAL
                instr_type  = `J_TYPE;
                destination = instr[11:7];
                alu_op      = `ALU_OP_ADD;
            end
            default: begin
                instr_type  = `NOP_TYPE;  // NOP encoded as ADDI x0, x0, 0
                alu_op      = `ALU_OP_ADD;    
            end
        endcase
    end

    assign mem_read = (instr_type == (`I_TYPE && `OPCODE_L)) ? 1'b1 : 1'b0;
    assign mem_write = (instr_type == `S_TYPE) ? 1'b1 : 1'b0;
    // x0 can't be written to, so we'll default to 0, and change if we are writing to
    // Even if you are trying to intentionally or unintnetionally write to x0, it will fail
    assign reg_write = (destination != 5'd0) ? 1'b1 : 1'b0; 
    
    assign src_immd = (instr_type == (`I_TYPE || `NOP_TYPE)) ? 1'b1 : 1'b0;
    assign branch = (instr_type == `B_TYPE) ? 1'b1 : 1'b0;
    

endmodule
