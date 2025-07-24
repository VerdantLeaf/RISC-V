`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: myself
// Engineer: kyle 
// 
// Create Date: 05/17/2025 10:35:55 PM
// Design Name: 
// Module Name: alu
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

module alu #(

    WORD_SIZE = 32

    )(
    input [3:0] alu_op,
    input [WORD_SIZE - 1 : 0] A, // rs1
    input [WORD_SIZE - 1 : 0] B, // rs2 or immd

    output reg [WORD_SIZE - 1 : 0] result,
    output zero
    );

    // We're keeping a simple execution unit, for now
    // this is because I want to get the design up and running so that I can start
    // to face the systems integration challenges. I am short on time this summer,
    // for personal reasons, and so we're executing.

    wire signed [WORD_SIZE - 1 : 0] signed_A = $signed(A); // Create signed copies
    wire signed [WORD_SIZE - 1 : 0] signed_B = $signed(B);

    always @(*) begin
        case (alu_op)
            `ALU_OP_ADD:    result = A + B; // overflow bit in the future {overflow, result}
            `ALU_OP_SUB:    result = A - B;
            `ALU_OP_SLL:    result = A << B;
            `ALU_OP_SLT:    result = (signed_A < signed_B) ? {{(WORD_SIZE - 1){1'b0}}, 1'b1} : {WORD_SIZE{1'b0}};
            `ALU_OP_SLTU:   result = (A < B) ? {{(WORD_SIZE - 1){1'b0}}, 1'b1} : {WORD_SIZE{1'b0}};
            `ALU_OP_XOR:    result = A ^ B;
            `ALU_OP_SRL:    result = A >> B;            // Logical shift
            `ALU_OP_SRA:    result = signed_A >>> B;    // Arithmetic shift (does sign extend)
            `ALU_OP_OR:     result = A | B;
            `ALU_OP_AND:    result = A & B;
            `ALU_OP_PASS:   result = B;
            default:        result = {WORD_SIZE{1'b0}}; // In future have error flag?
        endcase
    end

    assign zero = (result == {WORD_SIZE{1'b0}}) ? 1 : 0; 

endmodule
