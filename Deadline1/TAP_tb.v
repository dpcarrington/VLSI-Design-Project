module TAP_tb;
	//Inputs
	reg TMS;
	reg TCK;
	//Outputs
	wire reset;
	wire select;
	wire enable;
	wire clock_ir;
	wire capture_ir;
	wire shift_ir;
	wire update_ir;
	wire clock_dr;
	wire capture_ir;
	wire shift_dr;
	wire update_dr;


// Instantiate the Unit Under Test (UUT)
TAP uut(
	.TMS (TMS),
	.TDI (TDI),
	.TCK (TCK),
	.TDO (TDO),
	.reset (reset),
	.select (select),
	.enable (enable),
	.clock_ir (clock_ir),
	.capture_ir (capture_ir),
	.shift_ir (shift_ir),
	.update_ir (update_ir),
	.clock_dr (clock_dr),
	.capture_ir (capture_ir),
	.shift_dr (shift_dr),
	.update_dr (update_dr),
	);

// Insert Global Resets
initial begin
	TCK = 0;
	TDI = 1;
end

always
	#10  TCK = ~TCK;
	

initial begin
	//Beginning Loop (Assume start in Reset state)
	TMS = 1; #10 // Remain in Reset
	TMS = 0; #10 // Goto Run-Test/Idle
	TMS = 0; #10 // Remain in Run-Test/Idle
	TMS = 1; #10 // Goto Select-DR-Scan
	TMS = 1; #10 // Goto Select-IR-Scan
	TMS = 1; #10 // Goto Test-Logic-Reset
	TMS = 0; #10 // Goto Run-Test/Idle

	//1st Speed DR (From Run-Test/Idle)
	TMS = 1; #10 // Goto Select-DR-Scan
	TMS = 0; #10 // Goto Capture-DR
	TMS = 1; #10 // Goto Exit1-DR
	TMS = 1; #10 // Goto Update-DR
	TMS = 1; #10 // Goto Select-DR-Scan

	//2nd Full DR w/Loopback (From Select-DR-Scan)
	TMS = 0; #10 // Goto Capture-DR
	TMS = 0; #10 // Goto Shift-DR
	TMS = 0; #10 // Remain in Shift-DR
	TMS = 1; #10 // Goto Exit1_DR
	TMS = 0; #10 // Goto Pause-DR
	TMS = 0; #10 // Remain in Pause-DR
	TMS = 1; #10 // Goto Exit2-DR 
	TMS = 0; #10 // Goto Shift-DR
	TMS = 1; #10 // Goto Exit1_DR
	TMS = 0; #10 // Goto Pause-DR
	TMS = 1; #10 // Goto Exit2-DR
	TMS = 1; #10 // Goto Update-DR
	TMS = 0; #10 // Goto Run-Test/Idle

	//3rd Speed IR (From Run-Test/Idle)
	TMS = 1; #10 // Goto Select-DR-Scan
	TMS = 1; #10 // Goto Select-IR-Scan
	TMS = 0; #10 // Goto Capture-IR
	TMS = 1; #10 // Goto Exit1-IR
	TMS = 1; #10 // Goto Update-IR
	TMS = 1; #10 // Goto Select-DR-Scan

	//4th Full IR w/Loopback (From Select-DR-Scan)
	TMS = 1; #10 // Goto Select-IR-Scan
	TMS = 0; #10 // Goto Capture-IR
	TMS = 0; #10 // Goto Shift-IR
	TMS = 0; #10 // Remain in Shift-IR
	TMS = 1; #10 // Goto Exit1_IR
	TMS = 0; #10 // Goto Pause-IR
	TMS = 0; #10 // Remain in Pause-IR
	TMS = 1; #10 // Goto Exit2-IR 
	TMS = 0; #10 // Goto Shift-IR
	TMS = 1; #10 // Goto Exit1_IR
	TMS = 0; #10 // Goto Pause-IR
	TMS = 1; #10 // Goto Exit2-IR
	TMS = 1; #10 // Goto Update-IR
	TMS = 0; #10 // Goto Run-Test/Idle

#10

end

endmodule
