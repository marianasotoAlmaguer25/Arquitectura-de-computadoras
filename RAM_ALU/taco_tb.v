`timescale 1ns/1ps
// Mariana Soto Almaguer
// 1. Declaracion de modulo testbench
module taco_tb();
    reg clk, EN, sel;
    reg [4:0] addr;
    reg [31:0] data_in;
    reg [3:0] alu_op;
    wire [31:0] data_out, alu_result;

// 2. instancia de la unidad a probar
    taco uut (clk, addr, data_in, EN, alu_op, sel, data_out, alu_result);

// 3. generacion de señales de prueba
    always #5 clk = ~clk;

    initial begin
        clk = 0; EN = 0; sel = 0; addr = 0; data_in = 0; alu_op = 0;
        
        $display("Iniciando Casos de Prueba...");

        // Caso 1: Escritura Asincrona
        #10 addr = 5; data_in = 100; EN = 1;
        #10 EN = 0; 

        // Caso 2: Lectura Asincrona y DEMUX (Salida Directa)
        #10 sel = 1; 
        
        // Caso 3: Operacion ALU (Suma: 2) -> 100 + 5 = 105
        #10 sel = 0; alu_op = 2; 
        
        // Caso 4: Cambio DEMUX y Operacion (Resta: 6) -> 100 - 5 = 95
        #10 alu_op = 6;

        #20 $finish;
    end
endmodule