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

    wire flush_ifid, flush_idex, flush_exmem, flush_memwb;
    wire stall_ifid, stall_idex, stall_exmem, stall_memwb;


    wire [ADDR_SIZE - 1 : 0] branch_target;
    wire [ADDR_SIZE - 1 : 0] pc_if, pc_id, pc_ex;
    wire [WORD_SIZE - 1 : 0] instr_if, instr_id;
    wire [WORD_SIZE - 1 : 0] data1_id, data2_id, data1_ex, data2_ex;

    // write back
    wire reg_write_mem, reg_write_wb;
    wire [WORD_SIZE - 1 : 0] write_data;
    wire [REG_SEL - 1 : 0] write_select;

    // immediates
    wire [WORD_SIZE - 1 : 0] immd_id, immd_ex;

    // control signals
    // terminate in ex
    wire alu_src_id, alu_src_ex;
    wire forward_select1, forward_select2;
    wire [3:0] alu_op_id, alu_op_ex;

    // terminate in mem
    wire mem_read_id, mem_read_ex, mem_read_mem;
    wire mem_write_id, mem_write_ex, mem_write_mem;
    wire branch_id, branch_ex, branch_mem;
    wire jump_id, jump_ex, jump_mem;

    // termiante in wb
    wire mem_to_reg_id, mem_to_reg_ex, mem_to_reg_mem,  mem_to_reg_wb;
    wire reg_write_id, reg_write_ex, reg_write_mem, reg_write_wb;












































    // Pipeline registers and stages
    if_stage instructionfetch(
        .clk(clk),
        .rst(rst),
        
        .pc_src(pc_src),
        .en(en_pc_reg), // Enables updating of PC register. Sourced from branch unit?
        
        .branch_target(branch_target),
        .pc_next(pc_if),

        .instr(instr_if)
    );

    if_id_reg IFID_register(
        .clk(clk),
        .rst(rst),
        .flush(flush_ifid),
        .stall(stall_ifid),

        .instr(instr_if),
        .pc(pc_if),

        .instr_out(instr_id), // instruction and PC to ID stage
        .pc_out(pc_id)
    );

    id_stage #(
        .WORD_SIZE(WORD_SIZE),
        .NUM_REGS(NUM_REGS),
        .REG_SEL(REG_SEL),
        .ADDR_SIZE(ADDR_SIZE)
    ) instructiondecode (
        .clk(clk),
        .rst(rst),

        .instr(instr_id),

        .reg_write(reg_write_wb),
        .rd_data(write_data),
        .rd_select(write_select),

        .immd(immd_id),
        .data1(),
        .data2(),
        .alu_op(alu_op_id),
        .rd(),
        .rs1(),
        .rs2(),

        .mem_read(mem_read_id),
        .mem_write(mem_write_id),
        .mem_to_reg(mem_to_reg_id),
        .reg_write(reg_write_id),
        .alu_src(alu_src_id),
        .branch(branch_id),
        .jump(jump_id),

        .data_size(),
        .data_sign(),
    );

    id_ex_reg IDEX_register(
        .clk(clk),
        .rst(rst),
        .flush(flush_idex),
        .stall(stall_idex),

        .pc(pc_id),
        .immd(immd_id),
        .data1(),
        .data2(),

        .alu_op(alu_op_id),
        .rd(),
        .rs1(),
        .rs2(),

        .mem_read(mem_read_id),
        .mem_write(mem_write_id),
        .mem_to_reg(mem_to_reg_id),
        .reg_write(reg_write_id),
        .alu_src(alu_src_id),
        .branch(branch_id),
        .jump(jump_id),

        .data_size(),
        .data_sign(),

        .pc_out(pc_ex),
        .immd_out(),
        .data1_out(),
        .data2_out(),

        .alu_op_out(alu_op_ex),
        .rs1_out(),
        .rs2_out(),
        .rd_out(),

        .mem_read_out(mem_read_ex),
        .mem_write_out(mem_write_ex),
        .mem_to_reg_out(mem_to_reg_ex),
        .reg_write_out(reg_write_ex),
        .alu_src_out(alu_src_ex),
        .branch_out(branch_ex),
        .jump_out(jump_ex),
        
        .data_size_out(),
        .data_sign_out()

    );

    ex_stage #(
        .WORD_SIZE(WORD_SIZE),
        .NUM_REGS(NUM_REGS),
        .REG_SEL(NUM_REGS),
        .ADDR_SIZE(ADDR_SIZE)
    )execution(
        .pc(pc_ex),
    );

    ex_mem_reg EXMEM_register();

    mem_stage memory();

    mem_wb_reg MEMWB_register();

    wb_stage #(
        .WORD_SIZE(WORD_SIZE)
    )writeback(
        .memory_data(read_data),
        .alu_data(alu_res_wb),
        .mem_to_reg(mem_to_reg_wb),
        .write_data(write_data_to_regfile)
    );

    // External control and hazard units
    forwarding_unit forwarding_unit();

    branch_unit branch_unit();

endmodule
