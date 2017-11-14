`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    19:34:23 10/26/2017 
// Design Name: 
// Module Name:    main_controller 
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
module main_controller(
    input clk,
    input rst,
    input lcd_finish,
    output reg reg_sel,
    output reg mode,
    output reg [1:0]lcd_cnt,
    output reg lcd_enable,
    output reg data_sel,
    output reg DB_sel
    );
	 
	 
reg [2:0] state, next_state;
	 
localparam idle = 3'b0, init = 3'b001, addr = 3'b010, addr1 = 3'b011, ref = 3'b100, ref1 = 3'b101;	 
localparam LCD_INIT = 1, LCD_REF = 0, INIT_CONST_NO = 4, REF_DATA_NO = 4;

always @(posedge clk, posedge rst)
	if(rst)
		state <= idle;
	else
		state <= next_state;
		
always @*
begin
	lcd_cnt=INIT_CONST_NO-1;
	DB_sel=1'b1;
	data_sel=1'b0;
	reg_sel=1'b0;
	mode=LCD_INIT;
	lcd_enable=1'b1;
	case(state)
		idle:
			next_state = init;
		init:
			begin
				lcd_enable=1'b0;
				if(lcd_finish)
					next_state = addr;
				else
					next_state = init;
				mode=LCD_INIT;
			end
		addr:
			begin
				lcd_enable=1'b1;
				lcd_cnt = 1'b0;
				DB_sel = 1'b0;
				next_state = addr1;
				mode=LCD_INIT;
			end
		addr1:
			begin
				lcd_enable=1'b0;
				lcd_cnt = 1'b0;
				DB_sel = 1'b0;
				mode=LCD_INIT;
				if(lcd_finish)
					next_state = ref;
				else
					next_state = addr1;
			end
		ref:
			begin
				lcd_cnt=REF_DATA_NO-1;
				DB_sel=1'b1;
				data_sel=1'b1;
				reg_sel=1'b1;
				mode=LCD_REF;
				lcd_enable=1'b1;
				next_state = ref1;
			end
		ref1:
			begin
				lcd_enable=1'b0;
				lcd_cnt=REF_DATA_NO-1;
				DB_sel=1'b1;
				data_sel=1'b1;
				reg_sel=1'b1;
				mode=LCD_REF;
				if(lcd_finish)
					begin
						next_state = addr;
						reg_sel=0;
					end
				else
					next_state = ref1;
			end
		endcase
end


endmodule
