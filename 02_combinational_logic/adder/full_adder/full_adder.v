module full_adder (

	input a,
	input b,
	input Cin,
	output sum,
	output Cout
);
	

	assign sum = a ^ b ^ Cin;
	assign Cout = a & b | a & Cin | b & Cin;

endmodule
