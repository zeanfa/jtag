`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    15:10:35 12/17/2018 
// Design Name: 
// Module Name:    fsm 
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
//
	//{0100000000000000}// 0
	//{1113151111111111}// 1
	//{2222252222222222}// 2
	//{3333353733333333}// 3
	//{4424454444444444}// 4
	//{5555555555555555}// 5
	//{6666656666666666}// 6
	//{7777776777A77777}// 7
	//{8888486888888888}// 8
	//{9999996999999999}// 9
	//{AAAAAAAAA9AAADAA}// 10
	//{BBBBBBBB89BBBBBB}// 11
	//{CCCCCCCCC9CCCCCC}// 12
	//{DDDDDDDDDDDDCDDF}// 13
	//{EEEEEEEEEEEBCEEE}// 14
	//{FFFFFFFFFFFFCFEF}// 15
//////////////////////////////////////////////////////////////////////////////////
module fsm(
    input [3:0] X,
	input [3:0] PRESET_Y,
    output reg [3:0] Y,
    input CLK,
    input ENABLE
    );
	//reg [0:1023] memory = 1024'h01000000000000001113151111111111222225222222222233333537333333334424454444444444000000000000000066666566666666667777776777A7777788884868888888889999996999999999AAAAAAAAA9AAADAABBBBBBBB89BBBBBBCCCCCCCCC9CCCCCCDDDDDDDDDDDDCDDFEEEEEEEEEEEBCEEEFFFFFFFFFFFFCFEF;
	reg [0:1023] memory = 1024'h300000006A600A0D11B1000011138161999922222221E226333333F33343333347444C4C444444915582555555550554615466666B66666C077A757777772E2E88D78888881B83888699999999E999C9ADA2AAAAAA8AAAA5BBBBB4BBBE1BB8BDECCCCCCCC699CC3CDD0DD2DDD3DDDD5AEEEEEEEEEEEE3431AFFFCCCCFF6F3FFF;
	
	always @(posedge CLK) begin
		if (ENABLE) begin
			Y[3] <= memory[(Y*16 + X)*4];
			Y[2] <= memory[(Y*16 + X)*4 + 1];
			Y[1] <= memory[(Y*16 + X)*4 + 2];
			Y[0] <= memory[(Y*16 + X)*4 + 3];
		end
		else begin
			Y <= PRESET_Y;
		end
	end
endmodule
