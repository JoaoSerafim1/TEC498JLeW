//Modulo principal (entidade de maior nivel); Instancia todos os demais modulos e os liga
module mainmodule (CH0, CH1, CH2, CH3, CH4, CH5, CH6, CH7,
BT0, BT1, BT2, BT3, LED0, LED1, LED2, LED3, LED4, LED5, LED6,
COL0, COL1, COL2, COL3, COL4, COL5, LIN0, LIN1, LIN2, LIN3, LIN4, LIN5, LIN6,
SGDA, SGDB, SGDC, SGDD, SGDE, SGDF, SGDG); //Declara todos os elementos de entrada e saida (nao inclui fios)
	
	//Declara elementos de entrada (chaves HH e botoes)
	input CH0, CH1, CH2, CH3, CH4, CH5, CH6, CH7, BT0, BT1, BT2, BT3;
	
	//Declara elementos de saida (LEDS, Display de 7 Segmentos, e saida temporaria de teste)
	output LED0, LED1, LED2, LED3, LED4, LED5, LED6,
	COL0, COL1, COL2, COL3, COL4, COL5, LIN0, LIN1, LIN2, LIN3, LIN4, LIN5, LIN6,
	SGDA, SGDB, SGDC, SGDD, SGDE, SGDF, SGDG;
	
	//Declara os fios utilizados para conectar os modulos
	wire NBT0, NBT1, NBT2, NBT3,
	permIE01, permIE02,
	priorselwire, cftchkwire, sevenselTo6to3muxdisplay,
	Npriorselwire,
	mux6to3ToDisplay0, mux6to3ToDisplay1, mux6to3ToDisplay2;


//Negacao dos botoes
not (NBT0, BT0);
not (NBT1, BT1);
not (NBT2, BT2);
not (NBT3, BT3);

//Negacao do seletor de prioridade do BUS Transceiver da IE01
not (Npriorselwire, priorselwire);

allpermission allperm_0 (
		.A (CH7),
		.B (NBT3),
		.C (NBT2),
		.D (CH6),
		.E (CH5),
		.F (CH4),
		.permout (permIE01)
);

allpermission allperm_1 (
		.A (CH3),
		.B (NBT1),
		.C (NBT0),
		.D (CH2),
		.E (CH1),
		.F (CH0),
		.permout (permIE02)
);

entryinterfaceselector eisel_0 (
		.A (CH7),
		.B (NBT3),
		.C (NBT2),
		.D (CH3),
		.E (NBT1),
		.F (NBT0),
		.entitfsel (priorselwire)
);

featureconflictchecker ftcftchk_0 (
		.A (CH6),
		.B (CH5),
		.C (CH4),
		.D (CH2),
		.E (CH1),
		.F (CH0),
		.cftout (cftchkwire)
);

unidirbustrans3b busIE01 (
		.A0 (CH6),
		.A1 (CH5),
		.A2 (CH4),
		.flowvalve (permIE01),
		.conflictstatus (cftchkwire),
		.prioritystatus (Npriorselwire),
		.B0 (int01foutA),
		.B1 (int01foutB),
		.B2 (int01foutC)
);

unidirbustrans3b busIE02 (
		.A0 (CH2),
		.A1 (CH1),
		.A2 (CH0),
		.flowvalve (permIE02),
		.conflictstatus (cftchkwire),
		.prioritystatus (priorselwire),
		.B0 (int02foutA),
		.B1 (int02foutB),
		.B2 (int02foutC)
);

sevendisplayselector sevensel_0 (
		.A (int01foutA),
		.B (int01foutB),
		.C (int01foutC),
		.D (int02foutA),
		.E (int02foutB),
		.F (int02foutC),
		.priorsel (priorselwire),
		.displaysel (sevenselTo6to3muxdisplay)
);

/*mux6to3 authmux_0 (
		.A (CH7),
		.B (NBT3),
		.C (NBT2),
		.D (CH3),
		.E (NBT1),
		.F (NBT0),
		.sel (sevenselTo6to3muxdisplay),
		.out0 (mux6to3ToDisplay0),
		.out1 (mux6to3ToDisplay1),
		.out2 (mux6to3ToDisplay2)
);*/

mux6to3 displaymux_0 (
		.A (CH7),
		.B (NBT3),
		.C (NBT2),
		.D (CH3),
		.E (NBT1),
		.F (NBT0),
		.sel (sevenselTo6to3muxdisplay),
		.out0 (mux6to3ToDisplay0),
		.out1 (mux6to3ToDisplay1),
		.out2 (mux6to3ToDisplay2)
);

sevensegmentdisplay ssdisplay_0 (
		.A (mux6to3ToDisplay0),
		.B (mux6to3ToDisplay1),
		.C (mux6to3ToDisplay2),
		.D (CH2),
		.E (CH1),
		.F (CH0),
		.G (CH6),
		.H (CH5),
		.I (CH4),
		.sega (SGDA),
		.segb (SGDB),
		.segc (SGDC),
		.segd (SGDD),
		.sege (SGDE),
		.segf (SGDF),
		.segg (SGDG)
);

endmodule
