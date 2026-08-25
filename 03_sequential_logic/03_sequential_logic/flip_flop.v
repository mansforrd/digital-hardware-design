
module d_flip_flop (
		input clk,
		input D,
		output reg Q
);

	always @(posedge clk) begin
		Q <= D;
	end

endmodule
