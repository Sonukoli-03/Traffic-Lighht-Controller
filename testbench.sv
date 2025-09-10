`timescale 1ns / 1ps
module Traffic_Light_Controller_TB;

    reg clk, rst;
    wire [2:0] light_M1;
    wire [2:0] light_S;
    wire [2:0] light_MT;
    wire [2:0] light_M2;

    // Instantiate the DUT (Design Under Test)
    Traffic_Light_Controller dut (
        .clk(clk),
        .rst(rst),
        .light_M1(light_M1),
        .light_S(light_S),
        .light_MT(light_MT),
        .light_M2(light_M2)
    );

    // Clock Generation
    initial begin
        clk = 0;
        forever #5 clk = ~clk; // 10 ns clock period
    end

    // Generate VCD file for EPWave
    initial begin
        $dumpfile("dump.vcd");               // Create VCD file
        $dumpvars(0, Traffic_Light_Controller_TB); // Dump all signals
    end

    // Test sequence
    initial begin
        rst = 1;       // Assert reset
        #10 rst = 0;   // Deassert reset after 10ns

        // Run simulation for 300ns
        #300 $finish;
    end

endmodule
