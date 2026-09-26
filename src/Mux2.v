`timescale 1ns/1ps

module Mux2
(
    input         sel,
    input  [31:0] a,
    input  [31:0] b,
    output [31:0] out
);
    // Note: This mux is used for PCSrc, ALUSrc, ResultSrc
    assign out = ( sel ) ? b : a;
endmodule