`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   16:12:42 10/31/2017
// Design Name:   LCD_driver
// Module Name:   /home/lab_jos/bielabra/lcd2/lcd/tb_LCD_driver.v
// Project Name:  lcd
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: LCD_driver
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module tb_LCD_driver;

	// Inputs
	reg [3:0]count0;
	reg [3:0]count1;
	reg [3:0]count2;
	reg [3:0]count3;
	reg reset;
	reg clk;

	// Outputs
	wire E_out;
	wire RW_out;
	wire RS_out;
	wire [7:0] DB_out;

	// Instantiate the Unit Under Test (UUT)
	LCD_driver uut (
		.count0(count0), 
		.count1(count1), 
		.count2(count2), 
		.count3(count3), 
		.reset(reset), 
		.clk(clk), 
		.E_out(E_out), 
		.RW_out(RW_out), 
		.RS_out(RS_out), 
		.DB_out(DB_out)
	);

	initial begin
		count0 = 4'd1;
		count1 = 4'd2;
		count2 = 4'd3;
		count3 = 4'd4;
	end
	
		initial begin
		// Initialize Inputs
		reset = 0;
		clk = 0;

		// Wait 100 ns for global reset to finish
		#100;
        
		// Add stimulus here
		#5 reset = 1'b1;
		#20 reset = 1'b0;
	end
	initial begin
		#130 forever #5 clk = ~clk;
	end
      initial #1000 $finish;
endmodule

