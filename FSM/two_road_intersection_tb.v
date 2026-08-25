`timescale 1ns/1ps

module two_road_intersection_tb;
	reg clk;
	reg rst;
	reg sensor_A;
	reg sensor_B;
	wire [1:0] roadA_light;
	wire [1:0] roadB_light;

two_road_intersection uut (
	.clk(clk),
	.rst(rst),
	.sensor_A(sensor_A),
	.sensor_B(sensor_B),
	.roadA_light(roadA_light),
	.roadB_light(roadB_light)
);

	initial begin
		clk = 0;
	forever #5 clk = ~clk;
end

	initial begin
$dumpfile("two_road_intersection.vcd");
$dumpvars(0, two_road_intersection_tb);
$monitor("%0t | clk=%b | rst=%b | state=%b | A_light=%b | B_light=%b | sensorA=%b | sensorB=%b |", $time, clk, rst, uut.current_state, roadA_light, roadB_light, sensor_A, sensor_B);

	rst = 1;
	sensor_A = 0; 
	sensor_B = 0;
	#12 rst = 0;



	#8 sensor_A = 1;
	#300;


	#8 sensor_B = 1;
	#8 sensor_A = 0;
	#300;


	#8 sensor_A = 1;
	#500;

	#8 sensor_A = 0;
	#8 sensor_B = 0;
	#500;

	#8 sensor_A = 0;
	#8 sensor_B = 0;
	#500;

	$finish;
end

endmodule


	
