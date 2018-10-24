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
    input [1:0] CODE,
    input DEVICE_ID_TDO,
    input BSR_TDO,
    input BYPASS_TDO,
    output G1_TDO
    );
	 
	 localparam G1_BSR = 2'h1;
	 localparam G1_BYPASS = 2'h0;
	 localparam G1_DEVICE_ID = 2'h2;
	 
	 assign G1_TDO =	(CODE == G1_BSR) & BSR_TDO |
							(CODE == G1_BYPASS) & BYPASS_TDO |
							(CODE == G1_DEVICE_ID) & DEVICE_ID_TDO;
endmodule
