# Lecture 3: Cache Organization
## CPU-Memory Bottleneck
- latency: memory access time >> processor cycle time
- bandwidth: if fraction `m` of instructions access memory
    - `1 + m` memory references/instruction
    - `CPI = 1` requires `1 + m` memory refs/cycle
## Little's Law
```
Throughput (T) = Number in Flight (N) / Latency (L)
```
## Common Predictable Patterns
- Temporal Locality: same reference again in the future
- Spatial Locality: locations near it will more likely to referenced in the future
## Cache Models
### I. Direct-Mapped Cache (1-way Set-Associative Cache)
1. one address only map one cacheline
2. `thrashing`: if two memory addresses use same cacheline and are frequently references, they will be continually swapped in and out
### II. Fully Associative Cache(Fully Associative Cache)
1. can place anywhere
2. high `hit time` (need to check all cachelines to determine if address is in cache)
### III. in the middle - 2-way, 4-way, .etc
## Performance
### I. measurement
1. `hit time` -> time to hit in the cache
2. `miss rate`
3. `miss penalty` -> time to replace the block from memory
```
Average Memory Access time = Hit time + Miss rate * Miss Penalty
```
### II. Causes for Cache Misses
1. `compulsory`: cold start
2. `capacity`: cache is too samll to hold all data the program needs
3. `conflict`: misses from collisions due to block-placement stratege
### III. Basic Cache Optimizations
1. Larger Block size: `miss rate` down, `compulsory miss` down, `miss penalty` up.
2. Bigger Caches: `miss rate` down, `hit time` up.
3. Higher Associativity: `conflict miss` down.
4. Multilevel Caches: `miss penalty` down
5. Giving Priority to `read misses` over `writes`: originally: cache miss -> write dirty block to memory -> read new block from memory; now: cache miss -> copy dirty block to buffer -> read memory -> write memory. Processor doesn't have to wait so long. `miss penalty` down.
6. Avoiding Address Translation: use the page offset - the part that is identical in both virtual and physical addresses - to index the cache. advantages: `hit time` down, removing the TLB access. disadvantages: introduces some system complications and/or limitations on the size and structure of the L1 cache.
### IV. Block-level Optimizations
1. tags are too large, too much overhead -> solution: larger blocks
2. sub-block placement
    - a valid bit added to units smaller than the full block, called sub-blocks
    - only read a sub-block on a miss
    - if a tag matches, is the sub-block in the cache
## MISC
### I. Replacement Policy
1. Random
2. LRU
3. FIFO
4. NLRU (Not LRU): FIFO with exception for most recently used block or blocks
5. One-bit LRU: Each way represented by a bit. Set on use, replace first unused.
### II. Inclusion Policy
1. Inclusive Multilevel Cache
- inner cache holds copies of data in outer cache
- miss -> line inserted in inner and outer cache; replacement in outer cache invalidates line in inner cache
- external accesses need only check outer cache
- Commonly Used (Intel CPUs up to Broadwell)
2. Non-inclusive Multilevel Cache
- may hold different data
- replacement in outer cache doesn't invalidate line in inner cache
- used in Intel Skylake, ARM
3. Exclusive Multilevel Caches
- inner and outer hold different data
- swap lines on a miss
- AMD
### III. Victim Caches
1. a small associative back up cache, added to a direct mapped cache, which holds recently evicted lines
2. lookup in directed mapped cache:
    - miss -> look in victim cache
        - hit -> swap hit line with line now evicted from L1
        - miss -> L1 victim goes to VC, VC victim goes to <?>
3. fast hit time of direct mapped but with reduced conflict misses.