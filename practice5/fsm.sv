module fsm(input logic clk, reset, ready, add_sub, 
			input logic [3:0] a,
			input logic [3:0] b,
			output logic [3:0] out_res, out_valid);
	typedef enum logic [1:0] {INIT, RDY, ADD, SUB} statetype;

	statetype state, nextstate;
	// state register
	always_ff @(posedge clk, posedge reset)
		if (reset) state <= INIT;
		else state <= nextstate;
	// next state logic
	always_comb begin
		nextstate = state; 
		out_valid = 1'b0;
		out_res = '0;

		case (state)
			INIT: if (ready) nextstate = RDY;
				else nextstate = INIT;
			RDY: if (add_sub) nextstate = ADD;
				  else nextstate = SUB;

			ADD: begin 
				out_valid = 1'b1; 
				out_res = a + b; 
				nextstate = INIT;
			end
			SUB: begin
				out_valid = 1'b1; 
				out_res = a - b; 
				nextstate = INIT;
			end

			default: nextstate = INIT;
		endcase
	end
endmodule