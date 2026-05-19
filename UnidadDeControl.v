// 1. Definir modulo con I/O expandido
module UnidadDeControl (
    input [5:0] op,          
    output reg memToReg,
    output reg memToWrite,   
    output reg memToRead,    
    output reg [2:0] aluOp,
    output reg regWrite,
    output reg aluSrc,       // Controla el multiplexor de la ALU
    output reg branch        // Bandera para instrucciones de salto (beq)
);

// 2. Bloque combinacional para decodificación de opcodes
always @* begin 
    // Valores por defecto para evitar latches no deseados
    memToReg   = 1'b0;
    memToRead  = 1'b0;
    memToWrite = 1'b0;
    aluOp      = 3'b000;
    regWrite   = 1'b0;  
    aluSrc     = 1'b0;
    branch     = 1'b0;

    case(op)
        // Instrucción de tipo R.
        6'b000000: begin 
            regWrite   = 1'b1;
            aluOp      = 3'b010; // Operación determinada por el campo "funct"
        end
        // Instrucciones de tipo I.
        6'b001000: begin // addi (Add Immediate)
            aluSrc     = 1'b1;   // Usa el valor inmediato sign-extended
            regWrite   = 1'b1;   // Escribe en el registro de destino
            aluOp      = 3'b000; // Suma
        end

        6'b001010: begin // slti (Set Less Than Immediate)
            aluSrc     = 1'b1;
            regWrite   = 1'b1;
            aluOp      = 3'b011; // Comparación menor que
        end

        6'b001100: begin // andi (And Immediate)
            aluSrc     = 1'b1;   // Usa el valor inmediato zero-extended
            regWrite   = 1'b1;
            aluOp      = 3'b100; // Operación AND
        end

        6'b001101: begin // ori (Or Immediate)
            aluSrc     = 1'b1;
            regWrite   = 1'b1;
            aluOp      = 3'b101; // Operación OR
        end

        6'b100011: begin // lw (Load Word)
            aluSrc     = 1'b1;   // Suma base + offset inmediato
            memToReg   = 1'b1;   // Pasa el dato de la memoria al registro
            regWrite   = 1'b1;   // Guarda en el registro
            memToRead  = 1'b1;   // Activa lectura de memoria
            aluOp      = 3'b000; // Suma para la dirección
        end

        6'b101011: begin // sw (Store Word)
            aluSrc     = 1'b1;   // Suma base + offset inmediato
            memToWrite = 1'b1;   // Activa escritura en memoria
            aluOp      = 3'b000; // Suma para la dirección
        end

        6'b000100: begin // beq (Branch on Equal)
            branch     = 1'b1;   // Activa la bandera de salto condicional
            aluOp      = 3'b001; // Resta (para verificar si son iguales)
        end
        // Instrucción de tipo J.
        6'b000010: begin // j (Jump)
            // En un MIPS estándar, 'j' suele activar una señal 'jump' dedicada.
            // Como la imagen no pide explícitamente una salida 'jump', dejamos
            // todas las señales de memoria y registros en 0 para evitar escrituras corruptas.
        end

        default: begin
            // Mantiene los valores por defecto definidos al inicio del block always
        end 
    endcase 
end

endmodule