# Status:

I am nearly complete with the ID stage. New additions to my understanding include how to build out tasks in testbenches and utilizing verilog header files. The tasks are very useful to check expected signals with what the module is generating. The header files are nice to work with in Vivado, but can be annoying when Vivado doesn't recognize that they exist. 

I learned that with how I set a project setting, Vivado makes a copy of each file internally, and then doesn't reference the files in the VivadoSrc directory. This means that when I use VSCode to edit files and go into Vivado, I have to reload the files, but also that the two can get a little out of sync. Future knowledge to uncheck the "copy to project" setting when setting up the project. 

I am hopeful to have a completed and verified design, however, regardless, I've learned a whole lot and have most certainly become a better hardware designer. I've done everything here myself, and while that may have slowed me down a little, compared to working in a professional seting, I've had to learn it *all*.

# RISC-V
RISC-V implementation. Design and implementation of a 5-stage pipelines RV32I RISC-V processor in Verilog with a Harvard memory architecture. Utilizing the pipeline means developing each stage as well as units to handle the forwarding and branching. 

## Goals

Due to the late change between grad school and a full time offer, I am not working at an internship this summer. However, I want to get a lot deeper in to hardware design and understanding computer architecture. To do this, I wanted to create a RISC-V CPU that I can deploy onto my [Arty-S7-25](https://digilent.com/shop/arty-s7-spartan-7-fpga-development-board/), or if it's too much for that, then my [Pynq-Z2](https://www.newark.com/tul-corporation/1m1-m000127dvb/tul-pynq-z2-basic-kit-rohs-compliant/dp/69AC1754?st=tul-corporation). A decent portion of this I will be figuring out/learning as I go. I will try to strike a balance between incorporation of IP available to me (the Vivado IP catalog) and my own designs.

My first step is just completing the basic 5 stage pipeline for RISC-V and a standard In-Order CPU.

## Loading programs for simulation

For simulation, programs can be ran/added by generating the .mem file and then modifying the program name in the `i_mem.v` file. For testing without caring about actual program instructions, program.mem contains instructions that just increment throughout the memory block. This solution only works in simulation however, will need to figure out another solution for implementation. BRAM IP block + .coe file didn't seem to be working.

## Current status:

- ID stage should be complete and starting to testbench.
- Instruction decoder has been completed and testbenched.
- Immediate generator has been completed and testbenched.
- Register file design has been completed and testbenched.
- 4KB of instruction memory has been completed and testbenched. 
- IF/ID register is complete.
- IF stage is complete and testbenched.
- Data memory first complete draft completed. 1R1RW port setup
- Parameterization of regfile, i/d_mem and if_stage complete

## Future ideas/add ons:
- L1 instruction and/or data cache
- Prefetcher for instructions
- Out of order execution
- GShare branch prediction
- UART instruction injection to enable co-processor support for an STM32 Nucleo board/custom PCB
- Tiny GPU add on/custom instructions
- VonNeumann architecture with 1R/1RW memory
- More advanced ALU (Dadda multiplier)