`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    08:15:58 12/19/2018 
// Design Name: 
// Module Name:    bist_status_reg 
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
module bist_status_reg(
    input SHIFT,
    input ENABLE,
	// [input when error occured] [output expected][output got][error code]
    input [15:0] STATUS_REG,
    output reg TDO
    );
	reg 	[3:0] counter;
	
	always @(posedge SHIFT) begin
		if (ENABLE) begin
			counter <= counter + 1;
			TDO <= STATUS_REG >> counter;
		end
		else begin
			counter <= 0;
		end
	end

endmodule
