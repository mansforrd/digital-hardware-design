`timescale 1ns/1ps

module gates_tb;

	reg a,b;
	wire out_and, out_or, out_not;
	wire out_xor, out_nand, out_nor, out_xnor;

	

	gates uut (
		.a(a),
		.b(b),
		.out_and(out_and),
		.out_or(out_or),
		.out_not(out_not),
		.out_xor(out_xor),
		.out_nand(out_nand),
		.out_nor(out_nor),
		.out_xnor(out_xnor)
);

	initial begin
		a = 0; b = 0; #10;
		$display(" %b | %b | %b | %b | %b | %b | %b | %b | %b ",
		a, b, out_and, out_or, out_not, out_xor, out_nand, out_nor, out_xnor);
		

		a = 0; b = 1; #10;
		$display(" %b | %b | %b | %b | %b | %b | %b | %b | %b ",
                a, b, out_and, out_or, out_not, out_xor, out_nand, out_nor, out_xnor);

		a = 1; b = 0; #10;
		$display(" %b | %b | %b | %b | %b | %b | %b | %b | %b ",
                a, b, out_and, out_or, out_not, out_xor, out_nand, out_nor, out_xnor);

		a = 1; b = 1; #10;
		$display(" %b | %b | %b | %b | %b | %b | %b | %b | %b ",
                a, b, out_and, out_or, out_not, out_xor, out_nand, out_nor, out_xnor);

		$finish;
	

	end

endmodule
