`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    08:29:36 12/19/2018 
// Design Name: 
// Module Name:    bist_user_test 
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
module bist_user_test(
    input TDI,
    input SHIFT,
    input ENABLE,
    output reg TDO,
	// [initial state] [input x] [expected output y]
    output reg [2051:0] USER_TEST
    );
	
	always @(posedge SHIFT) begin
		if (ENABLE) begin
			TDO <= USER_TEST[0];
			USER_TEST <= {TDI, USER_TEST[2051:1]};
		end
	end

endmodule
