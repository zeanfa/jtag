`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    01:54:13 10/24/2018 
// Design Name: 
// Module Name:    device_id 
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
module device_id(
    input SHIFT,
    input ENABLE,
	 input D_RST,
    output reg TDO
    );
	 
	 wire [7:0] ID_REG;
	 reg 	[2:0] counter;
	 
	 assign ID_REG = 8'hAB;
	 //assign TDO = ID_REG[counter];
	 
	 always @(posedge SHIFT or negedge D_RST) begin
		if (~D_RST) begin
			TDO <= 1'b0;
			counter <= 3'b0;
			//ID_REG <= 32'hABCD12FF;
		end
		
		else begin
			if (ENABLE) begin
				TDO <= ID_REG >> counter;
				counter <= counter + 1;
			end
		end
	 end


endmodule
