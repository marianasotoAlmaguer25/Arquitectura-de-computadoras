`timescale 1ns / 1ps

module TB_DPTR(); 

    // 1. Declaración de señales de estímulo
    reg clk;
    reg rst;
    reg [31:0] PC;
    wire [31:0] instruccion_leida;

    // 2. Memoria de instrucciones
    MemInst memoria_inst (
        .Adress(PC),
        .Instr(instruccion_leida)
    );

    // 3. Instancia del procesador DPTR
    DPTR dut (
        .clk(clk),
        .rst(rst),
        .instr(instruccion_leida)
    );

    // 4. Generador de reloj automático
    initial begin
        clk = 1'b0;
    end

    always begin
        #5 clk = ~clk;
    end

    // 5. Bloque principal de simulación
    initial begin
        // Inicialización
        PC = 32'd0;
        rst = 1'b1;

        // Reset para limpiar buffers
        #15;
        rst = 1'b0;

        // Lectura automática de instrucciones desde TestF2_MemInst.mem
        // Cada instrucción se mantiene un ciclo de reloj.
        repeat(16)
        begin
            #10;
            PC = PC + 32'd4;
        end

        // Vaciar pipeline
        #80;

        $display("=========================================================");
        $display("SIMULACION FASE 2 COMPLETADA");
        $display("Instrucciones leidas desde TestF2_MemInst.mem");
        $display("=========================================================");

        $stop;
    end

endmodule