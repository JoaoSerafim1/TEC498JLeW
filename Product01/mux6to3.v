module mux6to3 (A, B, C, D, E, F,
	sel,
	out0, out1, out2);

	input A, B, C, D, E, F, sel;

	output out0, out1, out2;
	
	wire Nsel, out0_0, out1_0, out2_0, out0_1, out1_1, out2_1;
	

not (Nsel, sel);

and out00and0(out0_0, A, Nsel);
and out01and0(out1_0, B, Nsel);
and out02and0(out2_0, C, Nsel);

and out00and1(out0_1, D, sel);
and out01and1(out1_1, E, sel);
and out02and1(out2_1, F, sel);

or finalout0 (out0, out0_0, out0_1);
or finalout1 (out1, out1_0, out1_1);
or finalout2 (out2, out2_0, out2_1);

endmodule
