module sevendisplayselector (A, B, C,
	priorsel, displaysel);
	
	input A, B, C,
	priorsel;
	
	output displaysel;
	
	wire NB, Npriorsel;
	

not (NB, B);
not (Npriorsel, priorsel);

nand (Npriorsel, A, NB, C);