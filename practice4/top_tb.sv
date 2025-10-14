`timescale 1ns/1ns
module top_tb;
	logic [3:0] a, b, res, dec_out;
	logic [1:0] dec_in;
	logic ternary1, ternary2;
	example DUT(
		.op1(a),
		.op2(b),
		.sum(res),
		.dec_in(dec_in),
		.dec_out(dec_out),
		.ternary1(ternary1),
		.ternary2(ternary2)
	);
	initial begin
		a = 4'd0; b = 4'd0; dec_in = 0;
		#10;
		a = 4'd3; b = 4'd4; dec_in = 1;
		#10;
		a = 4'd3; b = 4'd5; dec_in = 2;
		#10;
		a = 4'd1000; b = 4'b0110; dec_in = 3;
		#10;
		$stop;
	end
endmodule