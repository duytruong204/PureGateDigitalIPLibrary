module mux_1bit #(
    parameter SEL_WIDTH = 5
) (
    input  wire [2**SEL_WIDTH-1:0] i_data, 
    input  wire [SEL_WIDTH-1:0]    i_sel,   
    output wire                    o_out    
);
	 genvar stage;
	 genvar index;
    // Generate w_stage_data
    generate
        for (stage = 0; stage <= SEL_WIDTH; stage = stage + 1) begin: gen_w_stage
            wire [(2**(SEL_WIDTH - stage))-1:0] w_stage_data;
        end
    endgenerate

    
    generate
        for (stage = 0; stage < SEL_WIDTH; stage = stage + 1) begin: gen_stage
            for (index = 0; index < (2**(SEL_WIDTH - stage - 1)); index = index + 1) begin: gen_mux
                mux2to1_1bit mux_inst (
                    .i_data ({ gen_w_stage[stage].w_stage_data[2*index + 1], 
                               gen_w_stage[stage].w_stage_data[2*index] }), 
                    .i_sel  (i_sel[stage]),
                    .o_out  (gen_w_stage[stage + 1].w_stage_data[index])
                );
            end
        end
    endgenerate

    assign o_out = gen_w_stage[SEL_WIDTH].w_stage_data[0];

endmodule
