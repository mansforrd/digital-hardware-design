`timescale 1ns/1ps

module alu_tb;

	reg [3:0] a, b;
	reg [1:0] opcode;
	wire [3:0]  result;
	wire Cout;


	alu uut(
		.a(a),
		.b(b),
		.opcode(opcode),
		.result(result),
		.Cout(Cout)
);


	initial begin
	
	$dumpfile("alu.vcd");
	$dumpvars(0, alu_tb);

	$display(" A | B | opcode | result | Cout |");

	a = 4'b0111; b = 4'b0001; opcode = 2'b00; #10;
	$display(" %b | %b | %b | %b | %b |", a, b, opcode, result, Cout);

	a = 4'b0110; b = 4'b0101; opcode = 2'b00; #10;
	$display(" %b | %b | %b | %b | %b |", a, b, opcode, result, Cout);

	a = 4'b1000; b = 4'b0110; opcode = 2'b01; #10;
	$display(" %b | %b | %b | %b | %b |", a, b, opcode, result, Cout);

	a = 4'b0011; b = 4'b0100; opcode = 2'b01; #10;
	$display(" %b | %b | %b | %b | %b |", a, b, opcode, result, Cout);

	a = 4'b0101; b = 4'b0011; opcode = 2'b10; #10;
	$display(" %b | %b | %b | %b | %b |", a, b, opcode, result, Cout);

	a = 4'b0100; b = 4'b0100; opcode = 2'b11; #10;
	$display(" %b | %b | %b | %b | %b |", a, b, opcode, result, Cout);

$finish;

end

endmodule
