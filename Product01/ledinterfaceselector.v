module ledinterfaceselector (A, B, C,
ledsel);

	input A, B, C;
	
	output ledsel;
	
	wire abxorwire;

xor abxor(abxorwire, A, B);

nand (ledsel, abxorwire, C);

endmodule
