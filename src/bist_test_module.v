`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    16:56:37 12/26/2018 
// Design Name: 
// Module Name:    bist_test_module 
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
module bist_test_module(
    input CLK,
    input ENABLE,
    input [12:0] BIST_CONF_REG,
	input [2051:0] BIST_USER_TEST,
    output [15:0] BIST_STATUS_REG
    );
	
	wire [3:0] 	FSM_IN;
	wire [3:0] 	FSM_OUT;
	wire [3:0] 	FSM_PRESET;
	wire 		FSM_ENABLE;
	
	bist bist_inst (
		.ENABLE(ENABLE),
		.CLK(CLK),
//  [0 preset   ] [0-16 number of test] [0-256 user test length]
//  [1 user test]
		.BIST_CONF_REG(BIST_CONF_REG),
		.BIST_USER_TEST(BIST_USER_TEST),
		.FSM_IN(FSM_IN),
		.FSM_OUT(FSM_OUT),
		.FSM_PRESET(FSM_PRESET),
		.FSM_ENABLE(FSM_ENABLE),
// [input when error occured] [output expected][output got][error code]
		.BIST_STATUS_REG(BIST_STATUS_REG)
    );
	
	fsm fsm_inst (
		.X(FSM_OUT),
		.PRESET_Y(FSM_PRESET),
		.Y(FSM_IN),
		.CLK(CLK),
		.ENABLE(FSM_ENABLE)
	);


endmodule
