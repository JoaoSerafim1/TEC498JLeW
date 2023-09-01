//Modulo principal (entidade de maior nivel); Instancia todos os demais modulos e os liga
module mainmodule (CH0, CH1, CH2, CH3, CH4, CH5, CH6, CH7,
BT0, BT1, BT2, BT3, LED0, LED1, LED2, LED3, LED4, LED5, LED6,
COL0, COL1, COL2, COL3, COL4, COL5, LIN0, LIN1, LIN2, LIN3, LIN4, LIN5, LIN6,
SGDA, SGDB, SGDC, SGDD, SGDE, SGDF, SGDG,
tmp0, tmp1, tmp2, tmp3, tmp4); //Declara todos os elementos de entrada e saida (nao inclui fios)
	
	//Declara elementos de entrada (chaves HH e botoes)
	input CH0, CH1, CH2, CH3, CH4, CH5, CH6, CH7, BT0, BT1, BT2, BT3;
	
	//Declara elementos de saida (LEDS, Display de 7 Segmentos, e saida temporaria de teste)
	output LED0, LED1, LED2, LED3, LED4, LED5, LED6,
	COL0, COL1, COL2, COL3, COL4, COL5, LIN0, LIN1, LIN2, LIN3, LIN4, LIN5, LIN6,
	SGDA, SGDB, SGDC, SGDD, SGDE, SGDF, SGDG,
	tmp0, tmp1, tmp2, tmp3, tmp4;
	
	//Declara os fios utilizados para conectar os modulos
	wire NBT0, NBT1, NBT2, NBT3,
	permIE01, permIE02,
	selTo6to3Mux,
	mux6to3ToDisplay0, mux6to3ToDisplay1, mux6to3ToDisplay2;


//Negacao dos botoes
not (NBT0, BT0);
not (NBT1, BT1);
not (NBT2, BT2);
not (NBT3, BT3);

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
		.entitfsel (selTo6to3Mux)
);

mux6to3 displaymux_0 (
		.A (CH7),
		.B (NBT3),
		.C (NBT2),
		.D (CH3),
		.E (NBT1),
		.F (NBT0),
		.sel (selTo6to3Mux),
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

or (tmp0 ,selTo6to3Mux);

endmodule
