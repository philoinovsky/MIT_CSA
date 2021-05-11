# Lecture 2: Instruction Set Architecture & Hardwired, Non-pipelined ISA Implementation
## Overview
### I. Compatibility
each system has its own:
- instruction set
- IO system and secondary storage: magnetic tapes, drums and disk
- assemblers, compilers, libraries
### II. Processor State and Data Types
The information held in the processor at the end of an instruction to provide the processing context for the next instruction
### III. Instruction Set
The control for changing the information held on the processor are specified by the instructions available in the instruction set architecture or ISA
### IV. Processor Performance
```
time/program = instructions/program * cycles/instructions * time/cycle
```
## Hardware
### I. Hardware Elements
1. Combinational circuits
- mux(select one from multiple inputs), demux(select one from multiple outputs), decoder(one to many), alu(select operator)
2. synchronous state elements
- flipflop, register, register file(supports parallel read/write), SRAM, DRAM
- edge-triggered: data is sampled at the rising edge
### II. Register Files
1. no timing issue; writes happen at the end of the cycle
2. one with large number of ports are difficult to design
## Implement MIPS
... see pdf