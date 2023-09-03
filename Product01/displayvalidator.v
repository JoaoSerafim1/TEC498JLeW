//Modulo de validacao das entradas para o decodificador do display
module displayvalidator (A, B, C,
validout);
	
	//Entradas
	// (A, B, C) = Sequencia binaria referente a funcionalidade escolhida pelo usuario
	//que esta utilizando a interface oposta aquela cujo codigo sera exibido no display de 7 segmentos
	input A, B, C;
	
	//Saida
	//validout = 1: valido para exibir; 0 = invalido para exibir
	output validout;
	
	//Fios do modulo
	wire NA, NC;
	

//Negacao das entradas
not (NA, A);
not (NC, C);

//Verifica se esta executando a funcao 2
and validoutand (NA, B, NC);

endmodule
