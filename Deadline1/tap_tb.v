module tap_tb;
	//Inputs
	reg tms;
	reg tck;
	//Outputs
	wire reset;
	wire select;
	wire enable;
	wire clock_ir;
	wire capture_ir;
	wire shift_ir;
	wire update_ir;
	wire clock_dr;
	wire capture_dr;
	wire shift_dr;
	wire update_dr;


// Instantiate the Unit Under Test (UUT)
tap uut(
	.tms (tms),
	.tck (tck),
	.reset (reset),
	.select (select),
	.enable (enable),
	.clock_ir (clock_ir),
	.capture_ir (capture_ir),
	.shift_ir (shift_ir),
	.update_ir (update_ir),
	.clock_dr (clock_dr),
	.capture_dr (capture_dr),
	.shift_dr (shift_dr),
	.update_dr (update_dr)
	);

// Insert Global Resets
initial begin
	tck = 0;
	tms = 1;
end

always
	#5  tck = ~tck;
	

initial begin
	//Beginning Loop (Assume start in Reset state)
	tms = 1; #10; // Remain in Reset
	tms = 0; #10; // Goto Run-Test/Idle
	tms = 0; #10; // Remain in Run-Test/Idle
	tms = 1; #10; // Goto Select-DR-Scan
	tms = 1; #10; // Goto Select-IR-Scan
	tms = 1; #10; // Goto Test-Logic-Reset / Reset 1
	tms = 0; #10; // Goto Run-Test/Idle

	//1st Speed DR (From Run-Test/Idle)
	tms = 1; #10; // Goto Select-DR-Scan
	tms = 0; #10; // Goto Capture-DR
	tms = 1; #10; // Goto Exit1-DR
	tms = 1; #10; // Goto Update-DR
	tms = 1; #10; // Goto Select-DR-Scan

	//2nd Full DR w/Loopback (From Select-DR-Scan)
	tms = 0; #10; // Goto Capture-DR
	tms = 0; #10; // Goto Shift-DR
	tms = 0; #10; // Remain in Shift-DR
	tms = 1; #10; // Goto Exit1_DR
	tms = 0; #10; // Goto Pause-DR
	tms = 0; #10; // Remain in Pause-DR
	tms = 1; #10; // Goto Exit2-DR 
	tms = 0; #10; // Goto Shift-DR
	tms = 1; #10; // Goto Exit1_DR
	tms = 0; #10; // Goto Pause-DR
	tms = 1; #10; // Goto Exit2-DR
	tms = 1; #10; // Goto Update-DR
	tms = 0; #10; // Goto Run-Test/Idle

	//3rd Speed IR (From Run-Test/Idle)
	tms = 1; #10; // Goto Select-DR-Scan
	tms = 1; #10; // Goto Select-IR-Scan
	tms = 0; #10; // Goto Capture-IR
	tms = 1; #10; // Goto Exit1-IR
	tms = 1; #10; // Goto Update-IR
	tms = 1; #10; // Goto Select-DR-Scan

	//4th Full IR w/Loopback (From Select-DR-Scan)
	tms = 1; #10; // Goto Select-IR-Scan
	tms = 0; #10; // Goto Capture-IR
	tms = 0; #10; // Goto Shift-IR
	tms = 0; #10; // Remain in Shift-IR
	tms = 1; #10; // Goto Exit1_IR
	tms = 0; #10; // Goto Pause-IR
	tms = 0; #10; // Remain in Pause-IR
	tms = 1; #10; // Goto Exit2-IR 
	tms = 0; #10; // Goto Shift-IR
	tms = 1; #10; // Goto Exit1_IR
	tms = 0; #10; // Goto Pause-IR
	tms = 1; #10; // Goto Exit2-IR
	tms = 1; #10; // Goto Update-IR
	tms = 0; #10; // Goto Run-Test/Idle

#10;

end

endmodule
