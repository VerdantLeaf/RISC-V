`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: myself
// Engineer: Kyle
// 
// Create Date: 05/17/2025 10:55:15 PM
// Design Name: 
// Module Name: regfile
// Project Name: RISC-V Implementation
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


module regfile(
    input rst,
    input clk,
    // Read port 1
    input [4:0] rSel1,
    output [31:0] rs1Data,
    // Read port 2
    input [4:0] rSel2,
    output [31:0] rs2Data,
    // Write port
    input wCtrl,
    input [4:0] wSel,
    input  wire [31:0] wData
    );
    
    wire [31:0] regOutput [0:31];
    wire [31:0] wEnable;

    // Generate enable signals for registers
    genvar i;
    generate
        // wEnable[0] == 0 and wEnable[i] == 1 when write control and selection are valid for each i
        for (i = 0; i < 32; i= i + 1) begin : gen_wEnable
            assign wEnable[i] = (wCtrl && (wSel == i) && (i != 0));
        end
    endgenerate
    
    // Generate 32 registers
    generate
        for (i = 0; i < 32; i = i + 1) begin : gen_registers
            register32 reg_i (
                .clk(clk),
                .rst(rst),
                .en(wEnable[i]),
                .d(wData),
                .q(regOutput[i])
            );
        end
    endgenerate

    // Effectively a 32:1 MUX with 5 selection bits
    assign rs1Data = (rSel1 == 5'd0) ? 32'b0 : regOutput[rSel1];
    assign rs2Data = (rSel2 == 5'd0) ? 32'b0 : regOutput[rSel2];
    
endmodule
