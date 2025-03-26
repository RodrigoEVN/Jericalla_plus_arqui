//Hecho por Rodrigo Esaú Villegas Nuño y José Luis Chávez Gómez
//Módulo general Jericalla plus.
`timescale 1ns/1ns

module Jericalla_plus(
	input   [16:0]instruccion,
	input    clk,
	output  [31:0] salida
);

//Definimos registros para las conexiones.
wire [31:0] r1;		//Dato escritura BR y salida 2 buffer 2
wire [7:0]  r2;		//salida de control: habilitación y operaciones.
wire [31:0] r3;		//Dato de lectura 1 BR y entrada 1 de buffer 1.
wire [31:0] r4;		//Dato de lectura 2 BR y entrada 2 de buffer 1.
wire [31:0] r5;		//Direccion de la memoria y salida 1 del buffer 2.
wire [31:0] r6;		//Salida 1 del demux y entrada A de la alu
wire [31:0] r7;		//Salida 2 del buffer 1, entrada B de la alu y entrada 3 de buffer 2.
wire [31:0] r8;		//Salida de la alu y entrada 2 del buffer 2
wire [31:0] r9;		//Salida 2 del demux y entrada 1 de buffer 2
wire [31:0] r10;	//Dato escritura memoria y salida 3 buffer 2
wire [31:0] r11;	//Dato entrada demux y salida 1 buffer 1
wire [31:0] r12;    //Entrada 3 y salida 3 de buffer 1.

//Definición de todas las instancias que se van a utilizar.
BR 		 instancia_BR(.direccion_lect_1(instruccion[9:5]), .direccion_lect_2(instruccion[4:0]), .direccion_escritura(instruccion[14:10]), .Wen(r2[0]), .datoEscritura(r1), .datoLect_1(r3), .datoLect_2(r4));
mem_out  instancia_memoria(.direccion(r5), .Wen(r2[6]), .Ren(r2[7]), .datoEscritura(r10), .datoLectura(salida));
ALU      instancia_ALU(.A(r6), .B(r7), .ALU_Sel(r2[4:1]), .R(r8));
demux    instancia_demux(.entrada_demux(r11), .demux_sel(r2[5]), .salida_demux_1(r6), .salida_demux_2(r9));
buffer	 instancia_buffer1(.entrada1(r3), .entrada2(r4), .entrada3(r12), .clk(clk), .salida1(r11), .salida2(r7), .salida3(r12));
buffer	 instancia_buffer2(.entrada1(r9), .entrada2(r8), .entrada3(r7), .clk(clk), .salida1(r5), .salida2(r1), .salida3(r10));
control  instancia_control(.opcode(instruccion[16:15]), .salida_control(r2));
endmodule

module Jericalla_plus_TB();

reg   [16:0]instruccion;
reg   clk;
wire  [31:0] salida;

Jericalla_plus inst_TB(.instruccion(instruccion), .clk(clk), .salida(salida));

//Banco de pruebas.
//El conjunto de instrucciones está distribuido de la siguiente manera:
//Para aritméticas:
//16 15 			opcode
//14 13 12 11 10	Dirección de escritura. (WA)
// 9  8  7  6  5	Dirección de lectura 1. (RA1)
// 4  3  2  1  0	Dirección de lectura 2. (RA2)

//Para SW:
//16 15 			opcode
//14 13 12 11 10	No importan los bits.
// 9  8  7  6  5	Dirección de lectura 1. (Direccion donde voy a escribir)
// 4  3  2  1  0	Dirección de lectura 2. (Dato que voy a escribir)

always #25 clk=~clk;
initial
	begin
		clk=0;
		$readmemb("datos.txt", inst_TB.instancia_BR.BR_in);
		instruccion = 17'b00_00100_00000_00001;			//Suma aritmética: $0 $1 $3
		#100;
		instruccion = 17'b01_00101_00001_00010;			//Resta aritmética: $1 $2 $5
		#100;
		instruccion = 17'b10_00110_00010_00011;			//Operación ternaria: $2 $3 $6
		#100;
		instruccion = 17'b11_00000_00111_00100;			//SW, leemos direccion 7 (contiene un 20) y direccion 4 (resultado suma)
		#100;
		instruccion = 17'b11_00000_01000_00101;			//SW, leemos direccion 8 (contiene un 21) y direccion 5 (resultado resta)
		#100;
		instruccion = 17'b11_00000_01001_00110;			//SW, leemos direccion 9 (contiene un 22) y direccion 6 (resultado ternario)
		#100;
		
		$stop;
	end
endmodule
