
module register_tb;
	reg clk, reset, shift, update, tdi;
	reg [7:0]data;

	wire [7:0]q;
	wire tdo;

	register UUT_1(clk, reset, shift, update, data, tdi, q, tdo);

	initial begin
		clk = 0;
		reset = 0;
		shift = 0;
		update = 0;
		tdi = 0;
		data = 0;
	end

	forever
		#5 clk = ~clk;
	
	initial begin
		#10;
		reset = 1; #10; //Set reset to high because it is active-low.

		data = 8'b10100011;
		update = 1;
		#10; //Perform a parallel data load

		update = 0;
		shift = 1;
		tdi = 0;
		#10; //Begin serial shift of register; will shift in 8'b01011100

		tdi = 0; #10;
		tdi = 1; #10;
		tdi = 1; #10;
		tdi = 1; #10;
		tdi = 0; #10;
		tdi = 1; #10;
		tdi = 0; #10;
	end
endmodule
