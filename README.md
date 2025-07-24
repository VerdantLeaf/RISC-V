# Status:

EX stage testbench is nearly complete and ready for testing. ALU has been completed and testbenched. I went with a simple combinational/single-cycle ALU. For now, it is easier, since I am concerned about being able to deliver a working product by the end of the Summer. In the future, I have designed in the ability to stall the pipeline for a future more complicated ALU (bit pair or Dadda multiplier, multi-cycle, etc...). I've increased my use of tasks and how I am using them in my testbenches. Tasks are easily one of my favorite features.

We are one step closer, and I am hopeful to have a completed and verified design. Regardless of that, I've learned a whole lot and have most certainly become a better hardware designer. I've done everything here myself, and while that may have slowed me down a little, compared to working in a professional setting, I've had to learn it *all*.

# RISC-V
RISC-V implementation. Design and implementation of a 5-stage pipelines RV32I RISC-V processor in Verilog with a Harvard memory architecture. Utilizing the pipeline means developing each stage as well as units to handle the forwarding and branching. 

## Goals

Due to the late change between grad school and a full time offer, I am not working at an internship this summer. However, I want to get a lot deeper in to hardware design and understanding computer architecture. To do this, I wanted to create a RISC-V CPU that I can deploy onto my [Arty-S7-25](https://digilent.com/shop/arty-s7-spartan-7-fpga-development-board/), or if it's too much for that, then my [Pynq-Z2](https://www.newark.com/tul-corporation/1m1-m000127dvb/tul-pynq-z2-basic-kit-rohs-compliant/dp/69AC1754?st=tul-corporation). A decent portion of this I will be figuring out/learning as I go. I will try to strike a balance between incorporation of IP available to me (the Vivado IP catalog) and my own designs.

My first step is just completing the basic 5 stage pipeline for RISC-V and a standard In-Order CPU.

## Loading programs for simulation

For simulation, programs can be ran/added by generating the .mem file and then modifying the program name in the `i_mem.v` file. For testing without caring about actual program instructions, program.mem contains instructions that just increment throughout the memory block. This solution only works in simulation however, will need to figure out another solution for implementation. BRAM IP block + .coe file didn't seem to be working.

## Current status:

- EX stage design completed, waiting on testbench
- IF and ID stages, as well as all submodules, are completed and testbenched
- CPU defaults to 4KB of instruction memory
- Data memory utilizes a 1R/1RW port setup to enable standard data memory for now, but Von Neumann memory in the future
- Parameterization of variable length vectors is mostly instantiated

## Future ideas/add ons:
- L1 instruction and/or data cache
- Prefetcher for instructions
- Out of order execution
- GShare branch prediction - Or any branch prediction algorithm (I've done GShare in HDLBits)
- UART instruction injection to enable co-processor support for an STM32 Nucleo board/custom PCB
- Tiny GPU add on/custom instructions (You could reformat I-type instructions to do a parallel operations on a series of registers, storing the values into a "parllel regfile" which you could then use to forward/writeback to the regfile/pipeline stages. It would be pretty cool, I think it's possible? (Learned about RISC-V vector instructions, which is cool)).
- VonNeumann architecture with 1R/1RW memory
- More advanced ALU (Dadda multiplier)