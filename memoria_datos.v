//Hecho por Rodrigo Esaú Villegas Nuño y Jose Luis Chávez Gómez
//Memoria de datos

module mem_out(
	input  wire[31:0]direccion,
	input  wire MemToWrite,
	input  wire[31:0] datoEscritura,
	output reg [31:0] datoLectura
);

reg [31:0]memr_out[0:31];

always@(*)
	begin
	//Escritura
	if(MemToWrite) 
	begin
		memr_out[direccion] = datoEscritura;
	end
	
	//Lectura
	if(!(MemToWrite))
	begin
		datoLectura = memr_out[direccion];
	end
end
endmodule
