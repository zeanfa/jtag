`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    05:02:48 10/24/2018 
// Design Name: 
// Module Name:    neg_latch 
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
module neg_latch(
    input G2_TDO,
    input TCKN,
    output reg TDO
    );
	 
	 always @(posedge TCKN) begin
		TDO <= G2_TDO;
	 end


endmodule
