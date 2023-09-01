//Modulo de verificacao de permissao (autenticacao X funcionalidade)
module permissionCheck (ATadm, ATtest, ATuser, ATguest,
	FT0, FT1, FT2, FT3, FT4, FT5, FT6,
	pmOutput); //Declara todos os elementos de entrada e saida (nao inclui fios)
	
	//Declara elementos de entrada (saida do modulo de autenticacao e selecao de funcionalidade)
	input ATadm, ATtest, ATuser, ATguest, FT0, FT1, FT2, FT3, FT4, FT5, FT6;
	
	//Declara os elementos de saida (saidas temporarias para teste)
	output pmOutput;
	
	//Declara os fios que ligam as portas logicas do circuito
	wire FT0andwire, FT1andwire, FT2andwire, FT3andwire, FT4andwire, FT5andwire,
	FT0final, FT1final, FT2final, FT3final, FT4final, FT5final, FT6final;

//Portas logicas OR para verificar se o usuario tem permissao
or FT0orgate(FT0andwire, ATadm, ATtest, ATuser, ATguest);
or FT1orgate(FT1andwire, ATadm, ATtest);
or FT2orgate(FT2andwire, ATadm, ATtest, ATuser);
or FT3orgate(FT3andwire, ATadm, ATtest, ATuser);
or FT5orgate(FT5andwire, ATadm, ATtest, ATuser, ATguest);

//Portas logicas AND para ver se uma funcionalidade esta ativa
and FT0andgate(FT0final, FT0andwire, FT0);
and FT1andgate(FT1final, FT1andwire, FT1);
and FT2andgate(FT2final, FT2andwire, FT2);
and FT3andgate(FT3final, FT3andwire, FT3);
and FT4andgate(FT4final, ATadm, FT4);
and FT5andgate(FT5final, FT5andwire, FT5);
and FT6andgate(FT6final, ATadm, FT6);

//Saida de teste (acende caso alguma funcionalidade permitida ao usuario atual esteja selecionada)
or finalOutput(pmOutput, FT0final, FT1final, FT2final, FT3final, FT4final, FT5final, FT6final);

endmodule
