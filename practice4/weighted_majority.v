module weighted_majority (
    input [5:0] in,
    output majority
);
    wire [3:0] weight_sum;

    assign weight_sum = in[0] + in[1] + in[2] + in[3]
                      + (in[4] ? 4'd2 : 4'd0)
                      + (in[5] ? 4'd2 : 4'd0);
    assign majority = (weight_sum >= 4'd4);
endmodule
