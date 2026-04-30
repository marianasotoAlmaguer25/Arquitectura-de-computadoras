//1. Definir modulo con I/O
module Mem(
    input [31:0] Adress,
    input [31:0] WriteData,
    input We,
    input Re,
    output reg [31:0] ReadData
);

//2. definen comp. internos Reg o wires-SI, assigns-na, instancias-na, bloq. secuenciales-SI
reg [31:0] sram [0:127];

//3. cuerpo del modulo, assigns-na, instancias-na, bloq. secuenciales-SI
initial begin
    sram[0]=32'd100;
    sram[1]=32'd200;
    sram[2]=32'd300;
    sram[3]=32'd400;
    sram[4]=32'd500;
    sram[5]=32'd600;
    sram[6]=32'd700;
end

always @(*) begin
    if (We)
        sram[Adress[6:0]] = WriteData;
    else if (Re)
        ReadData = sram[Adress[6:0]];
end

endmodule