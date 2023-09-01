//Modulo do seletor
module entryinterfaceselector (A, B, C, D, E, F,
entitfsel);

	input A, B, C, D, E, F;
	
	output entitfsel;
	
	wire NA, NB, NC, ND, NE, NF,
	min0, min1, min2, min3, min4, min5, min6;
	
not (NA, A);
not (NB, B);
not (NC, C);
not (ND, D);
not (NE, E);
not (NF, F);

//Portas logicas AND das condicoes minimas diferentes
and firstCondition(min0, NA, NC);
and secondCondition(min1, NB, NC);
and thirdCondition(min2, A, B, C);
and fourthCondition(min3, NA, C, D, NE, F);
and fifthCondition(min4, A, B, NC, NE, F);
and sixthCondition(min5, NA, NB, C, ND, E, F);
and seventhCondition(min6, A, B, NC, ND, E, F);

//Porta logica da soma dos minimos
or finalOutput(entitfsel, min0, min1, min2, min3, min4, min5, min6);

endmodule
