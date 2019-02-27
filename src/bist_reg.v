`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    07:39:28 12/19/2018 
// Design Name: 
// Module Name:    bist_reg 
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
module bist_conf_reg(
    input SHIFT,
    input ENABLE,
    input TDI,
    output reg TDO,
    output [12:0] BIST_CONF_REG
    );
	 //  [0 preset   ] [0-16 number of test] [0-256 user test length]
	 //  [1 user test]
	 reg [12:0] conf_reg;
	 assign BIST_CONF_REG = conf_reg; 
	
	 always @(posedge SHIFT) begin
		if (ENABLE) begin
			TDO <= conf_reg[0];
			conf_reg <= {TDI, conf_reg[12:1]};
		end
	 end
endmodule 
