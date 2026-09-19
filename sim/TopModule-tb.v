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
        $display("t=%0t pc=%h | x7=%0d x8=%0d x9=%0d x10=%0d x11=%0d x12=%0d x13=%0d x15=%0d(%0d) x16=%0d x17=%0d x18=%0d x19=%0d x20=%h x21=%0d x22=%0d",
            $time, uut.pc,
            uut.regfile.x[7], uut.regfile.x[8], uut.regfile.x[9], uut.regfile.x[10],
            uut.regfile.x[11], uut.regfile.x[12], uut.regfile.x[13],
            $signed(uut.regfile.x[15]), uut.regfile.x[15],
            uut.regfile.x[16], uut.regfile.x[17], uut.regfile.x[18], uut.regfile.x[19],
            uut.regfile.x[20], uut.regfile.x[21], uut.regfile.x[22]);
        end

        // iverilog -o sim_out src/TopModule.v src/PC.v src/PCPlus4.v src/PCBranch.v src/IMem.v src/Mux3.v src/Mux2.v src/RegFile.v src/ImmExt.v src/ALU.v src/DMem.v src/MainDecoder.v src/ALUDecoder.v src/PCSrc.v sim/TopModule-tb.v && vvp sim_out

        $finish;
    end
endmodule