`timescale 1ns / 1ps
module spi_system_tb;

	// Inputs
	reg clk;
	reg reset;
	reg start;
	reg [7:0] data_in;

	// Outputs
	wire mosi;
	wire sclk;
	wire ss;
	wire [7:0] data_out;

	// Instantiate the Unit Under Test (UUT)
	
	spi_master_fsm master(
	
	    .clk(clk),
		 .reset(reset),
		 .start(start),
		 .data_in(data_in),
		 .mosi(mosi),
		 .sclk(sclk),
		 .ss(ss)
		 
		 );
		 
	spi_slave slave (
		.sclk(sclk), 
		.reset(reset), 
		.ss(ss), 
		.mosi(mosi), 
		.data_out(data_out)
	);

	initial begin
		// Initialize Inputs
		clk = 0;
		forever #5 clk = ~clk;
		end
		initial
		begin
		  reset = 1;
		  start = 0;
		  data_in = 8'b10110011;
		  #20;
		  reset = 0;
		  #10;
		  start = 1;
		  #100;
		  start = 0;
		  #5000;
		  $finish;
		  
	end
      
endmodule

