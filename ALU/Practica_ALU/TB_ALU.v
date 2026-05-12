`timescale 1ns / 1ps

module TB_ALU();
    reg  [15:0] A, B;
    reg  [2:0]  ALU_Sel;
    wire [15:0] ALU_Out;
    wire CarryOut, Zero;

    // Instancia de la ALU
    ALU uut (
        .A(A), .B(B), .ALU_Sel(ALU_Sel), 
        .ALU_Out(ALU_Out), .CarryOut(CarryOut), .Zero(Zero)
    );

    initial begin
        // --- 000: SUMA ---
        ALU_Sel = 3'b000;
        A = 16'd100; B = 16'd200; #10;
        A = 16'd1000; B = 16'd500; #10;
        A = 16'd65535; B = 16'd1; #10; // Prueba de Acarreo (Carry)

        // --- 001: RESTA ---
        ALU_Sel = 3'b001;
        A = 16'd500; B = 16'd200; #10;
        A = 16'd10; B = 16'd10; #10;   // Prueba de Cero (Zero)
        A = 16'd50; B = 16'd100; #10;  // Prueba de resultado negativo

        // --- 010: AND ---
        ALU_Sel = 3'b010;
        A = 16'hFFFF; B = 16'h1234; #10;
        A = 16'hAAAA; B = 16'h5555; #10;
        A = 16'h00FF; B = 16'h0F0F; #10;

        // --- 011: OR ---
        ALU_Sel = 3'b011;
        A = 16'hF0F0; B = 16'h0F0F; #10;
        A = 16'hAAAA; B = 16'h5555; #10;
        A = 16'h0000; B = 16'h1234; #10;

        // --- 100: XOR ---
        ALU_Sel = 3'b100;
        A = 16'hFFFF; B = 16'hFFFF; #10; // Resultado 0
        A = 16'hAAAA; B = 16'h5555; #10; // Resultado FFFF
        A = 16'h1234; B = 16'h0000; #10;

        // --- 101: NOR ---
        ALU_Sel = 3'b101;
        A = 16'h0000; B = 16'h0000; #10; // Resultado FFFF
        A = 16'hFFFF; B = 16'hFFFF; #10;
        A = 16'h5555; B = 16'hAAAA; #10;

        // --- 110: SHIFT LEFT (A << 1) ---
        ALU_Sel = 3'b110;
        A = 16'd1; B = 16'd0; #10;    // Resultado 2
        A = 16'd100; B = 16'd0; #10;  // Resultado 200
        A = 16'h8000; B = 16'd0; #10; // Se pierde el bit más significativo

        // --- 111: SHIFT RIGHT (A >> 1) ---
        ALU_Sel = 3'b111;
        A = 16'd2; B = 16'd0; #10;    // Resultado 1
        A = 16'd500; B = 16'd0; #10;  // Resultado 250
        A = 16'h0001; B = 16'd0; #10; // Resultado 0

        $display("Simulación completa. Revisa la consola para los resultados.");
        $stop;
    end

    initial begin
        $monitor("Hora=%0t | Op=%b | A=%d | B=%d | Out=%d | C=%b | Z=%b", 
                 $time, ALU_Sel, A, B, ALU_Out, CarryOut, Zero);
    end
endmodule