`timescale 1ns / 1ps
module spi_slave(
    input sclk,
    input reset,
    input ss,
    input mosi,
    output reg[7:0] data_out
    );
	 
	 reg [7:0] shift_reg;
	 reg [2:0] bit_count;
	 
	 always @(posedge sclk or posedge reset)
	 begin
	   if(reset)
		begin
		 shift_reg <= 0;
		 bit_count <= 0;
		 data_out <= 0;
		end
		
	else
	begin 
	 if(ss==0)
	 begin
	   shift_reg <= {shift_reg[6:0],mosi};
		bit_count <= bit_count+1;
		if(bit_count == 7)
		begin
		  data_out <= {shift_reg[6:0],mosi};
		  bit_count = 0;
		end
    end
	end
	end
	endmodule
	
