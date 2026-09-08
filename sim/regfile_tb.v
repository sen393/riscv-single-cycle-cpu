module regfile_tb;
	
	// Instantiate clk
	reg clk;
	initial clk = 0;
	always #5 clk = ~clk;

	reg we3;
	reg [4:0] a1, a2, a3;
	wire [31:0] rd1, rd2;	
	reg [31:0] wd3;

	// Instantiate device under test
	regfile dut (
		.clk(clk),
		.we3(we3),
		.a1(a1),
		.a2(a2),
		.a3(a3),
		.wd3(wd3),
		.rd1(rd1),
		.rd2(rd2)	
	);
	
	// Begin test
	initial begin
		// Test 1: write and read data
		// Write to register x1
		a3 = 5'd1;
		wd3 = 32'hFFFFFFFC;
		we3 = 1'd1;
		@(posedge clk);
		#1;
		// Read from register x1
		a1 = 5'd1;
		we3 = 1'd0;
		@(posedge clk);
		#1;
		$display("Test 1: rd1=%h (expect: fffffffc)", rd1);	

		// Test 2: check reg x0
		we3 = 1'd0;
		a1 = 5'd0;
		@(posedge clk);
		$display("Test 2: rd1=%0d (expect: 0)", rd1);

		// Test 3: Check same cycle read + write
		a1 = 5'd3;
		a3 = 5'd3;
		wd3 = 32'hAAAAAAAA;
		we3 = 1'd1;
		@(posedge clk);
		#1;	// Set up precondition (have value already loaded in register x3)
		wd3 = 32'hBBBBBBBB;
		$display("Test 3: before edge rd1=%h (expect: aaaaaaaa)", rd1);
		@(posedge clk);
		#1;
		$display("Test 3: after edge rd1=%h (expect: bbbbbbbb)", rd1);

		$finish;
	end
endmodule
