
module d_ff(clk, reset, enable, d, q);
	input clk, d, reset, enable;
	output q;
	reg q;

	always @(posedge clk)
		if (enable)
			q <= reset & d;
endmodule

module register(
	input clk,
	input reset,
	input shift, //Enables shifting TDI
	input update, //Enables parallel-updating from parallel data in
	input [WIDTH-1:0]parallel_data,
	input tdi,
	output [WIDTH-1:0]q,
	output tdo);
	
	parameter WIDTH = 8;
	wire [WIDTH:0]shift_line;
	wire [WIDTH-1:0]data;
	wire enable;
	
	assign shift_line[0] = tdi;
	assign q = shift_line[WIDTH:1];
	assign tdo = shift_line[WIDTH];
	assign enable = shift || update;
	
	genvar i;
	generate
		for (i = 0 ; i < WIDTH ; i = i + 1) begin:REG_BITS
			basicmux dataselect(shift, parallel_data[i], shift_line[i], data[i])
			d_ff bit(clk, reset, enable, data[i], shift_line[i+1]);
		end
	endgenerate
endmodule

module shadow_register(
	input clk,
	input reset,
	input enable,
	input [WIDTH-1:0]data,
	output [WIDTH-1:0]q);
	
	parameter WIDTH = 8;
	
	genvar i;
	
	generate
		for (i = 0 ; i < WIDTH ; i = i + 1) begin:REG_BITS
			d_ff bit(clk, reset, enable, data[i], q[i]);
		end
	endgenerate
endmodule

module instruction_register_scan_path(
	input clk,
	input reset,
	input shift,
	input capture,
	input update,
	input tdi,
	output tdo,
	output [REG_WIDTH-1:0]instruction);
	parameter REG_WIDTH = 2;

	wire [REG_WIDTH-1:0]status;
	wire [REG_WIDTH-1:0]data;

	assign status = 2'b01;

	register #(.WIDTH(REG_WIDTH))
		ir_scan_latches(clk,
			reset,
			shift,
			capture,
			status,
			tdi,
			data,
			tdo);
	
	shadow_register #(.WIDTH(REG_WIDTH))
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
	
