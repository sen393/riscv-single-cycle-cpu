`timescale 1ns/1ps

module TopModule_tb;

    reg clk;
    reg reset;

    integer failures;

    // Instantiate CPU
    TopModule uut
    (
        .clk  (clk),
        .reset(reset)
    );

    // Instantiate Clock
    initial clk = 0;
    always #5 clk = ~clk;

    // Waveform dump
    initial begin
        $dumpfile("topmodule_tb.vcd");
        $dumpvars(0, TopModule_tb);
    end

    // Register checking task
    task check_reg;
        input integer reg_num;
        input [31:0] expected;

        begin
            if (uut.regfile.x[reg_num] === expected) begin
                $display("PASS: x%0d = %0d", reg_num, $signed(expected));
            end
            else begin
                $display(
                    "FAIL: x%0d expected %0d, got %0d",
                    reg_num,
                    $signed(expected),
                    $signed(uut.regfile.x[reg_num])
                );

                failures = failures + 1;
            end
        end
    endtask


    // ============================================================
    // MAIN TEST
    //
    // Program:
    //
    //   addi x5,  x0, 5
    //   addi x6,  x0, 3
    //   add  x7,  x5, x6
    //   sub  x8,  x5, x6
    //   and  x9,  x5, x6
    //   or   x10, x5, x6
    //   xor  x11, x5, x6
    //   sll  x12, x6, x5
    //   srl  x13, x12,x5
    //   addi x14, x0,-16
    //   sra  x15, x14,x5
    //   slt  x16, x8, x7
    //   slt  x17, x7, x8
    //   sltu x18, x0, x14
    //   sltu x19, x14,x0
    //   jal  x20, +8
    //   addi x21, x0,111      <-- skipped
    //   addi x22, x0,222
    //   lui  x23,0x12345
    //   auipc x24,0
    //
    //   ... branch tests using x25-x30 ...
    //
    //   jal x0, 0              <-- final infinite loop at PC=0xE0
    // ============================================================

    // Main test
    initial begin

        failures = 0;

        // Reset
        reset = 1;

        @(posedge clk);
        @(posedge clk);

        @(negedge clk);
        reset = 0;

        // Run program
        // Run long enough to complete all tests and reach
        // the final JAL loop at PC=0xE0.

        repeat (60)
            @(posedge clk);

        #1;

        // Check ALU instructions
        $display("");
        $display("Checking ALU instructions...");

        check_reg(5,  5);
        check_reg(6,  3);

        check_reg(7,  8);             // ADD
        check_reg(8,  2);             // SUB
        check_reg(9,  1);             // AND
        check_reg(10, 7);             // OR
        check_reg(11, 6);             // XOR

        check_reg(12, 96);            // SLL
        check_reg(13, 3);             // SRL

        check_reg(14, 32'hFFFFFFF0);  // ADDI -16
        check_reg(15, 32'hFFFFFFFF);  // SRA

        check_reg(16, 1);             // SLT
        check_reg(17, 0);             // SLT

        check_reg(18, 1);             // SLTU
        check_reg(19, 0);             // SLTU

        // Check JAL
        $display("");
        $display("Checking JAL...");
        if (uut.regfile.x[21] === 32'd111) begin
        $display("FAIL: JAL did not skip instruction at PC=0x40");
        failures = failures + 1;
        end else begin
            $display("PASS: JAL skipped instruction at PC=0x40");
        end

        // Check LUI and AUIPC
        $display("");
        $display("Checking LUI and AUIPC...");
        check_reg(22, 222);
        check_reg(23, 32'h12345000);
        check_reg(24, 32'h0000004C);

        // Check branches
        $display("");
        $display("Checking branch instructions...");
        check_reg(25, 2); // BEQ:  taken + not-taken passed
        check_reg(26, 2); // BNE:  taken + not-taken passed
        check_reg(27, 2); // BLT:  signed taken + not-taken passed
        check_reg(28, 2); // BGE:  signed taken + not-taken passed
        check_reg(29, 2); // BLTU: unsigned taken + not-taken passed
        check_reg(30, 2); // BGEU: unsigned taken + not-taken passed


        // Check final program loop
        $display("");
        $display("Checking final PC...");

        if (uut.pc === 32'h000000E0)
            $display("PASS: program reached final loop at PC=0xE0");
        else begin
            $display(
                "FAIL: expected final PC=0xE0, got PC=%h",
                uut.pc
            );
            failures = failures + 1;
        end


        // Results
        $display("");
        $display("--------------------------------");

        if (failures == 0)
            $display("ALL TESTS PASSED");
        else
            $display("%0d TEST(S) FAILED", failures);

        $display("--------------------------------");
        $display("");

        $finish;

    end

endmodule