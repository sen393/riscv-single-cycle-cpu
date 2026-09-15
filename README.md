# RISC-V Single-Cycle CPU

Building a single-cycle RISC-V CPU in Verilog, following Harris & Harris
(Digital Design and Computer Architecture, RISC-V edition, Chapter 7.3). The
current goal for this processor project is to run I-, R-, and B- type instructions,
then port it to a Spartan-7 board as a practice run of the FPGA design workflow.

## Status

**Modules written:**
- [x] Program Counter
- [x] Instruction memory
- [x] Register file
- [x] Immediate extender
- [x] ALU
- [x] Data memory
- [x] mux2 (generic 2:1 mux, used for PCSrc, ALUSrc, ResultSrc)
- [ ] Control unit
- [ ] Full datapath integration

**Verified via testbench:**
- [x] Instruction memory
- [x] Register file
- [ ] ALU, Data memory, Immediate extender, mux2 (pending)


## Structure
- `src/` — hardware modules
- `sim/` — testbenches
- `programs/` — hex-encoded test programs

## Running a testbench
```bash
./run_tests.sh <module>
```
