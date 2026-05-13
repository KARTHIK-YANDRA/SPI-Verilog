`timescale 1ns / 1ps
module clock_divider(
    input clk,
    input reset,
    output reg sclk
    );
	 
	 reg [3:0] count;
	 
	 always @(posedge clk or posedge reset)
	 begin
	 if(reset)
	 begin
	 count <= 0;
	 sclk <= 0;
	 end
	 else
	 begin
	 count <= count+1;
	 if(count == 4)
	 begin
	 sclk <= ~sclk;
	 count <= 0;
	 end
	 end
	 end
endmodule
