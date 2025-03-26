//Hecho por Rodrigo Esaú Villegas Nuño y Jose Luis Chávez Gómez
//Banco de registros

module BR(
	input  wire[4:0]direccion_lect_1,
	input  wire[4:0]direccion_lect_2,
	input  wire[4:0]direccion_escritura,
	input  wire Wen,
	input  wire[31:0] datoEscritura,
	output reg [31:0] datoLect_1,
	output reg [31:0] datoLect_2
);

reg [31:0]BR_in[0:31];

always@(*)
	begin
	//Procedimiento de lectura de datos
	datoLect_1 = BR_in[direccion_lect_1];
	datoLect_2 = BR_in[direccion_lect_2];
	
	if(Wen) 
	begin
		BR_in[direccion_escritura] = datoEscritura;
	end
	
end
endmodule
