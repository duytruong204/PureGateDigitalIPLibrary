module full_adder_1bit (
    input  wire i_a,
    input  wire i_b,
    input  wire i_carry,
    output wire o_sum,
    output wire o_carry
);
    assign o_sum   = i_a ^ i_b ^ i_carry;
    assign o_carry = (i_a & i_b) | (i_carry & (i_a ^ i_b));
endmodule