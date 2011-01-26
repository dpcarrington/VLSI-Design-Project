
module project (
	input tdi,
	input tms,
	input tck,
	output tdo);
	parameter REGISTER_WIDTH = 8;
	
	wire tap_reset, tap_select, tap_enable;
	wire tap_clock_ir, tap_update_ir, tap_shift_ir;
	wire tap_clock_dr, tap_update_dr, tap_shift_dr;
	
	wire ir_tdo, dr_tdo, tdo_gated;
	wire [1:0]instruction;
	
	basic_mux tdo_mux(tap_select, dr_tdo, ir_tdo, tdo_gated);
	
	bufif1 tdo_buffer(tdo, tdo_gated, tap_enable);
	
	tap controller(tck, tms, tap_reset, tap_select, tap_enable,
		tap_clock_ir, tap_capture_ir, tap_shift_ir, tap_update_ir,
		tap_clock_dr, tap_capture_ir, tap_shift_dr, tap_update_dr);
		
	ir_scan_path IR_Scan_Path(tap_clock_ir, 
			tap_reset,
			tap_shift_ir, 
			tap_capture_ir, 
			tap_update_ir, 
			tdi, 
			2'b01,
			ir_tdo,
			instruction);
		
	dr_scan_path DR_Scan_Path(tap_clock_dr,
			tap_reset,
			tap_shift_dr,
			tap_capture_dr,
			tap_update_dr,
			tdi,
			instruction,
			dr_tdo);
endmodule

module dr_scan_path(
	input clk,
	input reset,
	input shift,
	input capture,
	input update,
	input tdi,
	input instruction,
	output tdo);
	parameter INST_WIDTH = 2;
	
	input [INST_WIDTH-1:0]instruction;

	wire bypass_enable, sample_enable, extest_enable;
	wire boundary_enable;
	wire bypass_tdo;
	wire boundary_tdo;

	bypass_register Bypass(clk, reset && bypass_enable, 
			shift && bypass_enable, 
			capture && bypass_enable, 
			update && bypass_enable, 
			tdi, bypass_tdo);
	scan_block Boundary_Scan(clk, reset && boundary_enable,
			shift && boundary_enable,
			capture && boundary_enable,
			update && boundary_enable,
			tdi, boundary_tdo);
	
	decoder2to4 Address_Encoder(.address(instruction), .zero(extest_enable),
			.one(sample_enable), .three(bypass_enable));
	assign tdo = boundary_enable ? boundary_tdo : bypass_tdo;
endmodule
