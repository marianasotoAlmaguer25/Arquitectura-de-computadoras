//1. CREACION DEL MODULO DEFINICION DE I/O
module BR(
    input [4:0] AR1,      
    input [4:0] AR2,      
    input [4:0] AW,      
    input [31:0] DW,      
    input RegWrite,       
    output reg [31:0] DR1, 
    output reg [31:0] DR2  
);

//2. DEFINICION DE REGISTROS Y WIRES

reg [31:0] carnita [0:31];

// 3. INICIALIZACION DEL MODULO Y BLOQUES SECUENCIALES
initial
begin
  
	carnita[0] = 32'd0;
    carnita[1] = 32'd10;
    carnita[2] = 32'd20;
    carnita[3] = 32'd30;
    carnita[4] = 32'd40;
    carnita[5] = 32'd50;
    carnita[6] = 32'd60;
end


always @(*)
begin
    
    DR1 = carnita[AR1];
    DR2 = carnita[AR2];

    
    if(RegWrite)
    begin
        carnita[AW] = DW;
    end
end

endmodule