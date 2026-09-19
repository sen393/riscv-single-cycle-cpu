module PCSrc
(
    input   zero,
    input   branch,
    input   jump,
    output  pc_src
);

    assign pc_src = (branch & zero) | jump;
endmodule