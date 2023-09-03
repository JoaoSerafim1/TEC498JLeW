//Modulo para verificacao de conflitos de funcionalidade
module featureconflictchecker (A, B, C,
	D, E, F,
	cftout);
	
	//Entradas (A, B, C) = Codigo da funcionalidade da IE01 em formato binario, A mais significativo
	//(D, E, F) = Codigo da funcionalidade da IE02 em formato binario, D mais significativo
	input A, B, C, D, E, F;
	
	//Saida do status de conflito
	//1 = passou (nao houve conflito)
	//0 = nao passou (houve conflito)
	output cftout;
	
	//Fios do modulo
	wire adxorwire, bexorwire, cfxorwire;

//Sequencia de 3 expressoes XOR de duas entradas entre os bits de mesmo valor de cada Interface de Entrada
//Qualquer um que nao seja pareado retornara 1, indicando que nao pode ser a mesma funcionalidade
xor adparity (adxorwire, A, D);
xor beparity (bexorwire, B, E);
xor cfparity (cfxorwire, C, F);

//Passa para a frente valor 1 se ao menos um pares de bit nao tiver valores iguais
or cftfree (cftout, adxorwire, bexorwire, cfxorwire);

endmodule
