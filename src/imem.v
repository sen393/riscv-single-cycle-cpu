module imem (
	input [31:0] pc,
	output [31:0] instr );

	// Divide program counter by four
	wire [31:0] pc_div;
	assign pc_div = {2'd0, pc[31:2]};

	// Create array to store instructions
	reg [31:0] imem [255:0];

	// Load instructions from file into array
	initial begin
		$readmemh("programs/program.hex", imem);
	end

	// Load instruction to output instr
	// pc_div is narrowed to stay within 256 lines of instructions
	assign instr = imem[pc_div[7:0]];	

endmodule	
