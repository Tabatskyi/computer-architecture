`timescale 1ns/1ps
module fsm_tb;
	// Testbench signals
	logic clk;
	logic reset;
	logic a;
	logic smile;
	// Instantiate the FSM
	fsm uut (
		.clk(clk),
		.reset(reset),
		.a(a),
		.smile(smile)
	);
	// Clock generation: 10 ns period
	always #5 clk = ~clk;
	// Stimulus
	initial begin
		// Initialize
		clk = 0;
		reset = 1;
		a = 0;
		// Apply reset
		$display("[%0t] Reset applied", $time);
		#12;
		reset = 0;
		// expect move S0 → S1 at the nearest posedge
		// Drive input pattern
		$display("[%0t] Starting input sequence", $time);
		#10 a = 0; // expect remain S1
		#10 a = 1; // expect move S1 → S2, smile = 1
		#10 a = 1; // expect move S2 → S0, smile = 0
		#10 a = 0; // expect move S0 → S1
		#10 a = 0; // expect remain S1
		#10 a = 1; // expect S1 → S2, smile = 1
		#10 a = 0; // expect S2 → S1, smile = 0
		#10 a = 1; // expect S1 → S2, smile = 1
		#10 a = 1; // expect S2 → S0
		// End simulation
		#20;
		$display("[%0t] Simulation finished", $time);
		$stop;
	end
endmodule