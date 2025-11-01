`timescale 1ns/1ps

module u_multiplier_tb;
	logic [3:0] A;
	logic [3:0] B;
	logic [7:0] P;

	u_multiplier DUT (A,B, P);

	integer i, j;
	integer errors;

	task automatic check(input logic [3:0] a, input logic [3:0] b);
		logic [7:0] exp;
		begin
			A = a; B = b;
			exp = a * b; 
			#10;
			if (P !== exp) begin
				$display("FAIL A=%0d (0x%h) B=%0d (0x%h) => P=%0d (0x%h) exp=%0d (0x%h)", a, a, b, b, P, P, exp, exp);
				errors++;
			end else begin
				$display("PASS A=%0d B=%0d => P=%0d", a, b, P);
			end
			#10;
		end
	endtask

	initial begin
		errors = 0;
		for (i = 0; i < 16; i++) begin
			for (j = 0; j < 16; j++) begin
				check(i[3:0], j[3:0]);
			end
		end
		if (errors == 0) $display("RESULT: ALL TESTS PASSED");
		else $display("RESULT: %0d TEST(S) FAILED", errors);
		$stop;
	end
endmodule