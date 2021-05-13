# Lecture 4: Memory Management: From Absolute Addresses to Demand Paging
## Absolute Addresses
1. early 50's
2. va = pa
3. memory fracmentation
4. base and bound translation
5. seperation of code and data
## Modern Virtual Memory Systems
### Overview
1. protection & privacy: seperate private address space, one or more shared address spaces
2. demand paging: provides the ability to run programs larger than the primary memory (swapping store)
### Page Table
- PPN (Physical Page Number) -> for memory resident page
- DPN (Disk Page Number) -> for disk resident page
- Hierachical Page Table: can hide unused ones
### Address Translation & Protection
1. VPN -> PPN
2. Protection Check
### TLB (Translation Lookaside Buffers)
1. address translation is very expensive, in a 2-level page table, each reference becomes several memory accesses
2. TLB
    - typically 32-128 entries, usually highly associative, sometimes larger TLBs(256-512 entries) are 4-8 way set-associative
    - random or FIFO replacement policy
    - no process informatino in TLB
    - TLB reach: size of largest virtual address space that can be simultaneously mapped by TLB
3. Variable-Sized page support
4. variable-size page TLB
5. handling a TLB miss: software (MIPS, Alpha) -> causes an exception and the operating system walks the page tables and reloads TLB. A privileged "untranslated" addressing mode used for walk (kernel mode); hardware (SPARC v8, x86, PowerPC) -> 1. a memory management unit (MMU) walks the page tables and reloads the TLB. 2. if a missing (data or PT) page is encountered during the TLB reloading, MMU gives up and signals a Page-Fault exception for the original instruction.
### Putting all Together
```
Virtual address
TLB Lookup
    -> (miss) Page Table Walk
        -> (the page is in memory) Update TLB
        -> (not in memory) Page Fault
    -> (hit) Protection Check
        -> (denied) Protection Fault
        -> (permitted) Physical Address (to cache)
```