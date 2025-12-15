module peripheral(
	input logic clk, reset,
	input logic [31:0] config_reg,
	output logic [31:0] status_reg,
	output logic irrigation_active,  ventilation_active
);

	typedef enum logic [2:0] {
		IDLE = 3'b000,
		STATE1 = 3'b001,  // irrigation
		STATE2_PAUSE1 = 3'b010,
		STATE3 = 3'b011,  // ventilation
		STATE2_PAUSE2 = 3'b100,
		END = 3'b101
	} state_t;

	state_t current_state, next_state;

	logic enable;
	logic [7:0] state1_duration;
	logic [7:0] state2_pause1_duration;
	logic [7:0] state3_duration;
	logic [6:0] state2_pause2_duration;

	logic done;

	logic [7:0] timer;
	logic [7:0] duration_target;

	assign enable = config_reg[0];
	assign state1_duration = config_reg[8:1];
	assign state2_pause1_duration = config_reg[16:9];
	assign state3_duration = config_reg[24:17];
	assign state2_pause2_duration = config_reg[31:25];

	always_ff @(posedge clk or posedge reset) begin
		if (reset) begin
			current_state <= IDLE;
		end else begin
			current_state <= next_state;
		end
	end

	always_ff @(posedge clk or posedge reset) begin
		if (reset) begin
			timer <= 8'd0;
		end else begin
			if (current_state != next_state) begin
				timer <= 8'd0;
			end else if (timer < duration_target) begin
				timer <= timer + 8'd1;
			end
		end
	end

	always_comb begin
		next_state = current_state;
		duration_target = 8'd0;

		case (current_state)
			IDLE: begin
				duration_target = 8'd0;
				if (enable) begin
					next_state = STATE1;
				end
			end

			STATE1: begin
				duration_target = state1_duration;
				if (timer >= duration_target && duration_target > 0) begin
					next_state = STATE2_PAUSE1;
				end else if (duration_target == 0) begin
					next_state = STATE2_PAUSE1;
				end
			end

			STATE2_PAUSE1: begin
				duration_target = state2_pause1_duration;
				if (timer >= duration_target && duration_target > 0) begin
					next_state = STATE3;
				end else if (duration_target == 0) begin
					next_state = STATE3;
				end
			end

			STATE3: begin
				duration_target = state3_duration;
				if (timer >= duration_target && duration_target > 0) begin
					next_state = STATE2_PAUSE2;
				end else if (duration_target == 0) begin
					next_state = STATE2_PAUSE2;
				end
			end

			STATE2_PAUSE2: begin
				duration_target = {1'b0, state2_pause2_duration};
				if (timer >= duration_target && duration_target > 0) begin
					next_state = END;
				end else if (duration_target == 0) begin
					next_state = END;
				end
			end

			END: begin
				duration_target = 8'd0;
				if (!enable) begin
					next_state = IDLE;
				end
			end

			default: begin
				next_state = IDLE;
			end
		endcase
	end

	always_comb begin
		case (current_state)
			IDLE: begin
				done = 1'b0;
				irrigation_active = 1'b0;
				ventilation_active = 1'b0;
			end

			STATE1: begin
				done = 1'b0;
				irrigation_active = 1'b1;
				ventilation_active = 1'b0;
			end

			STATE2_PAUSE1: begin
				done = 1'b0;
				irrigation_active = 1'b0;
				ventilation_active = 1'b0;
			end

			STATE3: begin
				done = 1'b0;
				irrigation_active = 1'b0;
				ventilation_active = 1'b1;
			end

			STATE2_PAUSE2: begin
				done = 1'b0;
				irrigation_active = 1'b0;
				ventilation_active = 1'b0;
			end

			END: begin
				done = 1'b1;
				irrigation_active = 1'b0;
				ventilation_active = 1'b0;
			end

			default: begin
				done = 1'b0;
				irrigation_active = 1'b0;
				ventilation_active = 1'b0;
			end
		endcase
	end

	assign status_reg = {24'd0, current_state, ventilation_active, irrigation_active, done};

endmodule