module piecewise_func (
    input [3:0] in1,
    input [3:0] in2,
    output [7:0] out
);
    assign both_odd = in1[0] & in2[0];
    assign mult = in1 * in2;
    assign scaled = {in1, 2'b00};

    assign out = both_odd ? mult : scaled;
endmodule
