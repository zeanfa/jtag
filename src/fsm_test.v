`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   19:37:45 12/18/2018
// Design Name:   fsm
// Module Name:   /home/s29/Denisov/tapc/fsm_test.v
// Project Name:  tapc
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: fsm
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module fsm_test;

	// Inputs
	reg [3:0] X;
	reg [3:0] PRESET_Y;
	reg CLK;
	reg ENABLE;

	// Outputs
	wire [3:0] Y;
	
	// Instantiate the Unit Under Test (UUT)
	fsm uut (
		.X(X),
		.PRESET_Y(PRESET_Y),
		.Y(Y), 
		.CLK(CLK), 
		.ENABLE(ENABLE)
	);
	
	initial begin
		// Initialize Inputs
		X <= 0;
		CLK = 0;
		ENABLE = 0;
		PRESET_Y=1;
		// Wait 100 ns for global reset to finish
		#100;
	end
	
	always begin
		#5  CLK <=~CLK; // 200MHz
	end
	
	initial begin
		ENABLE = 0; @(negedge CLK);
		ENABLE = 1; @(negedge CLK);
		X <= 1; @(negedge CLK); 
		X <= 3; @(negedge CLK);
		X <= 7; @(negedge CLK);
		X <= 6; @(negedge CLK);
		X <= 5; @(negedge CLK);
		repeat(10) @(negedge CLK);
		$finish;
	end
      
endmodule

