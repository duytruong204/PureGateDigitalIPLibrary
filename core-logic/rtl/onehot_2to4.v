module onehot2to4 (
	input  wire [1:0] i_data,
	output wire [3:0] o_out
)
	assign o_out[3] = i_data[1] & i_data[0];
	assign o_out[2] = i_data[1] & i_data[0];
	assign o_out[1] = i_data[1] & i_data[0]
	assign o_out[0] = i_data[1] & i_data[0]
	
endmodule
