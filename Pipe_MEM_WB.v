// 1. Definir modulo con I/O
module Pipe_MEM_WB(
    input clk,
    input rst,

    input in_regWrite,
    input in_memToReg,

    input [31:0] in_mem_res,
    input [31:0] in_alu_res,
    input [4:0] in_write_reg,

    output reg out_regWrite,
    output reg out_memToReg,

    output reg [31:0] out_mem_res,
    output reg [31:0] out_alu_res,
    output reg [4:0] out_write_reg
);

// 2. Cuerpo del modulo
always @(posedge clk or posedge rst)
begin
    if(rst)
    begin
        out_regWrite  <= 1'b0;
        out_memToReg  <= 1'b0;

        out_mem_res   <= 32'd0;
        out_alu_res   <= 32'd0;
        out_write_reg <= 5'd0;
    end
    else
    begin
        out_regWrite  <= in_regWrite;
        out_memToReg  <= in_memToReg;

        out_mem_res   <= in_mem_res;
        out_alu_res   <= in_alu_res;
        out_write_reg <= in_write_reg;
    end
end

endmodule