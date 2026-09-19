module PCPlus4
(
    input  [31:0] pc_in,
    output [31:0] pc_out
);

    assign pc_out = pc_in + 32'd4;

endmodule