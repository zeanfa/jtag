`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   17:23:29 12/26/2018
// Design Name:   bist_test_module
// Module Name:   /home/s29/Denisov/tapc/bist_test.v
// Project Name:  tapc
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: bist_test_module
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module bist_test;

	// Inputs
	reg CLK;
	reg ENABLE;
	reg [12:0] BIST_CONF_REG;
	reg [2051:0] BIST_USER_TEST;

	// Outputs
	wire [15:0] BIST_STATUS_REG;

	// Instantiate the Unit Under Test (UUT)
	bist_test_module uut (
		.CLK(CLK), 
		.ENABLE(ENABLE), 
		.BIST_CONF_REG(BIST_CONF_REG), 
		.BIST_USER_TEST(BIST_USER_TEST),
		.BIST_STATUS_REG(BIST_STATUS_REG)
//[input when error occured] [output expected][output got][error code]
	);

	initial begin
		// Initialize Inputs
		CLK = 0;
		ENABLE = 0;
//  [0 preset   ] [0-16 number of test] [0-256 user test length]
//  [1 user test]
		BIST_CONF_REG = 13'h1103;
		BIST_USER_TEST = 0;
		BIST_USER_TEST[19:0] = 20'h73110;

		// Wait 100 ns for global reset to finish
		#100;
        
		// Add stimulus here

	end
	
	always begin
		#5  CLK <=~CLK; // 200MHz
	end
	
	initial begin
		ENABLE = 0; @(negedge CLK);
		ENABLE = 1; @(negedge CLK);
		repeat(10) @(negedge CLK);
		BIST_CONF_REG = 13'h0003;
		ENABLE = 0; @(negedge CLK);
		ENABLE = 1; @(negedge CLK);
		repeat(10) @(negedge CLK);

		$finish;
	end
      
      
endmodule

