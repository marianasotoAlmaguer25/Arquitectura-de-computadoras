module ALU (
    input [15:0] A,
    input [15:0] B,
    input [2:0]  ALU_Sel,
    output reg [15:0] ALU_Out,
    output reg CarryOut,
    output Zero
);
    
    // Lógica combinacional para la bandera Zero
    assign Zero = (ALU_Out == 16'b0);

    always @(*) begin 
        // Valor por defecto para evitar errores de memoria (latches)
        CarryOut = 1'b0;
        
        case (ALU_Sel)
            3'b000: {CarryOut, ALU_Out} = A + B; // Suma
            3'b001: ALU_Out = A - B;             // Resta
            3'b010: ALU_Out = A & B;             // AND
            3'b011: ALU_Out = A | B;             // OR
            3'b100: ALU_Out = A ^ B;             // XOR
            3'b101: ALU_Out = ~(A | B);          // NOR
            3'b110: ALU_Out = A << 1;           // Shift Left
            3'b111: ALU_Out = A >> 1;           // Shift Right
            default: ALU_Out = 16'h0000;
        endcase
    end 
endmodule
	