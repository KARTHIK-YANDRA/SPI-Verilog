`timescale 1ns / 1ps
module spi_slave(
    input sclk,
    input reset,
    input ss,
    input mosi,
	 input [7:0] data_in,
    output reg[7:0] data_out,
	 output reg miso
    );
	 
	 reg [7:0] shift_reg;
	 reg [2:0] bit_count;
	 reg [7:0] tx_shift_reg;
	 
	 always @(posedge sclk or posedge reset)
	 begin
	   if(reset)
		begin
		 shift_reg <= 0;
		 bit_count <= 0;
		 data_out <= 0;
		 tx_shift_reg <= 0;
		 miso <= 0;
		end
		
	else
	begin 
	 if(ss==0)
	 begin
	  if(bit_count == 0)
	  begin
	  miso <= data_in[7];
	  tx_shift_reg <= data_in << 1;
	  end
	  else
	  begin
	   miso <= tx_shift_reg[7];
		tx_shift_reg <= tx_shift_reg << 1;
		end
	   shift_reg <= {shift_reg[6:0],mosi};
		bit_count <= bit_count+1;
		if(bit_count == 7)
		begin
		  data_out <= {shift_reg[6:0],mosi};
		  bit_count <= 0;
		end
    end
	end
	end
	endmodule
	
