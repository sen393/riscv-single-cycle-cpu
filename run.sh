#!/bin/bash

set -e

echo "Compiling processor..."

iverilog \
    -Wall \
    -s TopModule_tb \
    -o sim_out \
    src/*.v \
    sim/TopModule-tb.v

echo
echo "Running testbench..."

vvp sim_out | tee sim_output.txt

echo
echo "Simulation complete."
echo "Waveform: topmodule_tb.vcd"