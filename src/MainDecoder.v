module MainDecoder (
    input      [6:0] opcode,
    output reg       branch,
    output reg       mem_write,
    output reg       reg_write,
    output reg       result_src,
    output reg       alu_src,
    output reg [1:0] imm_src,
    output reg [1:0] alu_op
);

    always @(*) begin
        case (opcode)
            7'b0110011: begin // R-type
                branch      = 0;
                mem_write   = 0;
                reg_write   = 1;
                result_src  = 0;
                alu_src     = 0;
                imm_src     = 2'b00; // Not used
                alu_op      = 2'b10; // ALU control determined by funct3 and funct7
            end
            7'b0000011: begin // I-type (Load)
                branch      = 0;
                mem_write   = 0;
                reg_write   = 1;
                result_src  = 1; // Load data from memory
                alu_src     = 1; // Immediate value used as ALU operand
                imm_src     = 2'b00; // I-type immediate
                alu_op      = 2'b00; // ALU performs addition for address calculation
            end
            7'b0100011: begin // S-type (Store)
                branch      = 0;
                mem_write   = 1; // Enable memory write
                reg_write   = 0;
                result_src  = 0; // Not used
                alu_src     = 1; // Immediate value used as ALU operand
                imm_src     = 2'b01; // S-type immediate
                alu_op      = 2'b00; // ALU performs addition for address calculation
            end
            7'b1100011: begin // B-type (Branch)
                branch      = 1; // Enable branching
                mem_write   = 0;
                reg_write   = 0;
                result_src  = 0; // Not used
                alu_src     = 0; // Register value used as ALU operand
                imm_src     = 2'b10; // B-type immediate
                alu_op      = 2'b01; // ALU performs subtraction for comparison
            end
            default: begin
                branch      = 0;
                mem_write   = 0;
                reg_write   = 0;
                result_src  = 0;
                alu_src     = 0;
                imm_src     = 2'b00; 
                alu_op      = 2'b00; 
            end
        endcase
    end

endmodule