`timescale 1ns / 1ps

module clock_divider_tb;

	// Inputs
	reg clk;
	reg reset;

	// Outputs
	wire sclk;

	// Instantiate the Unit Under Test (UUT)
	clock_divider uut (
		.clk(clk), 
		.reset(reset), 
		.sclk(sclk)
	);

	initial begin
		// Initialize Inputs
		clk = 0;
		forever #5 clk = ~clk;
		end
		initial
		begin
		reset = 1;
		#20;
		reset = 0;

		// Wait 100 ns for global reset to finish
		#200;
      $finish;
		// Add stimulus here

	end
      
endmodule

