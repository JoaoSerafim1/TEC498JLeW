//Modulo do seletor do display de 7 segmentos
module sevendisplayselector (A, B, C,
D, E, F,
priorsel,
displaysel);
	
	//Entradas
	// (A, B, C) = Sequencia binaria da funcionalidade da IE01, A mais significativo
	// (D, E, F) = Sequencia binaria da funcionalidade da IE01, D mais significativo
	//priorsel = seletor de prioridade da interface de entrada (0 = prioridade da IE01, 1 = prioridade da IE02)
	input A, B, C,
	D, E, F,
	priorsel;
	
	//Saida
	//displaysel = seletor da interface oposta aquela que esta executando a funcao 2
	output displaysel;
	
	//Fios do modulo
	wire NA, NC, ND, NF,
	Npriorsel,
	ft2IE01,
	ft2IE02,
	Nft2IE01,
	Nft2IE02,
	max0;
	

//Negacao de algumas entradas
not (NA, A);
not (NC, C);
not (ND, D);
not (NF, F);
not (Npriorsel, priorsel);

//Determina os booleanos das interfaces estarem acessando a funcionalidade 
and (ft2IE01, NA, B, NC);
and (ft2IE02, ND, E, NF);
not (Nft2IE02, ft2IE02);

//Mintermo !priorsel + !ft02
or max0condition(max0, Npriorsel, Nft2IE02);

//Expressao completa (ft02IE01*(!priorsel + !ft02IE02))
//Passa nivel logico ALTO se e somente se a IE01 estiver executando a funcao 2
//e, CASO ESTEJAM EXECUTANDO A MESMA FUNCIONALIDADE, seja, dentre as duas, a com o maior nivel de autoridade.
and (displaysel, ft2IE01, max0);

endmodule
