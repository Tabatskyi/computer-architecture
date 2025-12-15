module top(input logic clk, reset,
            output logic [31:0] WriteData, DataAdr, Instr,
            output logic MemWrite, irrigation_active, ventilation_active);
    logic [31:0] PC, ReadData;
    // instantiate processor and memories
    riscvsingle rvsingle(clk, reset, PC, Instr, MemWrite,
            DataAdr, WriteData, ReadData);
    imem imem(PC, Instr);
    dmem dmem(clk, MemWrite, reset, DataAdr, WriteData, ReadData, irrigation_active, ventilation_active);
endmodule