//Decodificador das saidas em LED
module ledsequencedecoder (A, B, C,
out0, out1, out2, out3, out4, out5, out6);
	
	//Entradas
	// (A, B, C) = Sequencia binaria da funcionalidade a ser exibida, A mais significativo
	input A, B, C;
	
	//Saidas
	// (out0, out1, out2, out3, out4, out5, out6) = Saidas que serao ligadas ou aos LEDS sequenciais, ou as linhas da matrix de LEDs
	output out0, out1, out2, out3, out4, out5, out6;
	
	//Fios do modulo
	wire NA, NB, NC;
	

//Negacao das entradas
not (NA, A);
not (NB, B);
not (NC, C);

//Condicoes para nivel ALTO em cada saida, descrevem os numeros binarios de 1 a 7
and led0and(out0, NA, NB, C);
and led1and(out1, NA, B, NC);
and led2and(out2, NA, B, C);
and led3and(out3, A, NB, NC);
and led4and(out4, A, NB, C);
and led5and(out5, A, B, NC);
and led6and(out6, A, B, C);

endmodule
