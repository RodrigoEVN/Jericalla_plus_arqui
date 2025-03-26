//Hecho por Rodrigo Esaú Villegas Nuño y Jose Luis Chávez Gómez
//Etapa de control

module control(
	input  wire[1:0]  opcode,
	output reg [7:0]  salida_control
);
	
//En base a la entrada, la salida presentará 8 bits diferentes, siendo la distribución siguiente:
// 0 		-> Write enable de BR
// 1 2 3 4 	-> Operaciones de la ALU. 
// 5		-> selector del demux
// 6		-> Write enable de memoria
// 7		-> Read enable de memoria

always@(*)
	begin
		case(opcode)
			2'b00: salida_control = 8'b1_0_0_0010_1;		//Suma aritmética.
			2'b01: salida_control = 8'b1_0_0_0110_1;		//Resta aritmética
			2'b10: salida_control = 8'b1_0_0_0111_1;		//Operación ternaria
			2'b11: salida_control = 8'b0_1_1_0000_0;		//No importa la operación, se hace SW.
		endcase
	end
endmodule


