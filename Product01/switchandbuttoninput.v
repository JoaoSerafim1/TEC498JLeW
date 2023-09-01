module authandfeatures(
CH0, CH1, CH2, CH3, CH4, CH5, CH6, CH7,
BT0, BT1, BT2, BT3,
ATadm0, ATtest0, ATuser0, ATguest0, FT00, FT10, FT20, FT30, FT40, FT50, FT60,
ATadm1, ATtest1, ATuser1, ATguest1, FT01, FT11, FT21, FT31, FT41, FT51, FT61
);
	
	input CH0, CH1, CH2, CH3, CH4, CH5, CH6, CH7, BT0, BT1, BT2, BT3;
	
	output ATadm0, ATtest0, ATuser0, ATguest0, FT00, FT10, FT20, FT30, FT40, FT50, FT60,
	ATadm1, ATtest1, ATuser1, ATguest1, FT01, FT11, FT21, FT31, FT41, FT51, FT61;
	
	wire NCH0, NCH1, NCH2, NCH3, NCH4, NCH5, NCH6, NCH7, NBT0, NBT1, NBT2, NBT3;

not (NCH0, CH0);
not (NCH1, CH1);
not (NCH2, CH2);
not (NCH3, CH3);
not (NCH4, CH4);
not (NCH5, CH5);
not (NCH6, CH6);
not (NCH7, CH7);
not (NBT0, BT0);
not (NBT1, BT1);
not (NBT2, BT2);
not (NBT3, BT3);

and atAnd00(ATadm0, CH0, NBT0, BT1);
and atAnd01(ATtest0, NCH0, BT0, BT1);
and atAnd02(ATuser0, NCH0, NBT0, BT1);
and atAnd03(ATguest0, CH0, BT0, NBT1);
and ftAnd01(FT00, NCH1, NCH2, CH3);
and ftAnd02(FT10, NCH1, CH2, NCH3);
and ftAnd03(FT20, NCH1, CH2, CH3);
and ftAnd04(FT30, CH1, NCH2, NCH3);
and ftAnd05(FT40, CH1, NCH2 , CH3);
and ftAnd06(FT50, CH1, CH2, NCH3);
and ftAnd00(FT60, CH1, CH2, CH3);

and atAnd10(ATadm1, CH4, NBT2, BT3);
and atAnd11(ATtest1, NCH4, BT2, BT3);
and atAnd12(ATuser1, NCH4, NBT2, BT3);
and atAnd13(ATguest1, CH4, BT2, NBT3);
and ftAnd11(FT01, NCH5, NCH6, CH7);
and ftAnd12(FT11, NCH5, CH6, NCH7);
and ftAnd13(FT21, NCH5, CH6, CH7);
and ftAnd14(FT31, CH5, NCH6, NCH7);
and ftAnd15(FT41, CH5, NCH6 , CH7);
and ftAnd16(FT51, CH5, CH6, NCH7);
and ftAnd10(FT61, CH5, CH6, CH7);

endmodule