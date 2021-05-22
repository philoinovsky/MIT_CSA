# Lecture 14: Directory Based Cache Coherence
## Maintaining Cache Coherence
1. write request: the address is `invalidated` in all other caches before the write is performed
2. read request: if a dirty copy is found in some cache, a write-back is performed before the memory is read
### I. Directory-Based Coherence
#### A. Snoopy Protocols
1. snoopy schemes broadcast requests over memory bus
2. difficult to scale to large numbers of processors
3. requires additional bandwidth to cache tags for snoop requests
#### B. Directory Protocols
1. directory schemes send messages to only those caches that might have the line
2. can scale to large numbers of processors
3. requires extra directory storage to track possible sharers
# Not finished