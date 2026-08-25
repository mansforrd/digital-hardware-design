module two_road_intersection (
	input clk,
	input rst,
	input sensor_A,
	input sensor_B,
	output reg [1:0] roadA_light,
	output reg [1:0] roadB_light
);

	parameter A_GREEN = 3'b000;
	parameter A_YELLOW = 3'b001;
	parameter ALL_RED = 3'b010;
	parameter B_GREEN = 3'b011;
	parameter B_YELLOW = 3'b100;

	parameter RED = 2'b00;
	parameter YELLOW = 2'b01;
	parameter GREEN = 2'b10;

	parameter A_MIN_GREEN = 15;
	parameter A_MAX_GREEN = 40;
	parameter B_MIN_GREEN = 15;
	parameter B_MAX_GREEN = 40;
	parameter YELLOW_DUR  = 5;
	parameter ALL_RED_DUR = 3;

	reg [2:0] current_state, next_state;
	reg [7:0] timer;
	reg last_served;

	always @(posedge clk) begin
		if (rst)
			current_state <= ALL_RED;
		else
			current_state <= next_state;
	end


	always @(posedge clk) begin
		if (rst) begin
			timer <= 0;
			last_served <= 0;
		end
		else if (current_state != next_state) begin
			timer <= 0;
			if (current_state == A_GREEN) last_served <= 0;
			if (current_state == B_GREEN) last_served <= 1;
		end
		else begin
			timer <= timer + 1;
		end
	end

	

	always @(*) begin
		roadA_light = RED;
		roadB_light = RED;

		case (current_state)
			A_GREEN: roadA_light  = GREEN;
			A_YELLOW: roadA_light = YELLOW;
			B_GREEN: roadB_light  = GREEN;
			B_YELLOW: roadB_light = YELLOW;
		endcase
	end

	always @(*) begin
		next_state = current_state;

		case (current_state)
			A_GREEN: begin
				if (timer >= A_MIN_GREEN && sensor_B && !sensor_A)
					next_state = A_YELLOW;
				else if (timer >= A_MAX_GREEN)
					next_state = A_YELLOW;
			end

			A_YELLOW: begin
				if (timer >= YELLOW_DUR)
					next_state = ALL_RED;
			end

			ALL_RED: begin
				if (timer >= ALL_RED_DUR) begin
					if (sensor_A && !sensor_B)
						next_state = A_GREEN;
					else if (sensor_B && !sensor_A)
						next_state = B_GREEN;
					else
						next_state = (last_served == 0) ? B_GREEN : A_GREEN;
				end
			end

			B_GREEN: begin
				if (timer >= B_MIN_GREEN && sensor_A && !sensor_B)
					next_state = B_YELLOW;
				else if (timer >= B_MAX_GREEN)
					next_state = B_YELLOW;
			end

			B_YELLOW: begin
				if (timer >= YELLOW_DUR)
					next_state = ALL_RED;
			end

			default: next_state = ALL_RED;
		endcase
	end
endmodule
