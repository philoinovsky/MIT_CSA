# Lecture 13: Cache Coherence
## Communication Models
1. shared memory:
    - single address space
    - implicit communication by reading/writing memory
        - data
        - control (semaphores, locks, barriers)
2. message passing
    - separate address spaces
    - explicit communication by send/rcv messages
        - data
        - control (blocking msgs, barriers, ...)
    - low level programming model: processes + inter-process communication
## Coherence & Consistency
- Coherence: what values can a read return?
- Consistency: When do writes become visible to reads?
### I. Implementing Cache Coherence
1. Coherence protocols must enforce two rules
    - write propagation: eventually visible
    - write serialization: writes to the same location is serialized (all processors see them in same order)
2. how to ensure write propagation?
    - write-invalidate protocols: invalidate all other cached copies before performing the write
    - write-update protocols:  update all other cached copies after performing the write
3. how to track sharing state of cached data and serialize requests to the same address?
    - snooping-based protocols: all caches observe each other's actinos through a shared bus (bus is the serialization point)
    - directory-based protocols: a coherence directory tracks contents of private caches and serializes requests (directory is the serialization point)
### II. Modified/Shared/Invalid (MSI) Protocol
1. allows writeback caches + satisfying writes locally
### III. Cache Interventions
1. MSI allows caches to serve writes without updating memory, so main memory can have stale data
    - core 0's cache needs to supply data
    - but main memory may also respond
2. Cache must override response from main memory
### IV. MSI Optimizations
#### A. Exclusive State
1. observation: Doing read-modify-write sequences on private data is common
    - what's the problem with MSI
2. Solution: E state (exclusive, clean)
    - if no other sharers, a read acquires line in E instead of S
    - writes silently cause E -> M (exclusive, dirty)
#### B. Owner State
1. observation: On M->S transitions, must write back line!
    - what happens with frequent read-write sharing
    - can we defer the write after S
2. Solution: O state (Owner)
    - O = S + responsibility to write back
    - on M -> S transition, one sharer (typically the one who had the line in M) retains the line in O instead of S
    - on eviction, O writes back line (or another sharer does S->O)
3. MSI, MESI, MOSI, MOESI
    - typically E if private read-write >> shared read-only (common)
    - typically O only if writebacks are expensive (main mem vs L3)

