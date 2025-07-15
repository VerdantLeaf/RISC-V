`define OPCODE_R   5'b01100
`define OPCODE_I   5'b00100
`define OPCODE_L   5'b00000
`define OPCODE_JAL 5'b11011
`define OPCODE_B   5'b11000
`define OPCODE_S   5'b01000
`define OPCODE_U_LUI  5'b01101
`define OPCODE_U_AUIPC 5'b00101
`define OPCODE_JALR 5'b11001

`define R_TYPE   3'd0
`define I_TYPE   3'd1
`define S_TYPE   3'd2
`define B_TYPE   3'd3
`define U_TYPE   3'd4
`define J_TYPE   3'd5
`define NOP_TYPE 3'd7