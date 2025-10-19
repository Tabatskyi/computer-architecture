module piecewise_func (
    input [3:0] in1,
    input [3:0] in2,
    output [7:0] out
);
    wire both_odd = in1[0] & in2[0];
    wire [7:0] mult = in1 * in2;
    wire [7:0] scaled = {in1, 2'b00};

    assign out = both_odd ? mult : scaled;
endmodule
