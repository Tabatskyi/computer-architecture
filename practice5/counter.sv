module counter
	#(parameter maxval = 10)
	(
		input clk,
		input reset,
		output logic is_limit
	);

	localparam [3:0] RESET_VAL = 4'd0;
	reg [3:0] cnt;

	always @(posedge clk or posedge reset) begin
		if (reset) begin
			cnt <= RESET_VAL;
			is_limit <= 1'b0;
		end 
		else if (cnt == maxval[3:0] - 4'd1) begin
			cnt <= RESET_VAL;
			is_limit <= 1'b1;
		end 
		else begin
			cnt <= cnt + 4'd1;
			is_limit <= 1'b0;
		end
	end
endmodule