# mesh-noc-router

Multi-core Cardinal NIC System on a Bidirectional 4x4 Mesh NoC

### Packet Layout

| 63 | 62:61 | 60:56    | 55:52       | 51:48       | 47:40    | 39:32    | 31:0 |
| -- | ----- | -------- | ----------- | ----------- | -------- | -------- | ---- |
| VC | Dir   | Reserved | Y-Hop Value | X-Hop Value | Y-Source | X-Source | Data |

Hop values are 1-hot right shifted values. For example, if you want to move 2 routers up. 
Your Y-hop value should be `4'b0010`.
After the first hop it would be `4'b0001`
After the second hop it would be `4'b0000` meaning the packet has reached its destination.

The router also moves in the X direction first and then in the Y direction.


### Direction (bits 62:61):

| 62 | 61 |
| -- | -- |
| NS | EW |

- North to South packet[62] = 0
- South to North packet[62] = 1
- East to West(CCW) packet[61] = 0
- West to East (CW) packet[61] = 1
