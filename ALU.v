//1. Definir modulo con I/O
module ALU (
    input [31:0] a,
    input [31:0] b,
    input [2:0] alu_control,
    output reg [31:0] result,
    output zero
);

//2. definen comp. internos Reg o wires-na, assigns-SI, instancias-na, bloq. secuenciales-SI
always @* begin
    case (alu_control)
        3'b000:  result = a & b;
        3'b001:  result = a | b;
        3'b010:  result = a + b;
        3'b110:  result = a - b;
        3'b111:  result = (a < b) ? 32'd1 : 32'd0; // SLT operador ternario
        default: result = 32'b0;
    endcase
end

assign zero = (result == 32'b0);

//3. cuerpo del modulo, assigns-SI, instancias-na, bloq. secuenciales-SI
endmodule