`timescale 1ns/1ps

module d_flip_flop_tb;

	reg clk;
	reg D;
	wire Q;


d_flip_flop uut (
	.clk(clk),
	.D(D),
	.Q(Q)
);

	initial begin
		clk = 0;
	forever #2 clk = ~clk;

end


	initial begin
	$dumpfile("d_flip_flop.vcd");
	$dumpvars(0, d_flip_flop_tb);
	$display(" time | clk | D | Q |");
	$monitor(" %0t | %b | %b | %b |", $time, clk, D, Q);

		D = 0;
		#3 D = 1;
		#4 D = 0;
		#4 D = 1;
		#4 D = 0;
		#6 $finish;
	end

endmodule
