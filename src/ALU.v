module ALU
(
    input      [3:0]  alu_control,
    input      [31:0] a, b,
    output reg [31:0] result,
    output            zero
);

    always @(*) begin
        case ( alu_control )
            4'b0000:  result = a + b;                                       // add
            4'b1000:  result = a - b;                                       // sub
            4'b0001:  result = a << b[4:0];                                 // sll
            4'b0010:  result = ($signed(a) < $signed(b)) ? 32'd1 : 32'd0;   // slt
            4'b0011:  result = (a < b) ? 32'd1 : 32'd0;                     // sltu
            4'b0100:  result = a ^ b;                                       // xor
            4'b0101:  result = a >>  b[4:0];                                // srl
            4'b1101:  result = $signed(a) >>> b[4:0];                       // sra
            4'b0110:  result = a | b;                                       // or
            4'b0111:  result = a & b;                                       // and
            default: result = 32'd0;
        endcase
    end

    assign zero = ( result == 32'd0 );

endmodule