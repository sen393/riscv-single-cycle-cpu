module TopModule (
    input clk,
    input reset
);

    // Fetch stage intermediate wires
    wire [31:0] pc, pc_next, pc_target, pc_plus4;
    wire [31:0] instr;

    PCPlus4 pcplus4
    (
        .pc_in  (pc),
        .pc_out (pc_plus4)
    );

    PC programcount
    (
        .clk        (clk),
        .reset      (reset),
        .pc_next    (pc_next),
        .pc         (pc)
    );

    IMem imem
    (
        .pc     (pc),
        .instr  (instr)
    );

    PCBranch pcbranch
    (
        .pc         (pc),
        .imm_ext    (imm_ext),
        .pc_target  (pc_target)
    );

    Mux2 select_pc_next
    (
        .sel    (pc_src),
        .a      (pc_plus4),
        .b      (pc_target),
        .out    (pc_next)
    );

    // Decode stage intermediate wires
    wire [31:0] rd_1, rd_2;
    wire [31:0] alu_a_mux_out;
    wire [31:0] alu_b_mux_out;
    wire [31:0] alu_result;
    wire [31:0] read_data;
    wire [31:0] result;
    wire [31:0] imm_ext;
    wire        zero;

    RegFile regfile
    (
        .clk    (clk),
        .we3    (reg_write),
        .a1     (instr[19:15]),
        .a2     (instr[24:20]),
        .a3     (instr[11:7]),
        .wd3    (result),
        .rd1    (rd_1),
        .rd2    (rd_2)
    );

    ImmExt immext
    (
        .imm_src    (imm_src),
        .instr      (instr),
        .imm_ext    (imm_ext)
    );

    Mux2 select_b
    (
        .sel    (alu_b_src),
        .a      (rd_2),
        .b      (imm_ext),
        .out    (alu_b_mux_out)
    );

    Mux3 select_a
    (
        .sel    (alu_a_src),
        .a      (32'b0),
        .b      (pc),
        .c      (rd_1),
        .out    (alu_a_mux_out)
    );

    ALU alu
    (
        .alu_control    (alu_control),
        .a              (alu_a_mux_out),
        .b              (alu_b_mux_out),
        .result         (alu_result),
        .zero           (zero)
    );

    DMem dmem
    (
        .clk        (clk),
        .we         (mem_write),
        .addr       (alu_result),
        .write_data (rd_2),
        .read_data  (read_data)
    );

    Mux3 select_alu_dmem
    (
        .sel    (result_src),
        .a      (alu_result),
        .b      (read_data),
        .c      (pc_plus4),
        .out    (result)
    );


    // Control unit intermediate wires
    wire [6:0] opcode = instr[6:0];
    wire [2:0] funct3 = instr[14:12];
    wire [6:0] funct7 = instr[31:25];
    wire       branch, jump, mem_write, reg_write, alu_b_src, pc_src;
    wire [1:0] result_src, alu_a_src, alu_op;
    wire [2:0] imm_src;
    wire [3:0] alu_control;

    MainDecoder main_decoder
    (
        .opcode     (opcode),
        .jump       (jump),
        .branch     (branch),
        .mem_write  (mem_write),
        .reg_write  (reg_write),
        .result_src (result_src),
        .alu_a_src  (alu_a_src),
        .alu_b_src  (alu_b_src),
        .imm_src    (imm_src),
        .alu_op     (alu_op)
    );

    ALUDecoder alu_decoder
    (
        .opcode         (opcode),
        .funct7         (funct7),
        .funct3         (funct3),
        .alu_op         (alu_op),
        .alu_control    (alu_control)
    );

    PCSrc pc_sel_branch
    (
        .zero   (zero),
        .jump   (jump),
        .branch (branch),
        .funct3 (funct3),
        .pc_src (pc_src)
    );

endmodule