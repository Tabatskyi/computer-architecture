`timescale 1ns/1ns
module priority_encoder_tb;
    logic [15:0] in;
    logic [3:0] idx;
    logic multi;

    priority_encoder DUT (
        .in(in),
        .idx(idx),
        .multi(multi)
    );

    initial begin
        in = 16'h0001; 
		  #10;
        in = 16'h0002;     
		  #10;
        in = 16'h0004;     
		  #10;
        in = 16'h0008;     
		  #10;
        in = 16'h0010;     
		  #10;
        in = 16'h0020;     
		  #10;
        in = 16'h0040;     
		  #10;
        in = 16'h0080;     
		  #10;
        in = 16'h0100;     
		  #10;
        in = 16'h0200;     
		  #10;
        in = 16'h0400;     
		  #10;
        in = 16'h0800;     
		  #10;
        in = 16'h1000;     
		  #10;
        in = 16'h2000;     
		  #10;
        in = 16'h4000;     
		  #10;
        in = 16'h8000;     
		  #10;
        in = 16'h1488;     
		  #10;
        in = 16'hFFFF;     
		  #10;
        in = 16'h8001;     
		  #10;
        in = 16'h00FF;     
		  #10;
        in = 16'h0A0A;     
		  #10;
        in = 16'h1488; 
		  #10;
        in = 16'h0000; 
		  #10;
        $stop;
    end
endmodule
