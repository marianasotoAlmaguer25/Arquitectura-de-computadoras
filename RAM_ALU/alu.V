//1.Declaración de modulo alu y sus I/O
module alu(
	input [3:0] alu_ctl,
	input [31:0] a, b,
	output reg [31:0] alu_out,
	output zero
);

//2. declaración de comp.
//internos wires: NA, Reg: si,
//bloque always condicional
 always @(*) begin
	case (alu_ctl)
	0: alu_out <= a & b; //AND
	1:  alu_out <= a | b;          // OR
    2:  alu_out <= a + b;          // Add
    6:  alu_out <= a - b;          // Subtract
    7:  alu_out <= a < b ? 1 : 0;  // SLT
    12: alu_out <= ~(a | b);       // NOR
        default: alu_out <= 0;
    endcase
end
	// 3. Asignación de bandera Zero y resultado final
	assign Zero = (alu_out == 0 );
	endmodule
	