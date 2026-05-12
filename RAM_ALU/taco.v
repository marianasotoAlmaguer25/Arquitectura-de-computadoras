// 1. Declaración de modulo taco y sus I/O
module taco (
	input clk,
	input [4:0] addr,
	input [31:0] data_in,
	input EN,
	input [3:0] alu_op,
	input sel,
	output [31:0] data_out,
	output [31:0] alu_result 
	);
//2. Declaracion de comp.
//internos wires: si, Reg: NA
wire[ 31:0] w_ram_demux;
wire[31:0] w_demux_alu;
//3. instanicas de los componentes
//conectamos ram, demux y alu
ram m_ram (
	.addr(addr),
	.data_in(data_in),
	.EN(EN),
	.data_out(w_ram_demux)
);
demux m_demux (
	.din(w_ram_demux),
	.sel(sel),
	.outA(data_out),
	.outB(w_demux_alu)
	
);
alu m_alu (
	.alu_ctl(alu_op),
	.a(w_demux_alu),
	 .b(32'd5),
	.alu_out(alu_result),
	.zero()
	);
endmodule 
	


	