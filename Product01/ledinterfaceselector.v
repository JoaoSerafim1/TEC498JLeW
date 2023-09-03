//Modulo de selecao da interface de saida (conjunto de LEDs) da funcionalidade de cada interface de entrada
module ledinterfaceselector (A, B, C,
ledsel);
	
	//Entradas
	// (A, B, C) = Sequencia binaria referente ao codigo do usuario da interface de entrada conectada
	input A, B, C;
	
	//Saida
	//ledsel = selecao da interface de saida
	// 0 = IS01; 1 = IS02
	output ledsel;
	
	//Fio do modulo
	wire abxorwire;

//XOR do mintermo (A$B)
xor abxor(abxorwire, A, B);

//Expressao final (C*(A$B))
nand (ledsel, abxorwire, C);

endmodule
