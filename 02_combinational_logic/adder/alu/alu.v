module alu (
	input [3:0] a,
	input [3:0] b,
	input [1:0] opcode,
	output reg [3:0] result,
	output reg Cout
);

	wire sub = (opcode == 2'b01);
	wire [3:0] b_mod = b ^ {4{sub}};
	wire Cin = sub;
	
	wire [3:0] sum_result;
	wire Cout_result;
	

	ripple_carry_adder adder_unit(
		.a(a),
		.b(b_mod),
		.Cin(Cin),
		.sum(sum_result),
		.Cout(Cout_result)
);

	always @(*) begin
		case (opcode)
			2'b00: begin result = sum_result;
			Cout = Cout_result;
		end

			2'b01: begin result = sum_result;
			Cout = Cout_result;
		end

			2'b10: begin result = a & b;
			Cout = 1'b0;
		end

			2'b11: begin result = a | b;
			Cout = 1'b0;
		end
	endcase
end

endmodule
	

	
