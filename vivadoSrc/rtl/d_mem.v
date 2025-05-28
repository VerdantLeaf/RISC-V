`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: myself
// Engineer: kyle
// 
// Create Date: 05/17/2025 10:35:55 PM
// Design Name: 
// Module Name: d_mem
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 1R1RW RAM module for data ram, and eventually unified data + instruction RAM
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////

module d_mem #(
    parameter NUM_WORDS = 1024,
    parameter WORD_SIZE = 32,
    parameter ADDR_SIZE = 10
    )(
    // Note: need to understand and document read/write to same address collision behavior

    input clk,

    // Instruction port (Port A)
    input                               a_en_write,     // Don't use at first, rely on i_mem.v
    input [ADDR_SIZE - 1 : 0]          a_addr,
    output reg [WORD_SIZE - 1 : 0]     a_dout,
    
    // Data port (Port B)
    input                               b_en_write,     // Keep names to change to true dual port one day
    input                               b_en_read,
    input [WORD_SIZE - 1 : 0]          b_addr,
    input [WORD_SIZE - 1 : 0]          b_din,
    input [1:0]                         b_size,         // 00 = byte, 01 = half, 10 = word
    input                               b_unsigned,     // 0 = signed, 1 = unsigned
    output reg [WORD_SIZE - 1 : 0]     b_dout
    
    );
    // Variable data size RAM - default to 4KB
    reg [WORD_SIZE - 1 : 0] memory [0 : NUM_WORDS - 1];

    // Calculate dynamically which bits to slice for the index into mem
    wire [ADDR_SIZE - 1 : $clog2(WORD_SIZE / 8)] a_index = a_addr[ADDR_SIZE - 1 : $clog2(WORD_SIZE / 8)];
    wire [ADDR_SIZE - 1 : $clog2(WORD_SIZE / 8)] b_index = b_addr[ADDR_SIZE - 1 : $clog2(WORD_SIZE / 8)];

    wire [1:0] b_offset = b_addr[1:0];
    reg [WORD_SIZE - 1 : 0] b_mem_word;

     // cascading if statement. Use one hot encoding
    wire [3:0] en_byte_write = (data_size == 2'b00) ? (4'b0001 << b_offset) :
                            (data_size == 2'b01) ? (4'b0011 << b_offset) :
                            (data_size == 2'b10) ? (4'b1111) : 4'b0000;

    // Load data memory with any data needed for the program, for simulation
    initial begin
        $readmemh("../../../../../programs/program_data.mem", memory);    
    end
    
    // -----------------
    // PORT A READ
    // -----------------
    always @(posedge clk) begin             
            a_dout = memory[a_index];   
    end
    
    // -----------------
    // PORT B READ/WRITE
    // -----------------
    always @(posedge clk) begin             // if a read or a write, grab the word at the index of the memory
        if(b_en_write || b_en_read)         
            b_mem_word = memory[a_index];   
    end
    
    // Data read port
    always @(*) begin
        case(b_size)
            2'b00: begin    // byte - Do 24b sign extensions
                case (b_offset)
                    2'b00: b_dout = b_unsigned ? {24'b0, b_mem_word[7:0]} : {{24{b_mem_word[7]}}, b_mem_word[7:0]};
                    2'b01: b_dout = b_unsigned ? {24'b0, b_mem_word[15:8]} : {{24{b_mem_word[15]}}, b_mem_word[15:8]};
                    2'b10: b_dout = b_unsigned ? {24'b0, b_mem_word[23:16]} : {{24{b_mem_word[23]}}, b_mem_word[23:16]};
                    2'b11: b_dout = b_unsigned ? {24'b0, b_mem_word[31:24]} : {{24{b_mem_word[31]}}, b_mem_word[31:24]};
                endcase
            end
            2'b01: begin    // half word - Do 16b sign extensions
                case (b_offset)
                    2'b00: b_dout = b_unsigned ? {16'b0, b_mem_word[15:0]} : {{16{b_mem_word[15]}}, b_mem_word[15:0]};
                    2'b10: b_dout = b_unsigned ? {16'b0, b_mem_word[31:16]} : {{16{b_mem_word[31]}}, b_mem_word[31:16]};
                endcase
            end 
            2'b10: b_dout = b_mem_word;     // word is easiest case
            default: b_dout = 32'hDEADBEEF; // nonsense if not valid
        endcase
    end
   
    // Write port for port B
    always @(posedge clk) begin
        if(b_en_write) begin    // en_byte_write is generated as one hot through the data size offset
            if(en_byte_write[0]) memory[b_index][7:0] <= b_din[7:0];
            if(en_byte_write[1]) memory[b_index][15:8] <= b_din[15:8];
            if(en_byte_write[2]) memory[b_index][23:16] <= b_din[23:16];
            if(en_byte_write[3]) memory[b_index][31:24] <= b_din[31:24];
        end
    end
endmodule
