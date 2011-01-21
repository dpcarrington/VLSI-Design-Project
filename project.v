
module project (
	input tdi,
	input tms,
	input tck,
	output tdo)
	parameter REGISTER_WIDTH = 8;
	
	wire tap_reset, tap_select, tap_enable;
	wire tap_clock_ir, tap_update_ir, tap_shift_ir;
	wire tap_clock_dr, tap_update_dr, tap_shift_dr;
	
	wire ir_tdo, dr_tdo;
	
	basic_mux tdo_mux(tap_select, dr_tdo, ir_tdo, tdo);
	
	tap controller(tck, tms, tap_reset, tap_select, tap_enable,
		tap_clock_ir, tap_capture_ir, tap_shift_ir, tap_update_ir,
		tap_clock_dr, tap_capture_ir, tap_shift_dr, tap_update_dr);
		
	scan_block #( REG_WIDTH(REGISTER_WIDTH) )
		IR_scan_path(tap_clock_ir, 
			tap_reset,
			tap_shift_ir, 
			tap_capture_ir, 
			tap_update_ir, 
			tdi, 
			ir_tdo);
		
	scan_block #( REG_WIDTH(REGISTER_WIDTH) )
		DR_scan_path(tap_clock_dr,
			tap_reset,
			tap_shift_dr,
			tap_capture_dr,
			tap_update_dr,
			tdi,
			dr_tdo);
endmodule
