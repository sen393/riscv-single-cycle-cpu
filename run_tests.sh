#!/bin/bash
# run_tests.sh - compile and run a testbench by name
# Usage: ./run_tests.sh imem | regfile

case "$1" in
  imem)
    iverilog -o sim_out src/imem.v src/pc.v sim/imem_tb.v && vvp sim_out
    ;;
  regfile)
    iverilog -o sim_out src/regfile.v sim/regfile_tb.v && vvp sim_out
    ;;
  *)
    echo "Unknown module: $1"
    echo "Usage: ./run_tests.sh {imem|regfile}"
    ;;
esac
