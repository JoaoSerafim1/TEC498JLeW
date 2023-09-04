//Modulo principal (entidade de maior nivel); Instancia todos os demais modulos e os liga
module mainmodule (CH0, CH1, CH2, CH3, CH4, CH5, CH6, CH7,
BT0, BT1, BT2, BT3, LED0, LED1, LED2, LED3, LED4, LED5, LED6,
//LED7, LED8, LED9,
COL0, COL1, COL2, COL3, COL4, LIN0, LIN1, LIN2, LIN3, LIN4, LIN5, LIN6,
SGDA, SGDB, SGDC, SGDD, SGDE, SGDF, SGDG); //Declara todos os elementos de entrada e saida (nao inclui fios)
	
	//Declara elementos de entrada (chaves HH e botoes)
	input CH0, CH1, CH2, CH3, CH4, CH5, CH6, CH7, BT0, BT1, BT2, BT3;
	
	//Declara elementos de saida (LED Sequencial, Matrix de LED e Display de 7 Segmentos)
	output LED0, LED1, LED2, LED3, LED4, LED5, LED6,
	//LED7, LED8, LED9,

	COL0, COL1, COL2, COL3, COL4,
	LIN0, LIN1, LIN2, LIN3, LIN4, LIN5, LIN6,

	SGDA, SGDB, SGDC, SGDD, SGDE, SGDF, SGDG;
	
	//Declara os fios utilizados para conectar os modulos
	//Fios de negacao dos botoes
	wire NBT0, NBT1, NBT2, NBT3,
	
	//Fios da permissao para passar (ALTO = permitido, BAIXO = negado) a frente a funcionalidade de cada interface de entrada
	permIE01, permIE02,
	
	//Fios da selecao de prioridade de interfaces (ALTO = IE02, BAIXO = IE01) e sua negacao
	priorselwire, Npriorselwire,
	//Fio da verificacao de conflito (ALTO = sem conflito, BAIXO = possui conflito)
	cftchkwire,
	
	//Vetores de fios de 3 bits referentes as funcionalidades apos passarem pelo
	//BUS transceiver de autorizacao
	featurebitIE01[2:0],
	featurebitIE02[2:0],
	
	//Fio do seletor do MULTIPLEX (6:3) do display de 7 segmentos
	sevenselwire,
	//Fios dos modulos validadores da funcionalidade 2 de cada interface de entrada
	displayvalwire0, displayvalwire1,
	//Fio cruzado da validacao da funcionalidade 2
	//Explicacao: (se o MUX 2:1 receber ALTO no sel, passa displayvalwire0, caso contrario, passa displayvalwire1)
	mux2to1ToDisplay,
	//Fios selecionados do usuario a ser exibido no display, de acordo com o MUX 6:3
	mux6to3ToDisplay0, mux6to3ToDisplay1, mux6to3ToDisplay2,
	
	//Fios de selecao da interface de saida para cada interface de entrada
	ledselwireIE01, ledselwireIE02,
	//Vetores de fios de entrada (no MUX 7:14) de 7 bits para cada interface de entrada
	ledwireIE01 [6:0],
	ledwireIE02 [6:0],
	//Vetores de fios de saida (do MUX 7:14) de 7 bits da IS01 (matrix de LEDs) para cada interface de entrada
	lattledwireIE01[6:0],
	lattledwireIE02[6:0],
	//Vetores de fios de saida (do MUX 7:14) de 7 bits da IS02 (LEDs sequenciais) para cada interface de entrada
	seqledwireIE01[6:0],
	seqledwireIE02[6:0],
	
	//Fio da verificacao de uma das saidas nao estar ligada
	noneOnWire;

//Negacao dos botoes
not (NBT0, BT0);
not (NBT1, BT1);
not (NBT2, BT2);
not (NBT3, BT3);

//Negacao do seletor de prioridade do BUS Transceiver da IE01
not (Npriorselwire, priorselwire);

//Instancia do modulo de permissoes - IE01
allpermission allperm_IE01 (
		.A (CH7),
		.B (NBT3),
		.C (NBT2),
		.D (CH6),
		.E (CH5),
		.F (CH4),
		.permout (permIE01)
);

//Instancia do modulo de permissoes - IE02
allpermission allperm_IE02 (
		.A (CH3),
		.B (NBT1),
		.C (NBT0),
		.D (CH2),
		.E (CH1),
		.F (CH0),
		.permout (permIE02)
);

//Instancia do modulo seletor de prioridade
entryinterfaceselector eisel_0 (
		.A (CH7),
		.B (NBT3),
		.C (NBT2),
		.D (CH3),
		.E (NBT1),
		.F (NBT0),
		.entitfsel (priorselwire)
);

//Instancia do modulo de verificacao de conflito de funcionalidade
featureconflictchecker ftcftchk_0 (
		.A (CH6),
		.B (CH5),
		.C (CH4),
		.D (CH2),
		.E (CH1),
		.F (CH0),
		.cftout (cftchkwire)
);

//Instancia do BUS TRANSCEIVER das funcionalidades - IE01
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

//Instancia do BUS TRANSCEIVER das funcionalidades - IE02
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

//Instancia do validador de usuario na IE01
displayvalidator dpval_0 (
		.A (featurebitIE01[0]),
		.B (featurebitIE01[1]),
		.C (featurebitIE01[2]),
		.validout (displayvalwire0)
);

//Instancia do validador de usuario na IE01
displayvalidator dpval_1 (
		.A (featurebitIE02[0]),
		.B (featurebitIE02[1]),
		.C (featurebitIE02[2]),
		.validout (displayvalwire1)
);

//Instancia do seletor da entrada do display de 7 segmentos
sevendisplayselector sevensel_0 (
		.A (displayvalwire0),
		.B (displayvalwire1),
		.priorsel (priorselwire),
		.displaysel (sevenselwire)
);

//Instancia do MULTIPLEX (2:1) da validacao das funcionalidades das duas interfaces
mux2to1 dpvalidatormux_0 (
		.A (displayvalwire1),
		.B (displayvalwire0),
		.sel (sevenselwire),
		.out (mux2to1ToDisplay)
);

//Instancia do MULTIPLEX (6:3) do usuario das duas interfaces
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

//Instancia do decodificador para o display de 7 segmentos
sevensegmentdisplay ssdisplay_0 (
		.A (mux6to3ToDisplay0),
		.B (mux6to3ToDisplay1),
		.C (mux6to3ToDisplay2),
		.dpval (mux2to1ToDisplay),
		.sega (SGDA),
		.segb (SGDB),
		.segc (SGDC),
		.segd (SGDD),
		.sege (SGDE),
		.segf (SGDF),
		.segg (SGDG)
);

//Instancia do decodificador BIN para 1-6, para saber qual LED deve ser aceso - IE01
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

//Instancia do decodificador BIN para 1-6, para saber qual LED deve ser aceso - IE02
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

//Instancia do seletor da interface de saidas LED - IE01
ledinterfaceselector ledifsel_IE01 (
		.A (CH7),
		.B (NBT3),
		.C (NBT2),
		.ledsel (ledselwireIE01)
);

//Instancia do seletor da interface de saidas LED - IE02
ledinterfaceselector ledifsel_IE02 (
		.A (CH3),
		.B (NBT1),
		.C (NBT0),
		.ledsel (ledselwireIE02)
);

//Instancia do (de)MULTIPLEX (7:14) das interfaces de saidas LED (IS01 ou IS02) - IE01
mux7to14 mux7to14_IE01(
		.A (ledwireIE01[0]),
		.B (ledwireIE01[1]),
		.C (ledwireIE01[2]),
		.D (ledwireIE01[3]),
		.E (ledwireIE01[4]),
		.F (ledwireIE01[5]),
		.G (ledwireIE01[6]),
		.sel (ledselwireIE01),
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

//Instancia do (de)MULTIPLEX (7:14) das interfaces de saidas LED (IS01 ou IS02) - IE02
mux7to14 mux7to14_IE02(
		.A (ledwireIE02[0]),
		.B (ledwireIE02[1]),
		.C (ledwireIE02[2]),
		.D (ledwireIE02[3]),
		.E (ledwireIE02[4]),
		.F (ledwireIE02[5]),
		.G (ledwireIE02[6]),
		.sel (ledselwireIE02),
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

//Condicoes de ligar linhas da matriz de LED (IS01)
nor (LIN0, lattledwireIE01[0], lattledwireIE02[0]);
nor (LIN1, lattledwireIE01[1], lattledwireIE02[1]);
nor (LIN2, lattledwireIE01[2], lattledwireIE02[2]);
nor (LIN3, lattledwireIE01[3], lattledwireIE02[3]);
nor (LIN4, lattledwireIE01[4], lattledwireIE02[4]);
nor (LIN5, lattledwireIE01[5], lattledwireIE02[5]);
nor (LIN6, lattledwireIE01[6], lattledwireIE02[6]);
//Manter sempre as colunas ligadas caso exista algum usuario utilizando funcionalidade permitida
nor (noneOnWire, permIE01, permIE02);
not (COL0, noneOnWire);
not (COL1, noneOnWire);
not (COL2, noneOnWire);
not (COL3, noneOnWire);
not (COL4, noneOnWire);
//or (COL0, permIE01, permIE02);
//or (COL1, permIE01, permIE02);
//or (COL2, permIE01, permIE02);
//or (COL3, permIE01, permIE02);
//or (COL4, permIE01, permIE02);

//Teste
//or (LED7, displayvalwire0);
//or (LED8, displayvalwire1);
//or (LED9, mux2to1ToDisplay);

//Condicoes de ligar unidades LED (IS02)
or (LED0, seqledwireIE01[0], seqledwireIE02[0]);
or (LED1, seqledwireIE01[1], seqledwireIE02[1]);
or (LED2, seqledwireIE01[2], seqledwireIE02[2]);
or (LED3, seqledwireIE01[3], seqledwireIE02[3]);
or (LED4, seqledwireIE01[4], seqledwireIE02[4]);
or (LED5, seqledwireIE01[5], seqledwireIE02[5]);
or (LED6, seqledwireIE01[6], seqledwireIE02[6]);

endmodule
