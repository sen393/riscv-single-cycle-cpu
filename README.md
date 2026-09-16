# RISC-V Single-Cycle CPU

Building a single-cycle RISC-V CPU in Verilog, following a design shown in Harris & Harris
(Digital Design and Computer Architecture, RISC-V edition). The current goal for this project is 
to implement most RV32I instructions, then build a calculator program on top of it, with memory-mapped
I/O for buttons/display. This will then be ported to a Spartan-7 board as a practice run of the FPGA 
design workflow. 

## Status

**Datapath: fully wired and verified working (As of 2025-09-15)**
- [x] PC, PCPlus4, PCBranch
- [x] Instruction memory (IMem)
- [x] Register file (RegFile)
- [x] Immediate extender (ImmExt)
- [x] ALU
- [x] Data memory (DMem)
- [x] Mux2 (generic 2:1 mux)
- [x] Control unit — MainDecoder, ALUDecoder, PCSrc
- [x] TopModule — full datapath wired together

**Verified via testbench:**
- [x] Instruction memory, Register file
- [x] Full datapath (via TopModule_tb, not per-module for alu/dmem/imm_ext/mux2)

## Function To-Do List

**R-type**
- [x] or
- [ ] add
- [ ] sub
- [ ] and
- [ ] slt
- [ ] sll, srl, sra
- [ ] xor

**I-type (arithmetic/logic)**
- [x] addi
- [ ] andi
- [ ] ori
- [ ] slti
- [ ] xori

**I-type (load)**
- [x] lw

**S-type**
- [x] sw

**B-type**
- [x] beq
- [ ] bne, blt, bge, bltu, bgeu

**U-type**
- [ ] lui
- [ ] auipc

**J-type**
- [ ] jal
- [ ] jalr

## Structure
- `src/` — hardware modules
- `sim/` — testbenches
- `programs/` — hex-encoded test programs

## Running a testbench
```bash
./run_tests.sh <module>
```
(Only working for 'imem' and 'regfile' currently)