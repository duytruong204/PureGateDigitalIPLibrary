module mux_1bit #(
		parameter SEL_WIDTH = 4
) (
		input  wire i_data[SEL_WIDTH**2],
		input  wire i_sel[SEL_WIDTH],
		output wire o_out
)
		wire w_mux_in[SEL_WIDTH]
		int i, j;
		generate
				for(i = 0, i < SEL_WIDTH, i = i + 1) begin: gen_stage
						for(j = 0, j < 
				end
		endgenerate
endmodule