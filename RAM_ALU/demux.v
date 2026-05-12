// 1.Declaracion de modulo demux y sus I/o
module demux (
	input [31:0] din,
	input sel,
	output reg [31:0] outA,
	output reg [31:0] outB
);
//2.Declaración de comp.
//internos wires: NA, Reg: si
//bloque always combinacional
always @(*) begin
    if (sel == 0) begin
        outA = 0;   
        outB = din; // outB va a la ALU 
    end else begin 
        outA = din; // outA va a data_out 
        outB = 0;
    end 
end

endmodule 

	