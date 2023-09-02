module sevensegmentdisplay (A, B, C,
dpval,
sega, segb, segc, segd, sege,segf, segg);

	input A, B, C, dpval;

	output sega, segb, segc, segd, sege, segf, segg;

	wire NA, NB, NC,
	and0wire, and1wire, and2wire, and3wire, and4wire,
	segbor, segcor, segeor,segfor, seggor;

not (NA, A);
not (NB, B);
not (NC, C);

and and0 (and0wire, NA, C);
and and1 (and1wire, A, B, NC);
and and2 (and2wire, NB, C);
and and3 (and3wire, NA, B, C);

or (segbor, and0wire, and1wire, and2wire);
or (segcor, and2wire, and1wire);
or (seggor, and0wire, and1wire);

nand (sega, and0wire, dpval);
nand (segb, segbor, dpval);
nand (segc, segcor, dpval);
nand (segd, and0wire, dpval);
nand (sege, and3wire, dpval);
nand (segf, and1wire, dpval);
nand (segg, seggor, dpval);

endmodule
