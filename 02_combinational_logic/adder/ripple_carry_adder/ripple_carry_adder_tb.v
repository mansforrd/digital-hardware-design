`timescale 1ns/1ps

module ripple_carry_adder_tb;

	reg [3:0] a, b;
	wire [3:0] sum;
	wire Cout;

	ripple_carry_adder uut (

		.a(a),
		.b(b),
		.Cin(1'b0),
		.sum(sum),
		.Cout(Cout)
);

	initial begin
	$dumpfile("ripple_carry_adder.vcd");
	$dumpvars(0, ripple_carry_adder_tb);

	a = 0; b = 0; #10;
	$display(" %b | %b | %b | %b", a, b, sum, Cout);

	a = 0; b = 1; #10;
	$display(" %b | %b | %b | %b", a, b, sum, Cout);

	a = 1; b = 0; #10;
	$display(" %b | %b | %b | %b", a, b, sum, Cout);

	a = 1; b = 1; #10; 
	$display(" %b | %b | %b | %b", a, b, sum, Cout);

$finish;

end
endmodule


