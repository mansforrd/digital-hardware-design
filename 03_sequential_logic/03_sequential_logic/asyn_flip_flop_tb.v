`timescale 1ns/1ps

module asyn_flip_flop_tb;

	reg clk;
	reg D;
	reg rst;
	wire Q;

asyn_flip_flop uut (
	.clk(clk),
	.D(D),
	.rst(rst),
	.Q(Q)
);

	initial begin
		clk = 0;
	forever #5 clk = ~clk;
end

	initial begin
	$dumpfile("asyn_flip_flop.vcd");
	$dumpvars(0, asyn_flip_flop_tb);
	$monitor(" %0t | %b | %b | %b | %b |", $time,  clk, D, rst, Q);

	

	rst = 1; D = 0;
	#8 rst = 0; D = 1; 
	#10 D = 0;
	#3 rst = 1;
	#4 rst = 0;
	#10 D = 1;
	#10 $finish;
end

endmodule

