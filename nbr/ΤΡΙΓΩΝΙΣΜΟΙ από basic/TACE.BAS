100 CLS
110 DEFDBL A-Z
120 PRINT"     ‡œ©©˜¢¦¤å¡ž, 1986                                "
130 PRINT
140 PRINT
150 PRINT"     *********     ***         *****    *******       "
160 PRINT"        ***       *****      ***        ***           "
170 PRINT"        ***      *** ***     ***        *****         "
180 PRINT"        ***     *********    ***        ***           "
190 PRINT"        ***     ***   ***      *****    *******       "
200 PRINT
210 PRINT
220 PRINT"     EŒ€ Ž‚€‹‹€ ‚I€ ’† ‘“ŒŽ‡—‘† ’†‘ „€’†‹„Œ†‘   "
230 PRINT"     ‹„ Ž‘€Œ€’ŽŠˆ‘‹Ž ‘’€ ƒ“Ž €‰€ Žƒ„“‘†‘ ‹„ ’†     "
240 PRINT"     ‹„‡ŽƒŽ ’—Œ „ˆ‘—‘„—Œ ‘“Œ‡†‰—Œ.                   "
250 PRINT
260 PRINT"     ‚¢é©©˜    : BASICA                               "
270 PRINT"     €¡¨å™œ ˜  : ƒ §¢ã                                "
280 PRINT"     ¨¦š¨˜££˜« ©«ãª :  A. ƒœ¨£á¤žª                   "
290 PRINT"     ’¦£â˜ª ‚œà›˜ ©å˜ª ¡˜  T¦§¦š¨˜­å˜ª                "
300 PRINT"     €¨ ©«¦«â¢œ ¦ ˜¤œ§ ©«ã£ ¦ ‡œ©©˜¢¦¤å¡žª           "
310 PRINT
320 PRINT
330 PRINT: PRINT"   á«ž©œ ¦§¦ ¦›ã§¦«œ §¢ã¡«¨¦ š ˜ ¤˜ ©¬¤œ®å©à  !  "
340 A$=INKEY$: IF A$="" GOTO 340
350 REM ************************************************************************
360 CLS
370 INPUT" ƒ—‘„ ’ŽŒ €ˆ‡‹Ž ’—Œ Š„“—Œ ’†‘ Žƒ„“‘†‘ ";N%
380 PRINT"------------------------------------------------------------------"
390 PRINT" ƒ—‘„ ’Ž ŽŒŽ‹€ ’Ž“ €•„ˆŽ“ ’—Œ ‘“Œ’„’€‚‹„Œ—Œ ’—Œ ‚Œ—‘’—Œ ‘†‹„ˆ—Œ ";
400 INPUT FILE1$
410 PRINT"------------------------------------------------------------------"
420 INPUT" ƒ—‘„ ’Ž ŽŒŽ‹€ ’Ž“ €•„ˆŽ“ ’—Œ €€’††‘„—Œ "; FILE2$
430 N1%=N%+1: N2%=N%+2
440 DIM TH(N1%),S(N%),X(N1%),Y(N1%),AZ(N2%),STH(N1%),SS(N%)
450 PI=4*ATN(1): L=PI/20000: R=200/PI
460 OPEN "I",#1,FILE1$
470 INPUT #1,X0,Y0
480 INPUT #1,X1,Y1
490 INPUT #1,XN,YN
500 INPUT #1,XN1,YN1
510 CLOSE #1
520 DX=X1-X0: DY=Y1-Y0
530 GOSUB 1470
540 AZ(1)=A0: X(1)=X1: Y(1)=Y1
550 A=0: B=0: C=0
560 D=0: E=0: F=0
570 REM-------------------------------------------------
580 OPEN "i",#1,FILE2$
590 FOR I%=1 TO N1%
600 INPUT #1,TH(I%),STH(I%)
610 I1%=I%+1
620 AZ(I1%)=AZ(I%)+TH(I%)-200
630 C=C+STH(I%)^2
640 IF I%=N1% GOTO 720
650 INPUT #1,S(I%),SS(I%)
660 A0=AZ(I1%)/R
670 X(I1%)=X(I%)+S(I%)*SIN(A0)
680 Y(I1%)=Y(I%)+S(I%)*COS(A0)
690 A=A+(SIN(A0)*SS(I%))^2
700 B=B+(COS(A0)*SS(I%))^2
710 D=D+SIN(A0)*COS(A0)*(SS(I%)^2)
720 NEXT I%
730 CLOSE #1
740 REM--------------------------------------------------
750 DX=XN1-XN: DY=YN1-YN: GOSUB 1470
760 WA=A0-AZ(N2%)
770 WX=(XN-X(N1%))*100: WY=(YN-Y(N1%))*100
780 IF WA>=-200 AND WA<=200 THEN GOTO 820
790 IF WA>200 THEN WA=WA-400
800 IF WA<-200 THEN WA=WA+400
810 GOTO 780
820 WA=WA*10000: CLS
830 LPRINT: LPRINT
840 LPRINT" 1  ’€ ‘”€Š‹€’€ ‰Š„ˆ‘ˆ‹€’Ž‘ ’†‘ Žƒ„“‘†‘"
850 LPRINT
860 LPRINT USING"  ‚à¤ ˜¡æ ©­á¢£˜ ¡¢œ ©å£˜«¦ª (cc) : #####.#";WA
870 LPRINT USING"  ‚¨˜££ ¡æ ©­á¢£˜ ¡¢œ ©å£˜«¦ª (cm) :  ¡˜«á  x = #####.#";WX
880 LPRINT TAB(35);USING"    ¡˜«á  y = #####.#";WY
890 LPRINT TAB(35);USING"    ¦¢ ¡æ   = #####.#";SQR(WX^2+WY^2)
900 REM--------------------------------------------------
910 FOR I%=1 TO N%
920 DX=(X(N1%)-X(I%))*L: DY=(Y(N1%)-Y(I%))*L
930 A=A+(STH(I%)*DY)^2
940 B=B+(STH(I%)*DX)^2
950 D=D-DX*DY*STH(I%)^2
960 E=E-DX*STH(I%)^2
970 F=F+DY*STH(I%)^2
980 NEXT I%
990 REM--------------------------------------------------
1000 DET=A*B*C+2*D*E*F-A*E^2-C*D^2-B*F^2
1010 KX=(B*C-E^2)*WX+(E*F-C*D)*WY+(D*E-B*F)*WA: KX=KX/DET
1020 KY=(E*F-C*D)*WX+(A*C-F^2)*WY+(D*F-A*E)*WA: KY=KY/DET
1030 KA=(D*E-B*F)*WX+(D*F-A*E)*WY+(A*B-D^2)*WA: KA=KA/DET
1040 REM--------------------------------------------------
1050 LPRINT: LPRINT: LPRINT
1060 LPRINT" 2  Žˆ €€’††‘„ˆ‘, OI ƒˆŽ‡—‘„ˆ‘ ’Ž“‘ ‰€ˆ Žˆ ‘“Œ’„’€‚Œ„Œ„‘"
1070 LPRINT"    T—Œ ‰Ž“”—Œ ’†‘ Žƒ„“‘†‘"
1080 LPRINT
1090 LPRINT"‰Ž“”†" TAB(10) "‚—Œˆ€" TAB(18) "ƒˆŽ‡—‘†" TAB(28) "€Ž‘’€‘†";
1100 LPRINT TAB(38) "ƒˆŽ‡—‘†" TAB(53) "‘“ŒŽ‡—‹„Œ„‘"
1110 LPRINT TAB(53) "‘“Œ’„’€‚‹„Œ„‘"
1120 LPRINT TAB(9) "(grad)" TAB(20) "(cc)" TAB(31) "(m)" TAB(40) "(cm)";
1130 LPRINT TAB(52) " x (m)      y (m)"
1140 LPRINT
1150 LPRINT TAB(48) USING"#######.###";X0,Y0
1160 FI=0
1170 FOR I%=1 TO N1%
1180 LPRINT USING"###";I%;: LPRINT TAB(8) USING"###.####";TH(I%);
1190 VTH=((Y(N1%)-Y(I%))*L*KX+(X(I%)-X(N1%))*L*KY+KA)*STH(I%)^2
1200 LPRINT TAB(18) USING"####.##";VTH;
1210 TH(I%)=TH(I%)+VTH/10000
1220 FI=FI+VTH^2/STH(I%)^2
1230 IF I%=N1% GOTO 1370
1240 I1%=I%+1: A0=AZ(I1%)/R
1250 VS=(SIN(A0)*KX+COS(A0)*KY)*SS(I%)^2
1260 S(I%)=S(I%)+VS/100
1270 FI=FI+VS^2/SS(I%)^2
1280 IF I%=1 THEN GOTO 1330
1290 I1%=I%-1: AZ(I%)=AZ(I1%)+TH(I1%)-200
1300 A0=AZ(I%)/R
1310 X(I%)=X(I1%)+S(I1%)*SIN(A0)
1320 Y(I%)=Y(I1%)+S(I1%)*COS(A0)
1330 LPRINT TAB(27) USING"#####.###";S(I%);
1340 LPRINT TAB(38) USING"####.##";VS;
1350 LPRINT TAB(48) USING"#######.###";X(I%),Y(I%)
1360 GOTO 1380
1370 LPRINT TAB(48) USING"#######.###";XN,YN
1380 NEXT I%
1390 LPRINT TAB(48) USING"#######.###";XN1,YN1
1400 SA=FI/3
1410 LPRINT: LPRINT: LPRINT
1420 LPRINT USING" 3  a-posteriori £œ«˜™¢ž«æ«ž«˜ = ###.####";SA
1430 LPRINT USING"    a-posteriori «¬§ ¡ã ˜§æ¡¢ ©ž = ###.##";SQR(SA)
1440 LPRINT USING"    ¡¨ «ã¨ ¦ ™œ¢« ©«¦§¦åž©žª = #####.####";FI
1450 END
1460 REM--------------------------------------------------
1470 REM      13 “ŽŠŽ‚ˆ‘‹Ž‘ ’Ž“ ’ŽŽ“ „”€’Ž‹„Œ†‘
1480 REM--------------------------------------------------
1490 IF DY=0 GOTO 1550
1500 A0=ATN(ABS(DX)/ABS(DY))*R
1510 IF DX>=0 AND DY<0 THEN A0=200-A0
1520 IF DX<0 AND DY<0 THEN A0=200+A0
1530 IF DX<0 AND DY>0 THEN A0=400-A0
1540 RETURN
1550 IF DX>0 THEN A0=100
1560 IF DX<0 THEN A0=300
1570 RETURN
A0=200+A0
1530 IF DX<0 AND DY>0 THEN A0=400-A0
1540 RETURN
1550 IF DX>0 THEN A0=100
1560 IF DX<0 