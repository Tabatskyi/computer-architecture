`timescale 1ns/1ns
module mux8_tb;
    logic [7:0] in;
    logic [2:0] sel;
    wire y;

    mux8 DUT (
        .in(in),
        .sel(sel),
        .y(y)
    );

    initial begin
        in = 8'b0000_0001; sel = 3'b000; #10;
        in = 8'b0000_0010; sel = 3'b001; #10;
        in = 8'b0000_0100; sel = 3'b010; #10;
        in = 8'b0000_1000; sel = 3'b011; #10;
        in = 8'b0001_0000; sel = 3'b100; #10;
        in = 8'b0010_0000; sel = 3'b101; #10;
        in = 8'b0100_0000; sel = 3'b110; #10;
        in = 8'b1000_0000; sel = 3'b111; #10;
        in = 8'b1111_0000; sel = 3'b010; #10;
        in = 8'b1010_1010; sel = 3'b101; #10;
        in = 8'b0101_0101; sel = 3'b001; #10;
        in = 8'b1100_0011; sel = 3'b111; #10;
        in = 8'b1100_0011; sel = 3'b000; #10;
        in = 8'b0000_0000; sel = 3'b100; #10;
        $stop;
    end
endmodule
