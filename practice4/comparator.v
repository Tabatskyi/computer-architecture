module comparator (
    input [3:0] a,
    input [3:0] b,
    output less,
    output equal,
    output greater,
    output diff_one
);

assign a_ext = {1'b0, a};
assign b_ext = {1'b0, b};
assign diff_ab = a_ext - b_ext;
assign diff_ba = b_ext - a_ext;

assign less = (a < b);
assign equal = (a == b);
assign greater = (a > b);
assign diff_one = (diff_ab == 5'd1) || (diff_ba == 5'd1);

endmodule
