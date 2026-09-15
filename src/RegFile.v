module RegFile (
	input 		  clk,
	input 		  we3,
	input  [4:0]  a1, a2, a3,
	input  [31:0] wd3,
	output [31:0] rd1, rd2
	);
	// Create 32x 32-bit registers
	reg [31:0] x [31:0];

	always @( posedge clk ) begin
		if ( we3 )
			x[a3] <= wd3;
	end

	assign rd1 = ( a1 == 5'd0 ) ? 32'd0 : x[a1];
	assign rd2 = ( a2 == 5'd0 ) ? 32'd0 : x[a2];

endmodule