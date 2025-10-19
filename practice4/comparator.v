module comparator (
    input [3:0] a,
    input [3:0] b,
    output less,
    output equal,
    output greater,
    output diff_one
);

wire [4:0] a_ext = {1'b0, a};
wire [4:0] b_ext = {1'b0, b};
wire [4:0] diff_ab = a_ext - b_ext;
wire [4:0] diff_ba = b_ext - a_ext;

assign less = (a < b);
assign equal = (a == b);
assign greater = (a > b);
assign diff_one = (diff_ab == 5'd1) || (diff_ba == 5'd1);

endmodule
