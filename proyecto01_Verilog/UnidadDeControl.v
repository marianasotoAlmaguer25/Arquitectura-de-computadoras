//1. Definir modulo con I/O
module UnidadDecontrol (
    input [5:0] op,
    output reg memToReg,
    output reg memToWrite,
    output reg memToRead,
    output reg [2:0] aluOp,
    output reg regWrite
);

//2. definen comp. internos Reg o wires-SI, assigns-na, instancias-na, bloq. secuenciales-SI
always @* begin 
    case(op)
        6'b000000: begin // Tipo-R
            memToReg  = 1'b0;
            memToRead = 1'b0;
            memToWrite = 1'b0;
            aluOp     = 3'b010;
            regWrite  = 1'b1;
        end
        default: begin
            memToReg  = 1'b0;
            memToRead = 1'b0;
            memToWrite = 1'b0;
            aluOp     = 3'b000;
            regWrite  = 1'b0;
        end 
    endcase 
end

//3. cuerpo del modulo, assigns-na, instancias-na, bloq. secuenciales-SI
endmodule