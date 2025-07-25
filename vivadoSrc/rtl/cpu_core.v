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
module cpu_core #(

    WORD_SIZE = 32,
    NUM_REGS = 32,
    REG_SEL = $clog2(NUM_REGS),
    ADDR_SIZE = 10

    )(

    input clk,
    input rst
    );

    wire pc_src, en_pc_reg;
    wire flush_ifid, flush_idex, flush_exmem, flush_memwb;
    wire stall_ifid, stall_idex, stall_exmem, stall_memwb;


    wire [ADDR_SIZE - 1 : 0] branch_target;
    wire [ADDR_SIZE - 1 : 0] pc_next;
    wire [WORD_SIZE - 1 : 0] instr_if, instr_id;

    // write back
    wire reg_write_mem, reg_write_wb;
    wire [WORD_SIZE - 1 : 0] write_data;
    wire [REG_SEL - 1 : 0] write_select;

    // immediates
    wire [WORD_SIZE - 1 : 0] immd_id;


    // control signals
    wire mem_read;
    wire mem_write;
    wire mem_to_reg;
    wire reg_write_out;
    wire alu_src;
    wire branch;
    wire jump;


    // Pipeline registers and stages
    if_stage instructionfetch(
        .clk(clk),
        .rst(rst),
        
        .pc_src(pc_src),
        .en(en_pc_reg), // Enables updating of PC register. Sourced from branch unit?
        
        .branch_target(branch_target),
        .pc_next(pc_next),

        .instr(instr_if)
    );

    if_id_reg IFID_register(
        .clk(clk),
        .rst(rst),
        .flush(flush_ifid),
        .stall(stall_ifid),

        .instr(instr_if),
        .pc(pc_next),

        .instr_out(instr_id), // instruction and PC to ID stage
        .pc_out(pc_id)
    );

    id_stage instructiondecode(
        .clk(clk),
        .rst(rst),

        .instr(instr_id),

        .reg_write(reg_write_wb),
        .rd_data(write_data),
        .rd_select(write_select),

        .immd(immd_id),
        .data1(),
        .data2(),
        .alu_op(),
        .rd(),
        .rs1(),
        .rs2(),

        .mem_read(),
        .mem_write(),
        .mem_to_reg(),
        .reg_write(),
        .alu_src(),
        .branch(),
        .jump(),

        .data_size(),
        .data_sign()
    );

    id_ex_reg IDEX_register(
        .clk(clk),
        .rst(rst),
        .flush(flush_idex),
        .stall(stall_idex),

        .pc(pc_id)
    );

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
