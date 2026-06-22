<div align="center">

<img src="https://readme-typing-svg.demolab.com?font=Orbitron&weight=700&size=30&duration=3000&pause=1000&color=00E5FF&center=true&vCenter=true&width=1000&lines=RISC-Style+Memory+Management+Unit;Virtual+to+Physical+Address+Translation;TLB+%7C+PTW+%7C+ASID+%7C+LRU;Verilog+HDL+%7C+Artix-7+FPGA"/>

<br>

<img src="https://capsule-render.vercel.app/api?type=waving&height=230&color=0:020617,30:0F172A,60:0EA5E9,100:22D3EE&text=RISC-STYLE%20MMU&fontColor=FFFFFF&fontSize=48&animation=fadeIn"/>

<p>

<img src="https://img.shields.io/badge/FPGA-Artix--7-00E5FF?style=for-the-badge"/>

<img src="https://img.shields.io/badge/Vivado-2025.2-FF6D00?style=for-the-badge"/>

<img src="https://img.shields.io/badge/Verilog-HDL-00FF88?style=for-the-badge"/>

<img src="https://img.shields.io/badge/MMU-Virtual%20Memory-FFC857?style=for-the-badge"/>

<img src="https://img.shields.io/badge/RISC-Architecture-8B5CF6?style=for-the-badge"/>

</p>

<img src="images/rtl_schematic.png" width="900"/>

</div>

---

# 🚀 Overview

This project implements a **RISC-Style Memory Management Unit (MMU)** in **Verilog HDL**, demonstrating how modern processors translate virtual addresses into physical addresses while enforcing memory protection and access permissions.

The design includes:

✅ Translation Lookaside Buffer (TLB)

✅ Address Space Identifiers (ASIDs)

✅ Page Table Walker (PTW)

✅ Permission Checking (R/W/X)

✅ User/Supervisor Protection

✅ TLB Refill Logic

✅ LRU-Based Replacement

✅ Fault Detection & Handling

The complete design was verified through behavioral simulation and synthesized on an **AMD Artix-7 FPGA** using **Vivado 2025.2**.

---

# 🔥 Why This Project?

Modern CPUs do not directly access physical memory.

Instead:

```text
Virtual Address
       ↓
MMU
       ↓
Physical Address
```

The MMU is responsible for:

* Fast address translation
* Memory protection
* Process isolation
* Permission enforcement
* TLB management

These concepts form the foundation of modern operating systems and processor architectures.

---

# ✨ Features

| Feature                        | Status |
| ------------------------------ | ------ |
| 32-bit Virtual Addressing      | ✅      |
| 4 KB Page Size                 | ✅      |
| Virtual → Physical Translation | ✅      |
| TLB Lookup                     | ✅      |
| TLB Refill                     | ✅      |
| PTW FSM                        | ✅      |
| ASID Support                   | ✅      |
| Read Permission                | ✅      |
| Write Permission               | ✅      |
| Execute Permission             | ✅      |
| User/Supervisor Protection     | ✅      |
| Page Fault Handling            | ✅      |
| Access Fault Handling          | ✅      |
| Vivado Synthesis               | ✅      |

---

# 🏗️ MMU Architecture

```text
                    CPU Request
                         │
                         ▼
                ┌────────────────┐
                │      TLB       │
                └───────┬────────┘
                        │
               Hit      │      Miss
                        ▼
                ┌────────────────┐
                │      PTW       │
                └───────┬────────┘
                        ▼
                ┌────────────────┐
                │  PTE Memory    │
                └───────┬────────┘
                        ▼
                ┌────────────────┐
                │      LRU       │
                └───────┬────────┘
                        ▼
                ┌────────────────┐
                │ Permission Ctl │
                └───────┬────────┘
                        ▼
                Physical Address
```

---

# 📂 Project Structure

```text
MMU-Design-Verilog-HDL/

├── rtl/
│   ├── mmu_top.v
│   ├── tlb.v
│   ├── lru.v
│   ├── ptw.v
│   ├── pte_memory.v
│   └── permission_checker.v
│
├── tb/
│   └── mmu_tb.v
│
├── constraints/
│   └── mmu_top.xdc
│
├── scripts/
│   └── yosys_synth.ys
│
├── simulation/
│   ├── waveform.png
│   └── simulation_notes.md
│
├── reports/
│   └── mmu_top_utilization_synth.txt
│
├── images/
│   └── rtl_schematic.png
│
├── docs/
│   ├── architecture.md
│   ├── verification_plan.md
│   └── synthesis_summary.md
│
├── README.md
└── .gitignore
```

---

# 🧪 Verification

The MMU was verified using a dedicated Verilog testbench covering:

* TLB Lookup
* Translation Requests
* TLB Misses
* PTW Operation
* Access Permissions
* Page Fault Generation
* Access Fault Generation

### Behavioral Simulation

<img src="waveforms/waveform.png" width="900"/>

---

# ⚙️ FPGA Synthesis Results

**Target Device:** Artix-7 (xc7a35tcpg236-1)

<div align="center">

<img src="https://img.shields.io/badge/LUTs-142-00E5FF?style=for-the-badge"/>

<img src="https://img.shields.io/badge/Registers-266-00FF88?style=for-the-badge"/>

<img src="https://img.shields.io/badge/DSP-0-94A3B8?style=for-the-badge"/>

<img src="https://img.shields.io/badge/BRAM-0-94A3B8?style=for-the-badge"/>

</div>

| Resource  | Used | Available |
| --------- | ---- | --------- |
| LUTs      | 142  | 20,800    |
| Registers | 266  | 41,600    |
| DSPs      | 0    | 90        |
| BRAM      | 0    | 50        |

The design utilizes less than **1% of available FPGA resources**, making it lightweight and scalable.

---

# 🎓 Concepts Demonstrated

* Verilog HDL
* FPGA Design Flow
* Virtual Memory Systems
* Translation Lookaside Buffer (TLB)
* Page Table Walker (PTW)
* Address Space Identifiers (ASID)
* Memory Protection
* Permission Management
* RTL Design
* Functional Verification
* FPGA Synthesis

---

# 🚀 Getting Started

```bash
git clone https://github.com/shravanisahare14-web/MMU-Design-Verilog-HDL.git
```

### Vivado Flow

1. Create Project
2. Add RTL Files
3. Set `mmu_top` as Top Module
4. Run Behavioral Simulation
5. Open RTL Schematic
6. Run Synthesis
7. Generate Reports

---

# 🔮 Future Improvements

* Fully Associative TLB
* AXI-Lite Memory Interface
* Multi-Level Page Tables
* RISC-V Core Integration
* Advanced LRU Policies
* Timing Analysis using OpenSTA

---

<div align="center">

### 💙 Built for FPGA • VLSI • Computer Architecture Engineering

</div>
