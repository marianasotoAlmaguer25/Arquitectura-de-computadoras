//1. Definir modulo con I/O
module Mem(input [31:0] Adress, input [31:0] WriteData, input We, input Re, output reg [31:0] ReadData);

//2. definen comp. internos Reg o wires-SI, assigns-na, instancias-na, bloq. secuenciales-SI
    reg [31:0] sram [0:127];

//3. cuerpo del modulo, assigns-na, instancias-na, bloq. secuenciales-SI
    always @(*) begin
        if (We) begin
            sram[Adress[6:0]] = WriteData;
        end
        else if (Re) begin
            ReadData = sram[Adress[6:0]];
        end
        else begin
            ReadData = 32'd0;
        end
    end
endmodule