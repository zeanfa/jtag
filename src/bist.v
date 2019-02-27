`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    08:52:44 12/19/2018 
// Design Name: 
// Module Name:    bist 
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
module bist(
    input				ENABLE,
    input				CLK,
//  [0 preset   ] [0-16 number of test] [0-256 user test length]
//  [1 user test]
    input		[12:0]	BIST_CONF_REG,
    input		[2051:0]BIST_USER_TEST,
    input		[3:0]	FSM_IN,
    output reg  [3:0]	FSM_OUT,
	output reg 	[3:0]	FSM_PRESET,
	output reg			FSM_ENABLE,
// [input when error occured] [output expected][output got][error code]
    output reg  [15:0]	BIST_STATUS_REG
    );
	
	parameter TEST_LEN = 20;
	reg en_dly;
	reg [11:0] counter;
	reg	stop_bit;
	reg [3:0] error_code;
	reg [3:0] output_got;
	reg [3:0] output_expected;
	reg [3:0] input_got;
	reg [TEST_LEN - 13:0] test;
	
	wire test_select;
	wire [3:0] test_num;
	wire [7:0] user_test_len;
	wire [11:0] init_state;
	wire en_edge;

// [initial state] [input x] [expected output y]
	localparam [TEST_LEN - 1:0] test0 = 20'h80902;
	localparam [TEST_LEN - 1:0] test1 = 20'h73110;
	localparam [TEST_LEN - 1:0] test2 = 20'h77331;
	localparam [TEST_LEN - 1:0] test3 = 20'h77331;
	localparam [TEST_LEN - 1:0] test4 = 20'hfffff;
	localparam [TEST_LEN - 1:0] test5 = 20'h0;
	localparam [TEST_LEN - 1:0] test6 = 20'h0;
	localparam [TEST_LEN - 1:0] test7 = 20'h33110;
	localparam [TEST_LEN - 1:0] test8 = 20'h0;
	localparam [TEST_LEN - 1:0] test9 = 20'h0;
	localparam [TEST_LEN - 1:0] test10= 20'h0;
	localparam [TEST_LEN - 1:0] test11= 20'h0;
	localparam [TEST_LEN - 1:0] test12= 20'h0;
	localparam [TEST_LEN - 1:0] test13= 20'h0;
	localparam [TEST_LEN - 1:0] test14= 20'h0;
	localparam [TEST_LEN - 1:0] test15= 20'h0;
	
	assign en_edge = ENABLE & ~en_dly;
	assign test_select = BIST_CONF_REG[12];
	assign test_num = BIST_CONF_REG[11:8];
	assign user_test_len = BIST_CONF_REG[7:0];
	assign init_state = !test_select 	?		(test_num == 4'h0 ?
						test0[11:0]			:	(test_num == 4'h1 ?
						test1[11:0]			:	(test_num == 4'h2 ?
						test2[11:0]			:	(test_num == 4'h3 ?
						test3[11:0]			:	(test_num == 4'h4 ?
						test4[11:0]			:	(test_num == 4'h5 ?
						test5[11:0]			:	(test_num == 4'h6 ?
						test6[11:0]			:	(test_num == 4'h7 ?
						test7[11:0]			:	(test_num == 4'h8 ?
						test8[11:0]			:	(test_num == 4'h9 ?
						test9[11:0]			:	(test_num == 4'hA ?
						test10[11:0]		:	(test_num == 4'hB ?
						test11[11:0]		:	(test_num == 4'hC ?
						test12[11:0]		:	(test_num == 4'hD ?
						test13[11:0]		:	(test_num == 4'hE ?
						test14[11:0]		:	(test15))))))))))))))))	
											:	BIST_USER_TEST[11:0];
	always @(negedge CLK) begin
		en_dly <= ENABLE;
	end
		
	always @(negedge CLK) begin
		if (en_edge) begin
			stop_bit <= 0;
		end
		
		if (ENABLE & !stop_bit) begin
			if (counter == 0) begin
				counter <= counter + 1;
				BIST_STATUS_REG <= 16'b0;
				FSM_PRESET <= init_state[3:0];
				error_code <= 4'h0;
				output_got <= 4'h0;
				input_got <= 4'h0;
				output_expected <= 0;
				if (!test_select) begin
					case(test_num)
						4'h0: test <= test0[TEST_LEN - 1:12];
						4'h1: test <= test1[TEST_LEN - 1:12];
						4'h2: test <= test2[TEST_LEN - 1:12];
						4'h3: test <= test3[TEST_LEN - 1:12];
						4'h4: test <= test4[TEST_LEN - 1:12];
						4'h5: test <= test5[TEST_LEN - 1:12];
						4'h6: test <= test6[TEST_LEN - 1:12];
						4'h7: test <= test7[TEST_LEN - 1:12];
						4'h8: test <= test8[TEST_LEN - 1:12];
						4'h9: test <= test9[TEST_LEN - 1:12];
						4'hA: test <= test10[TEST_LEN - 1:12];
						4'hB: test <= test11[TEST_LEN - 1:12];
						4'hC: test <= test12[TEST_LEN - 1:12];
						4'hD: test <= test13[TEST_LEN - 1:12];
						4'hE: test <= test14[TEST_LEN - 1:12];
						4'hF: test <= test15[TEST_LEN - 1:12];
						default: test <= 0;
					endcase
				end
			end
			else if (counter == 1) begin
				counter <= counter + 1;
				FSM_ENABLE <= 1'b1;
				FSM_OUT <= init_state[7:4];
				input_got <= init_state[7:4];
				output_expected <= init_state[11:8];
			end
			else if (counter < user_test_len) begin
				counter <= counter + 1;
				if (test_select) begin
					FSM_OUT	<= {BIST_USER_TEST[(counter - 1)*8 + 7], 
								BIST_USER_TEST[(counter - 1)*8 + 6], 
								BIST_USER_TEST[(counter - 1)*8 + 5], 
								BIST_USER_TEST[(counter - 1)*8 + 4]};
								
					input_got	<= {BIST_USER_TEST[(counter - 1)*8 + 7], 
								BIST_USER_TEST[(counter - 1)*8 + 6], 
								BIST_USER_TEST[(counter - 1)*8 + 5], 
								BIST_USER_TEST[(counter - 1)*8 + 4]};
					
					output_expected <= {BIST_USER_TEST[(counter - 1)*8 + 11],
											BIST_USER_TEST[(counter - 1)*8 + 10],
											BIST_USER_TEST[(counter - 1)*8 + 9],
											BIST_USER_TEST[(counter - 1)*8 + 8]};
					
				end
				else begin
					FSM_OUT	<= {test[(counter - 2)*8 + 3], 
								test[(counter - 2)*8 + 2], 
								test[(counter - 2)*8 + 1], 
								test[(counter - 2)*8]};
								
					input_got	<= {test[(counter - 2)*8 + 3], 
									test[(counter - 2)*8 + 2], 
									test[(counter - 2)*8 + 1], 
									test[(counter - 2)*8]};
					
					output_expected <= {test[(counter - 2)*8 + 7],
										test[(counter - 2)*8 + 6],
										test[(counter - 2)*8 + 5],
										test[(counter - 2)*8 + 4]};
				end
				if (~(FSM_IN == output_expected)) begin
					stop_bit <= 1'b1;
					error_code <= 4'h5;
					output_got <= FSM_IN;
				end
			end
			else begin
				stop_bit <= 1'b1;
				FSM_ENABLE <= 1'b0;	
				if (~(FSM_IN == output_expected)) begin
					error_code <= 4'h5;
					output_got <= FSM_IN;
				end
				else begin
					error_code <= 4'hF;
					output_got <= FSM_IN;
				end
			end
		end
		else begin
			counter <= 0;
			BIST_STATUS_REG <= {input_got, output_expected, output_got, error_code};
		end
	end


endmodule
