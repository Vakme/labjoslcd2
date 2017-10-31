`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    18:31:36 10/26/2017 
// Design Name: 
// Module Name:    LCD_dp 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module LCD_dp(
    input [3:0]count0,
    input [3:0]count1,
    input [3:0]count2,
    input [3:0]count3,
    input [1:0]init_sel,
    input [1:0]mux_sel,
    input data_sel,
    input DB_sel,
    output [7:0]DB_out
    );
	 
	 reg [3:0] counter_mux;
	 always @*
		 begin
			case(mux_sel)
				2'b00:
					counter_mux = count0;
				2'b01:
					counter_mux = count1;
				2'b10:
					counter_mux = count2;
				2'b11:
					counter_mux = count3;
			endcase
		end
		
		
	 reg [5:0] init_reset_mux;
	 always @*
		 begin
			case(init_sel)
				2'b00:
					init_reset_mux = 6'b000001;
				2'b01:
					init_reset_mux = 6'b001110;
				2'b10:
					init_reset_mux = 6'b000110;
				2'b11:
					init_reset_mux = 6'b111000;
			endcase
		end
		
	wire [7:0] data_outx;	
	assign data_outx = data_sel ? {4'b0011, counter_mux} : {2'b00, init_reset_mux};
		
	assign DB_out = DB_sel ? data_outx : 8'hcc;
		
			


endmodule
