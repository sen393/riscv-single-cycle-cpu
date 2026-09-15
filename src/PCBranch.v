module PCBranch (
    input  [31:0] pc,
    input  [31:0] imm_ext,
    output [31:0] pc_target
);
    // Add the imm ext to pc for b-type instr
    assign pc_target = pc + imm_ext;

endmodule