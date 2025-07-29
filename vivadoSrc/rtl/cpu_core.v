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
    NUM_WORDS = 1024,
    ADDR_SIZE = $clog2(NUM_WORDS)

    )(
    input clk,
    input rst
    );
    // Pipeline reg flush/stall
    wire flush_ifid, flush_idex, flush_exmem, flush_memwb;
    wire stall_pc_reg, stall_ifid, stall_idex, stall_exmem, stall_memwb;


    wire [ADDR_SIZE - 1 : 0] branch_target_ex, branch_target_mem;
    wire [ADDR_SIZE - 1 : 0] pc_if, pc_id, pc_ex;

    wire [WORD_SIZE - 1 : 0] instr_if, instr_id;
    wire [WORD_SIZE - 1 : 0] data1_id, data1_ex;
    wire [WORD_SIZE - 1 : 0] data2_id, data2_ex;
    wire [WORD_SIZE - 1 : 0] alu_result_ex, alu_result_mem, alu_result_wb;
    wire [WORD_SIZE - 1 : 0] write_mem_data_ex, write_mem_data_mem;
    wire [WORD_SIZE - 1 : 0] read_mem_data_mem, read_mem_data_wb;
    wire [WORD_SIZE - 1 : 0] write_regfile_data_ex, write_regfile_data_mem, write_regfile_data_wb;
    
    wire [WORD_SIZE - 1 : 0] immd_id, immd_ex;
    wire [WORD_SIZE - 1 : 0] arg1_regfile_id, arg1_regfile_ex;
    wire [WORD_SIZE - 1 : 0] arg2_regfile_id, arg2_regfile_ex;

    // rs1...
    wire [REG_SEL - 1 : 0] rs1_id, rs1_ex;
    wire [REG_SEL - 1 : 0] rs2_id, rs2_ex;
    wire [REG_SEL - 1 : 0] rd_id, rd_ex, rd_mem, rd_wb;


    // control signals
    // terminate in ex
    wire alu_src_id, alu_src_ex;
    wire [3:0] alu_op_id, alu_op_ex;
    wire [1:0] forward_select1, forward_select2;

    // terminate in mem
    wire mem_read_id, mem_read_ex, mem_read_mem;
    wire mem_write_id, mem_write_ex, mem_write_mem;
    wire branch_id, branch_ex, branch_mem;
    wire jump_id, jump_ex, jump_mem;
    wire [1:0] data_size_id, data_size_ex, data_size_mem;
    wire data_sign_id, data_sign_ex, data_sign_mem;
    wire alu_zero_ex, alu_zero_mem;

    // termiante in wb
    wire mem_to_reg_id, mem_to_reg_ex, mem_to_reg_mem,  mem_to_reg_wb;
    wire reg_write_id, reg_write_ex, reg_write_mem, reg_write_wb;



    // Pipeline registers and stages
    if_stage #(
        .WORD_SIZE(WORD_SIZE),
        .NUM_WORDS(NUM_WORDS),
        .ADDR_SIZE(ADDR_SIZE)
    ) instructionfetch (
        .clk(clk),
        .rst(rst),
        
        .pc_src(pc_src),
        .en(stall_pc_reg), // Enables updating of PC register. Sourced from branch unit?
        
        .branch_target(branch_target),
        .pc_next(pc_if),

        .instr(instr_if)
    );

    if_id_reg #(
        .WORD_SIZE(WORD_SIZE)
    ) IFID_register (
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
        .NUM_WORDS(NUM_WORDS),
        .REG_SEL(REG_SEL),
        .ADDR_SIZE(ADDR_SIZE)
    ) instructiondecode (
        .clk(clk),
        .rst(rst),

        .instr(instr_id),

        .reg_write(reg_write_wb),
        .rd_data(write_regfile_data_wb),
        .rd_select(rd_wb),

        .immd(immd_id),
        .data1(arg1_regfile_id),
        .data2(arg2_regfile_id),
        .alu_op(alu_op_id),
        .rd(rd_id),
        .rs1(rs1_id),
        .rs2(rs2_id),

        .mem_read(mem_read_id),
        .mem_write(mem_write_id),
        .mem_to_reg(mem_to_reg_id),
        .reg_write(reg_write_id),
        .alu_src(alu_src_id),
        .branch(branch_id),
        .jump(jump_id),

        .data_size(data_size_id),
        .data_sign(data_sign_id)
    );

    id_ex_reg #(
        .WORD_SIZE(WORD_SIZE),
        .NUM_REGS(NUM_REGS),
        .NUM_WORDS(NUM_WORDS),
        .REG_SEL(NUM_REGS),
        .ADDR_SIZE(ADDR_SIZE)
    ) IDEX_register (
        .clk(clk),
        .rst(rst),
        .flush(flush_idex),
        .stall(stall_idex),

        .pc(pc_id),
        .immd(immd_id),
        .data1(arg1_regfile_id),
        .data2(arg1_regfile_id),

        .alu_op(alu_op_id),
        .rd(rd_id),
        .rs1(rs1_id),
        .rs2(rs2_id),

        .mem_read(mem_read_id),
        .mem_write(mem_write_id),
        .mem_to_reg(mem_to_reg_id),
        .reg_write(reg_write_id),
        .alu_src(alu_src_id),
        .branch(branch_id),
        .jump(jump_id),

        .data_size(data_size_id),
        .data_sign(data_sign_id),

        .pc_out(pc_ex),
        .immd_out(immd_ex),
        .data1_out(arg1_regfile_ex),
        .data2_out(arg2_regfile_ex),

        .alu_op_out(alu_op_ex),
        .rs1_out(rs1_ex),
        .rs2_out(rs2_ex),
        .rd_out(rd_ex),

        .mem_read_out(mem_read_ex),
        .mem_write_out(mem_write_ex),
        .mem_to_reg_out(mem_to_reg_ex),
        .reg_write_out(reg_write_ex),
        .alu_src_out(alu_src_ex),
        .branch_out(branch_ex),
        .jump_out(jump_ex),
        
        .data_size_out(data_size_ex),
        .data_sign_out(data_sign_ex)
    );

    ex_stage #(
        .WORD_SIZE(WORD_SIZE),
        .NUM_REGS(NUM_REGS),
        .NUM_WORDS(NUM_WORDS),
        .REG_SEL(NUM_REGS),
        .ADDR_SIZE(ADDR_SIZE)
    )execution(
        .pc(pc_ex),

        .data1(arg1_regfile_ex),
        .mem_forward1(write_regfile_data_mem),
        .wb_forward1(write_regfile_data_wb),

        .data2(arg2_regfile_ex),
        .mem_forward2(write_regfile_data_mem),
        .wb_forward2(write_regfile_data_wb),

        .immd(immd_ex),

        .sel_forward1(forward_select1),
        .sel_forward2(forward_select2),

        .alu_op(alu_op_ex),
        .alu_src(alu_src_ex),
        .branch(branch_ex),
        .jump(jump_ex),

        .zero(alu_zero_ex),
        .brnach_target(branch_target_ex),
        .result(alu_result_ex),
        .write_data()
    );

    ex_mem_reg #(
        .WORD_SIZE(WORD_SIZE),
        .NUM_REGS(NUM_REGS),
        .NUM_WORDS(NUM_WORDS),
        .REG_SEL(REG_SEL),
        .ADDR_SIZE(ADDR_SIZE)
    ) EXMEM_register (
        .clk(clk),
        .rst(rst),
        .flush(flush_exmem),
        .stall(stall_exmem),

        .branch_target(),
        .alu_result(write_regfile_data_ex),
        .rd(rd_ex),

        .mem_read(mem_read_ex),
        .mem_write(mem_write_ex),
        .mem_to_reg(mem_to_reg_ex),
        .reg_write(reg_write_ex),
        .alu_zero(alu_zero_ex),
        .branch(branch_ex),
        .jump(jump_ex),

        .write_data(write_mem_data_ex),
        .data_size(data_size_ex),
        .data_sign(data_sign_ex),

        .branch_target_out(branch_target_mem),
        .alu_result_out(write_regfile_data_mem),
        .rd_out(rd_mem),

        .mem_read_out(mem_read_mem),
        .mem_write_out(mem_write_mem),
        .mem_to_reg_out(mem_to_reg_mem),
        .reg_write_out(reg_write_mem),
        .alu_zero_out(alu_zero_ex),
        .branch_out(branch_mem),
        .jump_out(jump_mem),

        .write_data_out(write_mem_data_mem),
        .data_size_out(data_size_mem),
        .data_sign_out(data_sign_mem)
    );

    mem_stage #(
        .NUM_WORDS(NUM_WORDS),
        .WORD_SIZE(WORD_SIZE),
        .ADDR_SIZE(ADDR_SIZE)
    ) memory (
        .clk(clk),

        .b_en_read(mem_read_mem),
        .b_en_write(mem_write_mem),
        .b_addr(write_regfile_data_mem),
        .b_din(write_mem_data_mem),
        .b_size(data_size_mem),
        .b_unsigned(data_sign_mem),
        .b_dout()
    );

    mem_wb_reg #(
        .WORD_SIZE(WORD_SIZE),
        .NUM_REGS(NUM_REGS),
        .NUM_WORDS(NUM_WORDS),
        .REG_SEL(REG_SEL),
        .ADDR_SIZE(ADDR_SIZE)
    ) MEMWB_register (
        .clk(clk),
        .rst(rst),
        .flush(flush_memwb),
        .stall(stall_memwb),

        .read_data(read_mem_data_mem),
        .result(write_regfile_data_mem),
        .rd(rd_mem),
        .mem_to_reg(mem_to_reg_mem),
        .reg_write(reg_write_mem),

        .read_data_out(read_mem_data_wb),
        .result_out(write_regfile_data_mem),
        .rd_out(rd_wb),
        .mem_to_reg_out(mem_to_reg_wb),
        .reg_write_out(reg_write_wb)
    );

    wb_stage #(
        .WORD_SIZE(WORD_SIZE)
    )writeback(
        .memory_data(read_mem_data_wb),
        .alu_data(write_regfile_data_wb),

        .mem_to_reg(mem_to_reg_wb),
        .write_data(write_regfile_data_wb)
    );

    // External control and hazard units
    forwarding_unit #(
        .NUM_REGS(NUM_REGS),
        .REG_SEL(REG_SEL)
    ) forwarding_unit (
        .ex_rs1(rs1_ex),
        .ex_rs2(rs2_ex),
        .mem_rd(rd_mem),
        .wb_rd(rd_wb),

        .mem_reg_write(reg_write_mem),
        .wb_reg_write(reg_write_wb),

        .forward1(forward_select1),
        .forward2(forward_select2)
    );

    branch_unit branch_unit();

endmodule
