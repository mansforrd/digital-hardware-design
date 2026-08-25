module smart_intersection (
    input clk,
    input rst,
    input sensor_N, sensor_S, sensor_E, sensor_W,
    input ped_request,
    input [1:0] emergency_dir,

    output reg [1:0] N_light, S_light, E_light, W_light,
    output reg walk_signal
);

    
    parameter NS_GREEN    = 3'b000;
    parameter NS_YELLOW   = 3'b001;
    parameter ALL_RED     = 3'b010;
    parameter EW_GREEN    = 3'b011;
    parameter EW_YELLOW   = 3'b100;
    parameter PED_WALK    = 3'b101;
    parameter EMERGENCY   = 3'b110;

    
    parameter RED    = 2'b00;
    parameter YELLOW = 2'b01;
    parameter GREEN  = 2'b10;

    
    parameter NS_MIN_GREEN   = 10;
    parameter NS_MAX_GREEN   = 30;
    parameter EW_MIN_GREEN   = 10;
    parameter EW_MAX_GREEN   = 30;
    parameter YELLOW_DUR     = 3;
    parameter ALL_RED_DUR    = 2;
    parameter WALK_DUR       = 15;
    parameter EMERGENCY_MIN  = 8;

    
    reg [2:0] current_state, next_state;
    reg [7:0] timer;
    reg last_served;

    
    wire traffic_NS = sensor_N | sensor_S;
    wire traffic_EW = sensor_E | sensor_W;
    wire emergency_active = (emergency_dir != 2'b00);

   


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
            
            if (current_state == NS_GREEN) last_served <= 0;
            if (current_state == EW_GREEN) last_served <= 1;
        end
        else begin
            timer <= timer + 1;
        end
    end

   
    
    always @(*) begin
        
        N_light = RED; S_light = RED; E_light = RED; W_light = RED;
        walk_signal = 0;

        case (current_state)
            NS_GREEN: begin
                N_light = GREEN; S_light = GREEN;
            end
            NS_YELLOW: begin
                N_light = YELLOW; S_light = YELLOW;
            end
            EW_GREEN: begin
                E_light = GREEN; W_light = GREEN;
            end
            EW_YELLOW: begin
                E_light = YELLOW; W_light = YELLOW;
            end
            PED_WALK: begin
                walk_signal = 1;   
            end
            EMERGENCY: begin
                if (emergency_dir == 2'b01) begin
                    N_light = GREEN; S_light = GREEN;
                end
                else if (emergency_dir == 2'b10) begin
                    E_light = GREEN; W_light = GREEN;
                end
            end
            
        endcase
    end

    
    always @(*) begin
        next_state = current_state; 

        
        if (emergency_active && current_state != EMERGENCY) begin
            next_state = EMERGENCY;
        end
        else begin
            case (current_state)

                NS_GREEN: begin
                    if (timer >= NS_MIN_GREEN && ped_request)
                        next_state = NS_YELLOW;
                    else if (timer >= NS_MIN_GREEN && traffic_EW && !traffic_NS)
                        next_state = NS_YELLOW;
                    else if (timer >= NS_MAX_GREEN)
                        next_state = NS_YELLOW;
                end

                NS_YELLOW: begin
                    if (timer >= YELLOW_DUR)
                        next_state = ALL_RED;
                end

                EW_GREEN: begin
                    if (timer >= EW_MIN_GREEN && ped_request)
                        next_state = EW_YELLOW;
                    else if (timer >= EW_MIN_GREEN && traffic_NS && !traffic_EW)
                        next_state = EW_YELLOW;
                    else if (timer >= EW_MAX_GREEN)
                        next_state = EW_YELLOW;
                end

                EW_YELLOW: begin
                    if (timer >= YELLOW_DUR)
                        next_state = ALL_RED;
                end

                ALL_RED: begin
                    if (timer >= ALL_RED_DUR) begin
                        if (ped_request)
                            next_state = PED_WALK;
                        else if (traffic_NS && !traffic_EW)
                            next_state = NS_GREEN;
                        else if (traffic_EW && !traffic_NS)
                            next_state = EW_GREEN;
                        else begin
                            
                            next_state = (last_served == 0) ? EW_GREEN : NS_GREEN;
                        end
                    end
                end

                PED_WALK: begin
                    if (timer >= WALK_DUR)
                        next_state = ALL_RED;
                end

                EMERGENCY: begin
                    if (!emergency_active && timer >= EMERGENCY_MIN)
                        next_state = ALL_RED;
                end

                default: next_state = ALL_RED;
            endcase
        end
    end

endmodule
