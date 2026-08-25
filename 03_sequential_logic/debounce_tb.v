`timescale 1ns/1ps
module debounce_tb;
    reg clk;
    reg rst;
    reg noisy_input;
    wire clean_output;

    debounce uut (
        .clk(clk),
        .rst(rst),
        .noisy_input(noisy_input),
        .clean_output(clean_output)
    );

    // Clock generator: period 10
    initial begin
        clk = 0;
        forever #5 clk = ~clk;
    end

    initial begin
        $dumpfile("debounce.vcd");
        $dumpvars(0, debounce_tb);
        $monitor(" %0t | clk=%b | rst=%b | noisy=%b | clean=%b", $time, clk, rst, noisy_input, clean_output);

        rst = 1;
        noisy_input = 0;
        #12 rst = 0;

      
        
        #8  noisy_input = 1;   // t=20  bounce start
        #8  noisy_input = 0;   // t=28  bounce
        #8  noisy_input = 1;   // t=36  bounce
        #8  noisy_input = 0;   // t=44  bounce
        #8  noisy_input = 1;   // t=52  settles high from here on

        
        #250 ;  

        
        #8  noisy_input = 0;   // bounce
        #8  noisy_input = 1;   // bounce
        #8  noisy_input = 0;   // settles low

        #250 ; 

        $finish;
    end

endmodule
