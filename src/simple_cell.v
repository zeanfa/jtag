`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    17:46:54 10/22/2018 
// Design Name: 
// Module Name:    simple_cell 
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
module simple_cell(
    input TDIS,
    input CAPTURE,
    input UPDATE,
    input MODE_SHIFT_LOAD,
    input MODE_TEST_NORMAL,
    input SYSTEM_DATA_IN,
    output TDOS,
    output SYSTEM_DATA_OUT
    );
	reg capture_reg;
	reg update_reg;

	assign SYSTEM_DATA_OUT = (SYSTEM_DATA_IN & MODE_TEST_NORMAL) | (update_reg & !MODE_TEST_NORMAL);
	assign TDOS = capture_reg;

	always @(posedge CAPTURE) begin
		capture_reg <=  (SYSTEM_DATA_IN & !MODE_SHIFT_LOAD) | (TDIS & MODE_SHIFT_LOAD);
	end

	always @(posedge UPDATE) begin
		update_reg <=  capture_reg;
	end


endmodule
