# Lecture 7: Instruction Pipelining: Hazard Resolution, Timing Constraints
## Hazards
### I. structural hazard - need resource being used by another inst
### II. data hazard - depend on value produced by an earlier inst
cases: `read after write (RAW)`, `write after read (WAR)`, `write after write (WAW)`
#### A. stall
#### B. bypass
split weE into two components: we-bypass, we-stall
```
ASrc = (rsD == wsE) * we-bypassE * re1D
stall = 
(
    (rsD == wsE) * we-stallE + 
    (rsD == wsM) * wsM +
    (rsD == wsW) * weW
) * re1D + 
(
    (rtD == wsE) * weE + 
    (rtD == wsM) * wsM +
    (rtD == wsW) * weW
) * re2D
```
#### C. Speculate
- guess correctly -> no special action required
- guessed incorrectly -> kill and restart
##### schema
1. freeze / flush the pipeline
2. treat every branch as untaken
3. treat every branch as taken
4. delayed branch -> compiler make next instruction valid and useful
## Why an Instruction may not be dispatched every cycle (CPI > 1)?
1. full bypassing may be too expensive to implement
2. loads have two-cycle latency
3. conditional branches, jumps and exceptions may cause bubbles