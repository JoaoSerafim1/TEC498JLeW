//Modulo do seletor do display de 7 segmentos
module sevendisplayselector (A, B,
priorsel,
displaysel);
	
	//Entradas
	// A = Bit relacionado a estar executando (ALTO) ou nao (BAIXO) a funcionalidade 2 na IE01
	// B = Bit relacionado a estar executando (ALTO) ou nao (BAIXO) a funcionalidade 2 na IE02
	//priorsel = seletor de prioridade da interface de entrada (0 = prioridade da IE01, 1 = prioridade da IE02)
	input A, B,
	priorsel;
	
	//Saida
	//displaysel = seletor da interface oposta aquela que esta executando a funcao 2
	output displaysel;
	
	//Fios do modulo
	wire NB,
	Npriorsel,
	max0;
	

//Negacao de algumas entradas
not (NB, C);
not (Npriorsel, priorsel);

//Parte da fatoracao dos dois mintermos (!priorsel + !B)
or max0condition(max0, Npriorsel, NB);

//Expressao booleana simplificada completa (A*(!priorsel + !B))
//Passa nivel logico ALTO se e somente se a IE01 estiver executando a funcao 2
//e, CASO ESTEJAM EXECUTANDO A MESMA FUNCIONALIDADE, seja, dentre as duas, a com o maior nivel de autoridade.
and (displaysel, A, max0);

endmodule
