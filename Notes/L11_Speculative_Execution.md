# Lecture 11: Speculative Execution
## Speculative Execution Recipe
1. proceed ahead despite unresolved dependencies using a prediction for an architectural or micro-architectural value
2. maintain both old and new values on updates to architectural (and often micro-architectural) state
3. A. after sure that there was no mis-speculation and there will be no more uses of the old values, discard old values and just use new values
3. B. in event of mis-speculation, dispose of all new values, restore old values, and re-execute from point before mis-speculation
## Value Management Strategies
### I. Greedy (or Eager) Update
- update value in place, and
- provide means to reconstruct old values for recovery
    - often this is a log of old values
### II. Lazy Update
- buffer new value, leaving old value in place
- replace old value only at `commit` stage
## Misprediction Recovery
### I. In-Order execution machines
- guarantee no instruction issued after branch can write-back before branch resolves by keeping values in the pipeline
- kill all values from all instructions in pipeline behind mispredicted branch
### II. Out-of-Order Execution
- multiple instructions following branch in program order can generate new values before branch resolves.
## Data-Driven Execution
### I. steps
1. enter `op` and `tag` or `data` (if known) for each source
2. replace `tag` with `data` as it becomes available
3. issue instruction when all sources are available
4. save dest data when operation finishes
### II. Rollback and Renaming
#### A. Renaming Table
1. update policy
2. what events cause mis-speculation
3. how can we respond to mis-speculation
4. after being cleared, when can instructions be added to ROB
#### B. Recovering ROB/Renaming Table
snapshot of register rename table at each predicted branch, recover earlier snapshot if branch mispredicted
#### C. Branch Predictor Recovery
1. 1-bit counter recovery
2. 2-bit counter recovery
3. global history recovery
4. local history recovery
## Out-Of-Order Execution with ROB
### I. Steps
1. enter `op` and `tag` or `data` (if known) for each source
2. replace `tag` with `data` as it becomes available
3. issue instruction when all sources are available
4. save dest data when operation finishes
5. commit saved dest data when instruction commits
### II. Unified Physical Register File
one regfile for both `committed` and `speculative` values
### III. Lifetime of Physical Registers
1. physical regfile holds `committed` and `speculative` values
2. physical registers decoupled from ROB entries (no data in ROB)
### IV. ROB
ROB holds `Active Instruction Window`
### V. Issue Timing
- schedule may fail due to unexpected latency
- types of latency
    - fixed latency: latency included in queue entry ("bypassed")
    - predicted latency: latency included in queue entry (speculated)
    - variable latency: wait for completion signal (stall)
### VI. Data-in-ROB vs. Unified RegFile
-
### VII. Superscalar Register Renaming
1. during decode, instructions allocated new physical destination register
2. source operands renamed to physical register with newest value
3. execution unit only sees physical register numbers
### VIII. Split Issue and Commit Queues
1. How large should the ROB be? think Little's Law
2. can split ROB into issue and commit queues
    - commit queue: allocate on decode, free on commit
    - issue queue: allocate on decode, free on `dispatch`
    - Pros: smaller issue queue -> simpler dispatch logic
    - Cons: More complex mis-speculation recovery