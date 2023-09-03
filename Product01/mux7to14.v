//Modulo do multiplexador 7 para 14
module mux7to14 (A, B, C, D, E, F, G,
	sel,
	out00, out01, out02, out03, out04, out05, out06,
	out07, out08, out09, out10, out11, out12, out13);
	
	//Entradas
	// (A, B, C, D, E, F) = entradas a serem distribuidas
	// sel = seletor para decidir qual das duas metades da saida sera conectada as entradas	
	input A, B, C, D, E, F, G, sel;
	
	//Saidas
	//out00, out01, out02, out03, out04, out05, out06 = primeira metade das saidas
	//out07, out08, out09, out10, out11, out12, out13 = segunda metade das saidas
	output out00, out01, out02, out03, out04, out05, out06,
	out07, out08, out09, out10, out11, out12, out13;
	
	//Fio do modulo
	wire Nsel;
	
//Negacao do seletor
not (Nsel, sel);

//Passagem das entradas para a primeira metade das saidas, caso o seletor esteja em nivel logico BAIXO
and out00and(out00, A, Nsel);
and out01and(out01, B, Nsel);
and out02and(out02, C, Nsel);
and out03and(out03, D, Nsel);
and out04and(out04, E, Nsel);
and out05and(out05, F, Nsel);
and out06and(out06, G, Nsel);

//Passagem das entradas para a segunda metade das saidas, caso o seletor esteja em nivel logico BAIXO
and out07and(out07, A, sel);
and out08and(out08, B, sel);
and out09and(out09, C, sel);
and out10and(out10, D, sel);
and out11and(out11, E, sel);
and out12and(out12, F, sel);
and out13and(out13, G, sel);

endmodule
