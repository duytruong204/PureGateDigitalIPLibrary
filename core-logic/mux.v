module mux #(
		parameter DATA_WIDTH = 4,
		parameter SEL_WIDTH = 3,
)(
		input  wire i_data[DATA_WIDTH],
		input  wire i_sel[SEL_WIDTH],
		output wire o_out[DATA_WIDTH]
)