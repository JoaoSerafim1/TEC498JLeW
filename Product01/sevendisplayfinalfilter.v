module sevendisplayfinalfilter (A, B, C,
	firstdisplaysel, seconddisplaysel);
	
	input A, B, C,
	firstdisplaysel;
	
	output seconddisplaysel;
	
	wire NB, Npriorsel;
	

not (NB, B);
not (Npriorsel, priorsel)

and (displaysel, Npriorsel, NA, B, NC);