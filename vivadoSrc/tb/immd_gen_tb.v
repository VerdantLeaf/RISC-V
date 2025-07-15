`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 07/15/2025 12:30:12 AM
// Design Name: 
// Module Name: immd_gen_tb
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

module immd_gen_tb #(

    WORD_SIZE = 32

    )();

    reg [WORD_SIZE - 1:0] instr;
    reg [2:0] instr_type;
    wire [WORD_SIZE - 1:0] immd_out;
    
    immd_gen dut(
        .instr(instr),
        .instr_type(instr_type),
        .immd_out(immd_out)
    ); 
    
    initial instr = 32'b0;
    initial instr_type = `NOP_TYPE;

    initial begin

        
        instr_type = `I_TYPE; instr = 32'h0223_8693; #10;
        instr_type = `S_TYPE; instr = 32'h5862_2c23; #10;
        instr_type = `B_TYPE; instr = 32'h35bb_8ee3; #10;
        instr_type = `U_TYPE; instr = 32'h07c9_fbb7; #10;
        instr_type = `J_TYPE; instr = 32'h29e4_f36f; #10;
        instr_type = `R_TYPE; instr = 32'hDEAD_BEEF; #10;

        $finish;
    end 
    
endmodule
