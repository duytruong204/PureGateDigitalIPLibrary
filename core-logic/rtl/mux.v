module mux #(
    parameter DATA_WIDTH = 32,
    parameter SEL_WIDTH  = 4
) (
    input  wire [(2**SEL_WIDTH)*DATA_WIDTH-1:0]  i_data,
    input  wire [SEL_WIDTH-1:0]                  i_sel,
    output wire [DATA_WIDTH-1:0]                 o_out
);
    localparam TOTAL_CHANNELS = (2**SEL_WIDTH);

    wire [DATA_WIDTH-1:0] w_stage_bus [0:SEL_WIDTH][0:TOTAL_CHANNELS-1];

    generate
        for (genvar c = 0; c < TOTAL_CHANNELS; c = c + 1) begin : gen_input_unpack
            assign w_stage_bus[0][c] = i_data[c * DATA_WIDTH +: DATA_WIDTH];
        end

        for (genvar stage = 0; stage < SEL_WIDTH; stage = stage + 1) begin : gen_stages
            // Calculate how many 2-to-1 word muxes are needed at this step
            localparam MUX_COUNT = TOTAL_CHANNELS >> (stage + 1);

            for (genvar m = 0; m < MUX_COUNT; m = m + 1) begin : gen_muxes
                mux2to1 #(
                    .DATA_WIDTH(DATA_WIDTH)
                ) u_mux2to1_inst (
                    .i_data ({w_stage_bus[stage][2*m + 1], w_stage_bus[stage][2*m]}),
                    .i_sel  (i_sel[stage]),
                    .o_out  (w_stage_bus[stage + 1][m])
                );
            end
        end
    endgenerate

    assign o_out = w_stage_bus[SEL_WIDTH][0];

endmodule
