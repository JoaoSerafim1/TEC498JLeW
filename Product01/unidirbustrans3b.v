module unidirbustrans3b (A0, A1, A2,
	flowvalve, conflictstatus, prioritystatus,
	B0, B1, B2,);

	input A0, A1, A2, flowvalve, conflictstatus, prioritystatus;
	
	output B0, B1, B2;
	
	wire statuswire;
	

or hasprioritORnoconflict (statuswire, conflictstatus, prioritystatus);

and A0toB0(B0, A0, flowvalve, statuswire);
and A1toB1(B1, A1, flowvalve, statuswire);
and A2toB2(B2, A2, flowvalve, statuswire);

endmodule
