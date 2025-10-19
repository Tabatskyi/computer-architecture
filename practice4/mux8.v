module mux2 (
    input d0,
    input d1,
    input sel,
    output y
);
    assign y = sel ? d1 : d0;
endmodule

module mux8 (
    input [7:0] in,
    input [2:0] sel,
    output y
);
    wire [3:0] stage1;
    wire [1:0] stage2;

    mux2 u0(in[0], in[1], sel[0], stage1[0]);
    mux2 u1(in[2], in[3], sel[0], stage1[1]);
    mux2 u2(in[4], in[5], sel[0], stage1[2]);
    mux2 u3(in[6], in[7], sel[0], stage1[3]);

    mux2 u4(stage1[0], stage1[1], sel[1], stage2[0]);
    mux2 u5(stage1[2], stage1[3], sel[1], stage2[1]);
    
    mux2 u6(stage2[0], stage2[1], sel[2], y);
endmodule
