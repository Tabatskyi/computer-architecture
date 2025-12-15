module testbench();
logic clk;
	logic reset;
	logic [31:0] WriteData, DataAdr, Instr;
	logic MemWrite;
	logic irrigation_active;
	logic ventilation_active;
	
	top dut (
		.clk(clk),
		.reset(reset),
		.WriteData(WriteData),
		.DataAdr(DataAdr),
		.Instr(Instr),
		.MemWrite(MemWrite),
		.irrigation_active(irrigation_active),
		.ventilation_active(ventilation_active)
	);
	
	always begin
		clk <= 1; #5; clk <= 0; #5;
	end
	
	logic [31:0] prev_DataAdr;
	logic prev_MemWrite;
	int config_writes = 0;
	int status_reads = 0;
	
	always @(posedge clk) begin
		if (MemWrite && DataAdr == 32'h100) begin
			config_writes++;
			$display("[%0t] CPU writes to CONFIG register: 0x%h", $time, WriteData);
			$display("  Enable: %b, State1: %0d, Pause1: %0d, State3: %0d, Pause2: %0d",
					WriteData[0], WriteData[8:1], WriteData[16:9], 
					WriteData[24:17], WriteData[31:25]);
		end
		
		if (!MemWrite && DataAdr == 32'h104) begin
			if (DataAdr != prev_DataAdr || !prev_MemWrite) begin
				status_reads++;
				if (status_reads % 100 == 1) begin
					$display("[%0t] CPU reads STATUS register (read #%0d)", $time, status_reads);
				end
			end
		end
		
		prev_DataAdr = DataAdr;
		prev_MemWrite = MemWrite;
	end
	
	logic [2:0] prev_state;
	initial prev_state = 3'b000;
	
	always @(posedge clk) begin
		if (dut.dmem.periph.current_state != prev_state) begin
			$display("[%0t] FSM State Change: %b -> %b", 
					$time, 
					prev_state,
					dut.dmem.periph.current_state);
			$display("  Irrigation: %b, Ventilation: %b, Done: %b",
					irrigation_active, ventilation_active, 
					dut.dmem.peripheral_status[0]);
			prev_state = dut.dmem.periph.current_state;
		end
	end
	
	initial begin
		$display("Starting Peripheral Integration Test");
		
		reset = 1;
		#100;
		reset = 0;
		
		$display("[%0t] Reset released, CPU starting execution\n", $time);
		
		wait(dut.dmem.RAM[32'h80 >> 2] == 32'h55);
		#1000;
		$display("Test completed successfully!");
		$display("Total config writes: %0d", config_writes);
		$display("Total status reads: %0d", status_reads);
		$stop;
	end
endmodule