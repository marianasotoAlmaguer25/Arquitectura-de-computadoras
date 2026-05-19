//1. Definir modulo con I/O
module MemInst(
    input [31:0] Adress,
     output [31:0] Instr
     );

//2. definen comp. internos Reg o wires-SI, assigns-SI, instancias-na, bloq. secuenciales-SI
    reg [7:0] memInst [0:127];

//3. cuerpo del modulo, assigns-SI, instancias-na, bloq. secuenciales-SI
    initial begin
        $readmemb("TestF2_MemInst.mem", memInst);
    end

    assign Instr = {memInst[Adress], memInst[Adress + 1], memInst[Adress + 2], memInst[Adress + 3]};

endmodule