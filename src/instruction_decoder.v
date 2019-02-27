`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    03:03:55 10/24/2018 
// Design Name: 
// Module Name:    instruction_decoder 
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
module instruction_decoder(
    input 	[3:0] INSTR_REG,
    output	[3:0] G1,
    output	BYPASS_ENABLE,
    output	DEVICE_ID_ENABLE,
	output	BSR_ENABLE,
	output	BIST_ENABLE,
	output	BIST_CONF_REG_ENABLE,
	output	BIST_STATUS_REG_ENABLE,
	output	BIST_USER_TEST_ENABLE,
    output	MODE_TEST_NORMAL,
	output	CAPTURE_MODE_INPUT,
	output	UPDATE_MODE_INPUT,
	output	CAPTURE_MODE_OUTPUT,
	output	UPDATE_MODE_OUTPUT
    );
	 
	localparam CODE_BYPASS = 4'hF;
	localparam CODE_SAMPLE_PRELOAD = 4'h1;
	localparam CODE_IDCODE = 4'h2;
	localparam CODE_EXTEST = 4'h4;
	localparam CODE_INTEST = 4'h8;
	localparam CODE_BIST = 4'h3;
	localparam CODE_BIST_CONF = 4'h5;
	localparam CODE_BIST_STATUS = 4'h7;
	localparam CODE_BIST_USER_TEST = 4'h9;
 
	localparam G1_BSR = 4'h1;
	localparam G1_BYPASS = 4'h0;
	localparam G1_DEVICE_ID = 4'h2;
	localparam G1_BIST_CONF = 4'h3;
	localparam G1_BIST_STATUS = 4'h4;
	localparam G1_BIST_USER_TEST = 4'h5;
 
	assign G1 = (INSTR_REG == CODE_BIST_CONF)	? G1_BIST_CONF : ((INSTR_REG == CODE_BIST_STATUS) 
												? G1_BIST_STATUS : ((INSTR_REG == CODE_BIST_USER_TEST) 
												? G1_BIST_USER_TEST : ((INSTR_REG == CODE_BYPASS) 
												? G1_BYPASS : ((INSTR_REG == CODE_IDCODE) 
												? G1_DEVICE_ID : G1_BSR))));
											
	assign BYPASS_ENABLE = (INSTR_REG == CODE_BYPASS) ? 1'b1 : 1'b0;
	assign DEVICE_ID_ENABLE =(INSTR_REG == CODE_IDCODE ? 1'b1 : 1'b0);
	assign BSR_ENABLE = ((INSTR_REG == CODE_SAMPLE_PRELOAD | 
						INSTR_REG == CODE_INTEST | 
						INSTR_REG == CODE_EXTEST) ? 1'b1 : 1'b0);
	assign MODE_TEST_NORMAL = (INSTR_REG == CODE_SAMPLE_PRELOAD | 
							INSTR_REG == CODE_BYPASS | 
							INSTR_REG == CODE_IDCODE) ? 1'b1 : 1'b0;
	assign CAPTURE_MODE_INPUT = (INSTR_REG == CODE_EXTEST) ? 1'b1 : 1'b0;
	assign CAPTURE_MODE_OUTPUT = (INSTR_REG == CODE_INTEST) ? 1'b1 : 1'b0;
	assign UPDATE_MODE_INPUT = (INSTR_REG == CODE_INTEST | INSTR_REG == CODE_SAMPLE_PRELOAD) ? 1'b1 : 1'b0;
	assign UPDATE_MODE_OUTPUT = (INSTR_REG == CODE_EXTEST | INSTR_REG == CODE_SAMPLE_PRELOAD) ? 1'b1 : 1'b0;
	 
	assign	BIST_ENABLE = (INSTR_REG == CODE_BIST) ? 1'b1 : 1'b0;
	assign	BIST_CONF_REG_ENABLE = (INSTR_REG == CODE_BIST_CONF) ? 1'b1 : 1'b0;
	assign	BIST_STATUS_REG_ENABLE = (INSTR_REG == CODE_BIST_STATUS) ? 1'b1 : 1'b0;
	assign	BIST_USER_TEST_ENABLE = (INSTR_REG == CODE_BIST_USER_TEST) ? 1'b1 : 1'b0;
	 
endmodule
