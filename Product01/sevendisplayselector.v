module sevendisplayselector (A, B, C,
D, E, F,
priorsel, displaysel);
	
	input A, B, C,
	D, E, F,
	priorsel;
	
	output displaysel;
	
	wire NA, NC, ND, NF,
	Npriorsel,
	ft2IE01,
	ft2IE02,
	Nft2IE01,
	Nft2IE02,
	max0;
	

not (NA, A);
not (NC, C);
not (ND, D);
not (NF, F);
not (Npriorsel, priorsel);

and (ft2IE01, NA, B, NC);
and (ft2IE02, ND, E, NF);
not (Nft2IE02, ft2IE02);

or max0condition(max0, Npriorsel, Nft2IE02);

and (displaysel, max0, ft2IE01);

endmodule
