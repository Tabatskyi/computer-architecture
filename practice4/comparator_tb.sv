`timescale 1ns/1ps

module comparator_tb;
    logic [3:0] a;
    logic [3:0] b;
    wire less;
    wire equal;
    wire greater;
    wire diff_one;

    comparator DUT (
        .a(a),
        .b(b),
        .less(less),
        .equal(equal),
        .greater(greater),
        .diff_one(diff_one)
    );

    initial begin
        a = 4'd0; b = 4'd0; #10;
        a = 4'd1; b = 4'd0; #10;
        a = 4'd0; b = 4'd1; #10;
        a = 4'd7; b = 4'd7; #10;
        a = 4'd8; b = 4'd2; #10;
        a = 4'd2; b = 4'd8; #10;
        a = 4'd5; b = 4'd4; #10;
        a = 4'd4; b = 4'd5; #10;
        a = 4'd9; b = 4'd10; #10;
        a = 4'd10; b = 4'd9; #10;
        a = 4'd15; b = 4'd0; #10;
        a = 4'd0; b = 4'd15; #10;
        a = 4'd6; b = 4'd6; #10;
        a = 4'd3; b = 4'd2; #10;
        a = 4'd2; b = 4'd3; #10;
        a = 4'd11; b = 4'd11; #10;
        a = 4'd12; b = 4'd13; #10;
        a = 4'd13; b = 4'd12; #10;
        a = 4'd5; b = 4'd5; #10;
        a = 4'd0; b = 4'd0; #10;
        $stop;
    end
endmodule
