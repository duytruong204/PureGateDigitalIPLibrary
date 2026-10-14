module mux #(
    parameter DATA_WIDTH = 32,
    parameter SEL_WIDTH  = 5
) (
    input  wire [(2**SEL_WIDTH)*DATA_WIDTH-1:0]  i_data,
    input  wire [SEL_WIDTH-1:0]                  i_sel,
    output wire [DATA_WIDTH-1:0]                 o_out
);
    genvar bit_idx;
    genvar ch_idx;
    
    wire [DATA_WIDTH-1:0] w_bus_data [0:2**SEL_WIDTH-1];

    generate
        for (bit_idx = 0; bit_idx < DATA_WIDTH; bit_idx = bit_idx + 1) begin: gen_mux_array
            
            wire [2**SEL_WIDTH-1:0] w_mux1bit_input;
            
            for (ch_idx = 0; ch_idx < 2**SEL_WIDTH; ch_idx = ch_idx + 1) begin: gen_collect_bits
                assign w_mux1bit_input[ch_idx] = i_data[ch_idx * DATA_WIDTH + bit_idx];
            end
            
            mux_1bit #(
                .SEL_WIDTH(SEL_WIDTH)
            ) mux_inst (
                .i_data (w_mux1bit_input),
                .i_sel  (i_sel),
                .o_out  (o_out[bit_idx])
            );
        end
        
    endgenerate

endmodule
