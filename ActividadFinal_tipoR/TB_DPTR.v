/* Testbench: 10 Pruebas para Datapath Tipo-R
Usando registros R1-R6 (Valores: 10, 20, 30, 40, 50, 60)
*/

//1. Definir modulo con I/O
module TB_DPTR(); 

//2. Definicion de señales internas
    reg [31:0] instruccion;

//3. Instancia del procesador (DPTR)
    // Conectamos solo la instruccion porque el DPTR ya no recibe clk
    DPTR dut (instruccion);

initial begin
    // --- BLOQUE DE SUMAS (ADD) ---
    // 1. ADD: R1 = R2 + R3 (20 + 30) = 50
    instruccion = 32'b000000_00010_00011_00001_00000_100000;
    #20;

    // 2. ADD: R4 = R1 + R2 (50 + 20) = 70
    instruccion = 32'b000000_00001_00010_00100_00000_100000;
    #20;

    // --- BLOQUE DE RESTAS (SUB) ---
    // 3. SUB: R5 = R6 - R4 (60 - 40) = 20
    instruccion = 32'b000000_00110_00100_00101_00000_100010;
    #20;

    // 4. SUB: R6 = R3 - R2 (30 - 20) = 10
    instruccion = 32'b000000_00011_00010_00110_00000_100010;
    #20;

    // --- BLOQUE LÓGICO AND ---
    // 5. AND: R1 = R2 & R3
    instruccion = 32'b000000_00010_00011_00001_00000_100100;
    #20;

    // 6. AND: R2 = R4 & R5
    instruccion = 32'b000000_00100_00101_00010_00000_100100;
    #20;

    // --- BLOQUE LÓGICO OR ---
    // 7. OR: R3 = R1 | R2
    instruccion = 32'b000000_00001_00010_00011_00000_100101;
    #20;

    // 8. OR: R4 = R5 | R6
    instruccion = 32'b000000_00101_00110_00100_00000_100101;
    #20;

    // --- BLOQUE DE COMPARACIÓN (SLT) ---
    // 9. SLT: R5 = R2 < R3 (20 < 30) -> Resultado 1
    instruccion = 32'b000000_00010_00011_00101_00000_101010;
    #20;

    // 10. SLT: R6 = R4 < R1 (Si no es menor) -> Resultado 0
    instruccion = 32'b000000_00100_00001_00110_00000_101010;
    #20;

    $stop; // Fin de la simulación
end

endmodule