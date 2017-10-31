`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    16:23:41 10/24/2017 
// Design Name: 
// Module Name:    write_cycle 
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
module write_cycle(
	input clk,
	input rst,
	input reg_sel,
    input wr_enable,
    output reg wr_finish,
    output reg E_out,
	output RW_out,
    output RS_out
    );
	 
reg [1:0] state, next_state;
localparam idle = 2'b0, init = 2'b01, Eout = 2'b10, endwr = 2'b11;	 
always @(posedge clk, posedge rst)
	if(rst)
		state <= idle;
	else
		state <= next_state;
		
	
always @* begin
	wr_finish <= 1'b0;
	E_out <= 1'b0;
			
	case(state)
		idle: // idle
			begin
				wr_finish <= 1'b0;
				E_out <= 1'b0;
				if(wr_enable)
					next_state = init;
				else
					next_state = idle;
			end
		init: // init
			begin
				E_out <= 1'b1;
				next_state <= Eout;
			end
		Eout: // Eout 
			begin
				E_out <= 1'b1;
				next_state <= endwr;
			end
		endwr: // endwr
			begin
				wr_finish <= 1'b1;
				next_state <= idle;
			end
	endcase
end

assign RS_out = reg_sel;
assign RW_out = 1'b0;

endmodule
