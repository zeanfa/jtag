`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    05:06:34 10/24/2018 
// Design Name: 
// Module Name:    z_state 
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
module z_state(
    input NEG_LATCH_TDO,
    input ENABLE,
    output TDO
    );
	
	//assign TDO = ENABLE ? NEG_LATCH_TDO : 1'bz;
	assign TDO = NEG_LATCH_TDO;

endmodule
