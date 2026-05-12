//1. Definir modulo con I/O
module TB_DPTR(); 

//2. definen comp. internos Reg o wires-SI, assigns-na, instancias-na, bloq. secuenciales-SI
    reg [31:0] PC; 
    wire [31:0] instruccion_leida;

    // Instancia de la memoria de instrucciones
    MemInst memoria_inst (
        .Adress(PC),
        .Instr(instruccion_leida)
    );

    DPTR dut (
        .instr(instruccion_leida)
    );

//3. cuerpo del modulo, assigns-na, instancias-na, bloq. secuenciales-SI
    initial begin
        PC = 32'd0;   
        #100;

        PC = 32'd4;   
        #100;

        PC = 32'd8;   
        #100;

        PC = 32'd12;  
        #100;

        PC = 32'd16;  
        #100;

        $display("=========================================================");
        $display("SIMULACION COMPLETADA");
        $display("Las instrucciones fueron leidas desde TestF1_MemInst.mem");
        $display("=========================================================");
        
        $stop;
    end

endmodule