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

`define R_TYPE 3'd0
`define I_TYPE 3'd1
`define S_TYPE 3'd2
`define B_TYPE 3'd3
`define U_TYPE 3'd4
`define J_TYPE 3'd5
`define NOP_TYPE 3'd7

module id_stage #(

    WORD_SIZE = 32,
    NUM_REGS = 32,
    REG_SEL = $clog2(NUM_REGS),
    ADDR_SIZE = 10

    )(
    
    input clk, 
    input rst,
    input [WORD_SIZE - 1 : 0] instr,    // Instruction to be decoded
    
    output [WORD_SIZE - 1 : 0] immd, 
    output alu_op,                      // Tells the ALU which operation to do
    output reg_write,                   // Says if instruction writes to register
    output mem_read                     // Says if instruction reads from memory

    );

    wire [REG_SEL - 1 : 0] rs1, rs2;
    wire [WORD_SIZE - 1 : 0] rs1Data, rs2Data;
    wire opcode;
    reg [2:0] instr_type;


    regfile registerfile(
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

    immd_gen immediategenerator();
    
    always @(*) begin
        
        // Decode the opcode to select the correct if statement
        opcode <= instr[6:2];  // instr[1:0] is same forall instructions

        case(opcode)
            `OPCODE_R: begin // R=type
                instr_type = R_TYPE;
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
            end
        endcase

    end
endmodule
