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
// Description: Dual-port RAM for data access 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////

// note: parameterize if you want to later

module d_mem(
    input clk,
    
    // port A
    input               a_en_write,
    input               a_en_read,
    input [31:0]        a_addr,
    input [31:0]        a_din,
    input [1:0]         a_size,         // 00 = byye, 01 = half, 10 = word
    input               a_unsigned,     // 0 = signed, 1 = unsigned
    output reg [31:0]   a_dout,
    
    
    // port B
    input               b_en_write,
    input               b_en_read,
    input [31:0]        b_addr,
    input [31:0]        b_din,
    input [1:0]         b_size,         // 00 = byye, 01 = half, 10 = word
    input               b_unsigned,     // 0 = signed, 1 = unsigned
    output reg [31:0]   b_dout
    
    );
    // 1024 word RAM (can always scale up)
    reg [31:0] memory [0 : 1023];
    
    wire [9:2]          a_index     = a_addr[9:2]; // note: Change for parameterization
    wire [1:0]          a_offset    = a_addr[1:0];
    
    wire [9:2]          b_index     = b_addr[9:2];
    wire [1:0]          b_offset    = b_addr[1:0];

    
    
    
    
    // future: Implement buffering on the memory system, and optimize read/write logic?
    
    // Load data memory with any data needed for the program, for simulation
    initial begin
        $readmemh("../../../../../programs/program_data.mem", memory);    
    end
    
//    always @(posedge clk) begin
//        if (en_read_mem ^ en_write_mem) begin   // if the two are different, then valid
//            if (en_read_mem) begin
                
//            end else if (en_write_mem) begin
                
//            end
//        end else if (en_read_mem && en_write_mem) begin // Using split bus, allow for concurrent reads and writes
            
//        end else begin // IF read and write enables are the same, then throw error  
//            access_status <= 1;
//            read_data <= 32'hFFFFFFFF;       
//        end
//    end
    
    
endmodule
