`timescale 1ns/1ps

module uart_tb;

	reg clk;
	reg rst;
	reg start_send;
	reg [7:0] data_byte;
	wire tx_line;

	uart uut (
		.clk(clk),
		.rst(rst),
		.start_send(start_send),
		.data_byte(data_byte),
		.tx_line(tx_line)
);

	initial begin 
		clk = 0;
	forever #5 clk = ~clk;
end

	initial begin
	$dumpfile("uart.vcd");
	$dumpvars(0, uart_tb);
	$monitor("%0t | clk=%b | rst=%b | start=%b | tx_line=%b |", $time, clk, rst, start_send, tx_line);

	rst = 1;
	start_send = 0;
	data_byte = 8'b00000000;

	#12 rst = 0;


	#8 data_byte = 8'b10110010;
	#2 start_send = 1;
	#10 start_send = 0;


	#150;

	$finish;
end

endmodule
