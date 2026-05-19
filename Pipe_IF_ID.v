// 1. Definir modulo con I/O
module Pipe_IF_ID(
    input clk,
    input rst,
    input [31:0] in_instr,
    output reg [31:0] out_instr
);
//2. regs o wires 
// 3. Cuerpo del modulo
always @(posedge clk or posedge rst)
begin
    if(rst)
    begin
        out_instr <= 32'd0;
    end
    else
    begin
        out_instr <= in_instr;
    end
end

endmodule