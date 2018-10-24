`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    05:06:41 10/23/2018 
// Design Name: 
// Module Name:    bypass 
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
module bypass(
    input TDI,
	 input SHIFT,
    output reg TDO,
    input ENABLE
    );
	
	always @(posedge SHIFT) begin
		if (ENABLE) begin
			TDO <= TDI;
		end
	end

endmodule
