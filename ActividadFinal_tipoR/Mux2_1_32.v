//1. Definir modulo con I/O
module Mux2_1_32 (
    input [31:0] d0,      // Dato de la ALU (cuando sel=0)
    input [31:0] d1,      // Dato de la Memoria (cuando sel=1)
    input sel,            // Señal MemToReg (viene de la UC)
    output [31:0] out     // Dato seleccionado
);

//2. definen comp. internos Reg o wires-na, assigns-SI, instancias-na, bloq. secuenciales-na
// Aquí no hay memoria ni reloj, solo una selección directa.

//3. cuerpo del modulo, assigns-SI, instancias-na, bloq. secuenciales-na
    assign out = (sel == 1'b0) ? d0 : d1; 

endmodule