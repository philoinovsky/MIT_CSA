# Lecture 19: Microcoded and VLIW Processors
## Hardwired vs Microcoded Processors
1. all processors we have seen so far are hardwired
2. microcoded processors add a layer of interpretation: each ISA instruction is executed as a sequence of simpler microinstruction
- simpler implementation
- lower performance than hardwired (CPI > 1)
3. microcoding common until the 80s, still in use today (e.g. complex x86 instructions are decoded into multiple "micro-ops")
## Microcoded Microarchitecture
1. memory -> holds user program written in `macrocode` instructions (e.g., MIPS, x86)
2. micro-controller ->  holds fixed microcode instructions
### I. a bus-based datapath for MIPS
### II. Memory Module
assumption: Memory operates asynchronously and is slow compared to reg-to-reg trasfer
### III. Instruction Execution
- Execution of a MIPS instruction involves
    1. instruction fetch
    2. decode and register fetch
    3. ALU operation
    4. memory operation (optional)
    5. write back to register file (optional) + the computation of the next instruction address
## VLIW Processors (Very Long Instruction Word)
1. the architecture:
    - allows operation parallelism within an instruction
    - provides deterministic latency for all operations
2. the compiler:
    - schedules (reorders) to maximize parallel execution
    - guarantees intra-instruction parallelism
    - schedules to avoid data hazards (no interlocks)
### I. loop unrolling
- software pipelining vs unrolling
    - software pipelining pays startup/wind-down costs `only once` per loop, not once per iteration
### II. Trace Scheduling
- pick string of basic blocks, a trace, that represents most frequent branch path
- schedule whole "trace" at once
- add fixeup code to cope with branches jumping out of trace
### III. Problems with "classic" VLIW
- knowing branch probabilities
- scheduing for statically unpredictable branches
- object code size
- scheduling memroy operations
- object-code compatibility
### IV. Clustered VLIW
- divide machine into clusters of local register files and local functional units
- lower bandwiddth/higher latency interconnect between clusters
- software responsible for mapping computations to minimize communication overhead
- common in commercial embedded processors
- exists in some superscalar processors
### V. Limits of Static Scheduling
- unpredictable branches
- unpredictable memory behavior (cache misses and dependencies)
- code size explosion
- compiler complexity
