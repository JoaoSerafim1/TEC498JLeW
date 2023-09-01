module sevensegmentdisplay (A, B, C,
D, E, F,
G, H, I,
sega, segb, segc, segd, sege,segf, segg);

	input A, B, C,
	D, E, F,
	G, H, I;

	output sega, segb, segc, segd, sege, segf, segg;

	wire NA, NB, NC,
	ND, NF,
	NG, NI,
	and0wire, and1wire, and2wire, and3wire, and4wire,
	segbor, segcor, segeor,segfor, seggor,
	ft2chkand1wire, ft2chkand2wire, ft2chkwire;

not (NA, A);
not (NB, B);
not (NC, C);

not (ND, D);
not (NF, F);

not (NG, G);
not (NI, I);

and and0 (and0wire, NA, C);
and and1 (and1wire, A, B, NC);
and and2 (and2wire, NB, C);
and and3 (and3wire, NA, B, C);
and and4 (and4wire, A, NB, C);

//or (segaor);
or (segbor, and0wire, and1wire, and4wire);
or (segcor, and2wire, and1wire);
//or (segdor);
//or (segeor);
//or (segfor);
or (seggor, and0wire, and1wire);

and ft2chkand1 (ft2chkand1wire, ND, E, NF);
and ft2chkand2 (ft2chkand2wire, NG, H, NI);
or ft2chkor (ft2chkwire, ft2chkand1wire, ft2chkand2wire);

nand (sega, and0wire, ft2chkwire);
nand (segb, segbor, ft2chkwire);
nand (segc, segcor, ft2chkwire);
nand (segd, and0wire, ft2chkwire);
nand (sege, and3wire, ft2chkwire);
nand (segf, and1wire, ft2chkwire);
nand (segg, seggor, ft2chkwire);

endmodule
