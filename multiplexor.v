//Hecho por Rodrigo Esaú Villegas Nuño y Jose Luis Chávez Gómez
//Multiplexor

module multiplexor(
    input wire[31:0]entrada1_mux,
    input wire[31:0]entrada2_mux,
    input wire mux_sel,
    output reg[31:0]salida_mux
);

always@(*) 
	begin
		if(mux_sel)
		begin
			salida_mux = entrada1_mux;  // La salida toma el valor de la entrada 1.
		end
		
		else
		begin
			salida_mux = entrada2_mux;  // La salida toma el valor de la entrada 2.
		end
	end
endmodule
