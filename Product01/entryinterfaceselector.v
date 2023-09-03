//Modulo do seletor da interface de entrada prioritaria
module entryinterfaceselector (A, B, C,
D, E, F,
entitfsel);
	
	//Entradas
	// (A, B, C) = Codigo binario do usuario da IE01, A mais significativo
	// (D, E, F) = Codigo binario do usuario da IE02, D mais significativo
	input A, B, C, D, E, F;
	
	//Saida
	//entitfsel = seletor da prioridade
	//0 = prioridade da IE01
	//1 = prioridade da IE02
	output entitfsel;
	
	//Fios do modulo
	wire NA, NB, NC, ND, NE, NF,
	min0, min1, min2, min3, min4, min5, min6;

//Negacoes das entradas
not (NA, A);
not (NB, B);
not (NC, C);
not (ND, D);
not (NE, E);
not (NF, F);

//Portas logicas AND das condicoes minimas diferentes
and firstCondition(min0, NA, NC); // !A!C
and secondCondition(min1, NB, NC); // !B!C
and thirdCondition(min2, A, B, C); // ABC
and fourthCondition(min3, NA, C, D, NE, F); // !ACD!EF
and fifthCondition(min4, A, B, NC, NE, F); // AB!C!EF
and sixthCondition(min5, NA, NB, C, ND, E, F); // !A!BC!DEF
and seventhCondition(min6, A, B, NC, ND, E, F); // AB!C!DEF

//Porta logica da soma dos minimos (expressao final: !A!C + !B!C + ABC + !ACD!EF + AB!C!EF + !A!BC!DEF + AB!C!DEF)
or finalOutput(entitfsel, min0, min1, min2, min3, min4, min5, min6);

endmodule
