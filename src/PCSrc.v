`timescale 1ns/1ps

module PCSrc
(
    input        zero,
    input        branch,
    input        jump,
    input        jalr,
    input  [2:0] funct3,
    output [1:0] pc_src
);

    reg branch_taken;

    always @(*) begin
        case (funct3)

            3'b000: branch_taken = zero;   // beq
            3'b001: branch_taken = ~zero;  // bne

            3'b100: branch_taken = ~zero;  // blt
            3'b101: branch_taken = zero;   // bge

            3'b110: branch_taken = ~zero;  // bltu
            3'b111: branch_taken = zero;   // bgeu

            default: branch_taken = 1'b0;

        endcase
    end

    assign pc_src = (jalr) ? 2'b10 : 
                    ((branch & branch_taken) | jump) ? 2'b01 : 2'b00;
    
endmodule