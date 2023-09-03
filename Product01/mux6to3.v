//Modulo do multiplexador 6 para 3
module mux6to3 (A, B, C, D, E, F,
	sel,
	out0, out1, out2);
	
	//Entradas
	//(A,B,C) = primeiro grupo de entradas da selecao
	//(D,E,F) = segundo grupo de entradas da selecao
	//sel = seletor para decidir se o primeiro ou segundo grupo sera ligado a saida do mux
	input A, B, C, D, E, F, sel;
	
	//Saidas
	//out0 = A / D
	//out1 = B / E
	//out2 = C / F
	output out0, out1, out2;
	
	//Fios do modulo
	wire Nsel, out0_0, out1_0, out2_0, out0_1, out1_1, out2_1;
	

//Negacao do seletor
not (Nsel, sel);

//Metade do barramento de portas AND que verifica se o seletor esta em nivel logico BAIXO
//Passa as entradas (A, B, C) para a saida
and out00and0(out0_0, A, Nsel);
and out01and0(out1_0, B, Nsel);
and out02and0(out2_0, C, Nsel);

//Metade do barramento de portas AND que verifica se o seletor esta em nivel logico ALTO
//Passa as entradas (D, E, F) para a saida
and out00and1(out0_1, D, sel);
and out01and1(out1_1, E, sel);
and out02and1(out2_1, F, sel);

//Ou que liga as duas metades do barramento de portas AND
or finalout0 (out0, out0_0, out0_1);
or finalout1 (out1, out1_0, out1_1);
or finalout2 (out2, out2_0, out2_1);

endmodule
