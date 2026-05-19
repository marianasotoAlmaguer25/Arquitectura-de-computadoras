// 1. Definir modulo con I/O
module Pipe_ID_EX(
    input clk,
    input rst,

    input in_regWrite,
    input in_memToReg,
    input in_memToWrite,
    input in_memToRead,
    input in_branch,
    input in_aluSrc,
    input [2:0] in_aluOp,

    input [31:0] in_d1,
    input [31:0] in_d2,
    input [31:0] in_imm_ext,
    input [5:0] in_funct,
    input [4:0] in_rt,
    input [4:0] in_rd,

    output reg out_regWrite,
    output reg out_memToReg,
    output reg out_memToWrite,
    output reg out_memToRead,
    output reg out_branch,
    output reg out_aluSrc,
    output reg [2:0] out_aluOp,

    output reg [31:0] out_d1,
    output reg [31:0] out_d2,
    output reg [31:0] out_imm_ext,
    output reg [5:0] out_funct,
    output reg [4:0] out_rt,
    output reg [4:0] out_rd
);
//2. wires y registros 
// 3. Cuerpo del modulo
always @(posedge clk or posedge rst)
begin
    if(rst)
    begin
        out_regWrite   <= 1'b0;
        out_memToReg   <= 1'b0;
        out_memToWrite <= 1'b0;
        out_memToRead  <= 1'b0;
        out_branch     <= 1'b0;
        out_aluSrc     <= 1'b0;
        out_aluOp      <= 3'b000;

        out_d1         <= 32'd0;
        out_d2         <= 32'd0;
        out_imm_ext    <= 32'd0;
        out_funct      <= 6'd0;
        out_rt         <= 5'd0;
        out_rd         <= 5'd0;
    end
    else
    begin
        out_regWrite   <= in_regWrite;
        out_memToReg   <= in_memToReg;
        out_memToWrite <= in_memToWrite;
        out_memToRead  <= in_memToRead;
        out_branch     <= in_branch;
        out_aluSrc     <= in_aluSrc;
        out_aluOp      <= in_aluOp;

        out_d1         <= in_d1;
        out_d2         <= in_d2;
        out_imm_ext    <= in_imm_ext;
        out_funct      <= in_funct;
        out_rt         <= in_rt;
        out_rd         <= in_rd;
    end
end

endmodule