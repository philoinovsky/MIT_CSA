# Lecture 1: Introduction
## Evolution
1. single accumulator, absolute address
```
LOAD    x
```
2. index registers
```
LOAD    x, IX
```
3. Indirection
```
LOAD    x
```
4. Multiple accumulators, index registers, indirection
```
LOAD    R, IX, x -> pointer of array
LOAD    R, IX, (x) -> array of pointers
```
5. Indirect through registers
```
LOAD    Ri, (Rj)
```
6. The works
```
LOAD    Ri, Rj, (Rk) -> Rj = index, Rk = base addr
```
## Instruction Formats
### I. three addresses
1. (Regj op Regk) to Regi
2. (Regj op Mem) to Regi
### II. two addresses
dest is same as one of the operand sources
### III. one address
accumulator machine
### IV. zero address
operands on a stack