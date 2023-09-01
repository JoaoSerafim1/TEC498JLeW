module featureconflictchecker (A, B, C,
	D, E, F,
	cftout);
	
	input A, B, C, D, E, F;
	
	output cftout;
	
	wire adxorwire, bexorwire, cfxorwire;

xor adparity (adxorwire, A, D);
xor beparity (bexorwire, B, E);
xor cfparity (cfxorwire, C, F);

or cftfree (cftout, adxorwire, bexorwire, cfxorwire);

endmodule
