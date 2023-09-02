module displayvalidator (A, B, C,
validout);
	
	input A, B, C;
	
	output validout;
	
	wire NA, NC;
	

not (NA, A);
not (NC, C);

and validoutand (NA, B, NC);

endmodule
