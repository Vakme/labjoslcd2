`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   15:46:21 10/31/2017
// Design Name:   LCD_controller
// Module Name:   /home/lab_jos/bielabra/lcd2/lcd/tb_LCD_controller.v
// Project Name:  lcd
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: LCD_controller
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module tb_LCD_controller;

	// Inputs
	reg reset;
	reg clk_1ms;

	// Outputs
	wire data_sel;
	wire DB_sel;
	wire [1:0]init_sel;
	wire [1:0]mux_sel;
	wire E_out;
	wire RW_out;
	wire RS_out;

	// Instantiate the Unit Under Test (UUT)
	LCD_controller uut (
		.reset(reset), 
		.clk_1ms(clk_1ms), 
		.data_sel(data_sel), 
		.DB_sel(DB_sel), 
		.init_sel(init_sel), 
		.mux_sel(mux_sel), 
		.E_out(E_out), 
		.RW_out(RW_out), 
		.RS_out(RS_out)
	);

	initial begin
		// Initialize Inputs
		reset = 0;
		clk_1ms = 0;

		// Wait 100 ns for global reset to finish
		#100;
        
		// Add stimulus here
		#5 reset = 1'b1;
		#20 reset = 1'b0;
	end
	initial begin
		#130 forever #10 clk_1ms = ~clk_1ms;
	end
	
	initial #500 $finish;
      
endmodule

