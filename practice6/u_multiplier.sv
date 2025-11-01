module full_adder (
    input logic a, b, cin,
    output logic sum, cout
);
    assign {cout, sum} = a + b + cin;
endmodule

module u_multiplier (
    input logic [3:0] A,
    input logic [3:0] B,
    output logic [7:0] P
);
    logic [3:0] pp0, pp1, pp2, pp3;
    assign pp0 = A & {4{B[0]}}; 
    assign pp1 = A & {4{B[1]}};
    assign pp2 = A & {4{B[2]}};
    assign pp3 = A & {4{B[3]}};

    logic [7:0] row0, row1, row2, row3;
    assign row0 = {4'b0000, pp0};
    assign row1 = {3'b000, pp1, 1'b0};
    assign row2 = {2'b00, pp2, 2'b00};
    assign row3 = {1'b0, pp3, 3'b000};

    // row0 + row1 -> s01
    logic [7:0] s01;
    logic c01_0, c01_1, c01_2, c01_3, c01_4, c01_5, c01_6, c01_7;
    full_adder add01_b0 (.a(row0[0]), .b(row1[0]), .cin(1'b0), .sum(s01[0]), .cout(c01_0));
    full_adder add01_b1 (.a(row0[1]), .b(row1[1]), .cin(c01_0), .sum(s01[1]), .cout(c01_1));
    full_adder add01_b2 (.a(row0[2]), .b(row1[2]), .cin(c01_1), .sum(s01[2]), .cout(c01_2));
    full_adder add01_b3 (.a(row0[3]), .b(row1[3]), .cin(c01_2), .sum(s01[3]), .cout(c01_3));
    full_adder add01_b4 (.a(row0[4]), .b(row1[4]), .cin(c01_3), .sum(s01[4]), .cout(c01_4));
    full_adder add01_b5 (.a(row0[5]), .b(row1[5]), .cin(c01_4), .sum(s01[5]), .cout(c01_5));
    full_adder add01_b6 (.a(row0[6]), .b(row1[6]), .cin(c01_5), .sum(s01[6]), .cout(c01_6));
    full_adder add01_b7 (.a(row0[7]), .b(row1[7]), .cin(c01_6), .sum(s01[7]), .cout(c01_7));

    // s01 + row2 -> s012
    logic [7:0] s012;
    logic c12_0, c12_1, c12_2, c12_3, c12_4, c12_5, c12_6, c12_7;
    full_adder add12_b0 (.a(s01[0]), .b(row2[0]), .cin(1'b0), .sum(s012[0]), .cout(c12_0));
    full_adder add12_b1 (.a(s01[1]), .b(row2[1]), .cin(c12_0), .sum(s012[1]), .cout(c12_1));
    full_adder add12_b2 (.a(s01[2]), .b(row2[2]), .cin(c12_1), .sum(s012[2]), .cout(c12_2));
    full_adder add12_b3 (.a(s01[3]), .b(row2[3]), .cin(c12_2), .sum(s012[3]), .cout(c12_3));
    full_adder add12_b4 (.a(s01[4]), .b(row2[4]), .cin(c12_3), .sum(s012[4]), .cout(c12_4));
    full_adder add12_b5 (.a(s01[5]), .b(row2[5]), .cin(c12_4), .sum(s012[5]), .cout(c12_5));
    full_adder add12_b6 (.a(s01[6]), .b(row2[6]), .cin(c12_5), .sum(s012[6]), .cout(c12_6));
    full_adder add12_b7 (.a(s01[7]), .b(row2[7]), .cin(c12_6), .sum(s012[7]), .cout(c12_7));

    // s012 + row3 -> P
    logic cF_0, cF_1, cF_2, cF_3, cF_4, cF_5, cF_6, cF_7;
    full_adder addF_b0 (.a(s012[0]), .b(row3[0]), .cin(1'b0), .sum(P[0]), .cout(cF_0));
    full_adder addF_b1 (.a(s012[1]), .b(row3[1]), .cin(cF_0), .sum(P[1]), .cout(cF_1));
    full_adder addF_b2 (.a(s012[2]), .b(row3[2]), .cin(cF_1), .sum(P[2]), .cout(cF_2));
    full_adder addF_b3 (.a(s012[3]), .b(row3[3]), .cin(cF_2), .sum(P[3]), .cout(cF_3));
    full_adder addF_b4 (.a(s012[4]), .b(row3[4]), .cin(cF_3), .sum(P[4]), .cout(cF_4));
    full_adder addF_b5 (.a(s012[5]), .b(row3[5]), .cin(cF_4), .sum(P[5]), .cout(cF_5));
    full_adder addF_b6 (.a(s012[6]), .b(row3[6]), .cin(cF_5), .sum(P[6]), .cout(cF_6));
    full_adder addF_b7 (.a(s012[7]), .b(row3[7]), .cin(cF_6), .sum(P[7]), .cout(cF_7));
endmodule
