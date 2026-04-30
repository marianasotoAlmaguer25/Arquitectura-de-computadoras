//1. Definir modulo con I/O
module DPTR (
    input [31:0] instr
);

//2. Definicion de componentes internos (Wires)
wire RegW, MemW, MemR, MtoReg;
wire [2:0] AlOp;
wire [2:0] AlSel;
wire [31:0] d1, d2, alu_res, mem_res, d_final;
wire zero_flag;

//3. Cuerpo del modulo e instancias de los componentes


UnidadDecontrol UC (instr[31:26], MtoReg, MemW, MemR, AlOp, RegW);


BR miBR (instr[25:21], instr[20:16], instr[15:11], d_final, RegW, d1, d2);


ALU_ctrl AC (AlOp, instr[5:0], AlSel);


ALU miALU (d1, d2, AlSel, alu_res, zero_flag);

Mem miMem (alu_res, d2, MemW, MemR, mem_res);

// Selección del dato final (ALU o Memoria) para regresar al Banco de Registros
Mux2_1_32 mux (alu_res, mem_res, MtoReg, d_final);

endmodule