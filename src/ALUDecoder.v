module ALUDecoder
(
    input      [6:0] opcode,
    input      [6:0] funct7,
    input      [2:0] funct3,
    input      [1:0] alu_op,
    output reg [3:0] alu_control
);

    reg alt_bit;

    always @(*) begin
        case (funct3)
            3'b000:     alt_bit = (funct7[5] & opcode[5]);
            3'b101:     alt_bit = (funct7[5]);
            default:    alt_bit = 1'b0;
        endcase
    end

    always @(*) begin
        case (alu_op)
            2'b00:      alu_control = 4'b0000; // add for lw/sw
            2'b01:      alu_control = 4'b1000; // sub for beq
            2'b10:      alu_control = { alt_bit, funct3 }; // R/I-type instructions
            default:    alu_control = 4'b0000; // default to add
        endcase
    end
endmodule