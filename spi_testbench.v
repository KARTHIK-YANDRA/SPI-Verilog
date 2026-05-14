`timescale 1ns / 1ps
module spi_master_tb;

	// Inputs
	reg clk;
	reg reset;
	reg start;
	reg [7:0] data_in;

	// Outputs
	wire mosi;
	wire sclk;
	wire ss;

	// Instantiate the Unit Under Test (UUT)
	spi_master uut (
		.clk(clk), 
		.reset(reset), 
		.start(start), 
		.data_in(data_in), 
		.mosi(mosi), 
		.sclk(sclk), 
		.ss(ss)
	);

	initial begin
		// Initialize Inputs
		clk = 0;
		forever #5 clk = ~clk;
		end
		
		initial begin
		reset = 1;
		start = 0;
		data_in = 8'b10110011;
		#20;
		reset = 0;
		#10;
		start = 1;
		#100;
		start = 0;
		#50;
		$finish;
		end
		
      
endmodule

