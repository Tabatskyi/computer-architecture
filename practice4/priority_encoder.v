module priority_encoder(
  input [15:0] in,
  output reg [3:0] idx,
  output multi
);

integer ones;
integer i;

always@* begin
 ones = 0;
 idx = 4'd0;

 for (i = 0; i < 16; i = i + 1) begin
	if (in[i]) begin
		ones = ones + 1;
		idx = i[3:0];
	end
 end
end
assign multi = (ones > 1) ? 1'b1 : 1'b0;
endmodule
