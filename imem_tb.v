module imem_tb;
	reg [31:0] pc;
	wire [31:0] instr;

	// Instantiate device under test
	imem dut (
		.pc(pc),
		.instr(instr)
	);

	initial begin
		// Test 1: first instruction (pc = 0, => imem[0])
		pc = 32'd0;
		#10; // 10 time unit delay
		$display("pc=%0d instr=%h", pc, instr);

		// Test 2: second instruction (pc = 4, => imem[1])
		pc = 32'd4;
		#10; // 10 time unit delay
		$display("pc=%0d instr=%h", pc, instr);

		// Test 3: second instruction (pc = 8, => imem[2])
		pc = 32'd8;
		#10; // 10 time unit delay
		$display("pc=%0d instr=%h", pc, instr);

		// Test 4: second instruction (pc = 12, => imem[3])
		pc = 32'd12;
		#10; // 10 time unit delay
		$display("pc=%0d instr=%h", pc, instr);

		$finish;
	end
endmodule
