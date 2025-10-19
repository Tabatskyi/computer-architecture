`timescale 1ns/1ns
module weighted_majority_tb;
    logic [5:0] in;
    wire        majority;

    weighted_majority DUT (
        .in(in),
        .majority(majority)
    );

    initial begin
        in = 6'b000000; #10;
        in = 6'b000001; #10;
        in = 6'b000011; #10;
        in = 6'b000111; #10;
        in = 6'b001111; #10;
        in = 6'b010000; #10;
        in = 6'b100000; #10;
        in = 6'b110000; #10;
        in = 6'b010011; #10;
        in = 6'b100101; #10;
        in = 6'b111000; #10;
        in = 6'b011110; #10;
        in = 6'b101111; #10;
        in = 6'b000000; #10;
        $stop;
    end
endmodule
