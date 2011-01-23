module tap (
	// Inputs
	tck, 	// External Clock Source
	tms, 	// State Machine Control
	// Outputs
	reset, 	// Register Reset signal
	select, // Selects between IR and DR TDO signals
	enable, // Enables TDO output (in Shift_Ir or Shift_Dr state)
	
	// Instruction Register Signals
	clock_ir, 	// Clock for Instruction Register Latches
	capture_ir, // Signal to shift previous state out of the Shadow Latches
	shift_ir, 	// Signal to shift TDI into Serial Latches
	update_ir, 	// Singal to shift Serial state into Shadow Latches
	
	// Data Register Signals
	clock_dr, 	// Clock for Instruction Register Latches
	capture_ir, // Signal to shift previous state out of the Shadow Latches
	shift_dr,   // Signal to shift TDI into Serial Latches
	update_dr   // Singal to shift Serial state into Shadow Latches
);
	
	input tck, tms;
	output reset, select, enable, clock_ir, capture_ir, shift_ir, update_ir, clock_dr, capture_ir, shift_dr, update_dr;
	
	reg [3:0]y, Y;
	/* 
	JTAG TAP controller
	TMS/TDI are sampled on the rising edge of TCK
	TDO is sampled on the falling edge of TCK
	
	*/
	
	parameter // States of JTAG machine
		Run_Test_Idle 	= 4'b0000,
		
		Select_Dr 		= 4'b0001,
		Capture_Dr 		= 4'b0010,
		Shift_Dr 		= 4'b0011,
		Exit1_Dr 		= 4'b0100,
		Pause_Dr 		= 4'b0101,
		Exit2_Dr 		= 4'b0110,
		Update_Dr 		= 4'b0111,
		
		Reset 			= 4'b1000,
						
		Select_Ir 		= 4'b1001,
		Capture_Ir 		= 4'b1010,
		Shift_Ir 		= 4'b1011,
		Exit1_Ir 		= 4'b1100,
		Pause_Ir 		= 4'b1101,
		Exit2_Ir 		= 4'b1110,
		Update_Ir 		= 4'b1111;

	
	always @(posedge tck)
	begin
		case(y)
			Run_Test_Idle:	if(tms == 0)	Y = Run_Test_Idle
				else						Y = Select_Dr;
			Select_Dr:	if(tms == 0)		Y = Capture_Dr;
				else						Y = Select_Ir;
			Capture_Dr:	if(tms == 0)		Y = Shift_Dr;
				else						Y = Exit1_Dr;
			Shift_Dr:	if(tms == 0)		Y = Shift_Dr;
				else						Y = Exit1_Dr;
			Exit1_Dr:	if(tms == 0)		Y = Pause_Dr;
				else						Y = Update_Dr
			Pause_Dr:	if(tms == 0)		Y = Pause_Dr;
				else						Y = Exit2_Dr;
			Exit2_Dr:	if(tms == 0)		Y = Shift_Dr;
				else						Y = Update_Dr;
			Update_Dr:	if(tms == 0)		Y = Run_Test_Idle;
				else						Y = Select_Dr;
			Select_Ir:	if(tms == 0)		Y = Capture_Ir
				else						Y = Reset;
			Capture_Ir:	if(tms == 0)		Y = Shift_Ir;
				else						Y = Exit1_Ir;
			Shift_Ir:	if(tms == 0)		Y = Shift_Ir;
				else						Y = Exit1_Ir;
			Exit1_Ir:	if(tms == 0)		Y = Pause_Ir;
				else						Y = Update_Ir;
			Pause_Ir	if(tms == 0)		Y = Pause_Ir;
				else						Y = Exit2_Ir;
			Exit2_Ir:	if(tms == 0)		Y = Shift_Ir;
				else						Y = Update_Ir;
			Update_Ir:	if(tms == 0)		Y = Run_Test_Idle
				else						Y = Select_Dr;
			Reset:	if(tms == 0)			Y = Run_Test_Idle
				else						Y = Reset;
			default: 						Y = 4'b1000; // Reset
		endcase
	end
	
	// Output Assignments
	assign reset = (y == Reset);
	assign select = (Y == 4'b1xxx); // 1 for IR, 0 otherwise
	// assign select = (Y[3] == 1'b1); // 1 for IR, 0 otherwise
	
	assign capture_ir = (Y == Capture_Ir);
	assign shift_ir = (Y == Capture_Ir); 
	assign update_ir = (Y == Capture_Ir);
	assign clock_ir = ((capture_ir || shift_ir || update_ir) && tck);
	
	assign capture_dr = (Y == Capture_Dr);
	assign shift_dr = (Y == Capture_Dr); 
	assign update_dr = (Y == Capture_Dr);
	assign clock_dr = ((capture_dr || shift_dr || update_dr) && tck);
			
	assign enable = shift_ir || shift_dr;
			
endmodule
