//Hecho por Rodrigo Esaú Villegas Nuño y José Luis Chávez Gómez
//ALU control

module ALU_control(
    input wire [5:0]  Function,
    input wire [2:0]  ALUOp_in,
    output reg [2:0]  OpALU_out
);

always@(*) 
	begin
		case (ALUOp_in)
			3'b010:									// Instrucciones tipo R
				case (Function)
					6'b100000: OpALU_out = 3'b010;		//Suma
					6'b100010: OpALU_out = 3'b110;		//Resta
					6'b100100: OpALU_out = 3'b000;		//AND
					6'b100101: OpALU_out = 3'b001;		//OR
					6'b101010: OpALU_out = 3'b111;		//SLT
				endcase
			3'b001: OpALU_out = 3'd0;        			// Instrucciones tipo J
			3'b000: OpALU_out = 3'd0;       			// Instrucciones tipo I
			default: OpALU_out = 3'd0;       			// Por defecto, salida en 0
		endcase
	end
endmodule

