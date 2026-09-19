module ALUDecoder
(
    input      [6:0] opcode,
    input      [6:0] funct7,
    input      [2:0] funct3,
    input      [1:0] alu_op,
    output reg [3:0] alu_control
);
    // MSB bit selecter for alternate operations
    // sub/add, sra/srl
    wire alt_bit = (funct3 == 3'b000 || funct3 == 3'b101)
                        ? (opcode[5] & funct7[5])
                        : 1'b0;

    always @(*) begin
        case (alu_op)
            2'b00:      alu_control = 4'b0000; // add for lw/sw
            2'b01:      alu_control = 4'b1000; // sub for beq
            2'b10:      alu_control = { alt_bit, funct3 }; // R/I-type instructions
            default:    alu_control = 4'b0000; // default to add
        endcase
    end
endmodule