`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    05:12:50 10/24/2018 
// Design Name: 
// Module Name:    main_module 
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
module main_module(
    input TDI,
    input TMS,
    input TCK,
    input TRST,
	 input CORE_IN_1,
	 input CORE_IN_2,
	 input PIN_IN_1,
	 input PIN_IN_2,
	 output CORE_OUT_1,
	 output CORE_OUT_2,
	 output PIN_OUT_1,
	 output PIN_OUT_2,
    output TDO,
	 output [3:0] STATE_OUT_MAIN,
	 output TMS_LA,
	 output TDO_LA,
	 output TDI_LA,
	 output TCK_LA,
	 output [7:0] LEDs
    );
	 
	// For logic analyzer

	assign TMS_LA = TMS;
	assign TDO_LA = TDO;
	assign TDI_LA = TDI;
	assign TCK_LA = TCK;
	
	assign LEDs[1] = 1'b0;
	assign LEDs[0] = 1'b0;
		
	// TAP outputs
	wire TAP_UPDATE_IR;
	wire TAP_SHIFT_IR;
	wire TAP_CAPTURE_IR;
	wire TAP_UPDATE_DR;
	wire TAP_SHIFT_DR;
	wire TAP_CAPTURE_DR;
	wire TAP_SELECT;
	wire TAP_ENABLE;
	wire TAP_RST;
	wire TAP_TCKN;
	wire LOAD;
	
	// BSR output
	wire BSR_TDO;
	
	// Device id register output
	wire ID_TDO;
	
	// Bypass register output
	wire BYPASS_TDO;
	
	// Instruction register output
	wire [3:0] INS_REG_INSTR_REG;
	
	assign STATE_OUT_MAIN = INS_REG_INSTR_REG;
	//assign LEDs[4] = INS_REG_INSTR_REG[0];
	//assign LEDs[5] = INS_REG_INSTR_REG[1];
	//assign LEDs[6] = INS_REG_INSTR_REG[2];
	//assign LEDs[7] = INS_REG_INSTR_REG[3];
	wire INS_REG_TDO;
	
	// Instruction decoder outputs
	wire [1:0] INS_DEC_G1;
   wire INS_DEC_BYPASS_ENABLE;
   wire INS_DEC_DEVICE_ID_ENABLE;
	wire INS_DEC_BSR_ENABLE;
   wire INS_DEC_MODE_TEST_NORMAL;
	wire INS_DEC_CAPTURE_MODE_INPUT;
	wire INS_DEC_UPDATE_MODE_INPUT;
	wire INS_DEC_CAPTURE_MODE_OUTPUT;
	wire INS_DEC_UPDATE_MODE_OUTPUT;
	
	// G1 output
	wire G1_TDO;
	
	// G2 output
	wire G2_TDO;
	
	// Neg latch output
	wire NEG_LATCH_TDO;
	


	// Instantiate tap controller
	tap_ctl tap_ctl_inst (
		.TCK(TCK), 
		.TMS(TMS), 
		.TRST(TRST), 
		.UPDATE_IR(TAP_UPDATE_IR), 
		.SHIFT_IR(TAP_SHIFT_IR), 
		.CAPTURE_IR(TAP_CAPTURE_IR), 
		.UPDATE_DR(TAP_UPDATE_DR), 
		.SHIFT_DR(TAP_SHIFT_DR), 
		.CAPTURE_DR(TAP_CAPTURE_DR), 
		.SELECT(TAP_SELECT), 
		.ENABLE(TAP_ENABLE), 
		.RST(TAP_RST), 
		.TCKN(TAP_TCKN),
		.LOAD(LOAD)
	);
	
	bsr bsr_inst (
		.CORE_IN_1(CORE_IN_1),
		.CORE_IN_2(CORE_IN_2),
		.PIN_IN_1(PIN_IN_1),
		.PIN_IN_2(PIN_IN_2),
		.TDI(TDI),
		.CAPTURE(TAP_CAPTURE_DR),
		.UPDATE(TAP_UPDATE_DR),
		.SHIFT(TAP_SHIFT_DR),
		.ENABLE(INS_DEC_BSR_ENABLE),
		.MODE_TEST_NORMAL(INS_DEC_MODE_TEST_NORMAL),
		.MODE_SHIFT_LOAD(LOAD),
		.CAPTURE_MODE_INPUT(INS_DEC_CAPTURE_MODE_INPUT),
		.UPDATE_MODE_INPUT(INS_DEC_UPDATE_MODE_INPUT),
		.CAPTURE_MODE_OUTPUT(INS_DEC_CAPTURE_MODE_OUTPUT),
		.UPDATE_MODE_OUTPUT(INS_DEC_UPDATE_MODE_OUTPUT),
		.TDO(BSR_TDO),
		.CORE_OUT_1(CORE_OUT_1),
		.CORE_OUT_2(CORE_OUT_2),
		.PIN_OUT_1(PIN_OUT_1),
		.PIN_OUT_2(PIN_OUT_2),
		.BSR_OUT(LEDs[7:2])
	);
	
	device_id device_id_inst (
		.SHIFT(TAP_SHIFT_DR),
		.ENABLE(INS_DEC_DEVICE_ID_ENABLE),
		.D_RST(TAP_RST),
		.TDO(ID_TDO)
	);
	
	bypass bypass_inst (
		.TDI(TDI),
		.SHIFT(TAP_SHIFT_DR),
		.ENABLE(INS_DEC_BYPASS_ENABLE),
		.TDO(BYPASS_TDO)
	);
	
	instruction_reg instruction_reg_inst (
		 .TDI(TDI),
		 .SHIFT(TAP_SHIFT_IR),
		 .UPDATE(TAP_UPDATE_IR),
		 .ENABLE(TAP_SELECT),
		 .MODE_SHIFT_LOAD(LOAD),
		 .INSTR_REG(INS_REG_INSTR_REG),
		 .TDO(INS_REG_TDO)
	);
	
	instruction_decoder instruction_decoder_inst (
		.INSTR_REG(INS_REG_INSTR_REG),
		.G1(INS_DEC_G1),
		.BYPASS_ENABLE(INS_DEC_BYPASS_ENABLE),
		.DEVICE_ID_ENABLE(INS_DEC_DEVICE_ID_ENABLE),
		.BSR_ENABLE(INS_DEC_BSR_ENABLE),
		.MODE_TEST_NORMAL(INS_DEC_MODE_TEST_NORMAL),
		.CAPTURE_MODE_INPUT(INS_DEC_CAPTURE_MODE_INPUT),
		.UPDATE_MODE_INPUT(INS_DEC_UPDATE_MODE_INPUT),
		.CAPTURE_MODE_OUTPUT(INS_DEC_CAPTURE_MODE_OUTPUT),
		.UPDATE_MODE_OUTPUT(INS_DEC_UPDATE_MODE_OUTPUT)
	);
	
	g1 g1_inst (
		.CODE(INS_DEC_G1),
		.DEVICE_ID_TDO(ID_TDO),
		.BSR_TDO(BSR_TDO),
		.BYPASS_TDO(BYPASS_TDO),
		.G1_TDO(G1_TDO)
	);
	
	g2 g2_inst (
		.G1_TDO(G1_TDO),
		.SELECT(TAP_SELECT),
		.INSTRUCTION_REG_TDO(INS_REG_TDO),
		.G2_TDO(G2_TDO)
	);
	
	neg_latch neg_latch_inst (
		.G2_TDO(G2_TDO),
		.TCKN(TAP_TCKN),
		.TDO(NEG_LATCH_TDO)
	);
	
	z_state z_state_inst (
		.NEG_LATCH_TDO(NEG_LATCH_TDO),
		.ENABLE(TAP_ENABLE),
		.TDO(TDO)
	);


endmodule
