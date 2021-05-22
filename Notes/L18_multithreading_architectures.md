# Lecture 18: Multithreading Architectures
## Multithreading Design Choices
1. fine-grained multithreading
    - context switch among threads every cycle
2. coarse-grained multithreading
    - context switch among threads every few cycles, s.g., on:
        - function unit data hazard
        - L1 miss
        - L2 miss
3. choice depends on
    - context-switch overhead
    - number of threads supported (due to per-thread state)
    - expected application-level parallelism
## Ideal Superscalar Multithreading
interleave multiple threads to multiple issue slots with no restrictions
### I. OoO simultaneous multithreading
1. add multiple contexts and fetch engines and allow instructions fetched from different threads to issue simultaneously
2. utilize wide OoO superscalar processor issue queue to find instructions to issue from multiple threads
3. OoO instruction window already has most of the circuitry required to schedule from multiple threads
4. any single thread can utilize whole machine
### II. Icount CHoosing Policy
fetch from thread with the least instructions in flight
### III. SMT Fetch Policies (Locks)
- problem: spin looping thread consumes resources
- solution: provide quiescing operation that allows a thread to sleep until a memory location changes
### IV. Adaptation to Parallelism Type
1. for regions with high thread level parallelism (TLP) entire machine width is shared by all threads
2. for regions with low thread level parallelism (TLP) entire machine width is available for instruction level parallelism (ILP)
