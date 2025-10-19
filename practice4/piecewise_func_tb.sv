`timescale 1ns/1ns
module piecewise_func_tb;
    logic [3:0] in1;
    logic [3:0] in2;
    wire [7:0] out;

    piecewise_func DUT (
        .in1(in1),
        .in2(in2),
        .out(out)
    );

    initial begin
        in1 = 4'd0; in2 = 4'd0; #10;
        in1 = 4'd1; in2 = 4'd1; #10;
        in1 = 4'd3; in2 = 4'd5; #10;
        in1 = 4'd7; in2 = 4'd9; #10;
        in1 = 4'd2; in2 = 4'd3; #10;
        in1 = 4'd4; in2 = 4'd7; #10;
        in1 = 4'd5; in2 = 4'd8; #10;
        in1 = 4'd9; in2 = 4'd10; #10;
        in1 = 4'd6; in2 = 4'd6; #10;
        in1 = 4'd11; in2 = 4'd11; #10;
        in1 = 4'd15; in2 = 4'd15; #10;
        in1 = 4'd0; in2 = 4'd7; #10;
        in1 = 4'd5; in2 = 4'd0; #10;
        in1 = 4'd1; in2 = 4'd2; #10;
        in1 = 4'd13; in2 = 4'd9; #10;
        in1 = 4'd8; in2 = 4'd1; #10;
        in1 = 4'd12; in2 = 4'd13; #10;
        in1 = 4'd14; in2 = 4'd15; #10;
        in1 = 4'd10; in2 = 4'd10; #10;
        in1 = 4'd0; in2 = 4'd0; #10;
        $stop;
    end
endmodule
