# Lecture 20: Vector Processors
## Vector SUpercomputers
- scalar unit
    - load/store architecture
- vector extension
    - vector registers
    - vector instructions
- implementation
    - hardwired control
    - highly pipelined functional units
    - no data caches
    - interleaved memory system
    - no virtual memory
## Vector ISA Attributes
- compact
    - one short instruction encodes N operations
- expressive, tells hardware that these N operations:
    - are independent
    - use the same functional unit
    - access disjoint elements in vector registers
    - access registers in same pattern as previous instructions
    - access a contiguous block of memory (unit-strided load/store)
    - access memory in a known pattern (strided load/store)
## Vector ISA Hardware Implications
- large amount of work per instruction
    - less instruction fetch bandwidth requirements
    - allows simplified instruction fetch design
- no data dependence within a vector
    - amenable to deeply pipelined/parallel designs
- disjoint vector element access
    - banked rather than multi-ported register files
- known regular memory access pattern
    - allows for banked memory for higher bandwidth
## Vector
### I. Vector Arithmetic Execution
- use deep pipeline (=> fast clock) to execute element operations
- simplifies control of deep pipeline because elements in vector are independent
### II. Vector Stripmining
- problem: vector registers have finite length
- solution: break loops into pieces that fit in registers, "strip mining"
### III. Vector Conditional Execution
- problem: want to vectorize loops with conditional code
- solution: add vector mask (or flag) registers and maskable vector instructions
### III. Vector Scatter/Gather
- problem: want to vectorize loops with indirect accesses
- indexed load instruction (Gather)
