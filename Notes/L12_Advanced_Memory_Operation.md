# Lecture 12: Advanced Memory Operation
## Reducing Write Hit Time
- Problem: writes take 2 cycles in memory stage, 1 cycle for tag check plus 1 cycle for data write if hit
- view: treat as data dependence on micro-architectural value "hit/miss"
- Solutions
    - wait -> delivering data asap
    - speculate predicting hit with greedy data update -> design data RAM that can perform read and write in one cycle, restore old value after tag miss (abort)
    - speculate predicting miss with lazy data update -> hold write data for store in single buffer ahead of cache; write cache data during next idle data access cycle (commit)
## Write Policy Choices
- cache hit
    - write through: write both cache & memory
    - write back: write cache only
- cache miss
    - no-write-allocate: only write to main memory
    - write-allocate: fetch into cache
- common combinations
    - write-through and no-write-allocate
    - write-back with write-allocate
## Reducing Read Miss Penalty
### I. Speculative Loads/Stores
- Problem: just like register updates, stores should not permanently change the architectural memory state until after the instruction is committed
- Choice: Data update policy: greedy or lazy -> lazy
- Choice: Handling of store-to-load data hazards: stall, bypass, speculate -> bypass
### II. Store Buffer Responsibilities
1. lazy store: buffer new data values for stores
2. commit/abort: data from the oldest instructions must be `committed` or `forgotten`
3. bypass: data from older instructions must be provided to younger instructions before older instruction is committed
### III. Store Buffer - Lazy Data Management
- on store execute
    - mark valid and speculative; save tag, data, and instruction number
- on store commit
    - clear speculative bit and eventually move data to cache
- on store abort
    - clear valid bit
## Memory Dependencies
### I. Conservative OoO Load Execution
1. split execution of store instruction into 2 phases
    - address calculation and data write
2. can execute load before store, if addresses known and r4 != r2
3. dont execute load if any previous store address not known
### II. Speculative Load Buffer
- on store execute
    - mark valid, and instruction number and tag of data
- on load commit
    - clear valid bit
- on load abort
    - clear valid bit
### III. Store Sets
1. a load must wait for any stores in its `store sets` that have not yet executed
2. the processor approximates each load's `store set` by initially allowing naive speculation and recording memory-order violations
### IV. Prefetching
1. execution of a load "depends" on the data it needs being in the cache...
2. speculate on future instruction and data accesses and fetch them into caches
3. varieties of prefetching
    - hardware prefetching
    - software prefetching
    - mixed schemes
4. how does prefetching affect cache misses?
