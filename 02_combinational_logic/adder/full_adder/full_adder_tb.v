`timescale 1ns/1ps

module full_adder_tb;

	reg a, b, Cin;
	wire sum, Cout;


	full_adder uut (
		.a(a),
		.b(b),
		.Cin(Cin),
		.sum(sum),
		.Cout(Cout)
);

	initial begin

	$dumpfile("full_adder.vcd");
	$dumpvars(0, full_adder_tb);
	

	$display(" A | B | Cin | sum | Cout");

	a = 0; b = 0; Cin = 0; #10;
	$display(" %b | %b | %b | %b | %b ", a, b, Cin, sum, Cout);

	a = 0; b = 0; Cin = 1; #10;
	$display(" %b | %b | %b | %b | %b ", a, b, Cin, sum, Cout);

	a = 0; b = 1; Cin = 0; #10;
	$display(" %b | %b | %b | %b | %b ", a, b, Cin, sum, Cout);

	a = 0; b = 1; Cin = 1; #10;
	$display(" %b | %b | %b | %b | %b ", a, b, Cin, sum, Cout);

	a = 1; b = 0; Cin = 0; #10;
	$display(" %b | %b | %b | %b | %b ", a, b, Cin, sum, Cout);

	a = 1; b = 0; Cin = 1; #10;
	$display(" %b | %b | %b | %b | %b ", a, b, Cin, sum, Cout);

	a = 1; b = 1; Cin = 0; #10;
	$display(" %b | %b | %b | %b | %b ", a, b, Cin, sum, Cout);

	a = 1; b = 1; Cin = 1; #10;
	$display(" %b | %b | %b | %b | %b ", a, b, Cin, sum, Cout);

$finish;

end

endmodule	
