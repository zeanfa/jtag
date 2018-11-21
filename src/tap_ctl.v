`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    07:32:58 10/10/2018 
// Design Name: 
// Module Name:    tap_ctl 
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
module tap_ctl(
    input TCK,
    input TMS,
    input TRST,
    output reg UPDATE_IR,
    output SHIFT_IR,
    output reg CAPTURE_IR,
    output reg UPDATE_DR,
    output SHIFT_DR,
    output reg CAPTURE_DR,
    output SELECT, // connect ! to ENABLE of instruction_reg
    output reg ENABLE, // connect to MODE_SHIFT_SELECT
    output RST,
    output TCKN,
	 output LOAD,
	 output [3:0] STATE_OUT
    );

reg [3:0] state;
reg TEMP_SHIFT_DR;
reg TEMP_SHIFT_IR;

localparam STATE_TEST_LOGIC_RESET = 4'hF;
localparam STATE_RUN_TEST_IDLE    = 4'hC;
localparam STATE_SELECT_DR        = 4'h7;
localparam STATE_CAPTURE_DR       = 4'h6;
localparam STATE_SHIFT_DR         = 4'h2;
localparam STATE_EXIT1_DR         = 4'h1;
localparam STATE_PAUSE_DR         = 4'h3;
localparam STATE_EXIT2_DR         = 4'h0;
localparam STATE_UPDATE_DR        = 4'h5;
localparam STATE_SELECT_IR		    = 4'h4;
localparam STATE_CAPTURE_IR       = 4'hE;
localparam STATE_SHIFT_IR         = 4'hA; 
localparam STATE_EXIT1_IR         = 4'h9;
localparam STATE_PAUSE_IR         = 4'hB;
localparam STATE_EXIT2_IR         = 4'h8;
localparam STATE_UPDATE_IR			 = 4'hD;

always @(posedge TCK) begin

		//ENABLE   		<= state == STATE_SHIFT_DR | state == STATE_SHIFT_IR;
			
	  case(state)
			STATE_TEST_LOGIC_RESET: begin
				 if (TMS) begin state <= STATE_TEST_LOGIC_RESET; end
				 else     begin state <= STATE_RUN_TEST_IDLE;    end 
			end
			STATE_RUN_TEST_IDLE: begin
				 if (TMS) begin state <= STATE_SELECT_DR;   end
				 else     begin state <= STATE_RUN_TEST_IDLE;    end 
			end
			STATE_SELECT_DR: begin
				 if (TMS) begin state <= STATE_SELECT_IR;   end
				 else     begin state <= STATE_CAPTURE_DR;       end 
			end
			STATE_CAPTURE_DR: begin
				 if (TMS) begin state <= STATE_EXIT1_DR;         end
				 else     begin state <= STATE_SHIFT_DR;         end
			end
			STATE_SHIFT_DR: begin
				 if (TMS) begin state <= STATE_EXIT1_DR;         end
				 else     begin state <= STATE_SHIFT_DR;         end
			end
			STATE_EXIT1_DR: begin
				 if (TMS) begin state <= STATE_UPDATE_DR;        end
				 else     begin state <= STATE_PAUSE_DR;         end
			end
			STATE_PAUSE_DR: begin
				 if (TMS) begin state <= STATE_EXIT2_DR;         end
				 else     begin state <= STATE_PAUSE_DR;         end
			end
			STATE_EXIT2_DR: begin
				 if (TMS) begin state <= STATE_UPDATE_DR;        end
				 else     begin state <= STATE_SHIFT_DR;         end
			end
			STATE_UPDATE_DR: begin
				 if (TMS) begin state <= STATE_SELECT_DR;   end
				 else     begin state <= STATE_RUN_TEST_IDLE;    end
			end
			STATE_SELECT_IR: begin
				 if (TMS) begin state <= STATE_TEST_LOGIC_RESET; end
				 else     begin state <= STATE_CAPTURE_IR;       end 
			end
			STATE_CAPTURE_IR: begin
				 if (TMS) begin state <= STATE_EXIT1_IR;         end
				 else     begin state <= STATE_SHIFT_IR;         end
			end
			STATE_SHIFT_IR: begin
				 if (TMS) begin state <= STATE_EXIT1_IR;         end
				 else     begin state <= STATE_SHIFT_IR;         end
			end
			STATE_EXIT1_IR: begin
				 if (TMS) begin state <= STATE_UPDATE_IR;        end
				 else     begin state <= STATE_PAUSE_IR;         end
			end
			STATE_PAUSE_IR: begin
				 if (TMS) begin state <= STATE_EXIT2_IR;         end
				 else     begin state <= STATE_PAUSE_IR;         end
			end
			STATE_EXIT2_IR: begin
				 if (TMS) begin state <= STATE_UPDATE_IR;        end
				 else     begin state <= STATE_SHIFT_IR;         end
			end
			STATE_UPDATE_IR: begin
				 if (TMS) begin state <= STATE_SELECT_DR;   end
				 else     begin state <= STATE_RUN_TEST_IDLE;    end
			end
			default:           state <= STATE_TEST_LOGIC_RESET;
	  endcase
end

always @(negedge TCK) begin
		
		ENABLE   		<= state == STATE_SHIFT_DR | state == STATE_SHIFT_IR;
		UPDATE_IR  	  	<= 1'b0;
		TEMP_SHIFT_IR       <= 1'b0;
		UPDATE_DR  	  	<= 1'b0;
		TEMP_SHIFT_DR       <= 1'b0;
		CAPTURE_IR     <= 1'b0;
		CAPTURE_DR     <= 1'b0;
		
		case(state)
        STATE_UPDATE_IR:  begin UPDATE_IR   		 <= 1'b1; end
        STATE_SHIFT_IR:   begin TEMP_SHIFT_IR         <= 1'b1; end
        STATE_UPDATE_DR:  begin UPDATE_DR   		 <= 1'b1; end
        STATE_SHIFT_DR:   begin TEMP_SHIFT_DR         <= 1'b1; end
        STATE_CAPTURE_DR: begin CAPTURE_DR       <= 1'b1; end
        STATE_CAPTURE_IR: begin CAPTURE_IR       <= 1'b1; end
		endcase   
end

assign SHIFT_IR = TEMP_SHIFT_IR ? TCK : 1'b0;
assign SHIFT_DR = TEMP_SHIFT_DR ? TCK : 1'b0;
assign TCKN = ~TCK;
assign RST = ~(state == STATE_TEST_LOGIC_RESET);
//assign ENABLE   = state == STATE_SHIFT_DR | state == STATE_SHIFT_IR;
assign SELECT   = state == STATE_TEST_LOGIC_RESET   
                | state == STATE_RUN_TEST_IDLE
                | state == STATE_CAPTURE_DR
                | state == STATE_SHIFT_DR
                | state == STATE_EXIT1_DR
                | state == STATE_PAUSE_DR
                | state == STATE_EXIT2_DR
					 | state == STATE_UPDATE_DR;
assign LOAD = state == STATE_SHIFT_DR | state == STATE_SHIFT_IR;

assign STATE_OUT = state;



endmodule
