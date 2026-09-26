`timescale 1ns/1ps

module Mux3
(
    input  [1:0]  sel,
    input  [31:0] a,
    input  [31:0] b,
    input  [31:0] c,
    output [31:0] out
);

    assign out = (sel == 2'b10) ? c :
                 (sel == 2'b01) ? b :
                 (sel == 2'b00) ? a : 1'bx;

endmodule