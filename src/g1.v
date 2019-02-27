`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    04:35:38 10/24/2018 
// Design Name: 
// Module Name:    g1 
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
module g1(
    input [3:0] CODE,
    input DEVICE_ID_TDO,
    input BSR_TDO,
    input BYPASS_TDO,
	input BIST_CONF_TDO,
	input BIST_STATUS_TDO,
	input BIST_USER_TEST_TDO,
    output G1_TDO
    );
	 
	localparam G1_BSR = 4'h1;
	localparam G1_BYPASS = 4'h0;
	localparam G1_DEVICE_ID = 4'h2;
	localparam G1_BIST_CONF = 4'h3;
	localparam G1_BIST_STATUS = 4'h4;
	localparam G1_BIST_USER_TEST = 4'h5;
	 
	assign G1_TDO =	(CODE == G1_BSR) & BSR_TDO |
					(CODE == G1_BYPASS) & BYPASS_TDO |
					(CODE == G1_DEVICE_ID) & DEVICE_ID_TDO |
					(CODE == G1_BIST_CONF) & BIST_CONF_TDO | 
					(CODE == G1_BIST_STATUS) & BIST_STATUS_TDO |
					(CODE == G1_BIST_USER_TEST) & BIST_USER_TEST_TDO;
endmodule
