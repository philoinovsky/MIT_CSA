# Lecture 10: Branch Prediction
## Branch Penalties
### I. Example Branch Penalties
1. branch target address known after branch address calc/begin decode
2. rbranch direction jump register target known after register file read
### II. Reducing Control Flow Penalty
#### A. Software Solutions
1. eliminate branches - loop unrolling
2. reduce resolution time - instruction scheduling
#### B. Hardware Solutions
1. bypass - usually results are used immediately
2. change architecture
    - delay slots
3. speculate - branch prediction
## Branch Prediction
### I. Required Hardware Support
#### A. Prediction Structures
branch history tables, branch target buffers, etc.
#### B. Mispredict recovery mechanism
1. keep result computation separate from commit
2. kill instructions following branch in pipeline
3. restore state to state following branch
### II. Static Branch Prediction
i.e. backward 90%, forward 50%
### III. Dynamic Prediction
based on: temporal, spatial
## Temporal - BHT
### I. Predictor Primitive
- indexed table holding values
- `Prediction = P[width, depth](index; update)`
### II. one bit predictor
always return last taken. simple temporal prediction
```
P[1, 2K](PC; T)
```
### III. two bit predictor
two bit, move after two wrong predictions
```
MSB(Counter[2, 2K](PC; T))
```
### IV. Branch History Table (BHT)
4k-entry, 2 bits/entry, ~80%-90% correct predictions
## Spatial
### I. History Registers
1. history registers: `History(PC; T) = P(PC; P||T)`
2. global history predictor: `GHist(;T) = MSB(Counter(History(O,T); T))`
3. local history predictor: `LHist(PC;T) = MSB(Counter(History(O,T); T))`
4. global history predictor with per-pc counters: `GHist(;T) = MSB(Counter(History(O,T); P||T))`
5. two level branch predictor: use result from the last two branches to select one of the four sets of BHT bits
### II. TAGE Predictor
-
### III. Limitations of Branch Predictors
only predicts branch direction. cannot redirect fetch stream until after branch target is determined
## Branch Target Buffer (BTB)
### I. untagged
- no pc
- IF stage: if (BP = taken) nPC = target; else nPC = PC + 4
- later: check prediction, if wrong -> kill the instruction and update BTB & BPb, else -> update BPb
#### Prblem: Address Collisions
- jump when shouldn't
- BTB is only for Control Instructions! how to achieve this without decoding the instruction
### II. tagged
has pc
## Combining BTB and BHT
1. BTB entries are more expensive, but can redirect fetches at earlier stage in pipeline and an accelerate indirect branches (JR)
2. BHT can hold many more entries and is more accurate
## MISC
### I. Uses of Jump Register(JR)
- switch statements
- dynamic function call (jump to run-time function address)
- subroutine returns (jump to return address)
### II. Subroutine Return Stack
push when call, pop when return
### III. Line Prediction
- for superscalar, useful to predict next cacheline to fetch
- line predictor predicts line to fetch each cycle (tight loop)
- Icache fetches block, and predictors improve target prediction
- PC calc checks accuracy of line predictions