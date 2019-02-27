`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   13:19:19 10/24/2018
// Design Name:   main_module
// Module Name:   /home/s29/tapc/main_module_tb.v
// Project Name:  tapc
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: main_module
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module main_module_tb;

	// Inputs
	reg TDI;
	reg TMS;
	reg TCK;
	reg TRST;
	reg BIST_CLK;
	reg CORE_IN_1;
	reg CORE_IN_2;
	reg PIN_IN_1;
	reg PIN_IN_2;

	// Outputs
	wire CORE_OUT_1;
	wire CORE_OUT_2;
	wire PIN_OUT_1;
	wire PIN_OUT_2;
	wire TDO;
	
	localparam BYPASS   			= 4'hF;
	localparam SAMPLE_PRELOAD		= 4'h1;
	localparam EXTEST   			= 4'h4;
	localparam INTEST   			= 4'h8; 
	localparam IDCODE   			= 4'h2;
	localparam BIST 				= 4'h3;
	localparam BIST_CONF 			= 4'h5;
	localparam BIST_STATUS 			= 4'h7;
	localparam BIST_USER_TEST 		= 4'h9;


	// Instantiate the Unit Under Test (UUT)
	main_module uut (
		.TDI(TDI), 
		.TMS(TMS), 
		.TCK(TCK), 
		.TRST(TRST),
		.BIST_CLK(BIST_CLK),
		.CORE_IN_1(CORE_IN_1), 
		.CORE_IN_2(CORE_IN_2), 
		.PIN_IN_1(PIN_IN_1), 
		.PIN_IN_2(PIN_IN_2), 
		.CORE_OUT_1(CORE_OUT_1), 
		.CORE_OUT_2(CORE_OUT_2), 
		.PIN_OUT_1(PIN_OUT_1), 
		.PIN_OUT_2(PIN_OUT_2), 
		.TDO(TDO)
	);

	/*initial begin
		// Initialize Inputs
		TDI <=0;
		TMS <=0;
		TCK <=0;
		TRST <=0;
		CORE_IN_1 <=0;
		CORE_IN_2 <=0;
		PIN_IN_1 <=0;
		PIN_IN_2 <=0;

		// Wait 100 ns for global reset to finish
		#100;
        
		// Add stimulus here
		
	end*/
	
	always begin
		#5  TCK <=~TCK; // 200MHz
	end
	
	always begin
		#2	BIST_CLK <= ~BIST_CLK; //500MHz
	end

	initial begin
		TCK <=0; TMS <=1; TRST <=1; TDI <=0; BIST_CLK <= 0; @(posedge TCK);
		TRST <=0;                            @(posedge TCK);
		TRST <=1;                            @(posedge TCK);
	end  

	task command;
	  input [3:0] cmd;
	  begin
		 TMS <=0; repeat(1) @(negedge TCK); // Run Test IDLE <- C
		 TMS <=1; @(negedge TCK); // Select DR_Scan <- 7
		 TMS <=1; @(negedge TCK); // Select IR_Scan <- 4
		 TMS <=0; @(negedge TCK); // Capture_IR <- E
		 TMS <=0; @(negedge TCK); // SHIFT_IR <- A 

			TDI <=cmd[0]; TMS <=0; @(negedge TCK); // SHIFT_IR <- A
			TDI <=cmd[1]; TMS <=0; @(negedge TCK); // SHIFT_IR <- A
			TDI <=cmd[2]; TMS <=0; @(negedge TCK); // SHIFT_IR <- A
			TDI <=cmd[3]; TMS <=1; @(negedge TCK); // EXIT1_IR <- 9

		 TDI <=0; TMS <=1; @(negedge TCK); // UPDATE_IR <- D
		 TMS <=0; @(negedge TCK); // Run Test IDLE <- C
		 TMS <=0; @(negedge TCK); // Run Test IDLE <- C
		 TMS <=0; @(negedge TCK); // Run Test IDLE <- C
	  end 
	endtask

	task data;
	  input [12:0] data;
	  begin
		 TMS <=1; @(negedge TCK); // Select_DR_Scan <- 7
		 TMS <=0; @(negedge TCK); // Capture_DR <- 7
		 TMS <=0; @(negedge TCK); // Shidt_DR <- 2

			// For LBS
			//TDI <=0; TMS <=0; @(negedge TCK); // Shidt_DR <- 2
			//TDI <=0; TMS <=0; @(negedge TCK); // Shidt_DR <- 2

			TDI <=data[0]; TMS <=0; @(negedge TCK); // Shidt_DR <- 2
			TDI <=data[1]; TMS <=0; @(negedge TCK); // Shidt_DR <- 2
			TDI <=data[2]; TMS <=0; @(negedge TCK); // Shidt_DR <- 2
			TDI <=data[3]; TMS <=0; @(negedge TCK); // Shidt_DR <- 2

			TDI <=data[4]; TMS <=0; @(negedge TCK); // Shidt_DR <- 2
			TDI <=data[5]; TMS <=0; @(negedge TCK); // Shidt_DR <- 2
			TDI <=data[6]; TMS <=0; @(negedge TCK); // Shidt_DR <- 2
			TDI <=data[7]; TMS <=0; @(negedge TCK); // Shidt_DR <- 2
			
			TDI <=data[8]; TMS <=0; @(negedge TCK); // Shidt_DR <- 2
			TDI <=data[9]; TMS <=0; @(negedge TCK); // Shidt_DR <- 2
			TDI <=data[10]; TMS <=0; @(negedge TCK); // Shidt_DR <- 2

			TDI <=data[11]; TMS <=0; @(negedge TCK); // Shidt_DR <- 2
			TDI <=data[12]; TMS <=1; @(negedge TCK); // Shidt_DR <- 2
			//TDI <=data[13]; TMS <=0; @(negedge TCK); // Shidt_DR <- 2
			//TDI <=data[14]; TMS <=0; @(negedge TCK); // Shidt_DR <- 2
			//TDI <=data[15]; TMS <=1; @(negedge TCK); // EXIT1_DR <- 2*/


			TDI <=0; TMS <=0; @(negedge TCK); // PAUSE_DR <- 3
			TDI <=0; TMS <=0; @(negedge TCK); // PAUSE_DR <- 3
			TDI <=0; TMS <=0; @(negedge TCK); // PAUSE_DR <- 3
			TDI <=0; TMS <=0; @(negedge TCK); // PAUSE_DR <- 3

		 TMS <=1; @(negedge TCK); // EXIT2_DR  <- 0
		 TMS <=1; @(negedge TCK); // UPDATE_DR <- 5
		 TMS <=0; @(negedge TCK); // RUN_TEST_IDLE <- C
		 TMS <=0; @(negedge TCK); // RUN_TEST_IDLE <- C
		 TMS <=0; @(negedge TCK); // RUN_TEST_IDLE <- C
	  end 
	endtask

	initial begin

	  repeat(5) @(negedge TCK); // Test Logic Reset <- F

	  command(BIST_CONF); //data(4'b0001); 
	  data(13'h0003);
	  command(BIST);
	  command(BIST_STATUS);
	  data(13'b0);
	  data(13'b0);
	  //data(4'b1111);
	  //data(4'b0011);
	  //data(4'b0100);
	  //data(4'b0101);
	  //command(EXTEST);
	  //data(4'b1101);
	  //data(4'b0101);
	  //command(IDCODE); data(4'b0101);//data(16'b0101010100001111); 
	  //command(EXTEST); //data(4'b1111);
	  //command(INTEST); data(4'b0110);
	  //command(BYPASS); //data(4'b1000);
	  
	  repeat(10) @(posedge TCK); $finish;
	end

	/*initial begin
	  $dumpfile("ics_tb.vcd");
	  $dumpvars(-1, ics_tb);
	end*/
      
endmodule

