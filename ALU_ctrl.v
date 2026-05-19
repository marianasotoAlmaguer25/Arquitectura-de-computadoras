// 1. Definir modulo con I/O
module ALU_ctrl(
    input [2:0] aluOp,         
    input [5:0] fnC,           
    output reg [2:0] salidaAc  
);

// 2. Bloque combinacional para decodificar la operación de la ALU
always @* begin 
    case(aluOp)
        // lw, sw, addi: Fuerzan una SUMA en la ALU para calcular dirección o inmediato
        3'b000: begin 
            salidaAc = 3'b010; // Código de SUMA en tu ALU
        end
        // beq: Fuerza una RESTA en la ALU para comparar igualdad
        3'b001: begin 
            salidaAc = 3'b110; // Código de RESTA en tu ALU
        end
        // Tipo-R: Depende del campo de función (fnC / funct)
        3'b010: begin 
            case(fnC)
                6'b100000: salidaAc = 3'b010; // ADD
                6'b100010: salidaAc = 3'b110; // SUB
                6'b100100: salidaAc = 3'b000; // AND
                6'b100101: salidaAc = 3'b001; // OR
                6'b101010: salidaAc = 3'b111; // SLT
                default:   salidaAc = 3'b010; 
            endcase
        end
        // slti: Fuerza una comparación "Menor que"
        3'b011: begin
            salidaAc = 3'b111; // Código de SLT en tu ALU
        end
        // andi: Fuerza una operación AND lógica
        3'b100: begin
            salidaAc = 3'b000; // Código de AND en tu ALU
        end
        // ori: Fuerza una operación OR lógica
        3'b101: begin
            salidaAc = 3'b001; // Código de OR en tu ALU
        end
        // Caso por defecto (Por seguridad)
        default: begin
            salidaAc = 3'b010; // Mantiene una operación segura por defecto (Suma)
        end 
    endcase
end

// 3. cuerpo del modulo, assigns-na, instancias-na, bloq. secuenciales-SI
endmodule