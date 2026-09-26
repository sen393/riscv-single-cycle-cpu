`timescale 1ns/1ps

module PC
(
	input 			  clk,
	input 			  reset,
	input  	   [31:0] pc_next,
	output reg [31:0] pc
);

	always @( posedge clk ) begin
		if ( reset )
			pc <=32'd0;
		else
			pc <= pc_next;
	end

endmodule	