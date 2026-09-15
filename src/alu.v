module alu (
    input [2:0] alu_control,
    input [31:0] a, b,
    output reg [31:0] result,
    output zero
);

    always @(*) begin
        case (alu_control)
            3'b000: result = a + b;        // add
            3'b001: result = a - b;        // sub
            3'b010: result = a & b;        // and
            3'b011: result = a | b;        // or
            default: result = 32'd0;
        endcase
    end

    assign zero = (result == 32'd0);

endmodule