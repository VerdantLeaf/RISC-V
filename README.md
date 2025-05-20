# RISC-V
RISC-V implementations **(In Verilog, no idea why it says VHDL for the language)**

## Goals

Due to the late change between grad school and a full time offer, I am not working at an internship this summer. However, I want to get a lot deeper in to hardware design and understanding computer architecture. To do this, I wanted to create a RISC-V CPU that I can deploy onto my [Arty-S7-25](https://digilent.com/shop/arty-s7-spartan-7-fpga-development-board/), or if it's too much for that, then my [Pynq-Z2](https://www.newark.com/tul-corporation/1m1-m000127dvb/tul-pynq-z2-basic-kit-rohs-compliant/dp/69AC1754?st=tul-corporation). A decent portion of this I will be figuring out/learning as I go. I will try to strike a balance between incorporation of IP available to me (the Vivado IP catalog) and my own designs.

Ny first step is just completing the basic 5 stage pipeline for RISC-V and a standard In-Order CPU.

## Current status:

- Register file design has been completed and testbenched.
- 4KB of instruction memory has been added and testbenched. For simulation, programs can be ran/added by generating the .mem file and then modifying the program name in the `imem.v` file
