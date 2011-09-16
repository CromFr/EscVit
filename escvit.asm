
_main:
	MOV	#2048, W15
	MOV	#6142, W0
	MOV	WREG, 32
	MOV	#1, W0
	MOV	WREG, 52
	MOV	#4, W0
	IOR	68
	LNK	#4
	PUSH	W2

;escvit.c,134 :: 		void main()
;escvit.c,136 :: 		char cStabDelay[3]="00";
	PUSH	W10
	PUSH	W11
	PUSH	W12
	MOV	#48, W2
	MOV.B	W2, [W14+0]
	MOV	#48, W2
	MOV.B	W2, [W14+1]
	MOV	#0, W2
	MOV.B	W2, [W14+2]
;escvit.c,140 :: 		ADPCFG = 0xFFFF;
	MOV	#65535, W0
	MOV	WREG, ADPCFG
;escvit.c,143 :: 		TRISB = 0x000;
	CLR	TRISB
;escvit.c,144 :: 		PORTB = 0x000;
	CLR	PORTB
;escvit.c,145 :: 		TRISB = 0xFF;
	MOV	#255, W0
	MOV	WREG, TRISB
;escvit.c,147 :: 		TRISA = 0x00;    //Porte C = sorties
	CLR	TRISA
;escvit.c,148 :: 		PORTA = 0x00;
	CLR	PORTA
;escvit.c,150 :: 		Lcd_Init();
	CALL	_Lcd_Init
;escvit.c,151 :: 		Lcd_Cmd(_LCD_CLEAR);
	MOV.B	#1, W10
	CALL	_Lcd_Cmd
;escvit.c,152 :: 		Lcd_Cmd(_LCD_CURSOR_OFF);
	MOV.B	#12, W10
	CALL	_Lcd_Cmd
;escvit.c,164 :: 		pBuzzer = 1;
	BSET	PORTA, #0
;escvit.c,165 :: 		Delay_ms(150);
	MOV	#13, W8
	MOV	#13571, W7
L_main0:
	DEC	W7
	BRA NZ	L_main0
	DEC	W8
	BRA NZ	L_main0
;escvit.c,166 :: 		pBuzzer = 0;
	BCLR	PORTA, #0
;escvit.c,168 :: 		_MainMenu_SelectModes();
	CALL	__MainMenu_SelectModes
;escvit.c,170 :: 		while(1)
L_main2:
;escvit.c,174 :: 		if(pHaut)
	BTSS	PORTB, #0
	GOTO	L_main4
;escvit.c,177 :: 		if(nMenu == MAINMENU_PARAMETRES_HTEURMUR)
	MOV	#lo_addr(_nMenu), W0
	MOV.B	[W0], W0
	CP.B	W0, #11
	BRA Z	L__main199
	GOTO	L_main5
L__main199:
;escvit.c,180 :: 		if(nHauteurMurM>=30)
	MOV	#lo_addr(_nHauteurMurM), W0
	MOV.B	[W0], W0
	CP.B	W0, #30
	BRA GE	L__main200
	GOTO	L_main6
L__main200:
;escvit.c,182 :: 		BipRefus();
	CALL	_BipRefus
;escvit.c,183 :: 		}
	GOTO	L_main7
L_main6:
;escvit.c,186 :: 		Bip();
	CALL	_Bip
;escvit.c,188 :: 		nHauteurMurCM++;
	MOV.B	#1, W1
	MOV	#lo_addr(_nHauteurMurCM), W0
	ADD.B	W1, [W0], [W0]
;escvit.c,189 :: 		if(nHauteurMurCM == 100)
	MOV	#lo_addr(_nHauteurMurCM), W0
	MOV.B	[W0], W1
	MOV.B	#100, W0
	CP.B	W1, W0
	BRA Z	L__main201
	GOTO	L_main8
L__main201:
;escvit.c,191 :: 		nHauteurMurCM = 0;
	MOV	#lo_addr(_nHauteurMurCM), W1
	CLR	W0
	MOV.B	W0, [W1]
;escvit.c,192 :: 		nHauteurMurM++;
	MOV.B	#1, W1
	MOV	#lo_addr(_nHauteurMurM), W0
	ADD.B	W1, [W0], [W0]
;escvit.c,193 :: 		}
L_main8:
;escvit.c,195 :: 		}
L_main7:
;escvit.c,196 :: 		}
	GOTO	L_main9
L_main5:
;escvit.c,198 :: 		else if(nMenu == MAINMENU_PARAMETRES_STAB)
	MOV	#lo_addr(_nMenu), W0
	MOV.B	[W0], W0
	CP.B	W0, #12
	BRA Z	L__main202
	GOTO	L_main10
L__main202:
;escvit.c,200 :: 		Bip();
	CALL	_Bip
;escvit.c,202 :: 		if(nStab == STAB_AUTO)
	MOV	#lo_addr(_nStab), W0
	MOV.B	[W0], W0
	CP.B	W0, #1
	BRA Z	L__main203
	GOTO	L_main11
L__main203:
;escvit.c,204 :: 		nStab = STAB_SANS;
	MOV	#lo_addr(_nStab), W1
	MOV.B	#3, W0
	MOV.B	W0, [W1]
;escvit.c,205 :: 		Lcd_Out(2, 4, STR_STAB_SANS);
	MOV	#lo_addr(_STR_STAB_SANS), W12
	MOV	#4, W11
	MOV	#2, W10
	CALL	_Lcd_Out
;escvit.c,206 :: 		Lcd_Out(3, 6, "     ");
	MOV	#lo_addr(?lstr1_escvit), W12
	MOV	#6, W11
	MOV	#3, W10
	CALL	_Lcd_Out
;escvit.c,207 :: 		}
	GOTO	L_main12
L_main11:
;escvit.c,208 :: 		else if(nStab == STAB_MANU)
	MOV	#lo_addr(_nStab), W0
	MOV.B	[W0], W0
	CP.B	W0, #2
	BRA Z	L__main204
	GOTO	L_main13
L__main204:
;escvit.c,210 :: 		nStab = STAB_AUTO;
	MOV	#lo_addr(_nStab), W1
	MOV.B	#1, W0
	MOV.B	W0, [W1]
;escvit.c,211 :: 		Lcd_Out(2, 4, STR_STAB_AUTO);
	MOV	#lo_addr(_STR_STAB_AUTO), W12
	MOV	#4, W11
	MOV	#2, W10
	CALL	_Lcd_Out
;escvit.c,213 :: 		Lcd_Out(3, 6, cStabDelay);
	ADD	W14, #0, W0
	MOV	W0, W12
	MOV	#6, W11
	MOV	#3, W10
	CALL	_Lcd_Out
;escvit.c,214 :: 		Lcd_Out(3, 8, STR_UNITE_SEC);
	MOV	#lo_addr(_STR_UNITE_SEC), W12
	MOV	#8, W11
	MOV	#3, W10
	CALL	_Lcd_Out
;escvit.c,215 :: 		}
	GOTO	L_main14
L_main13:
;escvit.c,216 :: 		else if(nStab == STAB_SANS)
	MOV	#lo_addr(_nStab), W0
	MOV.B	[W0], W0
	CP.B	W0, #3
	BRA Z	L__main205
	GOTO	L_main15
L__main205:
;escvit.c,218 :: 		nStab = STAB_MANU;
	MOV	#lo_addr(_nStab), W1
	MOV.B	#2, W0
	MOV.B	W0, [W1]
;escvit.c,219 :: 		Lcd_Out(2, 4, STR_STAB_MANU);
	MOV	#lo_addr(_STR_STAB_MANU), W12
	MOV	#4, W11
	MOV	#2, W10
	CALL	_Lcd_Out
;escvit.c,220 :: 		}
L_main15:
L_main14:
L_main12:
;escvit.c,221 :: 		}
	GOTO	L_main16
L_main10:
;escvit.c,222 :: 		else if(nMenu == MAINMENU_PARAMETRES_AFFVIT)
	MOV	#lo_addr(_nMenu), W0
	MOV.B	[W0], W0
	CP.B	W0, #13
	BRA Z	L__main206
	GOTO	L_main17
L__main206:
;escvit.c,224 :: 		if(nUniteVitesse == UNITE_VITESSE_MS)
	MOV	#lo_addr(_nUniteVitesse), W0
	MOV.B	[W0], W0
	CP.B	W0, #2
	BRA Z	L__main207
	GOTO	L_main18
L__main207:
;escvit.c,226 :: 		Bip();
	CALL	_Bip
;escvit.c,227 :: 		nUniteVitesse = UNITE_VITESSE_KMH;
	MOV	#lo_addr(_nUniteVitesse), W1
	MOV.B	#1, W0
	MOV.B	W0, [W1]
;escvit.c,228 :: 		Lcd_Out(2, 14, STR_UNITE_KMH);
	MOV	#lo_addr(_STR_UNITE_KMH), W12
	MOV	#14, W11
	MOV	#2, W10
	CALL	_Lcd_Out
;escvit.c,229 :: 		}
	GOTO	L_main19
L_main18:
;escvit.c,230 :: 		else if(nUniteVitesse == UNITE_VITESSE_KMH)
	MOV	#lo_addr(_nUniteVitesse), W0
	MOV.B	[W0], W0
	CP.B	W0, #1
	BRA Z	L__main208
	GOTO	L_main20
L__main208:
;escvit.c,232 :: 		Bip();
	CALL	_Bip
;escvit.c,233 :: 		nUniteVitesse = UNITE_VITESSE_MS;
	MOV	#lo_addr(_nUniteVitesse), W1
	MOV.B	#2, W0
	MOV.B	W0, [W1]
;escvit.c,234 :: 		Lcd_Out(2, 14, STR_UNITE_MS);
	MOV	#lo_addr(_STR_UNITE_MS), W12
	MOV	#14, W11
	MOV	#2, W10
	CALL	_Lcd_Out
;escvit.c,235 :: 		}
L_main20:
L_main19:
;escvit.c,236 :: 		}
	GOTO	L_main21
L_main17:
;escvit.c,237 :: 		else if(nMenu == MAINMENU_PARAMETRES_DUREEDECOMPTE)
	MOV	#lo_addr(_nMenu), W0
	MOV.B	[W0], W0
	CP.B	W0, #16
	BRA Z	L__main209
	GOTO	L_main22
L__main209:
;escvit.c,239 :: 		if(nDureeDecompte != 10)
	MOV	_nDureeDecompte, W0
	CP	W0, #10
	BRA NZ	L__main210
	GOTO	L_main23
L__main210:
;escvit.c,241 :: 		Bip();
	CALL	_Bip
;escvit.c,242 :: 		nDureeDecompte++;
	MOV	#1, W1
	MOV	#lo_addr(_nDureeDecompte), W0
	ADD	W1, [W0], [W0]
;escvit.c,244 :: 		Lcd_Out(2, 8, cDureeDecompte);
	MOV	#lo_addr(_cDureeDecompte), W12
	MOV	#8, W11
	MOV	#2, W10
	CALL	_Lcd_Out
;escvit.c,245 :: 		}
	GOTO	L_main24
L_main23:
;escvit.c,248 :: 		BipRefus();
	CALL	_BipRefus
;escvit.c,249 :: 		}
L_main24:
;escvit.c,250 :: 		}
	GOTO	L_main25
L_main22:
;escvit.c,251 :: 		else if(nMenu == MAINMENU_PARAMETRES_BIPSDECOMPTE)
	MOV	#lo_addr(_nMenu), W0
	MOV.B	[W0], W0
	CP.B	W0, #17
	BRA Z	L__main211
	GOTO	L_main26
L__main211:
;escvit.c,253 :: 		if(nBipsDecompte != 5 && nDureeDecompte<=nBipsDecompte)
	MOV	_nBipsDecompte, W0
	CP	W0, #5
	BRA NZ	L__main212
	GOTO	L__main181
L__main212:
	MOV	_nDureeDecompte, W1
	MOV	#lo_addr(_nBipsDecompte), W0
	CP	W1, [W0]
	BRA LE	L__main213
	GOTO	L__main180
L__main213:
L__main179:
;escvit.c,255 :: 		Bip();
	CALL	_Bip
;escvit.c,256 :: 		nBipsDecompte++;
	MOV	#1, W1
	MOV	#lo_addr(_nBipsDecompte), W0
	ADD	W1, [W0], [W0]
;escvit.c,258 :: 		Lcd_Out(2, 8, cBipsDecompte);
	MOV	#lo_addr(_cBipsDecompte), W12
	MOV	#8, W11
	MOV	#2, W10
	CALL	_Lcd_Out
;escvit.c,259 :: 		}
	GOTO	L_main30
;escvit.c,253 :: 		if(nBipsDecompte != 5 && nDureeDecompte<=nBipsDecompte)
L__main181:
L__main180:
;escvit.c,262 :: 		BipRefus();
	CALL	_BipRefus
;escvit.c,263 :: 		}
L_main30:
;escvit.c,264 :: 		}
	GOTO	L_main31
L_main26:
;escvit.c,267 :: 		else if(nCurPos-1 < nCurLimHaut)
	MOV	#lo_addr(_nCurPos), W0
	SE	[W0], W0
	SUB	W0, #1, W1
	MOV	#lo_addr(_nCurLimHaut), W0
	ZE	[W0], W0
	CP	W1, W0
	BRA LT	L__main214
	GOTO	L_main32
L__main214:
;escvit.c,269 :: 		if(nMenu == MAINMENU_PARAMETRES_BIS)
	MOV	#lo_addr(_nMenu), W0
	MOV.B	[W0], W0
	CP.B	W0, #15
	BRA Z	L__main215
	GOTO	L_main33
L__main215:
;escvit.c,271 :: 		Bip();
	CALL	_Bip
;escvit.c,274 :: 		_MainMenu_Parametres();
	CALL	__MainMenu_Parametres
;escvit.c,276 :: 		DeplacerCurseur(4);
	MOV.B	#4, W10
	CALL	_DeplacerCurseur
;escvit.c,277 :: 		}
	GOTO	L_main34
L_main33:
;escvit.c,280 :: 		BipRefus();
	CALL	_BipRefus
;escvit.c,281 :: 		}
L_main34:
;escvit.c,282 :: 		}
	GOTO	L_main35
L_main32:
;escvit.c,285 :: 		Bip();
	CALL	_Bip
;escvit.c,288 :: 		Lcd_Out(nCurPos,3," ");
	MOV	#lo_addr(?lstr2_escvit), W12
	MOV	#3, W11
	MOV	#lo_addr(_nCurPos), W0
	SE	[W0], W10
	CALL	_Lcd_Out
;escvit.c,290 :: 		nCurPos--;
	MOV.B	#1, W1
	MOV	#lo_addr(_nCurPos), W0
	SUBR.B	W1, [W0], [W0]
;escvit.c,291 :: 		Lcd_Out(nCurPos,3,"~");
	MOV	#lo_addr(?lstr3_escvit), W12
	MOV	#3, W11
	MOV	#lo_addr(_nCurPos), W0
	SE	[W0], W10
	CALL	_Lcd_Out
;escvit.c,292 :: 		}
L_main35:
L_main31:
L_main25:
L_main21:
L_main16:
L_main9:
;escvit.c,294 :: 		while(pHaut){}
L_main36:
	BTSS	PORTB, #0
	GOTO	L_main37
	GOTO	L_main36
L_main37:
;escvit.c,295 :: 		}
	GOTO	L_main38
L_main4:
;escvit.c,298 :: 		else if(pBas)
	BTSS	PORTB, #2
	GOTO	L_main39
;escvit.c,301 :: 		if(nMenu == MAINMENU_PARAMETRES_HTEURMUR)
	MOV	#lo_addr(_nMenu), W0
	MOV.B	[W0], W0
	CP.B	W0, #11
	BRA Z	L__main216
	GOTO	L_main40
L__main216:
;escvit.c,304 :: 		if(nHauteurMurM<=1)
	MOV	#lo_addr(_nHauteurMurM), W0
	MOV.B	[W0], W0
	CP.B	W0, #1
	BRA LE	L__main217
	GOTO	L_main41
L__main217:
;escvit.c,306 :: 		BipRefus();
	CALL	_BipRefus
;escvit.c,307 :: 		}
	GOTO	L_main42
L_main41:
;escvit.c,310 :: 		Bip();
	CALL	_Bip
;escvit.c,312 :: 		nHauteurMurCM--;
	MOV.B	#1, W1
	MOV	#lo_addr(_nHauteurMurCM), W0
	SUBR.B	W1, [W0], [W0]
;escvit.c,313 :: 		if(nHauteurMurCM == -1)
	MOV	#lo_addr(_nHauteurMurCM), W0
	MOV.B	[W0], W1
	MOV.B	#255, W0
	CP.B	W1, W0
	BRA Z	L__main218
	GOTO	L_main43
L__main218:
;escvit.c,315 :: 		nHauteurMurCM = 99;
	MOV	#lo_addr(_nHauteurMurCM), W1
	MOV.B	#99, W0
	MOV.B	W0, [W1]
;escvit.c,316 :: 		nHauteurMurM--;
	MOV.B	#1, W1
	MOV	#lo_addr(_nHauteurMurM), W0
	SUBR.B	W1, [W0], [W0]
;escvit.c,317 :: 		}
L_main43:
;escvit.c,319 :: 		}
L_main42:
;escvit.c,320 :: 		}
	GOTO	L_main44
L_main40:
;escvit.c,321 :: 		else if(nMenu == MAINMENU_PARAMETRES_STAB)
	MOV	#lo_addr(_nMenu), W0
	MOV.B	[W0], W0
	CP.B	W0, #12
	BRA Z	L__main219
	GOTO	L_main45
L__main219:
;escvit.c,323 :: 		Bip();
	CALL	_Bip
;escvit.c,325 :: 		if(nStab == STAB_AUTO)
	MOV	#lo_addr(_nStab), W0
	MOV.B	[W0], W0
	CP.B	W0, #1
	BRA Z	L__main220
	GOTO	L_main46
L__main220:
;escvit.c,327 :: 		nStab = STAB_MANU;
	MOV	#lo_addr(_nStab), W1
	MOV.B	#2, W0
	MOV.B	W0, [W1]
;escvit.c,328 :: 		Lcd_Out(2, 4, STR_STAB_MANU);
	MOV	#lo_addr(_STR_STAB_MANU), W12
	MOV	#4, W11
	MOV	#2, W10
	CALL	_Lcd_Out
;escvit.c,329 :: 		}
	GOTO	L_main47
L_main46:
;escvit.c,330 :: 		else if(nStab == STAB_MANU)
	MOV	#lo_addr(_nStab), W0
	MOV.B	[W0], W0
	CP.B	W0, #2
	BRA Z	L__main221
	GOTO	L_main48
L__main221:
;escvit.c,332 :: 		nStab = STAB_SANS;
	MOV	#lo_addr(_nStab), W1
	MOV.B	#3, W0
	MOV.B	W0, [W1]
;escvit.c,333 :: 		Lcd_Out(2, 4, STR_STAB_SANS);
	MOV	#lo_addr(_STR_STAB_SANS), W12
	MOV	#4, W11
	MOV	#2, W10
	CALL	_Lcd_Out
;escvit.c,334 :: 		Lcd_Out(3, 6, STR_VIDE_5);
	MOV	#lo_addr(_STR_VIDE_5), W12
	MOV	#6, W11
	MOV	#3, W10
	CALL	_Lcd_Out
;escvit.c,335 :: 		}
	GOTO	L_main49
L_main48:
;escvit.c,336 :: 		else if(nStab == STAB_SANS)
	MOV	#lo_addr(_nStab), W0
	MOV.B	[W0], W0
	CP.B	W0, #3
	BRA Z	L__main222
	GOTO	L_main50
L__main222:
;escvit.c,338 :: 		nStab = STAB_AUTO;
	MOV	#lo_addr(_nStab), W1
	MOV.B	#1, W0
	MOV.B	W0, [W1]
;escvit.c,339 :: 		Lcd_Out(2, 4, STR_STAB_AUTO);
	MOV	#lo_addr(_STR_STAB_AUTO), W12
	MOV	#4, W11
	MOV	#2, W10
	CALL	_Lcd_Out
;escvit.c,341 :: 		Lcd_Out(3, 6, cStabDelay);
	ADD	W14, #0, W0
	MOV	W0, W12
	MOV	#6, W11
	MOV	#3, W10
	CALL	_Lcd_Out
;escvit.c,342 :: 		Lcd_Out(3, 8, STR_UNITE_SEC);
	MOV	#lo_addr(_STR_UNITE_SEC), W12
	MOV	#8, W11
	MOV	#3, W10
	CALL	_Lcd_Out
;escvit.c,343 :: 		}
L_main50:
L_main49:
L_main47:
;escvit.c,344 :: 		}
	GOTO	L_main51
L_main45:
;escvit.c,345 :: 		else if(nMenu == MAINMENU_PARAMETRES_AFFVIT)
	MOV	#lo_addr(_nMenu), W0
	MOV.B	[W0], W0
	CP.B	W0, #13
	BRA Z	L__main223
	GOTO	L_main52
L__main223:
;escvit.c,347 :: 		if(nUniteVitesse == UNITE_VITESSE_MS)
	MOV	#lo_addr(_nUniteVitesse), W0
	MOV.B	[W0], W0
	CP.B	W0, #2
	BRA Z	L__main224
	GOTO	L_main53
L__main224:
;escvit.c,349 :: 		Bip();
	CALL	_Bip
;escvit.c,350 :: 		nUniteVitesse = UNITE_VITESSE_KMH;
	MOV	#lo_addr(_nUniteVitesse), W1
	MOV.B	#1, W0
	MOV.B	W0, [W1]
;escvit.c,351 :: 		Lcd_Out(2, 14, STR_UNITE_KMH);
	MOV	#lo_addr(_STR_UNITE_KMH), W12
	MOV	#14, W11
	MOV	#2, W10
	CALL	_Lcd_Out
;escvit.c,352 :: 		}
	GOTO	L_main54
L_main53:
;escvit.c,353 :: 		else if(nUniteVitesse == UNITE_VITESSE_KMH)
	MOV	#lo_addr(_nUniteVitesse), W0
	MOV.B	[W0], W0
	CP.B	W0, #1
	BRA Z	L__main225
	GOTO	L_main55
L__main225:
;escvit.c,355 :: 		Bip();
	CALL	_Bip
;escvit.c,356 :: 		nUniteVitesse = UNITE_VITESSE_MS;
	MOV	#lo_addr(_nUniteVitesse), W1
	MOV.B	#2, W0
	MOV.B	W0, [W1]
;escvit.c,357 :: 		Lcd_Out(2, 14, STR_UNITE_MS);
	MOV	#lo_addr(_STR_UNITE_MS), W12
	MOV	#14, W11
	MOV	#2, W10
	CALL	_Lcd_Out
;escvit.c,358 :: 		}
L_main55:
L_main54:
;escvit.c,359 :: 		}
	GOTO	L_main56
L_main52:
;escvit.c,360 :: 		else if(nMenu == MAINMENU_PARAMETRES_DUREEDECOMPTE)
	MOV	#lo_addr(_nMenu), W0
	MOV.B	[W0], W0
	CP.B	W0, #16
	BRA Z	L__main226
	GOTO	L_main57
L__main226:
;escvit.c,362 :: 		if(nDureeDecompte != 1)
	MOV	_nDureeDecompte, W0
	CP	W0, #1
	BRA NZ	L__main227
	GOTO	L_main58
L__main227:
;escvit.c,364 :: 		Bip();
	CALL	_Bip
;escvit.c,365 :: 		nDureeDecompte--;
	MOV	#1, W1
	MOV	#lo_addr(_nDureeDecompte), W0
	SUBR	W1, [W0], [W0]
;escvit.c,367 :: 		Lcd_Out(2, 8, cDureeDecompte);
	MOV	#lo_addr(_cDureeDecompte), W12
	MOV	#8, W11
	MOV	#2, W10
	CALL	_Lcd_Out
;escvit.c,368 :: 		}
	GOTO	L_main59
L_main58:
;escvit.c,371 :: 		BipRefus();
	CALL	_BipRefus
;escvit.c,372 :: 		}
L_main59:
;escvit.c,373 :: 		}
	GOTO	L_main60
L_main57:
;escvit.c,374 :: 		else if(nMenu == MAINMENU_PARAMETRES_BIPSDECOMPTE)
	MOV	#lo_addr(_nMenu), W0
	MOV.B	[W0], W0
	CP.B	W0, #17
	BRA Z	L__main228
	GOTO	L_main61
L__main228:
;escvit.c,376 :: 		if(nBipsDecompte != 1 && nDureeDecompte>=nBipsDecompte)
	MOV	_nBipsDecompte, W0
	CP	W0, #1
	BRA NZ	L__main229
	GOTO	L__main183
L__main229:
	MOV	_nDureeDecompte, W1
	MOV	#lo_addr(_nBipsDecompte), W0
	CP	W1, [W0]
	BRA GE	L__main230
	GOTO	L__main182
L__main230:
L__main178:
;escvit.c,378 :: 		Bip();
	CALL	_Bip
;escvit.c,379 :: 		nBipsDecompte--;
	MOV	#1, W1
	MOV	#lo_addr(_nBipsDecompte), W0
	SUBR	W1, [W0], [W0]
;escvit.c,381 :: 		Lcd_Out(2, 8, cBipsDecompte);
	MOV	#lo_addr(_cBipsDecompte), W12
	MOV	#8, W11
	MOV	#2, W10
	CALL	_Lcd_Out
;escvit.c,382 :: 		}
	GOTO	L_main65
;escvit.c,376 :: 		if(nBipsDecompte != 1 && nDureeDecompte>=nBipsDecompte)
L__main183:
L__main182:
;escvit.c,385 :: 		BipRefus();
	CALL	_BipRefus
;escvit.c,386 :: 		}
L_main65:
;escvit.c,387 :: 		}
	GOTO	L_main66
L_main61:
;escvit.c,391 :: 		else if(nCurPos+1 > nCurLimBas)
	MOV	#lo_addr(_nCurPos), W0
	SE	[W0], W0
	ADD	W0, #1, W1
	MOV	#lo_addr(_nCurLimBas), W0
	ZE	[W0], W0
	CP	W1, W0
	BRA GT	L__main231
	GOTO	L_main67
L__main231:
;escvit.c,394 :: 		if(nMenu == MAINMENU_PARAMETRES)
	MOV	#lo_addr(_nMenu), W0
	MOV.B	[W0], W0
	CP.B	W0, #10
	BRA Z	L__main232
	GOTO	L_main68
L__main232:
;escvit.c,396 :: 		Bip();
	CALL	_Bip
;escvit.c,398 :: 		_MainMenu_Parametres_Bis();
	CALL	__MainMenu_Parametres_Bis
;escvit.c,399 :: 		}
	GOTO	L_main69
L_main68:
;escvit.c,402 :: 		BipRefus();
	CALL	_BipRefus
;escvit.c,403 :: 		}
L_main69:
;escvit.c,404 :: 		}
	GOTO	L_main70
L_main67:
;escvit.c,407 :: 		Bip();
	CALL	_Bip
;escvit.c,409 :: 		Lcd_Out(nCurPos,3," ");
	MOV	#lo_addr(?lstr4_escvit), W12
	MOV	#3, W11
	MOV	#lo_addr(_nCurPos), W0
	SE	[W0], W10
	CALL	_Lcd_Out
;escvit.c,411 :: 		nCurPos++;
	MOV.B	#1, W1
	MOV	#lo_addr(_nCurPos), W0
	ADD.B	W1, [W0], [W0]
;escvit.c,412 :: 		Lcd_Out(nCurPos,3,"~");
	MOV	#lo_addr(?lstr5_escvit), W12
	MOV	#3, W11
	MOV	#lo_addr(_nCurPos), W0
	SE	[W0], W10
	CALL	_Lcd_Out
;escvit.c,413 :: 		}
L_main70:
L_main66:
L_main60:
L_main56:
L_main51:
L_main44:
;escvit.c,415 :: 		while(pBas){}
L_main71:
	BTSS	PORTB, #2
	GOTO	L_main72
	GOTO	L_main71
L_main72:
;escvit.c,416 :: 		}
	GOTO	L_main73
L_main39:
;escvit.c,419 :: 		else if(pDroite)
	BTSS	PORTB, #1
	GOTO	L_main74
;escvit.c,421 :: 		if(nMenu == MAINMENU_SELECT_MODES)
	MOV	#lo_addr(_nMenu), W0
	MOV.B	[W0], W0
	CP.B	W0, #0
	BRA Z	L__main233
	GOTO	L_main75
L__main233:
;escvit.c,423 :: 		Bip();
	CALL	_Bip
;escvit.c,424 :: 		_MainMenu_Parametres();
	CALL	__MainMenu_Parametres
;escvit.c,425 :: 		}
	GOTO	L_main76
L_main75:
;escvit.c,426 :: 		else if(nMenu == MAINMENU_PARAMETRES || nMenu == MAINMENU_PARAMETRES_BIS)
	MOV	#lo_addr(_nMenu), W0
	MOV.B	[W0], W0
	CP.B	W0, #10
	BRA NZ	L__main234
	GOTO	L__main185
L__main234:
	MOV	#lo_addr(_nMenu), W0
	MOV.B	[W0], W0
	CP.B	W0, #15
	BRA NZ	L__main235
	GOTO	L__main184
L__main235:
	GOTO	L_main79
L__main185:
L__main184:
;escvit.c,428 :: 		Bip();
	CALL	_Bip
;escvit.c,429 :: 		_MainMenu_Programme();
	CALL	__MainMenu_Programme
;escvit.c,430 :: 		}
	GOTO	L_main80
L_main79:
;escvit.c,434 :: 		|| nMenu == MAINMENU_PARAMETRES_AFFVIT
	MOV	#lo_addr(_nMenu), W0
	MOV.B	[W0], W0
	CP.B	W0, #11
	BRA NZ	L__main236
	GOTO	L__main193
L__main236:
	MOV	#lo_addr(_nMenu), W0
	MOV.B	[W0], W0
	CP.B	W0, #13
	BRA NZ	L__main237
	GOTO	L__main192
L__main237:
;escvit.c,435 :: 		|| nMenu == MAINMENU_PROGRAMME
	MOV	#lo_addr(_nMenu), W0
	MOV.B	[W0], W0
	CP.B	W0, #20
	BRA NZ	L__main238
	GOTO	L__main191
L__main238:
;escvit.c,436 :: 		|| nMenu == MAINMENU_PROGRAMME_VERSION
	MOV	#lo_addr(_nMenu), W0
	MOV.B	[W0], W0
	CP.B	W0, #21
	BRA NZ	L__main239
	GOTO	L__main190
L__main239:
;escvit.c,437 :: 		|| nMenu == MAINMENU_PROGRAMME_INFOS
	MOV	#lo_addr(_nMenu), W0
	MOV.B	[W0], W0
	CP.B	W0, #22
	BRA NZ	L__main240
	GOTO	L__main189
L__main240:
;escvit.c,438 :: 		|| nMenu == MAINMENU_PARAMETRES_STAB
	MOV	#lo_addr(_nMenu), W0
	MOV.B	[W0], W0
	CP.B	W0, #12
	BRA NZ	L__main241
	GOTO	L__main188
L__main241:
;escvit.c,439 :: 		|| nMenu == MAINMENU_PARAMETRES_DUREEDECOMPTE
	MOV	#lo_addr(_nMenu), W0
	MOV.B	[W0], W0
	CP.B	W0, #16
	BRA NZ	L__main242
	GOTO	L__main187
L__main242:
;escvit.c,440 :: 		|| nMenu == MAINMENU_PARAMETRES_BIPSDECOMPTE)
	MOV	#lo_addr(_nMenu), W0
	MOV.B	[W0], W0
	CP.B	W0, #17
	BRA NZ	L__main243
	GOTO	L__main186
L__main243:
	GOTO	L_main83
;escvit.c,434 :: 		|| nMenu == MAINMENU_PARAMETRES_AFFVIT
L__main193:
L__main192:
;escvit.c,435 :: 		|| nMenu == MAINMENU_PROGRAMME
L__main191:
;escvit.c,436 :: 		|| nMenu == MAINMENU_PROGRAMME_VERSION
L__main190:
;escvit.c,437 :: 		|| nMenu == MAINMENU_PROGRAMME_INFOS
L__main189:
;escvit.c,438 :: 		|| nMenu == MAINMENU_PARAMETRES_STAB
L__main188:
;escvit.c,439 :: 		|| nMenu == MAINMENU_PARAMETRES_DUREEDECOMPTE
L__main187:
;escvit.c,440 :: 		|| nMenu == MAINMENU_PARAMETRES_BIPSDECOMPTE)
L__main186:
;escvit.c,442 :: 		BipRefus();
	CALL	_BipRefus
;escvit.c,443 :: 		}
L_main83:
L_main80:
L_main76:
;escvit.c,445 :: 		while(pDroite){}
L_main84:
	BTSS	PORTB, #1
	GOTO	L_main85
	GOTO	L_main84
L_main85:
;escvit.c,446 :: 		}
	GOTO	L_main86
L_main74:
;escvit.c,449 :: 		else if(pGauche)
	BTSS	PORTB, #3
	GOTO	L_main87
;escvit.c,451 :: 		if(nMenu == MAINMENU_PARAMETRES || nMenu == MAINMENU_PARAMETRES_BIS)
	MOV	#lo_addr(_nMenu), W0
	MOV.B	[W0], W0
	CP.B	W0, #10
	BRA NZ	L__main244
	GOTO	L__main195
L__main244:
	MOV	#lo_addr(_nMenu), W0
	MOV.B	[W0], W0
	CP.B	W0, #15
	BRA NZ	L__main245
	GOTO	L__main194
L__main245:
	GOTO	L_main90
L__main195:
L__main194:
;escvit.c,453 :: 		Bip();
	CALL	_Bip
;escvit.c,454 :: 		_MainMenu_SelectModes();
	CALL	__MainMenu_SelectModes
;escvit.c,455 :: 		}
	GOTO	L_main91
L_main90:
;escvit.c,456 :: 		else if(nMenu == MAINMENU_PROGRAMME)
	MOV	#lo_addr(_nMenu), W0
	MOV.B	[W0], W0
	CP.B	W0, #20
	BRA Z	L__main246
	GOTO	L_main92
L__main246:
;escvit.c,458 :: 		Bip();
	CALL	_Bip
;escvit.c,459 :: 		_MainMenu_Parametres();
	CALL	__MainMenu_Parametres
;escvit.c,460 :: 		}
	GOTO	L_main93
L_main92:
;escvit.c,461 :: 		else if(nMenu ==  MAINMENU_PROGRAMME_VERSION || nMenu == MAINMENU_PROGRAMME_INFOS)
	MOV	#lo_addr(_nMenu), W0
	MOV.B	[W0], W0
	CP.B	W0, #21
	BRA NZ	L__main247
	GOTO	L__main197
L__main247:
	MOV	#lo_addr(_nMenu), W0
	MOV.B	[W0], W0
	CP.B	W0, #22
	BRA NZ	L__main248
	GOTO	L__main196
L__main248:
	GOTO	L_main96
L__main197:
L__main196:
;escvit.c,463 :: 		Bip();
	CALL	_Bip
;escvit.c,464 :: 		_MainMenu_Programme();
	CALL	__MainMenu_Programme
;escvit.c,465 :: 		}
	GOTO	L_main97
L_main96:
;escvit.c,466 :: 		else if(nMenu == MAINMENU_PARAMETRES_HTEURMUR)
	MOV	#lo_addr(_nMenu), W0
	MOV.B	[W0], W0
	CP.B	W0, #11
	BRA Z	L__main249
	GOTO	L_main98
L__main249:
;escvit.c,468 :: 		Bip();
	CALL	_Bip
;escvit.c,471 :: 		_MainMenu_Parametres();
	CALL	__MainMenu_Parametres
;escvit.c,472 :: 		}
	GOTO	L_main99
L_main98:
;escvit.c,473 :: 		else if(nMenu == MAINMENU_PARAMETRES_AFFVIT)
	MOV	#lo_addr(_nMenu), W0
	MOV.B	[W0], W0
	CP.B	W0, #13
	BRA Z	L__main250
	GOTO	L_main100
L__main250:
;escvit.c,475 :: 		Bip();
	CALL	_Bip
;escvit.c,477 :: 		_MainMenu_Parametres();
	CALL	__MainMenu_Parametres
;escvit.c,478 :: 		}
	GOTO	L_main101
L_main100:
;escvit.c,479 :: 		else if(nMenu == MAINMENU_PARAMETRES_DUREEDECOMPTE)
	MOV	#lo_addr(_nMenu), W0
	MOV.B	[W0], W0
	CP.B	W0, #16
	BRA Z	L__main251
	GOTO	L_main102
L__main251:
;escvit.c,481 :: 		Bip();
	CALL	_Bip
;escvit.c,483 :: 		_MainMenu_Parametres_Bis();
	CALL	__MainMenu_Parametres_Bis
;escvit.c,484 :: 		}
	GOTO	L_main103
L_main102:
;escvit.c,485 :: 		else if(nMenu == MAINMENU_PARAMETRES_BIPSDECOMPTE)
	MOV	#lo_addr(_nMenu), W0
	MOV.B	[W0], W0
	CP.B	W0, #17
	BRA Z	L__main252
	GOTO	L_main104
L__main252:
;escvit.c,487 :: 		Bip();
	CALL	_Bip
;escvit.c,489 :: 		_MainMenu_Parametres_Bis();
	CALL	__MainMenu_Parametres_Bis
;escvit.c,490 :: 		}
	GOTO	L_main105
L_main104:
;escvit.c,493 :: 		else if(nMenu == MAINMENU_SELECT_MODES)
	MOV	#lo_addr(_nMenu), W0
	MOV.B	[W0], W0
	CP.B	W0, #0
	BRA Z	L__main253
	GOTO	L_main106
L__main253:
;escvit.c,495 :: 		BipRefus();
	CALL	_BipRefus
;escvit.c,496 :: 		}
L_main106:
L_main105:
L_main103:
L_main101:
L_main99:
L_main97:
L_main93:
L_main91:
;escvit.c,498 :: 		while(pGauche){}
L_main107:
	BTSS	PORTB, #3
	GOTO	L_main108
	GOTO	L_main107
L_main108:
;escvit.c,499 :: 		}
	GOTO	L_main109
L_main87:
;escvit.c,502 :: 		else if(pMenu)
	BTSS	PORTB, #5
	GOTO	L_main110
;escvit.c,504 :: 		if(nMenu == -1)
	MOV	#lo_addr(_nMenu), W0
	ZE	[W0], W1
	MOV	#65535, W0
	CP	W1, W0
	BRA Z	L__main254
	GOTO	L_main111
L__main254:
;escvit.c,506 :: 		BipRefus();
	CALL	_BipRefus
;escvit.c,507 :: 		}
	GOTO	L_main112
L_main111:
;escvit.c,510 :: 		Bip();
	CALL	_Bip
;escvit.c,511 :: 		_MainMenu_SelectModes();
	CALL	__MainMenu_SelectModes
;escvit.c,512 :: 		}
L_main112:
;escvit.c,514 :: 		while(pMenu){}
L_main113:
	BTSS	PORTB, #5
	GOTO	L_main114
	GOTO	L_main113
L_main114:
;escvit.c,515 :: 		}
	GOTO	L_main115
L_main110:
;escvit.c,518 :: 		else if(pOK)
	BTSS	PORTB, #4
	GOTO	L_main116
;escvit.c,520 :: 		switch(nMenu)
	GOTO	L_main117
;escvit.c,523 :: 		case MAINMENU_SELECT_MODES:
L_main119:
;escvit.c,529 :: 		if(nCurPos == 2)
	MOV	#lo_addr(_nCurPos), W0
	MOV.B	[W0], W0
	CP.B	W0, #2
	BRA Z	L__main255
	GOTO	L_main120
L__main255:
;escvit.c,531 :: 		Lcd_Cmd(_LCD_CLEAR);
	MOV.B	#1, W10
	CALL	_Lcd_Cmd
;escvit.c,532 :: 		Lcd_Out(1,1,STR_LIGNE_HR_2BLOC);
	MOV	#lo_addr(_STR_LIGNE_HR_2BLOC), W12
	MOV	#1, W11
	MOV	#1, W10
	CALL	_Lcd_Out
;escvit.c,533 :: 		Lcd_Out(2,1,STR_MODE);
	MOV	#lo_addr(_STR_MODE), W12
	MOV	#1, W11
	MOV	#2, W10
	CALL	_Lcd_Out
;escvit.c,534 :: 		Lcd_Out(3,1,"|      Automatique |");
	MOV	#lo_addr(?lstr6_escvit), W12
	MOV	#1, W11
	MOV	#3, W10
	CALL	_Lcd_Out
;escvit.c,535 :: 		Lcd_Out(4,1,STR_LIGNE_HR_2BLOC);
	MOV	#lo_addr(_STR_LIGNE_HR_2BLOC), W12
	MOV	#1, W11
	MOV	#4, W10
	CALL	_Lcd_Out
;escvit.c,537 :: 		}
	GOTO	L_main121
L_main120:
;escvit.c,538 :: 		else if(nCurPos == 3)
	MOV	#lo_addr(_nCurPos), W0
	MOV.B	[W0], W0
	CP.B	W0, #3
	BRA Z	L__main256
	GOTO	L_main122
L__main256:
;escvit.c,540 :: 		Lcd_Cmd(_LCD_CLEAR);
	MOV.B	#1, W10
	CALL	_Lcd_Cmd
;escvit.c,541 :: 		Lcd_Out(1,1,STR_LIGNE_HR_2BLOC);
	MOV	#lo_addr(_STR_LIGNE_HR_2BLOC), W12
	MOV	#1, W11
	MOV	#1, W10
	CALL	_Lcd_Out
;escvit.c,542 :: 		Lcd_Out(2,1,STR_MODE);
	MOV	#lo_addr(_STR_MODE), W12
	MOV	#1, W11
	MOV	#2, W10
	CALL	_Lcd_Out
;escvit.c,543 :: 		Lcd_Out(3,1,"|         Manuel   |");
	MOV	#lo_addr(?lstr7_escvit), W12
	MOV	#1, W11
	MOV	#3, W10
	CALL	_Lcd_Out
;escvit.c,544 :: 		Lcd_Out(4,1,STR_LIGNE_HR_2BLOC);
	MOV	#lo_addr(_STR_LIGNE_HR_2BLOC), W12
	MOV	#1, W11
	MOV	#4, W10
	CALL	_Lcd_Out
;escvit.c,546 :: 		}
	GOTO	L_main123
L_main122:
;escvit.c,547 :: 		else if(nCurPos == 4)
	MOV	#lo_addr(_nCurPos), W0
	MOV.B	[W0], W0
	CP.B	W0, #4
	BRA Z	L__main257
	GOTO	L_main124
L__main257:
;escvit.c,549 :: 		Lcd_Out(1,1,STR_LIGNE_HR_2BLOC);
	MOV	#lo_addr(_STR_LIGNE_HR_2BLOC), W12
	MOV	#1, W11
	MOV	#1, W10
	CALL	_Lcd_Out
;escvit.c,550 :: 		Lcd_Out(2,1,STR_MODE);
	MOV	#lo_addr(_STR_MODE), W12
	MOV	#1, W11
	MOV	#2, W10
	CALL	_Lcd_Out
;escvit.c,551 :: 		Lcd_Out(3,1,"|        Asservit  |");
	MOV	#lo_addr(?lstr8_escvit), W12
	MOV	#1, W11
	MOV	#3, W10
	CALL	_Lcd_Out
;escvit.c,552 :: 		Lcd_Out(4,1,STR_LIGNE_HR_2BLOC);
	MOV	#lo_addr(_STR_LIGNE_HR_2BLOC), W12
	MOV	#1, W11
	MOV	#4, W10
	CALL	_Lcd_Out
;escvit.c,554 :: 		}
L_main124:
L_main123:
L_main121:
;escvit.c,555 :: 		break;
	GOTO	L_main118
;escvit.c,558 :: 		case MAINMENU_PARAMETRES:
L_main125:
;escvit.c,564 :: 		if(nCurPos == 2)
	MOV	#lo_addr(_nCurPos), W0
	MOV.B	[W0], W0
	CP.B	W0, #2
	BRA Z	L__main258
	GOTO	L_main126
L__main258:
;escvit.c,566 :: 		Bip();
	CALL	_Bip
;escvit.c,567 :: 		_MainMenu_Parametres_HteurMur();
	CALL	__MainMenu_Parametres_HteurMur
;escvit.c,568 :: 		}
	GOTO	L_main127
L_main126:
;escvit.c,569 :: 		else if(nCurPos == 3)
	MOV	#lo_addr(_nCurPos), W0
	MOV.B	[W0], W0
	CP.B	W0, #3
	BRA Z	L__main259
	GOTO	L_main128
L__main259:
;escvit.c,571 :: 		Bip();
	CALL	_Bip
;escvit.c,572 :: 		_MainMenu_Parametres_Stab();
	CALL	__MainMenu_Parametres_Stab
;escvit.c,573 :: 		}
	GOTO	L_main129
L_main128:
;escvit.c,574 :: 		else if(nCurPos == 4)
	MOV	#lo_addr(_nCurPos), W0
	MOV.B	[W0], W0
	CP.B	W0, #4
	BRA Z	L__main260
	GOTO	L_main130
L__main260:
;escvit.c,576 :: 		Bip();
	CALL	_Bip
;escvit.c,577 :: 		_MainMenu_Parametres_AffVit();
	CALL	__MainMenu_Parametres_AffVit
;escvit.c,578 :: 		}
L_main130:
L_main129:
L_main127:
;escvit.c,579 :: 		break;
	GOTO	L_main118
;escvit.c,582 :: 		case MAINMENU_PARAMETRES_BIS:
L_main131:
;escvit.c,588 :: 		if(nCurPos == 1)
	MOV	#lo_addr(_nCurPos), W0
	MOV.B	[W0], W0
	CP.B	W0, #1
	BRA Z	L__main261
	GOTO	L_main132
L__main261:
;escvit.c,590 :: 		Bip();
	CALL	_Bip
;escvit.c,591 :: 		_MainMenu_Parametres_DureeDecompte();
	CALL	__MainMenu_Parametres_DureeDecompte
;escvit.c,592 :: 		}
	GOTO	L_main133
L_main132:
;escvit.c,593 :: 		else if(nCurPos == 2)
	MOV	#lo_addr(_nCurPos), W0
	MOV.B	[W0], W0
	CP.B	W0, #2
	BRA Z	L__main262
	GOTO	L_main134
L__main262:
;escvit.c,595 :: 		Bip();
	CALL	_Bip
;escvit.c,596 :: 		_MainMenu_Parametres_BipsDecompte();
	CALL	__MainMenu_Parametres_BipsDecompte
;escvit.c,597 :: 		}
	GOTO	L_main135
L_main134:
;escvit.c,598 :: 		else if(nCurPos == 3)
	MOV	#lo_addr(_nCurPos), W0
	MOV.B	[W0], W0
	CP.B	W0, #3
	BRA Z	L__main263
	GOTO	L_main136
L__main263:
;escvit.c,602 :: 		}
L_main136:
L_main135:
L_main133:
;escvit.c,603 :: 		break;
	GOTO	L_main118
;escvit.c,606 :: 		case MAINMENU_PARAMETRES_HTEURMUR:
L_main137:
;escvit.c,608 :: 		Bip();
	CALL	_Bip
;escvit.c,613 :: 		Lcd_Cmd(_LCD_CLEAR);
	MOV.B	#1, W10
	CALL	_Lcd_Cmd
;escvit.c,614 :: 		Lcd_Out(1,1,STR_LIGNE_HR_2BLOC);
	MOV	#lo_addr(_STR_LIGNE_HR_2BLOC), W12
	MOV	#1, W11
	MOV	#1, W10
	CALL	_Lcd_Out
;escvit.c,615 :: 		Lcd_Out(2,1,"| HAUTEUR DU MUR   |");
	MOV	#lo_addr(?lstr9_escvit), W12
	MOV	#1, W11
	MOV	#2, W10
	CALL	_Lcd_Out
;escvit.c,616 :: 		Lcd_Out(3,1,STR_ENREGISTREE);
	MOV	#lo_addr(_STR_ENREGISTREE), W12
	MOV	#1, W11
	MOV	#3, W10
	CALL	_Lcd_Out
;escvit.c,617 :: 		Lcd_Out(4,1,STR_LIGNE_HR_2BLOC);
	MOV	#lo_addr(_STR_LIGNE_HR_2BLOC), W12
	MOV	#1, W11
	MOV	#4, W10
	CALL	_Lcd_Out
;escvit.c,618 :: 		Delay_ms(800);
	MOV	#66, W8
	MOV	#6847, W7
L_main138:
	DEC	W7
	BRA NZ	L_main138
	DEC	W8
	BRA NZ	L_main138
	NOP
;escvit.c,620 :: 		_MainMenu_Parametres();
	CALL	__MainMenu_Parametres
;escvit.c,621 :: 		break;
	GOTO	L_main118
;escvit.c,624 :: 		case MAINMENU_PARAMETRES_STAB:
L_main140:
;escvit.c,626 :: 		Bip();
	CALL	_Bip
;escvit.c,631 :: 		Lcd_Cmd(_LCD_CLEAR);
	MOV.B	#1, W10
	CALL	_Lcd_Cmd
;escvit.c,632 :: 		Lcd_Out(1,1,STR_LIGNE_HR_2BLOC);
	MOV	#lo_addr(_STR_LIGNE_HR_2BLOC), W12
	MOV	#1, W11
	MOV	#1, W10
	CALL	_Lcd_Out
;escvit.c,633 :: 		Lcd_Out(2,1,"| TYPE DE STAB.    |");
	MOV	#lo_addr(?lstr10_escvit), W12
	MOV	#1, W11
	MOV	#2, W10
	CALL	_Lcd_Out
;escvit.c,634 :: 		Lcd_Out(3,1,STR_ENREGISTREE);
	MOV	#lo_addr(_STR_ENREGISTREE), W12
	MOV	#1, W11
	MOV	#3, W10
	CALL	_Lcd_Out
;escvit.c,635 :: 		Lcd_Out(4,1,STR_LIGNE_HR_2BLOC);
	MOV	#lo_addr(_STR_LIGNE_HR_2BLOC), W12
	MOV	#1, W11
	MOV	#4, W10
	CALL	_Lcd_Out
;escvit.c,636 :: 		Delay_ms(800);
	MOV	#66, W8
	MOV	#6847, W7
L_main141:
	DEC	W7
	BRA NZ	L_main141
	DEC	W8
	BRA NZ	L_main141
	NOP
;escvit.c,638 :: 		_MainMenu_Parametres();
	CALL	__MainMenu_Parametres
;escvit.c,639 :: 		break;
	GOTO	L_main118
;escvit.c,642 :: 		case MAINMENU_PARAMETRES_AFFVIT:
L_main143:
;escvit.c,644 :: 		Bip();
	CALL	_Bip
;escvit.c,648 :: 		Lcd_Cmd(_LCD_CLEAR);
	MOV.B	#1, W10
	CALL	_Lcd_Cmd
;escvit.c,649 :: 		Lcd_Out(1,1,STR_LIGNE_HR_2BLOC);
	MOV	#lo_addr(_STR_LIGNE_HR_2BLOC), W12
	MOV	#1, W11
	MOV	#1, W10
	CALL	_Lcd_Out
;escvit.c,650 :: 		Lcd_Out(2,1,"| UNITE DE VITESSE |");
	MOV	#lo_addr(?lstr11_escvit), W12
	MOV	#1, W11
	MOV	#2, W10
	CALL	_Lcd_Out
;escvit.c,651 :: 		Lcd_Out(3,1,STR_ENREGISTREE);
	MOV	#lo_addr(_STR_ENREGISTREE), W12
	MOV	#1, W11
	MOV	#3, W10
	CALL	_Lcd_Out
;escvit.c,652 :: 		Lcd_Out(4,1,STR_LIGNE_HR_2BLOC);
	MOV	#lo_addr(_STR_LIGNE_HR_2BLOC), W12
	MOV	#1, W11
	MOV	#4, W10
	CALL	_Lcd_Out
;escvit.c,653 :: 		Delay_ms(800);
	MOV	#66, W8
	MOV	#6847, W7
L_main144:
	DEC	W7
	BRA NZ	L_main144
	DEC	W8
	BRA NZ	L_main144
	NOP
;escvit.c,655 :: 		_MainMenu_Parametres();
	CALL	__MainMenu_Parametres
;escvit.c,656 :: 		break;
	GOTO	L_main118
;escvit.c,659 :: 		case MAINMENU_PARAMETRES_DUREEDECOMPTE:
L_main146:
;escvit.c,661 :: 		Bip();
	CALL	_Bip
;escvit.c,665 :: 		Lcd_Cmd(_LCD_CLEAR);
	MOV.B	#1, W10
	CALL	_Lcd_Cmd
;escvit.c,666 :: 		Lcd_Out(1,1,STR_LIGNE_HR_2BLOC);
	MOV	#lo_addr(_STR_LIGNE_HR_2BLOC), W12
	MOV	#1, W11
	MOV	#1, W10
	CALL	_Lcd_Out
;escvit.c,667 :: 		Lcd_Out(2,1,"|DUREE DU DECOMPTE |");
	MOV	#lo_addr(?lstr12_escvit), W12
	MOV	#1, W11
	MOV	#2, W10
	CALL	_Lcd_Out
;escvit.c,668 :: 		Lcd_Out(3,1,STR_ENREGISTREE);
	MOV	#lo_addr(_STR_ENREGISTREE), W12
	MOV	#1, W11
	MOV	#3, W10
	CALL	_Lcd_Out
;escvit.c,669 :: 		Lcd_Out(4,1,STR_LIGNE_HR_2BLOC);
	MOV	#lo_addr(_STR_LIGNE_HR_2BLOC), W12
	MOV	#1, W11
	MOV	#4, W10
	CALL	_Lcd_Out
;escvit.c,670 :: 		Delay_ms(800);
	MOV	#66, W8
	MOV	#6847, W7
L_main147:
	DEC	W7
	BRA NZ	L_main147
	DEC	W8
	BRA NZ	L_main147
	NOP
;escvit.c,672 :: 		_MainMenu_Parametres_Bis();
	CALL	__MainMenu_Parametres_Bis
;escvit.c,673 :: 		break;
	GOTO	L_main118
;escvit.c,676 :: 		case MAINMENU_PARAMETRES_BIPSDECOMPTE:
L_main149:
;escvit.c,678 :: 		Bip();
	CALL	_Bip
;escvit.c,682 :: 		Lcd_Cmd(_LCD_CLEAR);
	MOV.B	#1, W10
	CALL	_Lcd_Cmd
;escvit.c,683 :: 		Lcd_Out(1,1,STR_LIGNE_HR_2BLOC);
	MOV	#lo_addr(_STR_LIGNE_HR_2BLOC), W12
	MOV	#1, W11
	MOV	#1, W10
	CALL	_Lcd_Out
;escvit.c,684 :: 		Lcd_Out(2,1,"| BIPS AVANT DEC   |");
	MOV	#lo_addr(?lstr13_escvit), W12
	MOV	#1, W11
	MOV	#2, W10
	CALL	_Lcd_Out
;escvit.c,685 :: 		Lcd_Out(3,1,STR_ENREGISTREE);
	MOV	#lo_addr(_STR_ENREGISTREE), W12
	MOV	#1, W11
	MOV	#3, W10
	CALL	_Lcd_Out
;escvit.c,686 :: 		Lcd_Out(4,1,STR_LIGNE_HR_2BLOC);
	MOV	#lo_addr(_STR_LIGNE_HR_2BLOC), W12
	MOV	#1, W11
	MOV	#4, W10
	CALL	_Lcd_Out
;escvit.c,687 :: 		Delay_ms(800);
	MOV	#66, W8
	MOV	#6847, W7
L_main150:
	DEC	W7
	BRA NZ	L_main150
	DEC	W8
	BRA NZ	L_main150
	NOP
;escvit.c,689 :: 		_MainMenu_Parametres_Bis();
	CALL	__MainMenu_Parametres_Bis
;escvit.c,690 :: 		break;
	GOTO	L_main118
;escvit.c,693 :: 		case MAINMENU_PROGRAMME:
L_main152:
;escvit.c,699 :: 		if(nCurPos == 2)
	MOV	#lo_addr(_nCurPos), W0
	MOV.B	[W0], W0
	CP.B	W0, #2
	BRA Z	L__main264
	GOTO	L_main153
L__main264:
;escvit.c,701 :: 		Bip();
	CALL	_Bip
;escvit.c,702 :: 		_MainMenu_Programme_Version();
	CALL	__MainMenu_Programme_Version
;escvit.c,703 :: 		}
	GOTO	L_main154
L_main153:
;escvit.c,704 :: 		else if(nCurPos == 3)
	MOV	#lo_addr(_nCurPos), W0
	MOV.B	[W0], W0
	CP.B	W0, #3
	BRA Z	L__main265
	GOTO	L_main155
L__main265:
;escvit.c,706 :: 		Bip();
	CALL	_Bip
;escvit.c,707 :: 		_MainMenu_Programme_Infos();
	CALL	__MainMenu_Programme_Infos
;escvit.c,708 :: 		}
L_main155:
L_main154:
;escvit.c,709 :: 		break;
	GOTO	L_main118
;escvit.c,710 :: 		}
L_main117:
	MOV	#lo_addr(_nMenu), W0
	MOV.B	[W0], W0
	CP.B	W0, #0
	BRA NZ	L__main266
	GOTO	L_main119
L__main266:
	MOV	#lo_addr(_nMenu), W0
	MOV.B	[W0], W0
	CP.B	W0, #10
	BRA NZ	L__main267
	GOTO	L_main125
L__main267:
	MOV	#lo_addr(_nMenu), W0
	MOV.B	[W0], W0
	CP.B	W0, #15
	BRA NZ	L__main268
	GOTO	L_main131
L__main268:
	MOV	#lo_addr(_nMenu), W0
	MOV.B	[W0], W0
	CP.B	W0, #11
	BRA NZ	L__main269
	GOTO	L_main137
L__main269:
	MOV	#lo_addr(_nMenu), W0
	MOV.B	[W0], W0
	CP.B	W0, #12
	BRA NZ	L__main270
	GOTO	L_main140
L__main270:
	MOV	#lo_addr(_nMenu), W0
	MOV.B	[W0], W0
	CP.B	W0, #13
	BRA NZ	L__main271
	GOTO	L_main143
L__main271:
	MOV	#lo_addr(_nMenu), W0
	MOV.B	[W0], W0
	CP.B	W0, #16
	BRA NZ	L__main272
	GOTO	L_main146
L__main272:
	MOV	#lo_addr(_nMenu), W0
	MOV.B	[W0], W0
	CP.B	W0, #17
	BRA NZ	L__main273
	GOTO	L_main149
L__main273:
	MOV	#lo_addr(_nMenu), W0
	MOV.B	[W0], W0
	CP.B	W0, #20
	BRA NZ	L__main274
	GOTO	L_main152
L__main274:
L_main118:
;escvit.c,712 :: 		while(pOK){}
L_main156:
	BTSS	PORTB, #4
	GOTO	L_main157
	GOTO	L_main156
L_main157:
;escvit.c,713 :: 		}//Fin bouton OK
L_main116:
L_main115:
L_main109:
L_main86:
L_main73:
L_main38:
;escvit.c,714 :: 		}//Fin while(1)
	GOTO	L_main2
;escvit.c,715 :: 		}//Fin main
L_end_main:
	POP	W2
	ULNK
L__main275:
	BRA	L__main275
; end of _main

__MainMenu_SelectModes:

;escvit.c,724 :: 		void _MainMenu_SelectModes()
;escvit.c,726 :: 		Lcd_Cmd(_LCD_CLEAR);
	PUSH	W10
	PUSH	W11
	PUSH	W12
	MOV.B	#1, W10
	CALL	_Lcd_Cmd
;escvit.c,727 :: 		Lcd_Out(1,1,"O--SELECTION MODE-->");
	MOV	#lo_addr(?lstr14_escvit), W12
	MOV	#1, W11
	MOV	#1, W10
	CALL	_Lcd_Out
;escvit.c,728 :: 		Lcd_Out(2,1,"| ~AUTOMATIQUE      ");
	MOV	#lo_addr(?lstr15_escvit), W12
	MOV	#1, W11
	MOV	#2, W10
	CALL	_Lcd_Out
;escvit.c,729 :: 		Lcd_Out(3,1,"|  MANUEL           ");
	MOV	#lo_addr(?lstr16_escvit), W12
	MOV	#1, W11
	MOV	#3, W10
	CALL	_Lcd_Out
;escvit.c,730 :: 		Lcd_Out(4,1,"O  ASSERVIT        >");
	MOV	#lo_addr(?lstr17_escvit), W12
	MOV	#1, W11
	MOV	#4, W10
	CALL	_Lcd_Out
;escvit.c,732 :: 		nCurPos = 2;
	MOV	#lo_addr(_nCurPos), W1
	MOV.B	#2, W0
	MOV.B	W0, [W1]
;escvit.c,733 :: 		nMenu = MAINMENU_SELECT_MODES;
	MOV	#lo_addr(_nMenu), W1
	CLR	W0
	MOV.B	W0, [W1]
;escvit.c,734 :: 		nCurLimHaut = 2;
	MOV	#lo_addr(_nCurLimHaut), W1
	MOV.B	#2, W0
	MOV.B	W0, [W1]
;escvit.c,735 :: 		nCurLimBas = 4;
	MOV	#lo_addr(_nCurLimBas), W1
	MOV.B	#4, W0
	MOV.B	W0, [W1]
;escvit.c,736 :: 		}
L_end__MainMenu_SelectModes:
	POP	W12
	POP	W11
	POP	W10
	RETURN
; end of __MainMenu_SelectModes

__MainMenu_Parametres:

;escvit.c,739 :: 		void _MainMenu_Parametres()
;escvit.c,741 :: 		Lcd_Cmd(_LCD_CLEAR);
	PUSH	W10
	PUSH	W11
	PUSH	W12
	MOV.B	#1, W10
	CALL	_Lcd_Cmd
;escvit.c,742 :: 		Lcd_Out(1,1,"<----PARAMETRES---->");
	MOV	#lo_addr(?lstr18_escvit), W12
	MOV	#1, W11
	MOV	#1, W10
	CALL	_Lcd_Out
;escvit.c,743 :: 		Lcd_Out(2,1,"  ~HAUTEUR MUR      ");
	MOV	#lo_addr(?lstr19_escvit), W12
	MOV	#1, W11
	MOV	#2, W10
	CALL	_Lcd_Out
;escvit.c,744 :: 		Lcd_Out(3,1,"   STABILISATION    ");
	MOV	#lo_addr(?lstr20_escvit), W12
	MOV	#1, W11
	MOV	#3, W10
	CALL	_Lcd_Out
;escvit.c,745 :: 		Lcd_Out(4,1,"v  AFF.VITESSE MOY v");
	MOV	#lo_addr(?lstr21_escvit), W12
	MOV	#1, W11
	MOV	#4, W10
	CALL	_Lcd_Out
;escvit.c,747 :: 		nCurPos = 2;
	MOV	#lo_addr(_nCurPos), W1
	MOV.B	#2, W0
	MOV.B	W0, [W1]
;escvit.c,748 :: 		nMenu = MAINMENU_PARAMETRES;
	MOV	#lo_addr(_nMenu), W1
	MOV.B	#10, W0
	MOV.B	W0, [W1]
;escvit.c,749 :: 		nCurLimHaut = 2;
	MOV	#lo_addr(_nCurLimHaut), W1
	MOV.B	#2, W0
	MOV.B	W0, [W1]
;escvit.c,750 :: 		nCurLimBas = 4;
	MOV	#lo_addr(_nCurLimBas), W1
	MOV.B	#4, W0
	MOV.B	W0, [W1]
;escvit.c,751 :: 		}
L_end__MainMenu_Parametres:
	POP	W12
	POP	W11
	POP	W10
	RETURN
; end of __MainMenu_Parametres

__MainMenu_Parametres_Bis:

;escvit.c,754 :: 		void _MainMenu_Parametres_Bis()
;escvit.c,756 :: 		Lcd_Cmd(_LCD_CLEAR);
	PUSH	W10
	PUSH	W11
	PUSH	W12
	MOV.B	#1, W10
	CALL	_Lcd_Cmd
;escvit.c,757 :: 		Lcd_Out(1,1,"^ ~DUREE DECOMPTE  ^");
	MOV	#lo_addr(?lstr22_escvit), W12
	MOV	#1, W11
	MOV	#1, W10
	CALL	_Lcd_Out
;escvit.c,758 :: 		Lcd_Out(2,1,"   BIPS DECOMPTE    ");
	MOV	#lo_addr(?lstr23_escvit), W12
	MOV	#1, W11
	MOV	#2, W10
	CALL	_Lcd_Out
;escvit.c,759 :: 		Lcd_Out(3,1,"                    ");
	MOV	#lo_addr(?lstr24_escvit), W12
	MOV	#1, W11
	MOV	#3, W10
	CALL	_Lcd_Out
;escvit.c,760 :: 		Lcd_Out(4,1,"<--PARAMETRES BIS-->");
	MOV	#lo_addr(?lstr25_escvit), W12
	MOV	#1, W11
	MOV	#4, W10
	CALL	_Lcd_Out
;escvit.c,762 :: 		nCurPos = 1;
	MOV	#lo_addr(_nCurPos), W1
	MOV.B	#1, W0
	MOV.B	W0, [W1]
;escvit.c,763 :: 		nMenu = MAINMENU_PARAMETRES_BIS;
	MOV	#lo_addr(_nMenu), W1
	MOV.B	#15, W0
	MOV.B	W0, [W1]
;escvit.c,764 :: 		nCurLimHaut = 1;
	MOV	#lo_addr(_nCurLimHaut), W1
	MOV.B	#1, W0
	MOV.B	W0, [W1]
;escvit.c,765 :: 		nCurLimBas = 2;
	MOV	#lo_addr(_nCurLimBas), W1
	MOV.B	#2, W0
	MOV.B	W0, [W1]
;escvit.c,766 :: 		}
L_end__MainMenu_Parametres_Bis:
	POP	W12
	POP	W11
	POP	W10
	RETURN
; end of __MainMenu_Parametres_Bis

__MainMenu_Parametres_HteurMur:

;escvit.c,769 :: 		void _MainMenu_Parametres_HteurMur()
;escvit.c,771 :: 		Lcd_Cmd(_LCD_CLEAR);
	PUSH	W10
	PUSH	W11
	PUSH	W12
	MOV.B	#1, W10
	CALL	_Lcd_Cmd
;escvit.c,772 :: 		Lcd_Out(1,1,STR_LIGNE_HR_FLECHE_BLOC);
	MOV	#lo_addr(_STR_LIGNE_HR_FLECHE_BLOC), W12
	MOV	#1, W11
	MOV	#1, W10
	CALL	_Lcd_Out
;escvit.c,773 :: 		Lcd_Out(2,1,"           METRES ^|");
	MOV	#lo_addr(?lstr26_escvit), W12
	MOV	#1, W11
	MOV	#2, W10
	CALL	_Lcd_Out
;escvit.c,774 :: 		Lcd_Out(3,19,"v|");
	MOV	#lo_addr(?lstr27_escvit), W12
	MOV	#19, W11
	MOV	#3, W10
	CALL	_Lcd_Out
;escvit.c,775 :: 		Lcd_Out(4,1,STR_LIGNE_HR_FLECHE_BLOC);
	MOV	#lo_addr(_STR_LIGNE_HR_FLECHE_BLOC), W12
	MOV	#1, W11
	MOV	#4, W10
	CALL	_Lcd_Out
;escvit.c,777 :: 		nCurPos = 0;
	MOV	#lo_addr(_nCurPos), W1
	CLR	W0
	MOV.B	W0, [W1]
;escvit.c,778 :: 		nMenu = MAINMENU_PARAMETRES_HTEURMUR;
	MOV	#lo_addr(_nMenu), W1
	MOV.B	#11, W0
	MOV.B	W0, [W1]
;escvit.c,779 :: 		nCurLimHaut = 0;
	MOV	#lo_addr(_nCurLimHaut), W1
	CLR	W0
	MOV.B	W0, [W1]
;escvit.c,780 :: 		nCurLimBas = 0;
	MOV	#lo_addr(_nCurLimBas), W1
	CLR	W0
	MOV.B	W0, [W1]
;escvit.c,786 :: 		Lcd_Out(2, 3, cHauteurMurM);
	MOV	#lo_addr(_cHauteurMurM), W12
	MOV	#3, W11
	MOV	#2, W10
	CALL	_Lcd_Out
;escvit.c,787 :: 		Lcd_Out(2, 5, ".");
	MOV	#lo_addr(?lstr28_escvit), W12
	MOV	#5, W11
	MOV	#2, W10
	CALL	_Lcd_Out
;escvit.c,788 :: 		Lcd_Out(2, 6, cHauteurMurCM);
	MOV	#lo_addr(_cHauteurMurCM), W12
	MOV	#6, W11
	MOV	#2, W10
	CALL	_Lcd_Out
;escvit.c,789 :: 		}
L_end__MainMenu_Parametres_HteurMur:
	POP	W12
	POP	W11
	POP	W10
	RETURN
; end of __MainMenu_Parametres_HteurMur

__MainMenu_Parametres_AffVit:

;escvit.c,792 :: 		void _MainMenu_Parametres_AffVit()
;escvit.c,794 :: 		Lcd_Cmd(_LCD_CLEAR);
	PUSH	W10
	PUSH	W11
	PUSH	W12
	MOV.B	#1, W10
	CALL	_Lcd_Cmd
;escvit.c,795 :: 		Lcd_Out(1,1,STR_LIGNE_HR_FLECHE_BLOC);
	MOV	#lo_addr(_STR_LIGNE_HR_FLECHE_BLOC), W12
	MOV	#1, W11
	MOV	#1, W10
	CALL	_Lcd_Out
;escvit.c,796 :: 		Lcd_Out(2,1,"   UNITE :        ^|");
	MOV	#lo_addr(?lstr29_escvit), W12
	MOV	#1, W11
	MOV	#2, W10
	CALL	_Lcd_Out
;escvit.c,797 :: 		Lcd_Out(3,19,"v|");
	MOV	#lo_addr(?lstr30_escvit), W12
	MOV	#19, W11
	MOV	#3, W10
	CALL	_Lcd_Out
;escvit.c,798 :: 		Lcd_Out(4,1,STR_LIGNE_HR_FLECHE_BLOC);
	MOV	#lo_addr(_STR_LIGNE_HR_FLECHE_BLOC), W12
	MOV	#1, W11
	MOV	#4, W10
	CALL	_Lcd_Out
;escvit.c,800 :: 		nCurPos = 0;
	MOV	#lo_addr(_nCurPos), W1
	CLR	W0
	MOV.B	W0, [W1]
;escvit.c,801 :: 		nMenu = MAINMENU_PARAMETRES_AFFVIT;
	MOV	#lo_addr(_nMenu), W1
	MOV.B	#13, W0
	MOV.B	W0, [W1]
;escvit.c,802 :: 		nCurLimHaut = 0;
	MOV	#lo_addr(_nCurLimHaut), W1
	CLR	W0
	MOV.B	W0, [W1]
;escvit.c,803 :: 		nCurLimBas = 0;
	MOV	#lo_addr(_nCurLimBas), W1
	CLR	W0
	MOV.B	W0, [W1]
;escvit.c,806 :: 		if(nUniteVitesse == UNITE_VITESSE_KMH)
	MOV	#lo_addr(_nUniteVitesse), W0
	MOV.B	[W0], W0
	CP.B	W0, #1
	BRA Z	L___MainMenu_Parametres_AffVit281
	GOTO	L__MainMenu_Parametres_AffVit158
L___MainMenu_Parametres_AffVit281:
;escvit.c,808 :: 		Lcd_Out(2, 14, STR_UNITE_KMH);
	MOV	#lo_addr(_STR_UNITE_KMH), W12
	MOV	#14, W11
	MOV	#2, W10
	CALL	_Lcd_Out
;escvit.c,809 :: 		}
	GOTO	L__MainMenu_Parametres_AffVit159
L__MainMenu_Parametres_AffVit158:
;escvit.c,810 :: 		else if (nUniteVitesse == UNITE_VITESSE_MS)
	MOV	#lo_addr(_nUniteVitesse), W0
	MOV.B	[W0], W0
	CP.B	W0, #2
	BRA Z	L___MainMenu_Parametres_AffVit282
	GOTO	L__MainMenu_Parametres_AffVit160
L___MainMenu_Parametres_AffVit282:
;escvit.c,812 :: 		Lcd_Out(2, 14, STR_UNITE_MS);
	MOV	#lo_addr(_STR_UNITE_MS), W12
	MOV	#14, W11
	MOV	#2, W10
	CALL	_Lcd_Out
;escvit.c,813 :: 		}
L__MainMenu_Parametres_AffVit160:
L__MainMenu_Parametres_AffVit159:
;escvit.c,814 :: 		}
L_end__MainMenu_Parametres_AffVit:
	POP	W12
	POP	W11
	POP	W10
	RETURN
; end of __MainMenu_Parametres_AffVit

__MainMenu_Parametres_Stab:
	LNK	#4

;escvit.c,817 :: 		void _MainMenu_Parametres_Stab()
;escvit.c,821 :: 		Lcd_Cmd(_LCD_CLEAR);
	PUSH	W10
	PUSH	W11
	PUSH	W12
	MOV.B	#1, W10
	CALL	_Lcd_Cmd
;escvit.c,822 :: 		Lcd_Out(1,1,STR_LIGNE_HR_FLECHE_BLOC);
	MOV	#lo_addr(_STR_LIGNE_HR_FLECHE_BLOC), W12
	MOV	#1, W11
	MOV	#1, W10
	CALL	_Lcd_Out
;escvit.c,823 :: 		Lcd_Out(2,19,"^|");
	MOV	#lo_addr(?lstr31_escvit), W12
	MOV	#19, W11
	MOV	#2, W10
	CALL	_Lcd_Out
;escvit.c,824 :: 		Lcd_Out(3,19,"v|");
	MOV	#lo_addr(?lstr32_escvit), W12
	MOV	#19, W11
	MOV	#3, W10
	CALL	_Lcd_Out
;escvit.c,825 :: 		Lcd_Out(4,1,STR_LIGNE_HR_FLECHE_BLOC);
	MOV	#lo_addr(_STR_LIGNE_HR_FLECHE_BLOC), W12
	MOV	#1, W11
	MOV	#4, W10
	CALL	_Lcd_Out
;escvit.c,827 :: 		nCurPos = 0;
	MOV	#lo_addr(_nCurPos), W1
	CLR	W0
	MOV.B	W0, [W1]
;escvit.c,828 :: 		nMenu = MAINMENU_PARAMETRES_STAB;
	MOV	#lo_addr(_nMenu), W1
	MOV.B	#12, W0
	MOV.B	W0, [W1]
;escvit.c,829 :: 		nCurLimHaut = 0;
	MOV	#lo_addr(_nCurLimHaut), W1
	CLR	W0
	MOV.B	W0, [W1]
;escvit.c,830 :: 		nCurLimBas = 0;
	MOV	#lo_addr(_nCurLimBas), W1
	CLR	W0
	MOV.B	W0, [W1]
;escvit.c,835 :: 		if(nStab == STAB_AUTO)
	MOV	#lo_addr(_nStab), W0
	MOV.B	[W0], W0
	CP.B	W0, #1
	BRA Z	L___MainMenu_Parametres_Stab284
	GOTO	L__MainMenu_Parametres_Stab161
L___MainMenu_Parametres_Stab284:
;escvit.c,837 :: 		Lcd_Out(2, 4, STR_STAB_AUTO);
	MOV	#lo_addr(_STR_STAB_AUTO), W12
	MOV	#4, W11
	MOV	#2, W10
	CALL	_Lcd_Out
;escvit.c,840 :: 		Lcd_Out(3, 6, cStabDelay);
	ADD	W14, #0, W0
	MOV	W0, W12
	MOV	#6, W11
	MOV	#3, W10
	CALL	_Lcd_Out
;escvit.c,841 :: 		Lcd_Out(3, 8, STR_UNITE_SEC);
	MOV	#lo_addr(_STR_UNITE_SEC), W12
	MOV	#8, W11
	MOV	#3, W10
	CALL	_Lcd_Out
;escvit.c,842 :: 		}
	GOTO	L__MainMenu_Parametres_Stab162
L__MainMenu_Parametres_Stab161:
;escvit.c,843 :: 		else if (nStab == STAB_MANU)
	MOV	#lo_addr(_nStab), W0
	MOV.B	[W0], W0
	CP.B	W0, #2
	BRA Z	L___MainMenu_Parametres_Stab285
	GOTO	L__MainMenu_Parametres_Stab163
L___MainMenu_Parametres_Stab285:
;escvit.c,845 :: 		Lcd_Out(2, 4, STR_STAB_MANU);
	MOV	#lo_addr(_STR_STAB_MANU), W12
	MOV	#4, W11
	MOV	#2, W10
	CALL	_Lcd_Out
;escvit.c,846 :: 		Lcd_Out(3, 6, STR_VIDE_5);
	MOV	#lo_addr(_STR_VIDE_5), W12
	MOV	#6, W11
	MOV	#3, W10
	CALL	_Lcd_Out
;escvit.c,847 :: 		}
	GOTO	L__MainMenu_Parametres_Stab164
L__MainMenu_Parametres_Stab163:
;escvit.c,848 :: 		else if (nStab == STAB_SANS)
	MOV	#lo_addr(_nStab), W0
	MOV.B	[W0], W0
	CP.B	W0, #3
	BRA Z	L___MainMenu_Parametres_Stab286
	GOTO	L__MainMenu_Parametres_Stab165
L___MainMenu_Parametres_Stab286:
;escvit.c,850 :: 		Lcd_Out(2, 4, STR_STAB_SANS);
	MOV	#lo_addr(_STR_STAB_SANS), W12
	MOV	#4, W11
	MOV	#2, W10
	CALL	_Lcd_Out
;escvit.c,851 :: 		Lcd_Out(3, 6, STR_VIDE_5);
	MOV	#lo_addr(_STR_VIDE_5), W12
	MOV	#6, W11
	MOV	#3, W10
	CALL	_Lcd_Out
;escvit.c,852 :: 		}
L__MainMenu_Parametres_Stab165:
L__MainMenu_Parametres_Stab164:
L__MainMenu_Parametres_Stab162:
;escvit.c,853 :: 		}
L_end__MainMenu_Parametres_Stab:
	POP	W12
	POP	W11
	POP	W10
	ULNK
	RETURN
; end of __MainMenu_Parametres_Stab

__MainMenu_Parametres_DureeDecompte:

;escvit.c,856 :: 		void _MainMenu_Parametres_DureeDecompte()
;escvit.c,858 :: 		Lcd_Cmd(_LCD_CLEAR);
	PUSH	W10
	PUSH	W11
	PUSH	W12
	MOV.B	#1, W10
	CALL	_Lcd_Cmd
;escvit.c,863 :: 		Lcd_Out(1,1,STR_LIGNE_HR_FLECHE_BLOC);
	MOV	#lo_addr(_STR_LIGNE_HR_FLECHE_BLOC), W12
	MOV	#1, W11
	MOV	#1, W10
	CALL	_Lcd_Out
;escvit.c,864 :: 		Lcd_Out(2,11,"sec     ^|");
	MOV	#lo_addr(?lstr33_escvit), W12
	MOV	#11, W11
	MOV	#2, W10
	CALL	_Lcd_Out
;escvit.c,865 :: 		Lcd_Out(3,19,"v|");
	MOV	#lo_addr(?lstr34_escvit), W12
	MOV	#19, W11
	MOV	#3, W10
	CALL	_Lcd_Out
;escvit.c,866 :: 		Lcd_Out(4,1,STR_LIGNE_HR_FLECHE_BLOC);
	MOV	#lo_addr(_STR_LIGNE_HR_FLECHE_BLOC), W12
	MOV	#1, W11
	MOV	#4, W10
	CALL	_Lcd_Out
;escvit.c,868 :: 		nCurPos = 0;
	MOV	#lo_addr(_nCurPos), W1
	CLR	W0
	MOV.B	W0, [W1]
;escvit.c,869 :: 		nMenu = MAINMENU_PARAMETRES_DUREEDECOMPTE;
	MOV	#lo_addr(_nMenu), W1
	MOV.B	#16, W0
	MOV.B	W0, [W1]
;escvit.c,870 :: 		nCurLimHaut = 0;
	MOV	#lo_addr(_nCurLimHaut), W1
	CLR	W0
	MOV.B	W0, [W1]
;escvit.c,871 :: 		nCurLimBas = 0;
	MOV	#lo_addr(_nCurLimBas), W1
	CLR	W0
	MOV.B	W0, [W1]
;escvit.c,873 :: 		nDureeDecompte = 12;//A SUPPR
	MOV	#12, W0
	MOV	W0, _nDureeDecompte
;escvit.c,876 :: 		Lcd_Out(2, 8, cDureeDecompte);
	MOV	#lo_addr(_cDureeDecompte), W12
	MOV	#8, W11
	MOV	#2, W10
	CALL	_Lcd_Out
;escvit.c,877 :: 		}
L_end__MainMenu_Parametres_DureeDecompte:
	POP	W12
	POP	W11
	POP	W10
	RETURN
; end of __MainMenu_Parametres_DureeDecompte

__MainMenu_Parametres_BipsDecompte:

;escvit.c,880 :: 		void _MainMenu_Parametres_BipsDecompte()
;escvit.c,882 :: 		Lcd_Cmd(_LCD_CLEAR);
	PUSH	W10
	PUSH	W11
	PUSH	W12
	MOV.B	#1, W10
	CALL	_Lcd_Cmd
;escvit.c,887 :: 		Lcd_Out(1,1,STR_LIGNE_HR_FLECHE_BLOC);
	MOV	#lo_addr(_STR_LIGNE_HR_FLECHE_BLOC), W12
	MOV	#1, W11
	MOV	#1, W10
	CALL	_Lcd_Out
;escvit.c,888 :: 		Lcd_Out(2,9,"Bip(s)    ^|");
	MOV	#lo_addr(?lstr35_escvit), W12
	MOV	#9, W11
	MOV	#2, W10
	CALL	_Lcd_Out
;escvit.c,889 :: 		Lcd_Out(3,19,"v|");
	MOV	#lo_addr(?lstr36_escvit), W12
	MOV	#19, W11
	MOV	#3, W10
	CALL	_Lcd_Out
;escvit.c,890 :: 		Lcd_Out(4,1,STR_LIGNE_HR_FLECHE_BLOC);
	MOV	#lo_addr(_STR_LIGNE_HR_FLECHE_BLOC), W12
	MOV	#1, W11
	MOV	#4, W10
	CALL	_Lcd_Out
;escvit.c,892 :: 		nCurPos = 0;
	MOV	#lo_addr(_nCurPos), W1
	CLR	W0
	MOV.B	W0, [W1]
;escvit.c,893 :: 		nMenu = MAINMENU_PARAMETRES_BIPSDECOMPTE;
	MOV	#lo_addr(_nMenu), W1
	MOV.B	#17, W0
	MOV.B	W0, [W1]
;escvit.c,894 :: 		nCurLimHaut = 0;
	MOV	#lo_addr(_nCurLimHaut), W1
	CLR	W0
	MOV.B	W0, [W1]
;escvit.c,895 :: 		nCurLimBas = 0;
	MOV	#lo_addr(_nCurLimBas), W1
	CLR	W0
	MOV.B	W0, [W1]
;escvit.c,897 :: 		nBipsDecompte = 12;//A SUPPR
	MOV	#12, W0
	MOV	W0, _nBipsDecompte
;escvit.c,900 :: 		Lcd_Out(2, 6, cBipsDecompte);
	MOV	#lo_addr(_cBipsDecompte), W12
	MOV	#6, W11
	MOV	#2, W10
	CALL	_Lcd_Out
;escvit.c,901 :: 		}
L_end__MainMenu_Parametres_BipsDecompte:
	POP	W12
	POP	W11
	POP	W10
	RETURN
; end of __MainMenu_Parametres_BipsDecompte

__MainMenu_Programme:

;escvit.c,904 :: 		void _MainMenu_Programme()
;escvit.c,906 :: 		Lcd_Cmd(_LCD_CLEAR);
	PUSH	W10
	PUSH	W11
	PUSH	W12
	MOV.B	#1, W10
	CALL	_Lcd_Cmd
;escvit.c,911 :: 		Lcd_Out(1,1,"<----PROGRAMME-----O");
	MOV	#lo_addr(?lstr37_escvit), W12
	MOV	#1, W11
	MOV	#1, W10
	CALL	_Lcd_Out
;escvit.c,912 :: 		Lcd_Out(2,3,"~VERSION         |");
	MOV	#lo_addr(?lstr38_escvit), W12
	MOV	#3, W11
	MOV	#2, W10
	CALL	_Lcd_Out
;escvit.c,913 :: 		Lcd_Out(3,4,"INFORMATIONS    |");
	MOV	#lo_addr(?lstr39_escvit), W12
	MOV	#4, W11
	MOV	#3, W10
	CALL	_Lcd_Out
;escvit.c,914 :: 		Lcd_Out(4,1,STR_LIGNE_HR_FLECHE_BLOC);
	MOV	#lo_addr(_STR_LIGNE_HR_FLECHE_BLOC), W12
	MOV	#1, W11
	MOV	#4, W10
	CALL	_Lcd_Out
;escvit.c,916 :: 		nCurPos = 2;
	MOV	#lo_addr(_nCurPos), W1
	MOV.B	#2, W0
	MOV.B	W0, [W1]
;escvit.c,917 :: 		nMenu = MAINMENU_PROGRAMME;
	MOV	#lo_addr(_nMenu), W1
	MOV.B	#20, W0
	MOV.B	W0, [W1]
;escvit.c,918 :: 		nCurLimHaut = 2;
	MOV	#lo_addr(_nCurLimHaut), W1
	MOV.B	#2, W0
	MOV.B	W0, [W1]
;escvit.c,919 :: 		nCurLimBas = 3;
	MOV	#lo_addr(_nCurLimBas), W1
	MOV.B	#3, W0
	MOV.B	W0, [W1]
;escvit.c,920 :: 		}
L_end__MainMenu_Programme:
	POP	W12
	POP	W11
	POP	W10
	RETURN
; end of __MainMenu_Programme

__MainMenu_Programme_Version:

;escvit.c,922 :: 		void _MainMenu_Programme_Version()
;escvit.c,924 :: 		Lcd_Cmd(_LCD_CLEAR);
	PUSH	W10
	PUSH	W11
	PUSH	W12
	MOV.B	#1, W10
	CALL	_Lcd_Cmd
;escvit.c,929 :: 		Lcd_Out(1,1,STR_LIGNE_HR_FLECHE_BLOC);
	MOV	#lo_addr(_STR_LIGNE_HR_FLECHE_BLOC), W12
	MOV	#1, W11
	MOV	#1, W10
	CALL	_Lcd_Out
;escvit.c,930 :: 		Lcd_Out(2,7,"V 2.2.1      |");
	MOV	#lo_addr(?lstr40_escvit), W12
	MOV	#7, W11
	MOV	#2, W10
	CALL	_Lcd_Out
;escvit.c,931 :: 		Lcd_Out(3,3,"Date: 27/01/2011 |");
	MOV	#lo_addr(?lstr41_escvit), W12
	MOV	#3, W11
	MOV	#3, W10
	CALL	_Lcd_Out
;escvit.c,932 :: 		Lcd_Out(4,1,STR_LIGNE_HR_FLECHE_BLOC);
	MOV	#lo_addr(_STR_LIGNE_HR_FLECHE_BLOC), W12
	MOV	#1, W11
	MOV	#4, W10
	CALL	_Lcd_Out
;escvit.c,934 :: 		nCurPos = 0;
	MOV	#lo_addr(_nCurPos), W1
	CLR	W0
	MOV.B	W0, [W1]
;escvit.c,935 :: 		nMenu = MAINMENU_PROGRAMME_VERSION;
	MOV	#lo_addr(_nMenu), W1
	MOV.B	#21, W0
	MOV.B	W0, [W1]
;escvit.c,936 :: 		nCurLimHaut = 0;
	MOV	#lo_addr(_nCurLimHaut), W1
	CLR	W0
	MOV.B	W0, [W1]
;escvit.c,937 :: 		nCurLimBas = 0;
	MOV	#lo_addr(_nCurLimBas), W1
	CLR	W0
	MOV.B	W0, [W1]
;escvit.c,938 :: 		}
L_end__MainMenu_Programme_Version:
	POP	W12
	POP	W11
	POP	W10
	RETURN
; end of __MainMenu_Programme_Version

__MainMenu_Programme_Infos:

;escvit.c,940 :: 		void _MainMenu_Programme_Infos()
;escvit.c,942 :: 		Lcd_Cmd(_LCD_CLEAR);
	PUSH	W10
	PUSH	W11
	PUSH	W12
	MOV.B	#1, W10
	CALL	_Lcd_Cmd
;escvit.c,947 :: 		Lcd_Out(1,1,STR_LIGNE_HR_FLECHE_BLOC);
	MOV	#lo_addr(_STR_LIGNE_HR_FLECHE_BLOC), W12
	MOV	#1, W11
	MOV	#1, W10
	CALL	_Lcd_Out
;escvit.c,948 :: 		Lcd_Out(2,4,"Pour les GDO!   |");
	MOV	#lo_addr(?lstr42_escvit), W12
	MOV	#4, W11
	MOV	#2, W10
	CALL	_Lcd_Out
;escvit.c,949 :: 		Lcd_Out(3,3,"Thibaut CHARLES  |");
	MOV	#lo_addr(?lstr43_escvit), W12
	MOV	#3, W11
	MOV	#3, W10
	CALL	_Lcd_Out
;escvit.c,950 :: 		Lcd_Out(4,2,"crom29@hotmail.fr |");
	MOV	#lo_addr(?lstr44_escvit), W12
	MOV	#2, W11
	MOV	#4, W10
	CALL	_Lcd_Out
;escvit.c,952 :: 		nCurPos = 0;
	MOV	#lo_addr(_nCurPos), W1
	CLR	W0
	MOV.B	W0, [W1]
;escvit.c,953 :: 		nMenu = MAINMENU_PROGRAMME_INFOS;
	MOV	#lo_addr(_nMenu), W1
	MOV.B	#22, W0
	MOV.B	W0, [W1]
;escvit.c,954 :: 		nCurLimHaut = 0;
	MOV	#lo_addr(_nCurLimHaut), W1
	CLR	W0
	MOV.B	W0, [W1]
;escvit.c,955 :: 		nCurLimBas = 0;
	MOV	#lo_addr(_nCurLimBas), W1
	CLR	W0
	MOV.B	W0, [W1]
;escvit.c,956 :: 		}
L_end__MainMenu_Programme_Infos:
	POP	W12
	POP	W11
	POP	W10
	RETURN
; end of __MainMenu_Programme_Infos

_Bip:

;escvit.c,959 :: 		void Bip()
;escvit.c,962 :: 		pBuzzer = 1;
	BSET	PORTA, #0
;escvit.c,963 :: 		Delay_ms(70);
	MOV	#6, W8
	MOV	#45654, W7
L_Bip166:
	DEC	W7
	BRA NZ	L_Bip166
	DEC	W8
	BRA NZ	L_Bip166
;escvit.c,964 :: 		pBuzzer = 0;
	BCLR	PORTA, #0
;escvit.c,965 :: 		}
L_end_Bip:
	RETURN
; end of _Bip

_BipRefus:

;escvit.c,968 :: 		void BipRefus()
;escvit.c,971 :: 		pBuzzer = 1;
	BSET	PORTA, #0
;escvit.c,972 :: 		Delay_ms(60);
	MOV	#5, W8
	MOV	#57856, W7
L_BipRefus168:
	DEC	W7
	BRA NZ	L_BipRefus168
	DEC	W8
	BRA NZ	L_BipRefus168
	NOP
;escvit.c,973 :: 		pBuzzer = 0;
	BCLR	PORTA, #0
;escvit.c,974 :: 		Delay_ms(40);
	MOV	#4, W8
	MOV	#16725, W7
L_BipRefus170:
	DEC	W7
	BRA NZ	L_BipRefus170
	DEC	W8
	BRA NZ	L_BipRefus170
	NOP
;escvit.c,975 :: 		pBuzzer = 1;
	BSET	PORTA, #0
;escvit.c,976 :: 		Delay_ms(60);
	MOV	#5, W8
	MOV	#57856, W7
L_BipRefus172:
	DEC	W7
	BRA NZ	L_BipRefus172
	DEC	W8
	BRA NZ	L_BipRefus172
	NOP
;escvit.c,977 :: 		pBuzzer = 0;
	BCLR	PORTA, #0
;escvit.c,978 :: 		}
L_end_BipRefus:
	RETURN
; end of _BipRefus

_DeplacerCurseur:

;escvit.c,981 :: 		void DeplacerCurseur(unsigned short nLigne)
;escvit.c,983 :: 		Lcd_Out(nCurPos,3," ");
	PUSH	W11
	PUSH	W12
	PUSH	W10
	MOV	#lo_addr(?lstr45_escvit), W12
	MOV	#3, W11
	MOV	#lo_addr(_nCurPos), W0
	SE	[W0], W10
	CALL	_Lcd_Out
	POP	W10
;escvit.c,984 :: 		nCurPos = nLigne;
	MOV	#lo_addr(_nCurPos), W0
	MOV.B	W10, [W0]
;escvit.c,985 :: 		Lcd_Out(nCurPos,3,"~");
	MOV	#lo_addr(?lstr46_escvit), W12
	MOV	#3, W11
	SE	W10, W10
	CALL	_Lcd_Out
;escvit.c,986 :: 		}
L_end_DeplacerCurseur:
	POP	W12
	POP	W11
	RETURN
; end of _DeplacerCurseur

_Puissance:

;escvit.c,991 :: 		int Puissance(int x, int n)
;escvit.c,1003 :: 		}
L_end_Puissance:
	RETURN
; end of _Puissance

_CustIntToString:

;escvit.c,1013 :: 		void CustIntToString(int nNbAConvertir, char *Var, int nChars, unsigned short bRemplir)
;escvit.c,1078 :: 		}
L_end_CustIntToString:
	RETURN
; end of _CustIntToString
