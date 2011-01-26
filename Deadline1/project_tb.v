module project_tb;
	//Inputs
	reg TMS;
	reg TDI;
	reg TCK;
	//Output
	wire TDO;


// Instantiate the Unit Under Test (UUT)
project uut(
	.TMS (TMS),
	.TDI (TDI),
	.TCK (TCK),
	.TDO (TDO)
	);
// Insert Global Resets??
initial begin
	TCK = 0;
	TDI = 1;
end

always
	#5 TCK = ~TCK;
	

initial begin
	TMS = 1; #10;
	TMS = 0; #10;
	TMS = 0; #10;
	TMS = 1; #10;
	TMS = 1; #10;
	TMS = 1; #10;
	TMS = 0; #10;


	TMS = 1; #10;
	TMS = 0; #10;
	TMS = 1; #10;
	TMS = 1; #10;
	TMS = 1; #10;


	TMS = 0; #10;
	TMS = 0; #10;
	TMS = 0; #10;
	TMS = 1; #10;
	TMS = 0; #10;
	TMS = 0; #10;
	TMS = 1; #10;
	TMS = 0; #10;
	TMS = 1; #10;
	TMS = 0; #10;
	TMS = 1; #10;
	TMS = 1; #10;
	TMS = 0; #10;


	TMS = 1; #10;
	TMS = 1; #10;
	TMS = 0; #10;
	TMS = 1; #10;
	TMS = 1; #10;
	TMS = 1; #10;


	TMS = 1; #10;
	TMS = 0; #10;
	TMS = 0; #10;
	TMS = 0; #10;
	TMS = 1; #10;
	TMS = 0; #10;
	TMS = 0; #10;
	TMS = 1; #10;
	TMS = 0; #10;
	TMS = 1; #10;
	TMS = 0; #10;
	TMS = 1; #10;
	TMS = 1; #10;
	TMS = 0; #10;

#10;

end

endmodule
