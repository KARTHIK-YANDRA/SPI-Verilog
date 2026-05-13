`timescale 1ns / 1ps
module spi_master_fsm(
    input clk,
    input reset,
    input start,
    input [7:0] data_in,
    output reg mosi,
    output sclk,
    output reg ss
    );
	 
	 parameter IDLE = 2'b00;
	 parameter LOAD = 2'b01;
	 parameter TRANSFER = 2'b10;
	 parameter DONE = 2'b11;
	 
	 reg[1:0] state;
	 reg[7:0] shift_reg;
	 reg[2:0] bit_count;
	 wire spi_clk;
	 reg spi_clk_d;
	 
	 
	 clock_divider cd(

    .clk(clk),
    .reset(reset),
    .sclk(spi_clk)

);

    assign sclk = (ss == 0) ? spi_clk : 0;	 
	 always @(posedge clk or posedge reset)
	 begin
	   if(reset)
		begin
		state <= IDLE;
		mosi <= 0;
		ss <= 1;
		shift_reg <= 0;
		bit_count <= 0;
		spi_clk_d <= 0;
		end
		
		else
		begin
		spi_clk_d <= spi_clk;
		case(state)
		IDLE:
       begin
       ss <= 1;
		 bit_count <= 0;
      // sclk <= 0;
       if(start)
       begin
        state <= LOAD;
       end
		 end
		LOAD:
       begin
       ss <= 0;
       shift_reg <= data_in;
       bit_count <= 0;
       state <= TRANSFER;
       end
		TRANSFER:
       begin
       // sclk <= ~sclk;
		 if(spi_clk == 1 && spi_clk_d ==0)
		 begin
        mosi <= shift_reg[7];
        shift_reg <= shift_reg << 1;
        bit_count <= bit_count + 1;
        if(bit_count == 7)
        begin
         state <= DONE;
        end
       end
		 end
		 DONE:
       begin
        ss <= 1;
        //sclk <= 0;    
		  state <= IDLE; 
       end
endcase
end
end
endmodule
