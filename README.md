# Status:

I think developing a non-pipelined CPU first would have been a good idea, but I have learned so much from this project, that I want to keep going. I didn't expect to get very sick or have the other issues this summer, but I am back. Would like to get to developing an interesting project.

# RISC-V
RISC-V implementation. Design and implementation of a 5-stage pipelines RV32I RISC-V processor in Verilog with a Harvard memory architecture. 

## Goals

Due to the late change between grad school and a full time offer, I am not working at an internship this summer. However, I want to get a lot deeper in to hardware design and understanding computer architecture. To do this, I wanted to create a RISC-V CPU that I can deploy onto my [Arty-S7-25](https://digilent.com/shop/arty-s7-spartan-7-fpga-development-board/), or if it's too much for that, then my [Pynq-Z2](https://www.newark.com/tul-corporation/1m1-m000127dvb/tul-pynq-z2-basic-kit-rohs-compliant/dp/69AC1754?st=tul-corporation). A decent portion of this I will be figuring out/learning as I go. I will try to strike a balance between incorporation of IP available to me (the Vivado IP catalog) and my own designs.

My first step is just completing the basic 5 stage pipeline for RISC-V and a standard In-Order CPU.

## Loading programs for simulation

For simulation, programs can be ran/added by generating the .mem file and then modifying the program name in the `i_mem.v` file. For testing without caring about actual program instructions, program.mem contains instructions that just increment throughout the memory block. This solution only works in simulation however, will need to figure out another solution for implementation. BRAM IP block + .coe file didn't seem to be working.

## Current status:

- Register file design has been completed and testbenched.
- 4KB of instruction memory has been added and testbenched. 
- IF/ID register is complete
- IF stage is complete and testbenched.
- Data memory first complete draft completed. 1R1RW port setup
- Parameterization of regfile, i/d_mem and if_stage complete
