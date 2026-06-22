# MMU Architecture

CPU Request
    ↓
TLB Lookup
    ↓
Hit ? → Physical Address
    ↓ No
Page Table Walker
    ↓
Page Table Memory
    ↓
LRU Victim Selection
    ↓
TLB Refill
    ↓
Physical Address

Additional Features:

- ASID Support
- R/W/X Permissions
- User/Supervisor Protection
- Page Fault Handling