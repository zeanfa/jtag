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
    input TDI,
    input CAPTURE,
    input SHIFT,
    input ENABLE,
    input MODE_SHIFT_LOAD,
    output TDO
    );
	 
	 wire TDO_1;
	 wire TDO_2;
	 wire TDO_3;
	 wire [3:0] ID_REG;
	 wire INPUT_CAPTURE;
	 
	 assign ID_REG = 4'hA;
	 assign INPUT_CAPTURE = ENABLE & (CAPTURE | SHIFT);
	 
	 simple_cell input_cell_1 (
		.TDIS(TDI),
		.CAPTURE(INPUT_CAPTURE),
		.UPDATE(),
		.MODE_SHIFT_LOAD(MODE_SHIFT_LOAD),
		.MODE_TEST_NORMAL(),
		.SYSTEM_DATA_IN(ID_REG[0]),
		.TDOS(TDO_1),
		.SYSTEM_DATA_OUT()
	);
	
	simple_cell input_cell_2 (
		.TDIS(TDO_1),
		.CAPTURE(INPUT_CAPTURE),
		.UPDATE(),
		.MODE_SHIFT_LOAD(MODE_SHIFT_LOAD),
		.MODE_TEST_NORMAL(),
		.SYSTEM_DATA_IN(ID_REG[1]),
		.TDOS(TDO_2),
		.SYSTEM_DATA_OUT()
	);
	
	simple_cell input_cell_3 (
		.TDIS(TDO_2),
		.CAPTURE(INPUT_CAPTURE),
		.UPDATE(),
		.MODE_SHIFT_LOAD(MODE_SHIFT_LOAD),
		.MODE_TEST_NORMAL(),
		.SYSTEM_DATA_IN(ID_REG[2]),
		.TDOS(TDO_3),
		.SYSTEM_DATA_OUT()
	);
	
	simple_cell input_cell_4 (
		.TDIS(TDO_3),
		.CAPTURE(INPUT_CAPTURE),
		.UPDATE(),
		.MODE_SHIFT_LOAD(MODE_SHIFT_LOAD),
		.MODE_TEST_NORMAL(),
		.SYSTEM_DATA_IN(ID_REG[3]),
		.TDOS(TDO),
		.SYSTEM_DATA_OUT()
	);


endmodule
