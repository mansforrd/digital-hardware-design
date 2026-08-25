`timescale 1ns/1ps

module ped_traffic_light_tb;

	reg clk;
	reg rst;
	reg ped_button_pressed;
	wire [1:0] light;
	wire walk_signal;

ped_traffic_light uut(
	.clk(clk),
	.rst(rst),
	.ped_button_pressed(ped_button_pressed),
	.light(light),
	.walk_signal(walk_signal)
);

	initial begin
	clk = 0;
	forever #5 clk = ~clk;
end

	initial begin
	$dumpfile("ped_traffic_light.vcd");
	$dumpvars(0, ped_traffic_light_tb);
	$monitor("%0t | clk=%b | rst=%b | state=%b | light=%b | walk=%b | button=%b |", $time, clk, rst,  uut.current_state, light, walk_signal, ped_button_pressed);

	rst = 1;
	ped_button_pressed = 0;
	#12 rst = 0;


	#210;


	#8 ped_button_pressed = 1;
	#10 ped_button_pressed = 0;
	#300;


	$finish;
end

endmodule


