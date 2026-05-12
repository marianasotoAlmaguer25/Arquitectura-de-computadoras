// 1.Declarión de modulo ram I/0
module ram (
	input clk,
	input [4:0] addr,
	input [31:0] data_in,
	input EN,
	output [31:0] data_out
);
//2.declaracion  de com.
//internos wires: NA, Reg: si,
//arreglo bidimensional
reg[ 31:0] MEM [0:31];

//3.leer de la memoria en la posicio = addr
//escritura sincrona
always @(*) begin
	if (EN)
		MEM[addr] = data_in;
	end
// lectura inmediata al cambiar dirección
assign data_out = MEM[addr];

endmodule 