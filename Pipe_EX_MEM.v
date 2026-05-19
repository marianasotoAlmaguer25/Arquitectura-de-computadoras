// 1. Definir modulo con I/O
module Pipe_EX_MEM(
    input clk,
    input rst,

    input in_regWrite,
    input in_memToReg,
    input in_memToWrite,
    input in_memToRead,
    input in_branch,

    input in_zero,
    input [31:0] in_alu_res,
    input [31:0] in_d2,
    input [4:0] in_write_reg,

    output reg out_regWrite,
    output reg out_memToReg,
    output reg out_memToWrite,
    output reg out_memToRead,
    output reg out_branch,

    output reg out_zero,
    output reg [31:0] out_alu_res,
    output reg [31:0] out_d2,
    output reg [4:0] out_write_reg
);

// 2. Cuerpo del modulo
always @(posedge clk or posedge rst)
begin
    if(rst)
    begin
        out_regWrite   <= 1'b0;
        out_memToReg   <= 1'b0;
        out_memToWrite <= 1'b0;
        out_memToRead  <= 1'b0;
        out_branch     <= 1'b0;

        out_zero       <= 1'b0;
        out_alu_res    <= 32'd0;
        out_d2         <= 32'd0;
        out_write_reg  <= 5'd0;
    end
    else
    begin
        out_regWrite   <= in_regWrite;
        out_memToReg   <= in_memToReg;
        out_memToWrite <= in_memToWrite;
        out_memToRead  <= in_memToRead;
        out_branch     <= in_branch;

        out_zero       <= in_zero;
        out_alu_res    <= in_alu_res;
        out_d2         <= in_d2;
        out_write_reg  <= in_write_reg;
    end
end

endmodule