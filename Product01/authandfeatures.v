//Modulo de autenticacao e selecao de funcionalidade
module authandfeatures(
afCH0, afCH1, afCH2, afCH3,
afBT0, afBT1,
ATadm, ATtest, ATuser, ATguest, FT0, FT1, FT2, FT3, FT4, FT5, FT6
); //Declara todos os elementos de entrada e saida (nao inclui fios)
	
	//Declara elementos de entrada (chaves HH e botoes)
	input afCH0, afCH1, afCH2, afCH3, afBT0, afBT1;
	
	//Declara elementos de saida (interface dos fios unitarios de usuario e de funcionalidade)
	output ATadm, ATtest, ATuser, ATguest, FT0, FT1, FT2, FT3, FT4, FT5, FT6;
	
	//Declara os fios que ligam os elementos de negacao com as portas logicas que os utilizam
	wire NCH0, NCH1, NCH2, NCH3, NBT0, NBT1;

//Portas logicas NOT (negacao)
not (NCH0, afCH0);
not (NCH1, afCH1);
not (NCH2, afCH2);
not (NCH3, afCH3);
not (NBT0, afBT0);
not (NBT1, afBT1);

//Portas logicas AND de autenticacao
and atAnd0(ATadm, afCH0, NBT0, BT1);
and atAnd1(ATtest, NCH0, BT0, afBT1);
and atAnd2(ATuser, NCH0, NBT0, afBT1);
and atAnd3(ATguest, afCH0, afBT0, NBT1);

//Portas logicas AND de selecao de funcionalidade
and ftAnd0(FT0, NCH1, NCH2, afCH3);
and ftAnd1(FT1, NCH1, afCH2, NCH3);
and ftAnd2(FT2, NCH1, afCH2, afCH3);
and ftAnd3(FT3, afCH1, NCH2, NCH3);
and ftAnd4(FT4, afCH1, NCH2 , afCH3);
and ftAnd5(FT5, afCH1, afCH2, NCH3);
and ftAnd6(FT6, afCH1, afCH2, afCH3);

endmodule