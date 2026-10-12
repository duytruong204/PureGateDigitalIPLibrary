module mux_1bit #(
	parameter SEL_WIDTH = 4
) (
	input  wire i_data[SEL_WIDTH**2],
	input  wire i_sel[SEL_WIDTH],
	output wire o_out
)
	wire w_mux_in[SEL_WIDTH + 1][SEL_WIDTH**2];
	
	generate
        for (genvar k = 0; k < SEL_WIDTH**2; k = k + 1) begin : gen_input_bind
            assign w_mux_in[SEL_WIDTH][k] = i_data[k];
        end
    endgenerate

	
    generate
        for (genvar i = 0; i < SEL_WIDTH; i = i + 1) begin : gen_stage
            for (genvar j = 0; j < (SEL_WIDTH**2 / (2**(i+1))); j = j + 1) begin : gen_mux
                mux2to1_1bit mux_gen (
                    // Read from the current stage (i) pairs
                    .i_data ({w_mux_in[i][2*j + 1], w_mux_in[i][2*j]}),
                    .i_sel  (i_sel[i]),
                    .o_out  (w_mux_in[i+1][j])
                );
            end
        end
		
	assign o_out = w_mux_in[SEL_WIDTH][0];
		
endmodule
