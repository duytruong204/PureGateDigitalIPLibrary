module mux2to1 #(
    parameter DATA_WIDTH = 32
) (
    input  wire [(2 * DATA_WIDTH)-1:0] i_data, 
    input  wire                        i_sel,   
    output wire [DATA_WIDTH-1:0]       o_out    
);

    generate
        for (genvar k = 0; k < DATA_WIDTH; k = k + 1) begin : gen_mux2to1
            // Instantiate your 1-bit 2-to-1 multiplexer for every bit position
            mux2to1_1bit mux_bit_inst (
                .i_data ({i_data[DATA_WIDTH + k], i_data[k]}), 
                .i_sel  (i_sel),
                .o_out  (o_out[k])
            );
        end
    endgenerate

endmodule
