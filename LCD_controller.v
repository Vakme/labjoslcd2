`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    14:58:07 10/31/2017 
// Design Name: 
// Module Name:    LCD_controller 
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
module LCD_controller(
    input reset,
    input clk_1ms,
    output data_sel,
    output DB_sel,
    output [1:0]init_sel,
    output [1:0]mux_sel,
    output E_out,
    output RW_out,
    output RS_out
    );
	
wire [1:0] lcd_count;

main_controller main_ctrl(.clk(clk_1ms), .rst(reset), .lcd_finish(lcd_finish), .reg_sel(reg_sel), .mode(mode), .lcd_cnt(lcd_count), 
						 .lcd_enable(lcd_enable), .data_sel(data_sel), .DB_sel(DB_sel));
LCD_init_refresh lcd_init_refr(.clk(clk_1ms), .rst(reset), .lcd_enable(lcd_enable), .mode(mode), .lcd_cnt(lcd_count), .lcd_finish(lcd_finish), 
							   .wr_enable(wr_enable), .wr_finish(wr_finish), .mux_sel(mux_sel), .init_sel(init_sel));
write_cycle wr_cycle(.clk(clk_1ms), .rst(reset), .reg_sel(reg_sel), .wr_enable(wr_enable), .wr_finish(wr_finish), .E_out(E_out), 
					 .RW_out(RW_out), .RS_out(RS_out));

endmodule





