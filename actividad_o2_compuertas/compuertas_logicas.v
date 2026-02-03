//<3<3<3<3<3<3<3<3<3<3<3<3<3<3<3<3
// PRACTICA 1: 7 COMPUERTAS LOGICAS
//<3<3<3<3<3<3<3<3<3<3<3<3<3<3<3<3

// 1. creacion de modulo y definir I/O
module compuertas_principales(
    input A, 
    input B,
    output c1, // AND
    output c2, // NAND
    output c3, // OR
    output c4, // NOR
    output c5, // NOT
    output c6, // XOR
    output c7  // XNOR
);

/*2. definicion de componente internos(reg, cables)
queda vacia porque trabajamos solo con logica */

//3. cuerpo del modulo, asignaciones, instancias
    assign c1 = A & B;     // AND
    assign c2 = ~(A & B);    // NAND
    assign c3 = A | B;   // OR
    assign c4 = ~(A | B);  // NOR
    assign c5 = ~A;         // NOT
    assign c6 = A ^ B;     // XOR
    assign c7 = ~(A ^ B);   // XNOR

endmodule