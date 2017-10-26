`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    16:49:21 10/24/2017 
// Design Name: 
// Module Name:    LCD_init_refresh 
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
module LCD_init_refresh(
    input clk,
    input rst,
    input lcd_enable,
    input mode,
    input [1:0] lcd_cnt,
    output reg lcd_finish,
    output reg wr_enable,
    output reg wr_finish,
    output reg [1:0] mux_sel,
    output reg [1:0] init_sel
    );

localparam  idle = 2'b00,
			data = 2'b01,
			data1 = 2'b10,
			endlcd = 2'b11;

reg [1:0] state, next_state;

always @(posedge clk, posedge rst)
	if(rst)
		state <= idle;
	else
		state <= next_state;
		
always @(posedge clk, posedge rst)
			if(rst)
				init_sel <= 2'b0;
			else case(state)
					idle: if(mode) init_sel <= lcd_cnt;
					endlcd: if(mode && init_sel != 2'b0) init_sel <= init_sel - 1;
				endcase
		
always @(posedge clk, posedge rst)
			if(rst)
				mux_sel <= 2'b0;
			else case(state)
					idle: 
						if(!mode) 
							mux_sel <= lcd_cnt;
						else
							lcd_finish <= 1;
					endlcd: 
						if(!mode && mux_sel != 2'b0) 
							mux_sel <= mux_sel - 1;
						else
							lcd_finish <= 1'b1;
				endcase
always @*
begin
	wr_enable = 1'b0;
	lcd_finish = 1'b0;
	case(state)
		idle:
			begin
				lcd_finish = 1'b0;
				if(lcd_enable)
					next_state = data;
				else 
					next_state = idle;
			end
		data:
			begin
				wr_enable = 1'b1;
				next_state = data1;
			end
		data1: 
			begin
				wr_enable = 1'b0;
				if(wr_finish)
					next_state = endlcd;
				else
					next_state = data1;
			end
		endlcd:
			next_state = idle;
	endcase
end

endmodule
