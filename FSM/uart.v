module uart ( 
	input clk,
	input rst,
	input start_send,
	input [7:0] data_byte,
	output reg tx_line
);

	parameter IDLE = 2'b00;
	parameter START = 2'b01;
	parameter DATA = 2'b10;
	parameter STOP = 2'b11;

	reg [1:0] current_state, next_state;
	reg [2:0] bit_counter;
	reg [7:0] data_reg;

	always @(posedge clk) begin
		if (rst)
			current_state <= IDLE;
		else
			current_state <= next_state;
end


	always @(posedge clk) begin
		if (rst) begin
			bit_counter <= 0;
			data_reg    <= 0;
			tx_line     <= 1'b1;
	end
	else begin
		case (current_state)
			IDLE: begin
				tx_line <= 1'b1;
				if (start_send) begin
					data_reg    <= data_byte;
					bit_counter <= 0;
				end
			end
			

			START: begin
				tx_line <= 1'b0;
			end

			DATA: begin
				tx_line <= data_reg[bit_counter];
				bit_counter <= bit_counter + 1;
			end


			STOP: begin
				tx_line <= 1'b1;
			end
		endcase
	end
end

always @(*) begin
	case (current_state)
		IDLE: next_state = start_send ? START : IDLE;
		START: next_state = DATA;
		DATA: next_state = (bit_counter == 7) ? STOP : DATA;
		STOP: next_state = IDLE;
		default: next_state = IDLE;
	endcase
end

endmodule
