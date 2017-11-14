`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    16:01:36 10/31/2017 
// Design Name: 
// Module Name:    LCD_driver 
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
module LCD_driver(
    input [3:0] count0,
    input [3:0] count1,
    input [3:0] count2,
    input [3:0] count3,
    input reset,
    input clk,
    output E_out,
    output RW_out,
    output RS_out,
    output [7:0] DB_out
    );
	 
wire [1:0] mux_sel, init_sel;

clockdivider clkdiv(.clk(clk), .rst(reset), .slow_clk(clk_1ms));
LCD_controller lcd_ctrl(.reset(reset), .clk_1ms(clk_1ms), .E_out(E_out), .RW_out(RW_out), .RS_out(RS_out),
						.DB_sel(DB_sel), .mux_sel(mux_sel), .data_sel(data_sel), .init_sel(init_sel));
LCD_dp lcd_dp(.count0(count0), .count1(count1), .count2(count2), .count3(count3), .DB_sel(DB_sel), .mux_sel(mux_sel),
			  .data_sel(data_sel), .init_sel(init_sel), .DB_out(DB_out));


endmodule

