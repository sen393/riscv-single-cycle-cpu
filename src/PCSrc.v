module PCSrc (
    input   zero,
    input   branch,
    output  pc_src
);
    assign pc_src = branch & zero;
endmodule