`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    19:46:42 12/26/2018 
// Design Name: 
// Module Name:    core_logic 
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
module core_logic(
    input [3:0] BSR_IN,
    input [3:0] BIST_IN,
    input [3:0] FSM_IN,
    output [3:0] BSR_OUT,
    output [3:0] BIST_OUT,
    output [3:0] FSM_OUT,
    input BIST_ENABLE
    );
	
	assign BSR_IN = BIST_ENABLE ? 4'bz : FSM_OUT;
	assign BIST_IN = BIST_ENABLE ? FSM_OUT : 4'bz;
	assign FSM_IN = BIST_ENABLE ? BIST_OUT : BSR_OUT;

endmodule
