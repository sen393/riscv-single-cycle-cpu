module DMem
(
    input              clk,
    input              we,
    input       [2:0]  funct3,
    input       [31:0] addr,
    input       [31:0] write_data,
    output reg  [31:0] read_data
);

    // 256 words = 1024 bytes of data memory
    reg [31:0] dmem [255:0];

    wire [7:0]  word_addr;
    wire [31:0] word_data;

    // addr[1:0] selects a byte within the 32-bit word
    assign word_addr = addr[9:2];
    assign word_data = dmem[word_addr];


    // ============================================================
    // WRITES
    // ============================================================

    always @(posedge clk) begin
        if (we) begin

            case (funct3)

                // SB
                3'b000: begin
                    case (addr[1:0])
                        2'b00: dmem[word_addr][7:0]   <= write_data[7:0];
                        2'b01: dmem[word_addr][15:8]  <= write_data[7:0];
                        2'b10: dmem[word_addr][23:16] <= write_data[7:0];
                        2'b11: dmem[word_addr][31:24] <= write_data[7:0];
                    endcase
                end


                // SH
                3'b001: begin
                    case (addr[1:0])
                        2'b00:
                            dmem[word_addr][15:0]  <= write_data[15:0];

                        2'b10:
                            dmem[word_addr][31:16] <= write_data[15:0];

                        default: ; // Misaligned SH not supported
                    endcase
                end


                // SW
                3'b010: begin
                    if (addr[1:0] == 2'b00)
                        dmem[word_addr] <= write_data;
                end
 
                default: ;

            endcase

        end
    end


    // ============================================================
    // READS
    // ============================================================

    always @(*) begin

        case (funct3)

            // LB
            3'b000: begin
                case (addr[1:0])
                    2'b00:
                        read_data =
                            {{24{word_data[7]}},
                             word_data[7:0]};

                    2'b01:
                        read_data =
                            {{24{word_data[15]}},
                             word_data[15:8]};

                    2'b10:
                        read_data =
                            {{24{word_data[23]}},
                             word_data[23:16]};

                    2'b11:
                        read_data =
                            {{24{word_data[31]}},
                             word_data[31:24]};
                endcase
            end


            // LH
            3'b001: begin
                case (addr[1:0])

                    2'b00:
                        read_data =
                            {{16{word_data[15]}},
                             word_data[15:0]};

                    2'b10:
                        read_data =
                            {{16{word_data[31]}},
                             word_data[31:16]};

                    default:
                        read_data = 32'd0;

                endcase
            end


            // LW
            3'b010: begin
                if (addr[1:0] == 2'b00)
                    read_data = word_data;
                else
                    read_data = 32'd0;
            end


            // LBU
            3'b100: begin
                case (addr[1:0])
                    2'b00:
                        read_data =
                            {24'd0, word_data[7:0]};

                    2'b01:
                        read_data =
                            {24'd0, word_data[15:8]};

                    2'b10:
                        read_data =
                            {24'd0, word_data[23:16]};

                    2'b11:
                        read_data =
                            {24'd0, word_data[31:24]};
                endcase
            end


            // LHU
            3'b101: begin
                case (addr[1:0])

                    2'b00:
                        read_data =
                            {16'd0, word_data[15:0]};

                    2'b10:
                        read_data =
                            {16'd0, word_data[31:16]};

                    default:
                        read_data = 32'd0;

                endcase
            end


            default:
                read_data = 32'd0;

        endcase
    end

endmodule