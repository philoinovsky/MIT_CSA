# Lecture 9: Complex Pipelining: Out-of-order Execution, Register Renaming, and Exceptions
## Register Renaming
### I. Reorder Buffer
```
inst use exec op p1 src1 p2 src2
```
- instruction slot is candidate for execution when:
    - it holds a valid instruction (`use` bit is set)
    - it has not yet started execution (`exec` bit is clear)
    - both operands are available (`present` bits p1 and p2 are set)
- is it obvious where an `architectural register` value is? No
### II. Renaming Table & Register File
1. two fields: `p` - present, `data` (or `tag`) - physical register.
2. steps
- insert instruction in ROB
- issue instruction from ROB
- complete instruction
- empty ROB entry
### III. Simplifying Allocation/Deallocation
instruction buffer is managed circularly, steps:
- set `exec` bit when instruction begins execution
- when an instruction completes its `use` bit is marked free
- increment ptr2 only if the `use` bit is marked free
### IV. Data-Driven Execution
- instruction template (i.e. tag t) is allocated by the Decode Stage, which also stores the tag in the reg file
- when an instruction completes, its tag is deallocated
## Precise Exceptions
### I. Methology
1. exceptions create a dependence on the value of the next PC
2. Options for handling this dependence:
- stall, bypass, find something else to do, change the architecture
- speculate!
3. how to handle rollback on mis-speculation?
4. earlier exceptions must override later ones
### II. Phases of Instruction Execution
![ASID](./img/9-24.png)
1. instruction fetched and decoded into instruction reorder buffer -> in-order
2. execution -> out-of-order completion
3. commit (write-back to architectural state, i.e. regfile & memory) -> in-order
4. note: temporary storage needed to hold results before commit (shadow registers and store buffers)
### III. Extensions for Precise Exceptions
1. add `pd, dest, data, cause` fields in the instruction template
2. commit instructions to regfile and memory in program order => buffers can be maintained circularly
3. on exception, clear reorder buffer by resetting `ptr1 = ptr2`. (stores must wait for commit before updating memory)
### IV. Rollback and Renaming
1. register file does not contain renaming tags any more. 
2. How does the decode stage find the tag of a source register
### V. Renaming Table
1. renaming table is a cache to speed up register name lookup
2. it needs to be cleared after each exception taken
3. when else are valid bits cleared?
### VI. Physical Register Files
1. reorder buffers are space inefficient - a data value may be stored in multiple places in the reorder buffer
2. idea: keep all data values in a physical register file
    - tag represents the name of the data value and name of the physical register that holds it
    - reorder buffers contains only tags