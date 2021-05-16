# Lecture 6: Instruction Pipelining and Hazards
## Pipelined Princeton Architecture
### I. phases
1. 4 phases
2. `tc-princeton > trf + talu + tM + tWB`
3. `1 + f` CPI where f is the fraction of instructions that cause a stall
## An Ideal Pipeline (5-stage)
fetch -> decode & Reg-fetch -> execute -> memory access -> write back
1. more stage, more speedup
2. need an `instruction register` between each phase
## Hazards
### I. structural hazard - need resource being used by another inst
### II. data hazard - depend on value produced by an earlier inst
#### A. type of dependency
1. data-dependence: source depends on last result
2. anti-dependence: source same as last result, cannot write before read
3. output-dependence: result same as last result, cannot write before last write
#### B. type of Data Hazards
1. read after write
2. write after read
3. write after write
### C. Register vs Memory Data Dependencies:
1. data hazards due to register operands can be determined at the decode stage
2. data hazards due to memory operands can be determined only after computing the effective address
#### A. stall
1. when to stall ->
```
(
    (rsD == wsE) * weE + 
    (rsD == wsM) * wsM +
    (rsD == wsW) * weW
) * re1D + 
(
    (rtD == wsE) * weE + 
    (rtD == wsM) * wsM +
    (rtD == wsW) * weW
) * re2D
```
in which `ws` and `we` depends on the opcode
#### B. bypass
#### C. Speculate
### III. control hazard - dependency for calculating next PC