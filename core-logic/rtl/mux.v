module mux #(
    parameter DATA_WIDTH = 32,
    parameter SEL_WIDTH  = 4
) (
    input  wire [(2**SEL_WIDTH)*DATA_WIDTH-1:0]  i_data,
    input  wire [SEL_WIDTH-1:0]                  i_sel,
    output wire [DATA_WIDTH-1:0]                 o_out
);
    localparam CHANNELS = (2**SEL_WIDTH);
    
    generate
        for (genvar k = 0; k < DATA_WIDTH; k = k + 1) begin : gen_mux
            mux_1bit  #(
                .SEL_WIDTH(SEL_WIDTH)
            ) mux_gen (
                // FIXED: Start at k*CHANNELS, always slice exactly CHANNELS bits upward
                .i_data(i_data[k*CHANNELS +: CHANNELS]),
                .i_sel (i_sel),
                .o_out (o_out[k])
            );
        end
    endgenerate
    
endmodule
