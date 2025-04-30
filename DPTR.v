//Hecho por Rodrigo Esaú Villegas Nuño y José Luis Chávez Gómez
//Data-Path Type R
`timescale 1ns/1ns

module DPTR(
	input   [31:0]instruccion_TR
);

//Definimos registros para las conexiones.
wire [31:0] r1;				//Dato escritura BR y salida multiplexor
wire [5:0]  out_control;	//Salida de la unidad de control, se separa en varios bits.
wire [31:0] r2;				//Salida de Read Data 1 y entrada de OP1 de la ALU
wire [31:0] r3;				//Salida de Read Data 2, entrada de OP2 de la ALU y dato escritura de memoria.
wire [2:0]  r4;				//Salida de ALU control y entrada de ALUop
wire [31:0] r5;			    //Direccion de memoria de datos, entrada 2 de mux y salida de ALU
wire [31:0] r6;				//Dato entrada 1 demux y dato de lectura.

//Definición de todas las instancias que se van a utilizar.
Banco_Registros 	instancia_BR(.direccion_lect_1(instruccion_TR[25:21]), .direccion_lect_2(instruccion_TR[20:16]), .direccion_escritura(instruccion_TR[15:11]), .RegEn(out_control[5]), .datoEscritura(r1), .datoLect_1(r2), .datoLect_2(r3));
mem_out  			instancia_memoria(.direccion(r5), .MemToWrite(out_control[1]), .datoEscritura(r3), .datoLectura(r6));
ALU      			instancia_ALU(.A(r2), .B(r3), .ALU_Sel(r4), .R(r5));
multiplexor    		instancia_mux(.entrada1_mux(r6), .entrada2_mux(r5), .mux_sel(out_control[0]), .salida_mux(r1));
Unidad_control		instancia_control(.OPcode(instruccion_TR[31:26]), .salida_control(out_control));
ALU_control			instancia_ALU_control(.Function(instruccion_TR[5:0]), .ALUOp_in(out_control[4:2]), .OpALU_out(r4));
endmodule

module DPTR_TB();

reg   [31:0]instruccion;

DPTR inst_TB(.instruccion_TR(instruccion));

//Banco de pruebas.
//El conjunto de instrucciones está distribuido de la siguiente manera:
//Para instrucciones tipo R:
//32-26 OPcode (000000 en instrucciones tipo R)
//21-25 Registro s (rs)
//16-20 Registro t (rt)
//11-15	Registro destino (resultado)
//6-10	Shamt (no se usa en instrucciones tipo R)
//0-5	Function

initial
	begin
		$readmemb("datos.txt", inst_TB.instancia_BR.BR_in);
		instruccion = 32'b000000_00000_00001_00010_00000_100000;	//Suma aritmética: $0 $1 $3
		#100;
		$stop;
	end
endmodule