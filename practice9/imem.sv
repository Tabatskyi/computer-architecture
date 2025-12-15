module imem(input logic [31:0] a,
output logic [31:0] rd);
logic [31:0] RAM[127:0];
initial
$readmemh("C:/Users/Vasenka88/AppData/Local/quartus/practice9/test.text",RAM);
assign rd = RAM[a[31:2]]; // word aligned
endmodule