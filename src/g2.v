`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    04:51:02 10/24/2018 
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
module g2(
    input G1_TDO,
    input SELECT,
    input INSTRUCTION_REG_TDO,
    output G2_TDO
	 );
	 
	 assign G2_TDO = (G1_TDO & SELECT) | (INSTRUCTION_REG_TDO & !SELECT);


endmodule
