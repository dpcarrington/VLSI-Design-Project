module tap (tck, tms, reset, select, enable, clock_ir, capture_ir, shift_ir, update_ir, clock_dr, capture_ir, shift_dr, update_dr);
	input tck, tms;
	output reset, select, enable, clock_ir, update_ir, shift_ir, clock_dr, update_dr, shift_dr;
	
	reg [3:0]y, Y;
	/* 
	JTAG TAP controller
	TMS/TDI are sampled on the rising edge of TCK
	TDO is sampled on the falling edge of TCK
	
	*/
	
	parameter 
		Run_Test_Idle = 4'b0000,
	/*
	States of JTAG machine
	A	Run_Test_Idle
	B	Select_Dr
	C	Capture_Dr
	D	Shift_Dr
	E	Exit1_Dr
	F	Pause_Dr
	G	Exit2_Dr
	H	Update_Dr
	I	Select_Ir
	J   Capture_Ir
	K   Shift_Ir
	L   Exit1_Ir
	M   Pause_Ir
	N   Exit2_Ir
	O   Update_Ir
	P	Reset
	
	*/
	
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
			default: 						Y = 4'bxxxx; // Unused
		endcase
	end
	
	
			
			
endmodule
