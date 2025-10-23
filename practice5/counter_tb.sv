`timescale 1ns/1ps
module counter_tb;
	// Parameters (match counter instances)
	localparam int unsigned MAX1 = 10;
	localparam int unsigned MAX2 = 10;

	// Testbench signals
	logic clk;
	logic reset;
	logic is_limit1, is_limit2;

	counter #(.maxval(MAX1)) uut1 (
		.clk(clk),
		.reset(reset),
		.is_limit(is_limit1)
	);

	counter #(.maxval(MAX2)) uut2 (
		.clk(is_limit1),
		.reset(reset),
		.is_limit(is_limit2)
	);

	// Clock generation: 10 ns period = 100 MHz
	always #5 clk = ~clk;

	// Test sequence
	initial begin
		// Initialize signals
		clk = 0;
		reset = 0;

		// Apply reset
		$display("[%0t] Applying reset...", $time);
		reset = 1;
		#20;
		reset = 0;
		// Let counters run
		$display("[%0t] Counters running...", $time);
		#1000;
		// Reset again
		$display("[%0t] Resetting again...", $time);
		reset = 1;
		#15;
		reset = 0;
		// Run more
		#200;
		// End simulation
		$display("[%0t] Simulation finished.", $time);
		$stop;
	end
endmodule