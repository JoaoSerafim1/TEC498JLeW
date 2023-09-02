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
	
	priorselwire, Npriorselwire, cftchkwire,
	
	featurebitIE01[2:0],
	featurebitIE02[2:0],
	
	sevenselwire,
	mux6to3ToValidator0, mux6to3ToValidator1, mux6to3ToValidator2,
	displayvalwire,
	
	mux6to3ToDisplay0, mux6to3ToDisplay1, mux6to3ToDisplay2,
	
	ledselwire0,
	ledselwire1,
	
	ledwireIE01 [6:0],
	ledwireIE02 [6:0],
	
	lattledwireIE01[6:0],
	lattledwireIE02[6:0],
	
	seqledwireIE01[6:0],
	seqledwireIE02[6:0];

//Negacao dos botoes
not (NBT0, BT0);
not (NBT1, BT1);
not (NBT2, BT2);
not (NBT3, BT3);

//Negacao do seletor de prioridade do BUS Transceiver da IE01
not (Npriorselwire, priorselwire);

allpermission allperm_IE01 (
		.A (CH7),
		.B (NBT3),
		.C (NBT2),
		.D (CH6),
		.E (CH5),
		.F (CH4),
		.permout (permIE01)
);

allpermission allperm_IE02 (
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

unidirbustrans3b gatedbus_IE01 (
		.A0 (CH6),
		.A1 (CH5),
		.A2 (CH4),
		.flowvalve (permIE01),
		.conflictstatus (cftchkwire),
		.prioritystatus (Npriorselwire),
		.B0 (featurebitIE01[0]),
		.B1 (featurebitIE01[1]),
		.B2 (featurebitIE01[2])
);

unidirbustrans3b gatedbus_IE02 (
		.A0 (CH2),
		.A1 (CH1),
		.A2 (CH0),
		.flowvalve (permIE02),
		.conflictstatus (cftchkwire),
		.prioritystatus (priorselwire),
		.B0 (featurebitIE02[0]),
		.B1 (featurebitIE02[1]),
		.B2 (featurebitIE02[2])
);

sevendisplayselector sevensel_0 (
		.A (featurebitIE01[0]),
		.B (featurebitIE01[1]),
		.C (featurebitIE01[2]),
		.D (featurebitIE02[0]),
		.E (featurebitIE02[1]),
		.F (featurebitIE02[2]),
		.priorsel (priorselwire),
		.displaysel (sevenselwire)
);

mux6to3 dpvalidatormux_0 (
		.A (CH2),
		.B (CH1),
		.C (CH0),
		.D (CH6),
		.E (CH5),
		.F (CH4),
		.sel (sevenselwire),
		.out0 (mux6to3ToValidator0),
		.out1 (mux6to3ToValidator1),
		.out2 (mux6to3ToValidator2)
);

displayvalidator dpval_0 (
		.A (mux6to3ToValidator0),
		.B (mux6to3ToValidator1),
		.C (mux6to3ToValidator2),
		.validout (displayvalwire)
);

mux6to3 displaymux_0 (
		.A (CH7),
		.B (NBT3),
		.C (NBT2),
		.D (CH3),
		.E (NBT1),
		.F (NBT0),
		.sel (sevenselwire),
		.out0 (mux6to3ToDisplay0),
		.out1 (mux6to3ToDisplay1),
		.out2 (mux6to3ToDisplay2)
);

sevensegmentdisplay ssdisplay_0 (
		.A (mux6to3ToDisplay0),
		.B (mux6to3ToDisplay1),
		.C (mux6to3ToDisplay2),
		.dpval (displayvalwire),
		.sega (SGDA),
		.segb (SGDB),
		.segc (SGDC),
		.segd (SGDD),
		.sege (SGDE),
		.segf (SGDF),
		.segg (SGDG)
);

ledinterfaceselector ledifsel_IE01 (
		.A (CH7),
		.B (NBT3),
		.C (NBT2),
		.ledsel (ledselwire0)
);

ledinterfaceselector ledifsel_IE02 (
		.A (CH3),
		.B (NBT1),
		.C (NBT0),
		.ledsel (ledselwire1)
);

ledsequencedecoder ledseqdec_IE01(
		.A (featurebitIE01[0]),
		.B (featurebitIE01[1]),
		.C (featurebitIE01[2]),
		.out0 (ledwireIE01[0]),
		.out1 (ledwireIE01[1]),
		.out2 (ledwireIE01[2]),
		.out3 (ledwireIE01[3]),
		.out4 (ledwireIE01[4]),
		.out5 (ledwireIE01[5]),
		.out6 (ledwireIE01[6])
);

ledsequencedecoder ledseqdec_IE02(
		.A (featurebitIE02[0]),
		.B (featurebitIE02[1]),
		.C (featurebitIE02[2]),
		.out0 (ledwireIE02[0]),
		.out1 (ledwireIE02[1]),
		.out2 (ledwireIE02[2]),
		.out3 (ledwireIE02[3]),
		.out4 (ledwireIE02[4]),
		.out5 (ledwireIE02[5]),
		.out6 (ledwireIE02[6])
);

mux7to14 mux7to14_IE01(
		.A (ledwireIE01[0]),
		.B (ledwireIE01[1]),
		.C (ledwireIE01[2]),
		.D (ledwireIE01[3]),
		.E (ledwireIE01[4]),
		.F (ledwireIE01[5]),
		.G (ledwireIE01[6]),
		.sel (ledselwire0),
		.out00 (lattledwireIE01[0]),
		.out01 (lattledwireIE01[1]),
		.out02 (lattledwireIE01[2]),
		.out03 (lattledwireIE01[3]),
		.out04 (lattledwireIE01[4]),
		.out05 (lattledwireIE01[5]),
		.out06 (lattledwireIE01[6]),
		.out07 (seqledwireIE01[0]),
		.out08 (seqledwireIE01[1]),
		.out09 (seqledwireIE01[2]),
		.out10 (seqledwireIE01[3]),
		.out11 (seqledwireIE01[4]),
		.out12 (seqledwireIE01[5]),
		.out13 (seqledwireIE01[6])
);

mux7to14 mux7to14_IE02(
		.A (ledwireIE02[0]),
		.B (ledwireIE02[1]),
		.C (ledwireIE02[2]),
		.D (ledwireIE02[3]),
		.E (ledwireIE02[4]),
		.F (ledwireIE02[5]),
		.G (ledwireIE02[6]),
		.sel (ledselwire1),
		.out00 (lattledwireIE02[0]),
		.out01 (lattledwireIE02[1]),
		.out02 (lattledwireIE02[2]),
		.out03 (lattledwireIE02[3]),
		.out04 (lattledwireIE02[4]),
		.out05 (lattledwireIE02[5]),
		.out06 (lattledwireIE02[6]),
		.out07 (seqledwireIE02[0]),
		.out08 (seqledwireIE02[1]),
		.out09 (seqledwireIE02[2]),
		.out10 (seqledwireIE02[3]),
		.out11 (seqledwireIE02[4]),
		.out12 (seqledwireIE02[5]),
		.out13 (seqledwireIE02[6])
);

or (LED0, lattledwireIE01[0], lattledwireIE02[0]);
or (LED1, lattledwireIE01[1], lattledwireIE02[1]);
or (LED2, lattledwireIE01[2], lattledwireIE02[2]);
or (LED3, lattledwireIE01[3], lattledwireIE02[3]);
or (LED4, lattledwireIE01[4], lattledwireIE02[4]);
or (LED5, lattledwireIE01[5], lattledwireIE02[5]);
or (LED6, lattledwireIE01[6], lattledwireIE02[6]);

endmodule
