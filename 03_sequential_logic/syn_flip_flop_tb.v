`timescale 1ns/1ps

module syn_flip_flop_tb;

	reg clk;
	reg rst;
	reg D;
	wire Q;

syn_flip_flop uut (
	.clk(clk),
	.rst(rst),
	.D(D),
	.Q(Q)
);

	initial begin
	clk = 0;
	forever #5 clk = ~clk;
end

	initial begin
	$dumpfile("syn_flip_flop.vcd");
	$dumpvars(0, syn_flip_flop_tb);
	$monitor(" %0t | clk=%b | rst=%b | D=%b | Q=%b |", $time, clk, rst, D, Q);
end
	
	initial begin	
	rst = 0; D = 0;

	#7 D =1;
	#5 rst = 1;
	#5 rst = 0;
	#10 D = 1;
	#20 $finish;


end
endmodule
