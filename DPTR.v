// 1. Definir modulo con I/O 
module DPTR (
    input clk,
    input rst,
    input [31:0] instr
);

// 2. DEFINICION DE INTERCONEXIONES WIRES O REGS 

// ---- IF/ID ----
wire [31:0] id_instr;

// ---- ID ----
wire uc_regWrite, uc_memToWrite, uc_memToRead, uc_memToReg, uc_aluSrc, uc_branch;
wire [2:0] uc_aluOp;
wire [31:0] id_d1, id_d2;
wire [31:0] id_imm_ext;

// ---- ID/EX ----
wire ex_regWrite, ex_memToWrite, ex_memToRead, ex_memToReg, ex_aluSrc, ex_branch;
wire [2:0] ex_aluOp;
wire [31:0] ex_d1, ex_d2;
wire [31:0] ex_imm_ext;
wire [5:0] ex_funct;
wire [4:0] ex_rt;
wire [4:0] ex_rd;

// ---- EX ----
wire [2:0] ex_aluSel;
wire [31:0] ex_mux_alu_out;
wire [31:0] ex_alu_res;
wire ex_zero_flag;
wire [4:0] ex_write_reg_dest;

// ---- EX/MEM ----
wire mem_regWrite, mem_memToWrite, mem_memToRead, mem_memToReg, mem_branch;
wire mem_zero_flag;
wire [31:0] mem_alu_res;
wire [31:0] mem_write_data;
wire [4:0] mem_write_reg_dest;

// ---- MEM ----
wire [31:0] mem_res;
wire branch_taken;

// ---- MEM/WB ----
wire wb_regWrite, wb_memToReg;
wire [31:0] wb_mem_res;
wire [31:0] wb_alu_res;
wire [4:0] wb_write_reg_dest;

// ---- WB ----
wire [31:0] wb_d_final;

// 3. CUERPO DEL MODULO E INSTANCIAS

// BUFFER IF/ID
Pipe_IF_ID buffer_if_id (
    .clk(clk),
    .rst(rst),
    .in_instr(instr),
    .out_instr(id_instr)
);

// UNIDAD DE CONTROL
UnidadDeControl UC (
    .op(id_instr[31:26]),
    .memToReg(uc_memToReg),
    .memToWrite(uc_memToWrite),
    .memToRead(uc_memToRead),
    .aluOp(uc_aluOp),
    .regWrite(uc_regWrite),
    .aluSrc(uc_aluSrc),
    .branch(uc_branch)
);

// BANCO DE REGISTROS
BR miBR (
    .AR1(id_instr[25:21]),
    .AR2(id_instr[20:16]),
    .AW(wb_write_reg_dest),
    .DW(wb_d_final),
    .RegWrite(wb_regWrite),
    .DR1(id_d1),
    .DR2(id_d2)
);

// EXTENSION DE SIGNO
assign id_imm_ext = {{16{id_instr[15]}}, id_instr[15:0]};

// BUFFER ID/EX
Pipe_ID_EX buffer_id_ex (
    .clk(clk),
    .rst(rst),

    .in_regWrite(uc_regWrite),
    .in_memToReg(uc_memToReg),
    .in_memToWrite(uc_memToWrite),
    .in_memToRead(uc_memToRead),
    .in_branch(uc_branch),
    .in_aluSrc(uc_aluSrc),
    .in_aluOp(uc_aluOp),

    .in_d1(id_d1),
    .in_d2(id_d2),
    .in_imm_ext(id_imm_ext),
    .in_funct(id_instr[5:0]),
    .in_rt(id_instr[20:16]),
    .in_rd(id_instr[15:11]),

    .out_regWrite(ex_regWrite),
    .out_memToReg(ex_memToReg),
    .out_memToWrite(ex_memToWrite),
    .out_memToRead(ex_memToRead),
    .out_branch(ex_branch),
    .out_aluSrc(ex_aluSrc),
    .out_aluOp(ex_aluOp),

    .out_d1(ex_d1),
    .out_d2(ex_d2),
    .out_imm_ext(ex_imm_ext),
    .out_funct(ex_funct),
    .out_rt(ex_rt),
    .out_rd(ex_rd)
);

// ALU CONTROL
ALU_ctrl AC (
    .aluOp(ex_aluOp),
    .fnC(ex_funct),
    .salidaAc(ex_aluSel)
);

// MUX ALUSrc
Mux2_1_32 mux_alu_src (
    .d0(ex_d2),
    .d1(ex_imm_ext),
    .sel(ex_aluSrc),
    .out(ex_mux_alu_out)
);

// ALU
ALU miALU (
    .a(ex_d1),
    .b(ex_mux_alu_out),
    .alu_control(ex_aluSel),
    .result(ex_alu_res),
    .zero(ex_zero_flag)
);

// REGISTRO DESTINO
// Tipo R escribe en rd
// Tipo I escribe en rt
assign ex_write_reg_dest = (ex_aluOp == 3'b010) ? ex_rd : ex_rt;

// BUFFER EX/MEM
Pipe_EX_MEM buffer_ex_mem (
    .clk(clk),
    .rst(rst),

    .in_regWrite(ex_regWrite),
    .in_memToReg(ex_memToReg),
    .in_memToWrite(ex_memToWrite),
    .in_memToRead(ex_memToRead),
    .in_branch(ex_branch),

    .in_zero(ex_zero_flag),
    .in_alu_res(ex_alu_res),
    .in_d2(ex_d2),
    .in_write_reg(ex_write_reg_dest),

    .out_regWrite(mem_regWrite),
    .out_memToReg(mem_memToReg),
    .out_memToWrite(mem_memToWrite),
    .out_memToRead(mem_memToRead),
    .out_branch(mem_branch),

    .out_zero(mem_zero_flag),
    .out_alu_res(mem_alu_res),
    .out_d2(mem_write_data),
    .out_write_reg(mem_write_reg_dest)
);

// MEMORIA DE DATOS
Mem miMem (
    .Adress(mem_alu_res),
    .WriteData(mem_write_data),
    .We(mem_memToWrite),
    .Re(mem_memToRead),
    .ReadData(mem_res)
);

// BRANCH
assign branch_taken = mem_branch & mem_zero_flag;

// BUFFER MEM/WB
Pipe_MEM_WB buffer_mem_wb (
    .clk(clk),
    .rst(rst),

    .in_regWrite(mem_regWrite),
    .in_memToReg(mem_memToReg),

    .in_mem_res(mem_res),
    .in_alu_res(mem_alu_res),
    .in_write_reg(mem_write_reg_dest),

    .out_regWrite(wb_regWrite),
    .out_memToReg(wb_memToReg),

    .out_mem_res(wb_mem_res),
    .out_alu_res(wb_alu_res),
    .out_write_reg(wb_write_reg_dest)
);

// WRITE BACK
Mux2_1_32 mux_wb (
    .d0(wb_alu_res),
    .d1(wb_mem_res),
    .sel(wb_memToReg),
    .out(wb_d_final)
);

endmodule