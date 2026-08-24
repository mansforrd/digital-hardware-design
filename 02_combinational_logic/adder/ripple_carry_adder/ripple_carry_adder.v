module ripple_carry_adder (
	

	input [3:0] a,
	input [3:0] b,
	input Cin,
	output [3:0] sum,
	output Cout
);

	wire [2:0] c;

	full_adder FA0 (.a(a[0]), .b(b[0]), .Cin(Cin), .sum(sum[0]), .Cout(c[0]));
	full_adder FA1 (.a(a[1]), .b(b[1]), .Cin(c[0]), .sum(sum[1]), .Cout(c[1]));
	full_adder FA2 (.a(a[2]), .b(b[2]), .Cin(c[1]), .sum(sum[2]), .Cout(c[2]));
	full_adder FA3 (.a(a[3]), .b(b[3]), .Cin(c[2]), .sum(sum[3]), .Cout(Cout));

endmodule
