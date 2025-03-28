//Modulo do multiplexador 6 para 3
module mux2to1 (A, B,
	sel,
	out);
	
	//Entradas
	//A = primeira entrada da selecao
	//B = segunda entrada da selecao
	//sel = seletor para decidir se a primeira ou segunda entrada sera ligado a saida do mux
	input A, B, sel;
	
	//Saidas
	//out = A / B
	output out;
	
	//Fios do modulo
	wire Nsel, out0, out1;
	

//Negacao do seletor
not (Nsel, sel);

//Metade do barramento de portas AND que verifica se o seletor esta em nivel logico BAIXO
//Passa a entrada A para a saida
and out00and0(out0, A, Nsel);

//Metade do barramento de portas AND que verifica se o seletor esta em nivel logico ALTO
//Passa a entrada B para a saida
and out00and1(out1, B, sel);

//Ou que liga as duas metades do barramento de portas AND
or finalout0 (out, out0, out1);

endmodule
