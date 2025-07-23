`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/17/2025 10:35:55 PM
// Design Name: 
// Module Name: cpu_core
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

/// @brief RV32I core that encapsulates all components of CPU
module cpu_core(
    input clk,
    input rst
    );

    // Pipeline registers and stages
    if_stage instructionfetch();

    if_id_reg IFID_register();

    id_stage instructiondecode();

    id_ex_reg IDEX_register();

    ex_stage execution();

    ex_mem_reg EXMEM_register();

    mem_stage memory();

    mem_wb_reg MEMWB_register();

    wb_stage writeback();

    // External control and hazard units
    forwarding_unit forwarder();

    hazard_unit hazard_unit();

    branch_unit branch_unit();

endmodule
