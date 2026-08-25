`timescale 1ns/1ps
module smart_intersection_tb;
    reg clk;
    reg rst;
    reg sensor_N, sensor_S, sensor_E, sensor_W;
    reg ped_request;
    reg [1:0] emergency_dir;

    wire [1:0] N_light, S_light, E_light, W_light;
    wire walk_signal;

    integer log_file;

    smart_intersection uut (
        .clk(clk),
        .rst(rst),
        .sensor_N(sensor_N), .sensor_S(sensor_S),
        .sensor_E(sensor_E), .sensor_W(sensor_W),
        .ped_request(ped_request),
        .emergency_dir(emergency_dir),
        .N_light(N_light), .S_light(S_light),
        .E_light(E_light), .W_light(W_light),
        .walk_signal(walk_signal)
    );

    initial begin
        clk = 0;
        forever #5 clk = ~clk;
    end

    
    always @(posedge clk) begin
        if (log_file)
            $fdisplay(log_file, "%0t,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b",
                      $time, uut.current_state, N_light, S_light, E_light, W_light, walk_signal,
                      sensor_N, sensor_S, sensor_E, sensor_W,
                      ped_request, emergency_dir);
    end

    initial begin
        $dumpfile("smart_intersection.vcd");
        $dumpvars(0, smart_intersection_tb);

        log_file = $fopen("intersection_log.csv", "w");
        $fdisplay(log_file, "time,current_state,N_light,S_light,E_light,W_light,walk_signal,sensor_N,sensor_S,sensor_E,sensor_W,ped_request,emergency_dir");

        rst = 1;
        sensor_N = 0; sensor_S = 0; sensor_E = 0; sensor_W = 0;
        ped_request = 0;
        emergency_dir = 2'b00;
        #12 rst = 0;

        
        #8 sensor_N = 1;
        #200 ;

        
        #8 sensor_E = 1; sensor_N = 0;
        #200 ;

        
        #8 ped_request = 1;
        #300 ;             
        ped_request = 0;
        #200 ;

        
        #8 emergency_dir = 2'b01;
        #150 ;
        #8 emergency_dir = 2'b00;
        #150 ;

        $fclose(log_file);
        $finish;
    end

endmodule
