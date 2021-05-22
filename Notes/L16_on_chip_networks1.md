# Lecture 16: On-Chip Networks I: Topology/Flow Control
## Topology
- routing distance - number of links on route
- diameter - maximum routing distance
- average distance
- a network is `partitioned` by a set of links if their removal disconnects the graph
- `bisection bandwidth` is the bandwidth crossing a minimal cut that divides the network in half
## Routing & Flow Control
### I. Routing vs Flow Control
- routing algorithm chooses path that packets should foolow to get from source to destination
- flow control schemes allocate resources (buffers, links, control state) to packets traversing the network
- out approach: Bottom-Up
### II. Properties of Routing Algorithms
- deterministic/oblivious
- adaptive
    - route influenced by traffic along the way
- minimal
    - only selects shortest paths
- deadlock-free
    - no traffic pattern can lead to a situation where no packets move forward
## Flow Control
- messages
- packet: basic unit of routing and sequencing (limited size (e.g. 64 bits - 64 KB))
- flit (flow control digit): basic unit of bandwidth/storage allocation
- phit (physical transfer digit): data transferred in single clock
### I. Protocols
#### A. Bufferless
- circuit switching
- dropping
- misrouting
#### B. Buffered
- store-and-forward
- virtual cut-through
- wormhole
- virtual-channel
### II. Circuit Switching
- form a circuit from source to dest
- probe to set up path through network
- reserve all links
- data sent through links
- bufferless
- process: request -> ack -> transmission -> tail
- disadvantage: too much overhead if packet is small
### III. Dropping - Speculative Flow Control
- if two things arrive and I dont have resources, drop one of them
- flow control protocol on the internet
- process -> header, body, tail -> failed -> retransmission
- disadvantage: drop the whole packet!!!
### IV. misrouting - less simple flow control
- ensure one message enter and one message exit each node at a time.
- intentionally route away from congestion
- no need for buffering
### V. store-and-forward (packet-based, no flits)
- strategy: make immediate stops and wait until the entire packet has arrived before you move on
- advantage: other packets can use intermediate links
- disadvantage: too slow, cannot utilize full transfer capability
### VI. virtual cut-through
- improved version of store-and-forward
- dont need to wait for entire message arrive, head flit arrive is enough
- then head gets blocked, whole packet gets blocked at one intermediate node
### VII. Wormhole - flit-buffer flow control
- improved version of virtual cut-through, but allow break
- when a packet blocks, just block wherever the pieces (flits) of the message are at that time
- operates like cut-through but with channel and buffers allocated to flits rather than packets
    - channel state (virtual channel) allocated to `packet` so body flits can follow head flit
### VIII. Virtual-Channel (VC) Flow Control
- when a message blocks, instead of holding on links so others can't use them, hold on to virtual links
- multiple queues in buffer storage
    - like lanes on the highway
- virtual channel can be though of as channel state and flit buffers
