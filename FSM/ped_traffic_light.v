module ped_traffic_light(
	input clk,
	input rst,
	input ped_button_pressed,	
	output reg [1:0] light,
	output reg walk_signal
);

	parameter RED    = 2'b00;
	parameter GREEN  = 2'b01;
	parameter YELLOW = 2'b10;
	parameter WALK   = 2'b11;

	parameter LIGHT_RED    = 2'b00;
	parameter LIGHT_GREEN  = 2'b01;
	parameter LIGHT_YELLOW = 2'b10;

	parameter RED_DURATION       = 20;
	parameter GREEN_MIN_DURATION = 15;
	parameter GREEN_MAX_DURATION = 40;
	parameter YELLOW_DURATION    = 5;
	parameter WALK_DURATION      = 15;

	reg [1:0] current_state, next_state;
	reg [7:0] timer;
	reg ped_request;


	always @(posedge clk) begin
		if (rst)
			current_state  <= RED;
		else
			current_state <= next_state;
	end

	

	always @(posedge clk) begin
		if (rst) begin
			timer <= 0;
			ped_request <= 0;
	end

	else if (current_state != next_state) begin
		timer <= 0;
	if (next_state == GREEN)
		ped_request <= 0;
	end
	else begin
		timer <= timer + 1;
	if (current_state == GREEN && ped_button_pressed)
		ped_request <= 1;
	end
end

	always @(*) begin
		light       = LIGHT_RED;
		walk_signal = 0;

	case (current_state)
		RED: light = LIGHT_RED;
		GREEN: light = LIGHT_GREEN;
		YELLOW: light = LIGHT_YELLOW;
		WALK: begin
			light  = LIGHT_RED;
			walk_signal = 1;
		end
	endcase
end


	always @(*) begin
		next_state = current_state;
		
		case (current_state)
            RED: begin
                if (timer == RED_DURATION)
                    next_state = GREEN;
            end

            GREEN: begin
                if (timer >= GREEN_MIN_DURATION && ped_request)
                    next_state = YELLOW;
                else if (timer == GREEN_MAX_DURATION)
                    next_state = YELLOW;
            end

            YELLOW: begin
                if (timer == YELLOW_DURATION)
                    next_state = WALK;
            end

            WALK: begin
                if (timer == WALK_DURATION)
                    next_state = RED;
            end

            default: next_state = RED;
        endcase
    end

endmodule
