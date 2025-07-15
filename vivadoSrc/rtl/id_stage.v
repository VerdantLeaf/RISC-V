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

`define OPCODE_R   5'b01100
`define OPCODE_I   5'b00100
`define OPCODE_L   5'b00000
`define OPCODE_JAL 5'b11011
`define OPCODE_B   5'b11000
`define OPCODE_S   5'b01000
`define OPCODE_U_LUI  5'b01101
`define OPCODE_U_AUIPC 5'b00101
`define OPCODE_JALR 5'b11001

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
    output reg [3:0]alu_op,                     // Tells the ALU which operation to do 
    output reg [REG_SEL - 1 : 0] destination,   // The destination register for the instruction
    output write_reg,                    // Says if instruction writes to a register
    output mem_write,                           // Says if instruction writes to memory
    output mem_read,                            // Says if instruction reads from memory
    output src_immd                             // 1 => Use immd, 0 => Use data 2 (Selector for mux)

    );

    reg [REG_SEL - 1 : 0] rs1, rs2;
    wire [WORD_SIZE - 1 : 0] rs1Data, rs2Data;
    reg opcode;
    reg [2:0] instr_type;

    // Not sure why defines would not work for this tbh
    localparam R_TYPE = 3'd0, I_TYPE = 3'd1, S_TYPE = 3'd2, B_TYPE = 3'd3;
    localparam U_TYPE = 3'd4, J_TYPE = 3'd5, NOP_TYPE = 3'd7;

    regfile registerfile(
        .clk(clk),
        .rst(rst),
        .rs1(rs1),
        .rs1Data(rs1Data),
        .rs2(rs2),
        .rs2Data(rs2Data),
        .wCtrl(reg_write),
        .wSel(rd_select),
        .wData(rd_data)
    );

    immd_gen immediategenerator();
    
    always @(*) begin
        
        // Decode the opcode to select the correct if statement

        opcode <= instr[6:2];

        case(opcode)
            `OPCODE_R: begin // R=type
                instr_type <= R_TYPE;

                destination <= instr[11:7];
                rs1 <= instr[19:15];
                rs2 <= instr[24:20];

                alu_op <= {instr[30], instr[14:12]}; // ALU operations are just func7[5] + func3

            end
            `OPCODE_I, `OPCODE_L, `OPCODE_JALR: begin // I-type
                instr_type = I_TYPE;

            end
            `OPCODE_S: begin // S-type
                instr_type = S_TYPE;
            end
            `OPCODE_B: begin // B-type
                instr_type = B_TYPE;

            end
            `OPCODE_U_LUI, `OPCODE_U_AUIPC: begin // LUI, AUIPC
                instr_type = U_TYPE;

            end
            `OPCODE_JAL: begin // JAL
                instr_type = J_TYPE;
            end
            default: begin
                instr_type = NOP_TYPE;      
                // NOP encoded as ADDI x0, x0, 0
            end
        endcase
    end

    assign mem_read = (instr_type == (I_TYPE && `OPCODE_L)) ? 1'b1 : 1'b0;
    assign mem_write = (instr_type == S_TYPE) ? 1'b1 : 1'b0;
    assign reg_write = (destination != 5'd0) ? 1'b1 : 1'b0;
    
    assign src_immd = (instr_type == (I_TYPE || NOP_TYPE)) ? 1'b1 : 1'b0;
    

endmodule
