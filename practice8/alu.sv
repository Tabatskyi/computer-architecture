module alu (
	input logic [31:0] A,
	input logic [31:0] B,
	input logic [2:0] ALUControl, 
	output logic [32:0] Result,
	output logic Z, N, C, V
);
	logic [32:0] add_ext;
	logic [32:0] sub_ext; 
	logic [31:0] add_res, sub_res;

	assign add_ext = {1'b0, A} + {1'b0, B};
	assign add_res = add_ext[31:0];

	assign sub_ext = {1'b0, A} + {1'b0, ~B} + {{32{1'b0}}, 1'b1};
	assign sub_res = sub_ext[31:0];

	always_comb begin
		Result = 0;
		C = 1'b0;
		V = 1'b0;

		case (ALUControl)
			3'b000: begin
				Result = add_res;
				C = add_ext[32];
				V = (A[31] == B[31]) && (add_res[31] != A[31]);
			end
			3'b001: begin
				Result = sub_res;
				C = sub_ext[32];
				V = (A[31] != B[31]) && (sub_res[31] != A[31]);
			end
			3'b010: begin
				Result = A & B;
			end
			3'b011: begin
				Result = A | B;
			end
			3'b101: begin
				Result = {{(32-1){1'b0}}, $signed(A) < $signed(B)};
			end
			default: begin
				Result = 0;
			end
		endcase

		N = Result[31];
		Z = (Result == 0);
	end

endmodule