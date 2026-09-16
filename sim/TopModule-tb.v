module TopModule_tb;
    reg clk;
    reg reset;

    TopModule uut (
        .clk(clk),
        .reset(reset)
    );

    // Clock generator
    initial clk = 0;
    always #5 clk = ~clk;

    // Waveform dump for GTKWave
    initial begin
        $dumpfile("topmodule_tb.vcd");
        $dumpvars(0, TopModule_tb);
    end

    initial begin
        reset = 1;
        @(posedge clk);
        @(posedge clk);
        reset = 0;

        // Run enough cycles to see the 0x08-0x1C loop iterate a couple times
        repeat (30) begin
            @(posedge clk);
            #1;
            $display("t=%0t pc=%h instr=%h | x4=%0d x5=%0d x6=%0d x7=%0d x9=%0d",
                $time, uut.pc, uut.instr,
                uut.regfile.x[4], uut.regfile.x[5], uut.regfile.x[6],
                uut.regfile.x[7], uut.regfile.x[9]);
        end

        $finish;
    end
endmodule