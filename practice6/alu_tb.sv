`timescale 1ns/1ps

module alu_tb;
    logic [31:0] A;
    logic [31:0] B;
    logic [2:0]  ALUControl;

    logic [32:0] Result;
    logic Z;
    logic N;
    logic C;
    logic V;

    alu DUT (
        .A(A),
        .B(B),
        .ALUControl(ALUControl),
        .Result(Result),
        .Z(Z),
        .N(N),
        .C(C),
        .V(V)
    );

    initial begin
        // ADD (000)
        ALUControl = 3'b000; A = 32'd0; B = 32'd0; #10; // 0 + 0 = 0
        ALUControl = 3'b000; A = 32'd1; B = 32'd2; #10; // 1 + 2 = 3
        ALUControl = 3'b000; A = 32'h7FFF_FFFF; B = 32'd1; #10; // overflow, V=1
        ALUControl = 3'b000; A = 32'hFFFF_FFFF; B = 32'd1; #10; // carry out, C=1
        ALUControl = 3'b000; A = 32'h8000_0000; B = 32'h8000_0000; #10; // n + n => overflow

        // SUB (001)
        ALUControl = 3'b001; A = 32'd5; B = 32'd3; #10; // 5 - 3 = 2
        ALUControl = 3'b001; A = 32'd3; B = 32'd5; #10; // 3 - 5 = -2, borrow (C=0)
        ALUControl = 3'b001; A = 32'd10; B = 32'd10; #10; // zero result
        ALUControl = 3'b001; A = 32'h8000_0000; B = 32'd1; #10; // overflow, V=1
        ALUControl = 3'b001; A = 32'h0000_0000; B = 32'hFFFF_FFFF; #10; // 0 - (-1) = 1

        // AND (010)
        ALUControl = 3'b010; A = 32'hFFFF_0000; B = 32'h0F0F_F0F0; #10; // mask upper/lower
        ALUControl = 3'b010; A = 32'hAAAA_AAAA; B = 32'hF0F0_F0F0; #10; // pattern
        ALUControl = 3'b010; A = 32'h0000_0000; B = 32'hFFFF_FFFF; #10; // zero

        // OR (011)
        ALUControl = 3'b011; A = 32'h0000_0000; B = 32'h1234_5678; #10; // passthrough B
        ALUControl = 3'b011; A = 32'h0F0F_0F0F; B = 32'hF0F0_F0F0; #10; // all ones
        ALUControl = 3'b011; A = 32'h0000_0000; B = 32'h0000_0000; #10; // zero

        // SLT (101)
        ALUControl = 3'b101; A = 32'd1; B = 32'd2; #10; // 1 < 2 => 1
        ALUControl = 3'b101; A = 32'd2; B = 32'd1; #10; // 2 < 1 => 0
        ALUControl = 3'b101; A = 32'hFFFF_FFFF; B = 32'd0; #10; // unsigned.max < 0 => 0
        ALUControl = 3'b101; A = 32'd0; B = 32'd0; #10; // equal => 0

        $stop;
    end
endmodule