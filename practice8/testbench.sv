module testbench();
logic clk;
logic reset;
logic [31:0] WriteData, DataAdr, Instr;
logic MemWrite;
localparam int NUM_EVENTS = 5;
localparam logic [31:0] expected_addr [0:NUM_EVENTS-1] = '{32'd40, 32'd44, 32'd48, 32'd52, 32'd56};
localparam logic signed [31:0] expected_data [0:NUM_EVENTS-1] = '{32'sd5, 32'sd4, 32'sd2, 32'sd0, 32'sd8};
integer event_idx;
// instantiate device to be tested
top dut(clk, reset, WriteData, DataAdr, Instr, MemWrite);
// initialize test
initial begin
	reset <= 1; #22; reset <= 0;
	event_idx = 0;
end
// generate clock to sequence tests
always begin
	clk <= 1; #5; clk <= 0; #5;
end
// check results
always @(negedge clk) begin
	if (reset) begin
		event_idx <= 0;
	end else if (MemWrite) begin
		if ((event_idx < NUM_EVENTS) &&
			(DataAdr === expected_addr[event_idx]) &&
			(WriteData === expected_data[event_idx])) begin
			if (event_idx == NUM_EVENTS - 1) begin
				$display("Simulation succeeded");
				$stop;
			end else begin
				event_idx <= event_idx + 1;
			end
		end else begin
			$display("Simulation failed at write %0d: expected addr=%0d data=%0d but got addr=%0d data=%0d",
				event_idx,
				expected_addr[event_idx < NUM_EVENTS ? event_idx : NUM_EVENTS-1],
				expected_data[event_idx < NUM_EVENTS ? event_idx : NUM_EVENTS-1],
				DataAdr, WriteData);
			$stop;
		end
	end
end
endmodule