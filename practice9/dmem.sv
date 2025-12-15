module dmem(input logic clk, we, reset,
			input logic [31:0] a, wd,
			output logic [31:0] rd,
			output logic irrigation_active, ventilation_active);

    logic [31:0] RAM[63:0];
    
    logic [31:0] peripheral_config;
    logic [31:0] peripheral_status;
    
    logic peripheral_irrigation;
    logic peripheral_ventilation;
    
    initial begin
        $readmemh("C:/Users/Vasenka88/AppData/Local/quartus/practice9/test.data", RAM);
    end
    
    peripheral periph (
        .clk(clk),
        .reset(reset),
        .config_reg(peripheral_config),
        .status_reg(peripheral_status),
        .irrigation_active(peripheral_irrigation),
        .ventilation_active(peripheral_ventilation)
    );
    
    assign irrigation_active = peripheral_irrigation;
    assign ventilation_active = peripheral_ventilation;
    
    always_comb begin
        if (a == 32'h100) begin
            rd = peripheral_config;
        end else if (a == 32'h104) begin
            rd = peripheral_status;
        end else begin
            rd = RAM[a[31:2]];
        end
    end
    
    always_ff @(posedge clk) begin
        if (reset) begin
            peripheral_config <= 32'h0;
        end else if (we) begin
            if (a == 32'h100) begin
                peripheral_config <= wd;
            end else begin
                RAM[a[31:2]] <= wd;
            end
        end
    end
endmodule