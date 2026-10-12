module mux #(
    parameter DATA_WIDTH = 32,
    parameter SEL_WIDTH  = 4
) (
    input  wire [(2**SEL_WIDTH)*DATA_WIDTH-1:0]  i_data,
    input  wire [SEL_WIDTH-1:0]                  i_sel,
    output wire [DATA_WIDTH-1:0]                 o_out
);
    localparam CHANNELS = (2**SEL_WIDTH);

    wire w_mux_input_array [0:DATA_WIDTH-1][0:CHANNELS-1];
    wire w_sel_array [0:SEL_WIDTH-1];
	
    generate
        for (genvar s = 0; s < SEL_WIDTH; s = s + 1) begin : gen_sel_bind
            assign w_sel_array[s] = i_sel[s];
        end

        for (genvar k = 0; k < DATA_WIDTH; k = k + 1) begin : gen_bit_extract
            for (genvar c = 0; c < CHANNELS; c = c + 1) begin : gen_channel_extract
                assign w_mux_input_array[k][c] = i_data[c * DATA_WIDTH + k];
            end
        end
	
        for (genvar k = 0; k < DATA_WIDTH; k = k + 1) begin : gen_mux_instances
            mux_1bit #(
                .SEL_WIDTH(SEL_WIDTH)
            ) u_mux_1bit_inst (
                .i_data (w_mux_input_array[k]), 
                .i_sel  (w_sel_array),
                .o_out  (o_out[k]) 
            );
        end
    endgenerate
		
endmodule
