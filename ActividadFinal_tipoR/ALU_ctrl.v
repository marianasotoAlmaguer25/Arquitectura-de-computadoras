//1. Definir modulo con I/O
module ALU_ctrl(
    input [2:0] aluOp,
    input [5:0] fnC,
    output reg [2:0] salidaAc
);

//2. definen comp. internos Reg o wires-na, assigns-na, instancias-na, bloq. secuenciales-SI
always @* begin 
    case(aluOp)
        3'b010: begin 
            case(fnC)
                6'b100000: salidaAc = 3'b010; // ADD
                6'b100010: salidaAc = 3'b110; // SUB
                6'b100100: salidaAc = 3'b000; // AND
                6'b100101: salidaAc = 3'b001; // OR
                6'b101010: salidaAc = 3'b111; // SLT
                default:   salidaAc = 3'b000;
            endcase
        end
        default: salidaAc = 3'b010; 
    endcase
end

//3. cuerpo del modulo, assigns-na, instancias-na, bloq. secuenciales-SI
endmodule