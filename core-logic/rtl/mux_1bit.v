module mux_1bit #(
    parameter SEL_WIDTH = 4
) (
    input  wire [2**SEL_WIDTH-1:0] i_data, 
    input  wire [SEL_WIDTH-1:0]    i_sel,   
    output wire                    o_out    
);
    // Generate w_tree
    wire [(2**SEL_WIDTH)-1:0] w_tree [0:SEL_WIDTH];
    
    generate
        for (genvar stage = 0; stage < SEL_WIDTH; stage = stage + 1) begin: gen_stage
            // The number of mux =  (number input of mux) / 2
            for (genvar index = 0; index < (2**(SEL_WIDTH - stage - 1)); index = index + 1) begin: gen_mux
                mux2to1_1bit mux_inst (
                    .i_data ({ w_tree[stage][2*index + 1], w_tree[stage][2*index] }), 
                    .i_sel  (i_sel[stage]),
                    .o_out  (w_tree[stage + 1][index])
                );
            end
        end
    endgenerate

    assign o_out = w_tree[SEL_WIDTH][0];

endmodule
