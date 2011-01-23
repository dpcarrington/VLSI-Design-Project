
/* Overly ambitious
module mux(
	input [BITS-1:0]select,
	input [DATAWIDTH-1:0]in[1 << BITS:1],
	output [DATAWIDTH-1:0]out);
	
	parameter BITS = 1;
	parameter DATAWIDTH = 1;
	
	wire [1 << BITS:0]tmp;
	
	genvar i, j, k;
	generate
		for (i = 0; i < DATAWIDTH; i = i + 1) begin:MUXTREE
			for (j = 0; j < BITS; j = j + 1) begin:TREELAYER
				for (k = 0; k < (1 << j); k = k + 1) begin:TREELEAF
					basicmux decision(select[j], tmp[
		
endmodule
*/

module basicmux(
	input select,
	input d0,
	input d1,
	output q);
	
	assign q = select ? d1 : d0;
endmodule

module encoder2to4(
	input [1:0]address,
	output zero,
	output one,
	output two,
	output three);

	assign zero = address == 2'b00;
	assign one = address == 2'b01;
	assign two = address == 2'b10;
	assign three = address == 2'b11;
endmodule
