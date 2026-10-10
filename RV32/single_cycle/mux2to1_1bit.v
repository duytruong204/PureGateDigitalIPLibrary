module mux2to1_1bit(
    input  wire [1:0] i_data,
    input  wire       i_sel,
    output wire       o_out
);

    assign o_out = i_sel ? i_data[1] : i_data[0];

endmodule
