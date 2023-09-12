//Modulo decodificador do display de 7 segmentos
module sevensegmentdisplay (A, B, C,
dpval,
sega, segb, segc, segd, sege,segf, segg);
	
	//Entradas
	// (A, B, C) = bits referentes ao usuario cujo numero sera exibido, de acordo com os codigos
	// (Codigo/Numero): 101/1 = Admin; 011/2 = Tester; 001/3 = User; 110/4 = Guest
	// dpval = seletor da validade da entrada de usuario
	input A, B, C, dpval;
	
	//Saidas
	
	output sega, segb, segc, segd, sege, segf, segg;

	wire NA, NB, NC,
	and0wire, and1wire, and2wire, and3wire, and4wire,
	segbor, segcor, segeor,segfor, seggor;

//Negacoes das entradas
not (NA, A);
not (NB, B);
not (NC, C);

//Condicionais AND individuais que constituem as expressoes para decidir o nivel logico de cada segmento do display 
and and0 (and0wire, NA, C); // !AC
and and1 (and1wire, A, B, NC); // AB!C
and and2 (and2wire, NB, C); // !BC
and and3 (and3wire, NA, B, C); // !ABC

//Condicionais OR para acomodar os segmentos que nao podem ser expressos como uma unica expressao AND, e sim como a soma de duas outras
or (segbor, and0wire, and1wire, and2wire);
or (segcor, and2wire, and1wire);
or (seggor, and0wire, and1wire);

//Termina as expressoes em logica nand (ja que os segmentos sao ligados em nivel logico BAIXO)
//Tambem exige que o seletor de validade esteja em nivel ALTO
// (a,d) = !AC
// (b) = !AC + !BC + AB!C
// (c) = !BC + AB!C
// (e) = !ABC
// (f) = AB!C
// (g) = !AC + AB!C
nand (sega, and0wire, dpval);
nand (segb, segbor, dpval);
nand (segc, segcor, dpval);
nand (segd, and0wire, dpval);
nand (sege, and3wire, dpval);
nand (segf, and1wire, dpval);
nand (segg, seggor, dpval);

endmodule
