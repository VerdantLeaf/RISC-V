`ifndef DEFINES_VH
`define DEFINES_VH

`define OPCODE_R   5'b01100
`define OPCODE_I   5'b00100
`define OPCODE_L   5'b00000
`define OPCODE_JAL 5'b11011
`define OPCODE_B   5'b11000
`define OPCODE_S   5'b01000
`define OPCODE_U_LUI    5'b01101
`define OPCODE_U_AUIPC  5'b00101
`define OPCODE_JALR     5'b11001

`define R_TYPE   3'd0
`define I_TYPE   3'd1
`define S_TYPE   3'd2
`define B_TYPE   3'd3
`define U_TYPE   3'd4
`define J_TYPE   3'd5
`define NOP_TYPE 3'd7

`define ALU_OP_ADD  4'b0000
`define ALU_OP_SUB  4'b1000
`define ALU_OP_SLL  4'b0001
`define ALU_OP_SLT  4'b0010
`define ALU_OP_SLTU 4'b0011
`define ALU_OP_XOR  4'b0100
`define ALU_OP_SRL  4'b0101
`define ALU_OP_SRA  4'b1101
`define ALU_OP_OR   4'b0110
`define ALU_OP_AND  4'b0111
`define ALU_OP_PASS 4'b1111

`endif
