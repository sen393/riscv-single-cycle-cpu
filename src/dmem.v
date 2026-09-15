module dmem (
    input clk,
    input we,
    input [31:0] addr,
    input [31:0] write_data,
    output [31:0] read_data
);

    // Divide byte address by 4 to get word index
    wire [31:0] addr_div;
    assign addr_div = {2'd0, addr[31:2]};

    // Create 256-word 32-bit data memory array
    reg [31:0] dmem [255:0];

    // Write on clock edge, only when enabled
    always @(posedge clk) begin
        if (we)
            dmem[addr_div[7:0]] <= write_data;  // addr_div is narrowed to stay within 256 words of data
    end

    // Combinational read
    assign read_data = dmem[addr_div[7:0]];

endmodule