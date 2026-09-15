module immext.v (
    input [31:0] instr,
    input [1:0] imm_src,
    output reg [31:0] imm_ext
);

    always @(*) begin
        case (imm_src)
            2'b00: imm_ext = {{20{instr[31]}}, instr[31:20]};                                   // I-type
            2'b01: imm_ext = {{20{instr[31]}}, instr[31:25], instr[11:7]};                      // S-type
            2'b10: imm_ext = {{20{instr[31]}}, instr[7],     instr[30:25], instr[11:8], 1'b0};  // B-type
            default: imm_ext = 32'd0;
        endcase
    end

endmodule