
module d_ff(clk, reset, enable, d, q, rstvalue);
	input clk, d, reset, enable, rstvalue;
	output q;
	reg q;

	always @(posedge clk)
		if (enable)
			q <= reset ? rstvalue : d;
endmodule

module register(
	input clk,
	input reset,
	input shift, //Enables shifting TDI
	input update, //Enables parallel-updating from parallel data in
  parallel_data,
	input tdi,
	output q,
	output tdo);
	parameter WIDTH = 8;
	parameter RESET_TO = 1'b1;
	wire [WIDTH:0]shift_line;
	wire [WIDTH-1:0]data;
	wire enable;
	
	input [WIDTH-1:0]parallel_data;
	output [WIDTH-1:0]q;
	
	assign shift_line[0] = tdi;
	assign q = shift_line[WIDTH:1];
	assign tdo = shift_line[WIDTH];
	assign enable = shift || update;
	
	genvar i;
	generate
		for (i = 0 ; i < WIDTH ; i = i + 1) begin:REG_BITS
			basicmux dataselect(shift, parallel_data[i], shift_line[i], data[i]);
			d_ff bit(clk, reset, enable, data[i], shift_line[i+1], RESET_TO);
		end
	endgenerate
endmodule

module shadow_register(
	input clk,
	input reset,
	input enable,
	input data,
	output q);
	parameter WIDTH = 8;
	parameter RESET_TO = 1'b1;
	
	input [WIDTH-1:0]data;
	output [WIDTH-1:0]q;
	
	genvar i;
	
	generate
		for (i = 0 ; i < WIDTH ; i = i + 1) begin:REG_BITS
			d_ff bit(clk, reset, enable, data[i], q[i], RESET_TO);
		end
	endgenerate
endmodule

module ir_scan_path(
	input clk,
	input reset,
	input shift,
	input capture,
	input update,
	input tdi,
	input status,
	output tdo,
	output instruction);
	parameter REG_WIDTH = 2;
	
	input [REG_WIDTH-1:0]status;
	output [REG_WIDTH-1:0]instruction;

	wire [REG_WIDTH-1:0]data;

	register #(.WIDTH(REG_WIDTH), .RESET_TO((1<<REG_WIDTH) - 1))
		ir_scan_latches(clk,
			reset,
			shift,
			capture,
			status,
			tdi,
			data,
			tdo);
	
	shadow_register #(.WIDTH(REG_WIDTH), .RESET_TO(1))
		ir_shadow_latches(clk, reset, update, data, instruction);
endmodule

module scan_block(
	input clk,
	input reset,
	input shift,
	input capture,
	input update,
	input tdi,
	output tdo);
	parameter REG_WIDTH = 8;
	
	wire [REG_WIDTH-1:0]cap_lines;
	wire [REG_WIDTH-1:0]upd_lines;
	
	register #( .WIDTH(REG_WIDTH) )
		scan_chain_block(clk,
			reset,
			shift, 
			capture, 
			cap_lines, 
			tdi,
			upd_lines,
			tdo);
	
	shadow_register #( .WIDTH(REG_WIDTH) )
		shadow (clk,
			reset,
			update,
			upd_lines,
			cap_lines);
	
endmodule
	
module bypass_register(
	input clk,
	input reset,
	input shift,
	input capture,
	input update,
	input tdi,
	output tdo);

	scan_block #(1)(clk, reset, shift, capture, update, tdi, tdo);
endmodule
