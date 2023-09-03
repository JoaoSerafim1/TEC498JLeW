//Modulo do BUS TRANSCEIVER de 3 bits
module unidirbustrans3b (A0, A1, A2,
	flowvalve, conflictstatus, prioritystatus,
	B0, B1, B2,);
	
	//Entradas
	//(A0, A1, A2) = Entradas a serem liberadas ou barradas
	//flowvalve = variavel que necessita estar em nivel logico ALTO para liberar a passagem de informacao
	//conflictstatus, prioritystatus = variaveis que, dentre as duas, ao menos uma necessita estar em nivel logico ALTO para liberar a passagem de informacao
	input A0, A1, A2, flowvalve, conflictstatus, prioritystatus;
	
	//Saidas
	// (B0, B1, B2) = Saidas que podem ser permitidas ou barradas pelo circuito
	output B0, B1, B2;
	
	//Fio do modulo
	wire statuswire;
	

//Condicional OR para ver se ou temos prioridade, ou nao existe conflito
or hasprioritORnoconflict (statuswire, conflictstatus, prioritystatus);

//Permite a passagem de informacao nas condicoes estabelecidas
and A0toB0(B0, A0, flowvalve, statuswire);
and A1toB1(B1, A1, flowvalve, statuswire);
and A2toB2(B2, A2, flowvalve, statuswire);

endmodule
