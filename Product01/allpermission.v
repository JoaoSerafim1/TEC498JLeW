module allpermission (A, B, C, D, E, F, permout);
	
	input A, B, C, D, E, F;
	
	output permout;
	
	wire NA, NB, NC, ND, NE, NF,
	perm0, perm1, perm2, perm3, perm4, perm5,
	isonwire, haspermissionwire;
	

not (NA, A);
not (NB, B);
not (NC, C);
not (ND, D);
not (NE, E);
not (NF, F);

and permission0(perm0, A, NB, C);
and permission1(perm1, NA, C, ND, F);
and permission2(perm2, NA, B, C, ND, E, NF);
and permission3(perm3, NA, C, D, NF);
and permission4(perm4, A, B, NC, ND, NE, F);
and permission5(perm5, A, B, NC, D, E, NF);

or ison(isonwire, D, E, F);

or haspermission(haspermissionwire, perm0, perm1, perm2, perm3, perm4, perm5);

and finalcheck(permout, isonwire, haspermissionwire);

endmodule
