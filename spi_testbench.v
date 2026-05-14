`timescale 1ns / 1ps
module spi_system_tb;

	// Inputs
	reg clk;
	reg reset;
	reg start;
	reg [7:0] master_data_in;
	reg [7:0] slave_data_in;

	// Outputs
	wire mosi;
	wire miso;
	wire sclk;
	wire ss;
	wire [7:0] master_data_out;
	wire [7:0] slave_data_out;

	// Instantiate the Unit Under Test (UUT)
	
	spi_master_fsm master(
	
	    .clk(clk),
		 .reset(reset),
		 .start(start),
		 .data_in(master_data_in),
		 .miso(miso),
		 .mosi(mosi),
		 .sclk(sclk),
		 .ss(ss),
		 .data_out(master_data_out)
		 
		 );
		 
	spi_slave slave (
		.sclk(sclk), 
		.reset(reset), 
		.ss(ss), 
		.mosi(mosi), 
		.data_in(slave_data_in),
		.miso(miso),
		.data_out(slave_data_out)
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
		  master_data_in = 8'b10110011;
		  slave_data_in = 8'b11001100;
		  #20;
		  reset = 0;
		  #10;
		  start = 1;
		  #20;
		  start = 0;
		  #5000;
		  $finish;
		  
	end
      
endmodule

