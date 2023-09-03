//Modulo de verificacao de permissao
module allpermission ( 

A, B, C, D, E, F, permout);
	
	//Entradas
	//(A, B, C) = Codigo de autenticacao em formato binario, A mais significativo
	//(D, E, F) = Codigo da funcionalidade em formato binario, D mais significativo
	input A, B, C, D, E, F;
	
	//Saida que diz respeito a obtencao ou nao de permissao
	output permout;
	
	//Fios do modulo
	wire NA, NB, NC, ND, NE, NF,
	perm0, perm1, perm2, perm3, perm4, perm5,
	isonwire, haspermissionwire;
	
//Negacao das entradas do modulo
not (NA, A);
not (NB, B);
not (NC, C);
not (ND, D);
not (NE, E);
not (NF, F);

//Checagem dos minimos da expressão simplificada (A!BC + !AC!DF + !ABC!DE + !ACD!F + AB!C!D!EF + AB!CDE!F)
and permission0(perm0, A, NB, C);
and permission1(perm1, NA, C, ND, F);
and permission2(perm2, NA, B, C, ND, E);
and permission3(perm3, NA, C, D, NF);
and permission4(perm4, A, B, NC, ND, NE, F);
and permission5(perm5, A, B, NC, D, E, NF);

//Soma dos minimos, resulta no valor da expressao
or haspermission(haspermissionwire, perm0, perm1, perm2, perm3, perm4, perm5);

//Verifica se existe valor diferente de zero na funcionalidade
or ison(isonwire, D, E, F);

//Passa para frente que existe funcionalidade sendo executada e que o usuario e autorizado
and finalcheck(permout, isonwire, haspermissionwire);

endmodule
