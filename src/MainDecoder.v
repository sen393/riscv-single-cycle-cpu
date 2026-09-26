module MainDecoder
(
    input      [6:0] opcode,
    output reg       jump,
    output reg       branch,
    output reg       mem_write,
    output reg       reg_write,
    output reg       alu_b_src,
    output reg [1:0] alu_a_src,
    output reg [1:0] result_src,
    output reg [2:0] imm_src,
    output reg [1:0] alu_op
);

    always @(*) begin
        case (opcode)
            7'b0110011: begin // R-type
                jump        = 1'b0;
                branch      = 1'b0;
                mem_write   = 1'b0;
                reg_write   = 1'b1;
                result_src  = 2'b00;
                alu_a_src   = 2'b10;
                alu_b_src   = 1'b0;
                imm_src     = 3'b000; // Not used
                alu_op      = 2'b10; // ALU control determined by funct3 and funct7
            end
            7'b0000011: begin // I-type (load)
                jump        = 1'b0;
                branch      = 1'b0;
                mem_write   = 1'b0;
                reg_write   = 1'b1;
                result_src  = 2'b01; // Load data from memory
                alu_a_src   = 2'b10;
                alu_b_src   = 1'b1;  // Immediate value used as ALU operand
                imm_src     = 3'b000; // I-type immediate
                alu_op      = 2'b00; // ALU performs addition for address calculation
            end
            7'b0100011: begin // S-type (store)
                jump        = 1'b0;
                branch      = 1'b0;
                mem_write   = 1'b1;  // Enable memory write
                reg_write   = 1'b0;
                result_src  = 2'b00; // Not used
                alu_a_src   = 2'b10;
                alu_b_src   = 1'b1;  // Immediate value used as ALU operand
                imm_src     = 3'b001; // S-type immediate
                alu_op      = 2'b00; // ALU performs addition for address calculation
            end
            7'b1100011: begin // B-type (branch)
                jump        = 1'b0;
                branch      = 1'b1;  // Enable branching
                mem_write   = 1'b0;
                reg_write   = 1'b0;
                result_src  = 2'b00; // Not used
                alu_a_src   = 2'b10;
                alu_b_src   = 1'b0;  // Register value used as ALU operand
                imm_src     = 3'b010; // B-type immediate
                alu_op      = 2'b01; // ALU performs subtraction for comparison
            end
            7'b0010011: begin // I-type (addi)
                jump        = 1'b0;
                branch      = 1'b0;
                mem_write   = 1'b0;
                reg_write   = 1'b1;
                result_src  = 2'b00;
                alu_a_src   = 2'b10;
                alu_b_src   = 1'b1;  // Immediate value used as ALU operand
                imm_src     = 3'b000; // I-type immediate
                alu_op      = 2'b10; // ALU performs addition
            end
            7'b1101111: begin // J-type (jal)
                jump        = 1'b1;
                branch      = 1'b0;
                mem_write   = 1'b0;
                reg_write   = 1'b1;
                result_src  = 2'b10;
                alu_a_src   = 2'b10;
                alu_b_src   = 1'b0;
                imm_src     = 3'b011;
                alu_op      = 2'b00;    // ALU performs addition
            end
            7'b0110111: begin // U-type (lui)
                jump        = 1'b0;
                branch      = 1'b0;
                mem_write   = 1'b0;
                reg_write   = 1'b1;
                result_src  = 2'b00;
                alu_a_src   = 2'b00;    // Add 0 to immediate
                alu_b_src   = 1'b1;     // Immediate value used as ALU operand
                imm_src     = 3'b100;   // U-type immediate extension
                alu_op      = 2'b00;    // ALU performs addition
            end
            7'b0010111: begin // U-type (auipc)
                jump        = 1'b0;
                branch      = 1'b0;
                mem_write   = 1'b0;
                reg_write   = 1'b1;
                result_src  = 2'b00;
                alu_a_src   = 2'b01;    // Add pc to immediate
                alu_b_src   = 1'b1;     // Immediate value used as ALU operand
                imm_src     = 3'b100;   // U-type immediate extension
                alu_op      = 2'b00;    // ALU performs addition
            end
            default: begin
                jump        = 1'b0;
                branch      = 1'b0;
                mem_write   = 1'b0;
                reg_write   = 1'b0;
                result_src  = 2'b00;
                alu_a_src   = 2'b10;
                alu_b_src   = 1'b0;
                imm_src     = 3'b000; 
                alu_op      = 2'b00; 
            end
        endcase
    end

endmodule