module ledsequencedecoder (A, B, C,
out0, out1, out2, out3, out4, out5, out6);

	input A, B, C;
	
	output out0, out1, out2, out3, out4, out5, out6;
	
	wire NA, NB, NC;
	

not (NA, A);
not (NB, B);
not (NC, C);

and led0and(out0, NA, NB, C);
and led1and(out1, NA, B, NC);
and led2and(out2, NA, B, C);
and led3and(out3, A, NB, NC);
and led4and(out4, A, NB, C);
and led5and(out5, A, B, NC);
and led6and(out6, A, B, C);

endmodule
