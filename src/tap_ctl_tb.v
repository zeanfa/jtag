`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   08:14:46 10/10/2018
// Design Name:   tap_ctl
// Module Name:   /home/s29/tapc/tap_ctl_tb.v
// Project Name:  tapc
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: tap_ctl
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module tap_ctl_tb;

	// Inputs
	reg TCK;
	reg TMS;
	reg TRST;

	// Outputs
	wire UPDATE_IR;
	wire SHIFT_IR;
	wire CAPTURE_IR;
	wire UPDATE_DR;
	wire SHIFT_DR;
	wire CAPTURE_DR;
	wire SELECT;
	wire ENABLE;
	wire RST;
	wire TCKN;

	// Instantiate the Unit Under Test (UUT)
	tap_ctl uut (
		.TCK(TCK), 
		.TMS(TMS), 
		.TRST(TRST), 
		.UPDATE_IR(UPDATE_IR), 
		.SHIFT_IR(SHIFT_IR), 
		.CAPTURE_IR(CAPTURE_IR), 
		.UPDATE_DR(UPDATE_DR), 
		.SHIFT_DR(SHIFT_DR), 
		.CAPTURE_DR(CAPTURE_DR), 
		.SELECT(SELECT), 
		.ENABLE(ENABLE), 
		.RST(RST), 
		.TCKN(TCKN)
	);
	
	always begin
		#5  TCK <= ~TCK; // 200MHz
	end

	initial begin
		// Initialize Inputs
		TCK <= 0;
		TMS <= 0;	@(posedge TCK)
		TRST <= 0;	@(posedge TCK);
		TRST <= 1;	@(posedge TCK);

		// Wait 100 ns for global reset to finish
		//#100;
		// Add stimulus here

	end
	
	initial begin

	  @(posedge TRST)  TMS = 1; // <- STATE_TEST_LOGIC_RESET
	  @(posedge TCK);  TMS = 0; // <- STATE_RUN_TEST_IDLE
	  repeat(2) @(posedge TCK); // <- STATE_RUN_TEST_IDLE
	  @(posedge TCK);  TMS = 1;

	  repeat(10) @(posedge TCK); 
	  $finish;
end

      
endmodule

