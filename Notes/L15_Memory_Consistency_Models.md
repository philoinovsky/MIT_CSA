# Lecture 15: Memory Consistency Models
## Coherence vs Consistency
- cache coherence makes private caches invisible to software
- memory consistency models precisely specify how memory behaves with respect to read and write operations from multiple processors
## Sequential Consistency
arbitrary order-preserving interleaving of memory references of sequential programs
## Relaxed Consistency (one or more of the following)
- loads may be reordered after loads
- loads may be reordered after stores
- stores may be reordered after loads
- stores may be reordered after stores
- other more esoteric characteristics
## Weaker Memory Models & Memory Fence Instructions
architectures with weaker memory models provide memory fence instructions to prevent otherwise permitted reorderings of loads and stores
## Implementing SC
1. the memory operations of each individual processor appear to all processors in the order the requests are made to the memory
2. any execution is the same as if the operations of all the processors were executed in some sequential order
### I. SC Data Dependence
- stall: use in-order execution and blocking caches
- change architecture => relaxed memory models
- speculate
### II. Sequential Consistency Speculation
- local load-store uses standard OOO mechanism
- globally non-speculative stores
- globally speculative loads
    - guess
    - check
    - data management
## Takeways
1. SC is too low level a programming model. High-level programming should be based on critical sections & locks, atomic transactions, monitors
2. high-level parallel programming should be oblivious of memory model issues
3. ISA definition for Load, Store, Memory Fence, Synchronization instructions should
    - be precise
    - permit max flexibility in hardware implementation
    - permit efficient implementation of high-level parallel constructs
