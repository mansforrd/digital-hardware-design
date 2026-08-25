module asyn_flip_flop (
	input clk,
	input D,
	input rst,
	output reg Q
);

	always @(posedge clk or posedge rst) begin
		if (rst)
		Q <= 1'b0;
		

		else
		Q <= D;

	end 

endmodule
