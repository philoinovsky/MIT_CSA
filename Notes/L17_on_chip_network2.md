# Lecture 17: On-Chip Network II: Router Microarchitecture & Routing
## Interconnection Network Architecture
- topology
- routing
- flow control
- router microarchitecture
- link microarchitecture
## Router Microarchitecture
### I. Ring-based interconnect
- ring stop
- priorities
### II. Ring Flow Control: Bounces
- what if traffic on the ring cannot get delivered (e.g. output FIFO is full)
- one alternative: continue on ring (bounce)
- what are the consequences of such bounces
### III. What's in a Router? it's a system as well
- logic - state machines, arbiters, allocators
    - control data movement through router
    - idle, routing, wairing for resources, active
- memory - buffers
    - store flits before forwarding them
    - SRAMs, registers, processor memory
- communication - switches
    - transfer flits from input to output ports
    - crossbars, multiple crossbars, fully-connected, bus
### IV. Allocators in Routers
- VC allocator
    - input VCs requesting for a range of output VCs
- Switch Allocator
- "Greedy" Algorithms used for efficiency
- what happens if allocation fails on a given cycle?
### V. Pipeline Optimizations
#### A. Lookahead Routing
- at current router, perform route computation for next router
    - head flit already carries output port for next router
    - RC just has to read output -> fast, can be overlapped with BW
    - Precomputing route allows flits to compete for VCs immediately after BW
    - Routing computation for the next hop (NRC) can be computed in parallel with VA
- or simplify RC
#### B. Speculative Switch Allocation
- assume that Virtual Channel Allocation stage will be successful
    - valid under low to moderate loads
- if both successful, VA and SA are done in parallel
- if VA unsuccessful (no virtual channel returned)
    - must repeat VA/SA next cycle
- Prioritize non-speculative requests
## Routing
### I. Dimension-Order Routing
xy, yx order -> prevent deadlock
#### A. turns allowed
- see picture in pdf
#### B. allowing more turns
- six turn model
#### C. turn model
- a systematic way of generating deadlock-free routes with small number of `prohibited turns`
- deadlock=free if routes conform to at least ONE of the turn models (acyclic channel dependence graph)
### II. 2-D Mesh and CDG
can create a channel dependency graph (CDG) of the network
- acyclic CDG -> deadlock-free
- west-first -> deadlock-free
- resource conflicts -> deadlocks
### III. Virtual Channels
can be used to avoid deadlock by restricting VC allocation
### IV. Randomized Routing: Valiant
route each packet through a randomly chosen intermediate node
#### A. ROMM: Randomized, Oblivious Multi-phase Minimal Routing
