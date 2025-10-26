`timescale 1ns/1ps
module fsm_tb;
	logic clk, reset, ready, add_sub;
	logic [3:0] a;
	logic [3:0] b;
	logic [3:0] out_res;
	logic [3:0] out_valid;

	fsm uut (
		.clk(clk),
		.reset(reset),
		.ready(ready),
		.add_sub(add_sub),
		.a(a),
		.b(b),
		.out_res(out_res),
		.out_valid(out_valid)
	);

	always #5 clk = ~clk;

	task automatic apply_op(input logic [3:0] a_in,
							input logic [3:0] b_in,
							input logic op_add);
		logic [3:0] expected;
		begin
			a = a_in;
			b = b_in;
			add_sub = op_add;
			ready = 1'b1;
			@(posedge clk);
			ready = 1'b0;
			@(posedge clk);
			#1;
			expected = op_add ? (a_in + b_in) : (a_in - b_in);
			if (!out_valid[0]) begin
				$error("[%0t] out_valid deasserted when result expected", $time);
			end
			if (out_res !== expected) begin
				$error("[%0t] Result mismatch: op=%s a=%0d b=%0d got %0d expected %0d", $time,
					op_add ? "ADD" : "SUB", a_in, b_in, out_res, expected);
			end else begin
				$display("[%0t] %s success: a=%0d b=%0d result=%0d", $time,
					op_add ? "ADD" : "SUB", a_in, b_in, out_res);
			end
			@(posedge clk);
		end
	endtask

	initial begin
		clk = 0;
		reset = 1;
		ready = 0;
		add_sub = 0;
		a = '0;
		b = '0;
		@(posedge clk);
		@(posedge clk);
		reset = 0;
		@(posedge clk);
		apply_op(4'd3, 4'd5, 1'b1);
		apply_op(4'd9, 4'd2, 1'b0);
		apply_op(4'd15, 4'd1, 1'b1);
		apply_op(4'd2, 4'd7, 1'b0);
		#20;
		$display("[%0t] Simulation finished", $time);
		$stop;
	end
endmodule