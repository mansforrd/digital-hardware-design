`timescale 1ns/1ps

module counter_tb;
	reg clk;
	reg rst;
	wire [3:0] Q;

counter uut (
	.clk(clk),
	.rst(rst),
	.Q(Q)
);

	initial begin
		clk = 0;
	forever #5 clk = ~clk;

end

	initial begin
	$dumpfile("counter.vcd");
	$dumpvars(0, counter_tb);
	$monitor(" %0t | clk=%b | rst=%b | Q=%b |", $time, clk, rst, Q);

		rst = 1;
		#12 rst = 0;
		#200 $finish;

end

endmodule

	
