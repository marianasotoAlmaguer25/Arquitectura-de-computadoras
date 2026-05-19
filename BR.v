//1. Definir modulo con I/O
module BR(input [4:0] AR1, input [4:0] AR2, input [4:0] AW, input [31:0] DW, input RegWrite, output reg [31:0] DR1, output reg [31:0] DR2);

//2. definen comp. internos Reg o wires-SI, assigns-na, instancias-na, bloq. secuenciales-SI
    reg [31:0] carnita [0:31];

//3. cuerpo del modulo, assigns-na, instancias-na, bloq. secuenciales-SI
    initial begin
        
$readmemb("TestF1_BReg.mem", carnita); 
 carnita[0] = 32'd0;
    end

    always @(*) begin
        DR1 = carnita[AR1];
        DR2 = carnita[AR2];
        if(RegWrite && AW != 5'd0) carnita[AW] = DW;
    end
endmodule