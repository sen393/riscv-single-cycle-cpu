module ALUDecoder (
    input      [6:0] opcode,
    input      [6:0] funct7,
    input      [2:0] funct3,
    input      [1:0] alu_op,
    output reg [2:0] alu_control
);
    always @(*) begin
        case ( alu_op )
            2'b00: alu_control = 3'b000; // add for lw/sw
            2'b01: alu_control = 3'b001; // sub for beq
            2'b10: begin // R-type instructions
                case ( funct3 )
                    3'b000:  begin
                        if ( ~opcode[5] | ( opcode[5] & ~funct7[5] ) )
                             alu_control = 3'b000; // add
                        else
                             alu_control = 3'b001; // sub
                    end
                    3'b010:  alu_control = 3'b101; // slt
                    3'b110:  alu_control = 3'b011; // or
                    3'b111:  alu_control = 3'b010; // and
                    default: alu_control = 3'b000; // default to add
                endcase
            end
            default:         alu_control = 3'b000; // default to add
        endcase
    end
endmodule