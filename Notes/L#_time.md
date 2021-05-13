# Time Frequently Used
1. cpu cycle ~ 200ps (5GHz) ~ 1 clock
2. L1 Cache ~ 1ns (64KB)  ~ 3-4 clocks | 4-way, 64KB, 64B block, private
3. L2 Cache ~ 3-10ns ~ 21 clocks | 16-way, 1-2MB, 64B block, private
4. L3 Cache ~ 10-20ns ~ 87 clocks | 64-way, 0-8MB, 64B block, shared
5. Memory ~ 50-100ns (CAS Latency, Row to Col time, active row time)
6. Pagetable Walk ~ 200-400ns (probably), usually 4 memory references
