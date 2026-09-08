# RISC-V Single-Cycle CPU

Building a single-cycle RISC-V CPU in Verilog, following Harris & Harris
(Digital Design and Computer Architecture, RISC-V edition, Chapter 7.3) 

## Status
- [x] Program Counter
- [x] Instruction memory
- [x] Register file
- [ ] ALU
- [ ] Control unit
- [ ] Full datapath integration

## Structure
- `src/` — hardware modules
- `sim/` — testbenches
- `programs/` — hex-encoded test programs

## Running a testbench
```bash
./run_tests.sh <module>
```
