module unidirbustrans6b (A0, A1, A2, A3, A4, A5,
	flowvalve, conflictstatus, prioritystatus,
	B0, B1, B2, B3, B4, B5);

	input A0, A1, A2, A3, A4, A5, flowvalve, conflictstatus, prioritystatus;
	
	output B0, B1, B2, B3, B4, B5;
	
	wire statuswire;
	

or hasprioritORnoconflict (statuswire, conflictstatus, prioritystatus);

and A0toB0(B0, A0, flowvalve, statuswire);
and A1toB1(B1, A1, flowvalve, statuswire);
and A2toB2(B2, A2, flowvalve, statuswire);
and A3toB3(B3, A3, flowvalve, statuswire);
and A4toB4(B4, A4, flowvalve, statuswire);
and A5toB5(B5, A5, flowvalve, statuswire);

endmodule
