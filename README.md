# RISC-V Single-Cycle CPU

Building a single-cycle RISC-V CPU in Verilog, following a design shown in Harris & Harris
(Digital Design and Computer Architecture, RISC-V edition). The current goal for this project is 
to implement most RV32I instructions, then build a calculator program on top of it, with memory-mapped
I/O for buttons/display. This will then be ported to a Spartan-7 board as a practice run of the FPGA 
design workflow. 

## Status

**(As of 2026-09-23)**

**Datapath:**
- [x] PC, PCPlus4, PCBranch
- [x] Instruction memory (IMem)
- [x] Register file (RegFile)
- [x] Immediate extender (ImmExt)
- [x] ALU
- [x] Data memory (DMem)
- [x] Mux2 (generic 2:1 mux)
- [x] Control unit — MainDecoder, ALUDecoder, PCSrc
- [x] TopModule — full datapath wired together

**Total Functions Implemented: 25**

## Current Schematic

Click the image to view the full-resolution schematic.

<a href="images/cpu-schematic.png">
  <img src="images/cpu-schematic.png"
       alt="RISC-V Single-Cycle CPU Schematic"
       width="900">
</a>

## Function To-Do List

**R-type**
- [x] add
- [x] sub
- [x] sll
- [x] slt
- [x] sltu
- [x] xor
- [x] srl, sra
- [x] or
- [x] and

**I-type (arithmetic/logic)**
- [x] addi
- [x] slti
- [x] sltiu
- [x] xori
- [x] ori
- [x] andi
- [x] slli
- [x] srli
- [x] srai

**I-type (load)**
- [x] lw

**S-type**
- [x] sw

**B-type**
- [x] beq
- [ ] bne, blt, bge, bltu, bgeu

**U-type**
- [x] lui
- [x] auipc

**J-type**
- [x] jal
- [ ] jalr

## Structure

- `src/` — hardware modules
- `sim/` — testbenches
- `programs/` — hex-encoded test programs

## Running a testbench

To compile and run the main CPU testbench:

```bash
./run.sh
```

The script:

- Compiles all Verilog modules in `src/`
- Uses `sim/TopModule-tb.v` as the top-level testbench
- Runs the simulation with `vvp`
- Prints the test results to the terminal
- Saves the same output to `sim_output.txt`
- Generates `topmodule_tb.vcd` for waveform inspection

The testbench is self-checking, so expected register values and control-flow behavior are reported automatically as `PASS` or `FAIL`.
