`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    02:27:09 10/24/2018 
// Design Name: 
// Module Name:    instruction_reg 
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
module instruction_reg(
    output [3:0] INSTR_REG,
	 output TDO,
    input TDI,
    input SHIFT,
    input UPDATE,
    input ENABLE,
	 input MODE_SHIFT_LOAD
    );
	 
	 wire TDO_1;
	 wire TDO_2;
	 wire TDO_3;
	 wire OUTPUT_UPDATE;
	 wire CAPTURE;
	 wire MODE_TEST_NORMAL;
	 
	 // ! is because SELECT is TRUE when DR is selected
	 assign CAPTURE = !ENABLE & SHIFT;
	 assign OUTPUT_UPDATE = !ENABLE & UPDATE;
	 assign MODE_TEST_NORMAL = 1'b0;
	 
	 simple_cell instruction_cell_1 (
		.TDIS(TDI),
		.CAPTURE(CAPTURE),
		.UPDATE(OUTPUT_UPDATE),
		.MODE_SHIFT_LOAD(MODE_SHIFT_LOAD),
		.MODE_TEST_NORMAL(MODE_TEST_NORMAL),
		.SYSTEM_DATA_IN(),
		.TDOS(TDO_1),
		.SYSTEM_DATA_OUT(INSTR_REG[0])
	);
	
	simple_cell instruction_cell_2 (
		.TDIS(TDO_1),
		.CAPTURE(CAPTURE),
		.UPDATE(OUTPUT_UPDATE),
		.MODE_SHIFT_LOAD(MODE_SHIFT_LOAD),
		.MODE_TEST_NORMAL(MODE_TEST_NORMAL),
		.SYSTEM_DATA_IN(),
		.TDOS(TDO_2),
		.SYSTEM_DATA_OUT(INSTR_REG[1])
	);
	
	simple_cell instruction_cell_3 (
		.TDIS(TDO_2),
		.CAPTURE(CAPTURE),
		.UPDATE(OUTPUT_UPDATE),
		.MODE_SHIFT_LOAD(MODE_SHIFT_LOAD),
		.MODE_TEST_NORMAL(MODE_TEST_NORMAL),
		.SYSTEM_DATA_IN(),
		.TDOS(TDO_3),
		.SYSTEM_DATA_OUT(INSTR_REG[2])
	);
	
	simple_cell instruction_cell_4 (
		.TDIS(TDO_3),
		.CAPTURE(CAPTURE),
		.UPDATE(OUTPUT_UPDATE),
		.MODE_SHIFT_LOAD(MODE_SHIFT_LOAD),
		.MODE_TEST_NORMAL(MODE_TEST_NORMAL),
		.SYSTEM_DATA_IN(),
		.TDOS(TDO),
		.SYSTEM_DATA_OUT(INSTR_REG[3])
	);


endmodule
