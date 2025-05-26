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
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module d_mem(
    input clk,
    input [31:0] addr,          // The address within the RAM to read/write data from/to
    input data_size,            // The size of the data to read/write in Bytes
    input en_write_mem,         // Enables a write to the memory address listed in addr
    input en_read_mem,          // Enables a read from the memory address listed in addr
    output reg [31:0] data,     // The data itself, where the upper N Bytes are zeros, where N = 4 - data_size
    output reg access_status    // Indicates if the access to memory was successful
    );
    
    // 2048 word RAM
    reg [31:0] memory [0 : 2047];
    
    // future: Implement buffering on the memory system, and optimize read/write logic?
    
    always @(posedge clk) begin
        if (en_read_mem ^ en_write_mem) begin   // if the two are different, then valid
        
        end else begin // IF read and write enables are the same, then throw error  
            access_status <= 1;
            if (en_write_mem) data <= 32'hFFFFFFFF; // if both are ones
            else data <= 32'hFFFFFFFE;              // if both are zeroes       
        end
    end
    
    
endmodule
