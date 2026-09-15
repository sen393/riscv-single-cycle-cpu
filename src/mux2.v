module mux2(
    input [31:0] a,
    input [31:0] b,
    input sel,
    output [31:0] out
);
    // Note: This mux is used for PCSrc, ALUSrc, ResultSrc
    assign out = (sel) ? b : a;
endmodule