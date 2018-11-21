`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    03:25:46 10/23/2018 
// Design Name: 
// Module Name:    bsr 
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
module bsr(
    output TDO,
	 output CORE_OUT_1,
	 output CORE_OUT_2,
	 output PIN_OUT_1,
	 output PIN_OUT_2,
	 output [5:0] BSR_OUT,
	 input CORE_IN_1,
	 input CORE_IN_2,
	 input PIN_IN_1,
	 input PIN_IN_2,
    input TDI,
    input CAPTURE,
    input UPDATE,
    input SHIFT,
    input ENABLE,
    input MODE_TEST_NORMAL,
	 input MODE_SHIFT_LOAD,
	 input CAPTURE_MODE_INPUT,
	 input UPDATE_MODE_INPUT,
	 input CAPTURE_MODE_OUTPUT,
	 input UPDATE_MODE_OUTPUT
    );
	 
	 wire INPUT_CAPTURE;
	 wire OUTPUT_CAPTURE;
	 wire INPUT_UPDATE;
	 wire OUTPUT_UPDATE;
	 wire LSB_CAPTURE;
	 wire TDO_1;
	 wire TDO_2;
	 wire TDO_3;
	 wire TDO_4;
	 wire TDO_n0;
	 
	 assign INPUT_CAPTURE = ENABLE & ((CAPTURE & CAPTURE_MODE_INPUT) | SHIFT);
	 assign INPUT_UPDATE = ENABLE & UPDATE & UPDATE_MODE_INPUT;
	 assign OUTPUT_CAPTURE = ENABLE & ((CAPTURE & CAPTURE_MODE_OUTPUT) | SHIFT);
	 assign OUTPUT_UPDATE = ENABLE & UPDATE & UPDATE_MODE_OUTPUT;
	 assign LSB_CAPTURE = ENABLE & (CAPTURE | SHIFT);
	 
	 assign BSR_OUT = {TDO_1, TDO_2, TDO_3, TDO_4, TDO_n0, TDO};
	 
	
	simple_cell input_cell_1 (
		.TDIS(TDI),
		.CAPTURE(INPUT_CAPTURE),
		.UPDATE(INPUT_UPDATE),
		.MODE_SHIFT_LOAD(MODE_SHIFT_LOAD),
		.MODE_TEST_NORMAL(MODE_TEST_NORMAL),
		.SYSTEM_DATA_IN(PIN_IN_1),
		.TDOS(TDO_1),
		.SYSTEM_DATA_OUT(CORE_OUT_1)
	);
	
	simple_cell input_cell_2 (
		.TDIS(TDO_1),
		.CAPTURE(INPUT_CAPTURE),
		.UPDATE(INPUT_UPDATE),
		.MODE_SHIFT_LOAD(MODE_SHIFT_LOAD),
		.MODE_TEST_NORMAL(MODE_TEST_NORMAL),
		.SYSTEM_DATA_IN(PIN_IN_2),
		.TDOS(TDO_2),
		.SYSTEM_DATA_OUT(CORE_OUT_2)
	);

	simple_cell output_cell_1 (
		.TDIS(TDO_2),
		.CAPTURE(OUTPUT_CAPTURE),
		.UPDATE(OUTPUT_UPDATE),
		.MODE_SHIFT_LOAD(MODE_SHIFT_LOAD),
		.MODE_TEST_NORMAL(MODE_TEST_NORMAL),
		.SYSTEM_DATA_IN(CORE_IN_1),
		.TDOS(TDO_3),
		.SYSTEM_DATA_OUT(PIN_OUT_1)
	);
	
	simple_cell output_cell_2 (
		.TDIS(TDO_3),
		.CAPTURE(OUTPUT_CAPTURE),
		.UPDATE(OUTPUT_UPDATE),
		.MODE_SHIFT_LOAD(MODE_SHIFT_LOAD),
		.MODE_TEST_NORMAL(MODE_TEST_NORMAL),
		.SYSTEM_DATA_IN(CORE_IN_2),
		.TDOS(TDO_4),
		.SYSTEM_DATA_OUT(PIN_OUT_2)
	);
	
	simple_cell cell_n0 (
		.TDIS(TDO_4),
		.CAPTURE(LSB_CAPTURE),
		.UPDATE(1'b0),
		.MODE_SHIFT_LOAD(MODE_SHIFT_LOAD),
		.MODE_TEST_NORMAL(1'b0),
		.SYSTEM_DATA_IN(1'b1),
		.TDOS(TDO_n0),
		.SYSTEM_DATA_OUT()
	);
	
	simple_cell cell_n1 (
		.TDIS(TDO_n0),
		.CAPTURE(LSB_CAPTURE),
		.UPDATE(1'b0),
		.MODE_SHIFT_LOAD(MODE_SHIFT_LOAD),
		.MODE_TEST_NORMAL(1'b0),
		.SYSTEM_DATA_IN(1'b0),
		.TDOS(TDO),
		.SYSTEM_DATA_OUT()
	);


endmodule
