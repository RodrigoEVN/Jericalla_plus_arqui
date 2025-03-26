//Hecho por Rodrigo Esaú Villegas Nuño y Jose Luis Chávez Gómez
//Búffer

module buffer(
	input  wire[31:0]entrada1,
	input  wire[31:0]entrada2,
	input  wire[31:0]entrada3,
	input  wire           clk,
	output reg [31:0] salida1,
	output reg [31:0] salida2,
	output reg [31:0] salida3
);

always@(posedge clk)
	begin
	//Se pasan los datos de la entrada a la salida cada flanco de subida de la señal de reloj.
	salida1 = entrada1;
	salida2 = entrada2;
	salida3 = entrada3;
end
endmodule

