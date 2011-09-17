
_main:
	MOVLW       48
	MOVWF       main_cStabDelay_L0+0 
	MOVLW       48
	MOVWF       main_cStabDelay_L0+1 
	CLRF        main_cStabDelay_L0+2 
;escvit.c,138 :: 		void main()
;escvit.c,143 :: 		ADCON1 = 0b11001110;
	MOVLW       206
	MOVWF       ADCON1+0 
;escvit.c,146 :: 		TRISB = 0x00;
	CLRF        TRISB+0 
;escvit.c,147 :: 		PORTB = 0x00;
	CLRF        PORTB+0 
;escvit.c,148 :: 		TRISB = 0xFF;
	MOVLW       255
	MOVWF       TRISB+0 
;escvit.c,150 :: 		TRISC = 0x00;    //Porte C = sorties
	CLRF        TRISC+0 
;escvit.c,151 :: 		PORTC = 0x00;
	CLRF        PORTC+0 
;escvit.c,153 :: 		Lcd_Init();
	CALL        _Lcd_Init+0, 0
;escvit.c,154 :: 		Lcd_Cmd(_LCD_CLEAR);
	MOVLW       1
	MOVWF       FARG_Lcd_Cmd_out_char+0 
	CALL        _Lcd_Cmd+0, 0
;escvit.c,155 :: 		Lcd_Cmd(_LCD_CURSOR_OFF);
	MOVLW       12
	MOVWF       FARG_Lcd_Cmd_out_char+0 
	CALL        _Lcd_Cmd+0, 0
;escvit.c,157 :: 		ADC_Init();
	CALL        _ADC_Init+0, 0
;escvit.c,169 :: 		pBuzzer = 1;
	BSF         PORTC+0, 0 
;escvit.c,170 :: 		Delay_ms(150);
	MOVLW       2
	MOVWF       R11, 0
	MOVLW       134
	MOVWF       R12, 0
	MOVLW       153
	MOVWF       R13, 0
L_main0:
	DECFSZ      R13, 1, 0
	BRA         L_main0
	DECFSZ      R12, 1, 0
	BRA         L_main0
	DECFSZ      R11, 1, 0
	BRA         L_main0
;escvit.c,171 :: 		pBuzzer = 0;
	BCF         PORTC+0, 0 
;escvit.c,173 :: 		_MainMenu_SelectModes();
	CALL        __MainMenu_SelectModes+0, 0
;escvit.c,175 :: 		while(1)
L_main1:
;escvit.c,179 :: 		if(pHaut)
	BTFSS       PORTB+0, 0 
	GOTO        L_main3
;escvit.c,300 :: 		}
	GOTO        L_main4
L_main3:
;escvit.c,303 :: 		else if(pBas)
	BTFSS       PORTB+0, 2 
	GOTO        L_main5
;escvit.c,306 :: 		if(nMenu == MAINMENU_PARAMETRES_HTEURMUR)
	MOVF        _nMenu+0, 0 
	XORLW       11
	BTFSS       STATUS+0, 2 
	GOTO        L_main6
;escvit.c,309 :: 		if(nHauteurMurM<=1)
	MOVLW       128
	XORLW       1
	MOVWF       R0 
	MOVLW       128
	XORWF       _nHauteurMurM+0, 0 
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 0 
	GOTO        L_main7
;escvit.c,311 :: 		BipRefus();
	CALL        _BipRefus+0, 0
;escvit.c,312 :: 		}
	GOTO        L_main8
L_main7:
;escvit.c,315 :: 		Bip();
	CALL        _Bip+0, 0
;escvit.c,317 :: 		nHauteurMurCM--;
	DECF        _nHauteurMurCM+0, 1 
;escvit.c,318 :: 		if(nHauteurMurCM == -1)
	MOVF        _nHauteurMurCM+0, 0 
	XORLW       255
	BTFSS       STATUS+0, 2 
	GOTO        L_main9
;escvit.c,320 :: 		nHauteurMurCM = 99;
	MOVLW       99
	MOVWF       _nHauteurMurCM+0 
;escvit.c,321 :: 		nHauteurMurM--;
	DECF        _nHauteurMurM+0, 1 
;escvit.c,322 :: 		}
L_main9:
;escvit.c,324 :: 		}
L_main8:
;escvit.c,325 :: 		}
	GOTO        L_main10
L_main6:
;escvit.c,326 :: 		else if(nMenu == MAINMENU_PARAMETRES_STAB)
	MOVF        _nMenu+0, 0 
	XORLW       12
	BTFSS       STATUS+0, 2 
	GOTO        L_main11
;escvit.c,328 :: 		Bip();
	CALL        _Bip+0, 0
;escvit.c,330 :: 		if(nStab == STAB_AUTO)
	MOVF        _nStab+0, 0 
	XORLW       1
	BTFSS       STATUS+0, 2 
	GOTO        L_main12
;escvit.c,332 :: 		nStab = STAB_MANU;
	MOVLW       2
	MOVWF       _nStab+0 
;escvit.c,333 :: 		Lcd_Out(2, 4, STR_STAB_MANU);
	MOVLW       2
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       4
	MOVWF       FARG_Lcd_Out_column+0 
	MOVLW       _STR_STAB_MANU+0
	MOVWF       FARG_Lcd_Out_text+0 
	MOVLW       hi_addr(_STR_STAB_MANU+0
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
;escvit.c,334 :: 		}
	GOTO        L_main13
L_main12:
;escvit.c,335 :: 		else if(nStab == STAB_MANU)
	MOVF        _nStab+0, 0 
	XORLW       2
	BTFSS       STATUS+0, 2 
	GOTO        L_main14
;escvit.c,337 :: 		nStab = STAB_SANS;
	MOVLW       3
	MOVWF       _nStab+0 
;escvit.c,338 :: 		Lcd_Out(2, 4, STR_STAB_SANS);
	MOVLW       2
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       4
	MOVWF       FARG_Lcd_Out_column+0 
	MOVLW       _STR_STAB_SANS+0
	MOVWF       FARG_Lcd_Out_text+0 
	MOVLW       hi_addr(_STR_STAB_SANS+0
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
;escvit.c,339 :: 		Lcd_Out(3, 6, STR_VIDE_5);
	MOVLW       3
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       6
	MOVWF       FARG_Lcd_Out_column+0 
	MOVLW       _STR_VIDE_5+0
	MOVWF       FARG_Lcd_Out_text+0 
	MOVLW       hi_addr(_STR_VIDE_5+0
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
;escvit.c,340 :: 		}
	GOTO        L_main15
L_main14:
;escvit.c,341 :: 		else if(nStab == STAB_SANS)
	MOVF        _nStab+0, 0 
	XORLW       3
	BTFSS       STATUS+0, 2 
	GOTO        L_main16
;escvit.c,343 :: 		nStab = STAB_AUTO;
	MOVLW       1
	MOVWF       _nStab+0 
;escvit.c,344 :: 		Lcd_Out(2, 4, STR_STAB_AUTO);
	MOVLW       2
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       4
	MOVWF       FARG_Lcd_Out_column+0 
	MOVLW       _STR_STAB_AUTO+0
	MOVWF       FARG_Lcd_Out_text+0 
	MOVLW       hi_addr(_STR_STAB_AUTO+0
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
;escvit.c,346 :: 		Lcd_Out(3, 6, cStabDelay);
	MOVLW       3
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       6
	MOVWF       FARG_Lcd_Out_column+0 
	MOVLW       main_cStabDelay_L0+0
	MOVWF       FARG_Lcd_Out_text+0 
	MOVLW       hi_addr(main_cStabDelay_L0+0
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
;escvit.c,347 :: 		Lcd_Out(3, 8, STR_UNITE_SEC);
	MOVLW       3
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       8
	MOVWF       FARG_Lcd_Out_column+0 
	MOVLW       _STR_UNITE_SEC+0
	MOVWF       FARG_Lcd_Out_text+0 
	MOVLW       hi_addr(_STR_UNITE_SEC+0
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
;escvit.c,348 :: 		}
L_main16:
L_main15:
L_main13:
;escvit.c,349 :: 		}
	GOTO        L_main17
L_main11:
;escvit.c,350 :: 		else if(nMenu == MAINMENU_PARAMETRES_AFFVIT)
	MOVF        _nMenu+0, 0 
	XORLW       13
	BTFSS       STATUS+0, 2 
	GOTO        L_main18
;escvit.c,352 :: 		if(nUniteVitesse == UNITE_VITESSE_MS)
	MOVF        _nUniteVitesse+0, 0 
	XORLW       2
	BTFSS       STATUS+0, 2 
	GOTO        L_main19
;escvit.c,354 :: 		Bip();
	CALL        _Bip+0, 0
;escvit.c,355 :: 		nUniteVitesse = UNITE_VITESSE_KMH;
	MOVLW       1
	MOVWF       _nUniteVitesse+0 
;escvit.c,356 :: 		Lcd_Out(2, 14, STR_UNITE_KMH);
	MOVLW       2
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       14
	MOVWF       FARG_Lcd_Out_column+0 
	MOVLW       _STR_UNITE_KMH+0
	MOVWF       FARG_Lcd_Out_text+0 
	MOVLW       hi_addr(_STR_UNITE_KMH+0
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
;escvit.c,357 :: 		}
	GOTO        L_main20
L_main19:
;escvit.c,358 :: 		else if(nUniteVitesse == UNITE_VITESSE_KMH)
	MOVF        _nUniteVitesse+0, 0 
	XORLW       1
	BTFSS       STATUS+0, 2 
	GOTO        L_main21
;escvit.c,360 :: 		Bip();
	CALL        _Bip+0, 0
;escvit.c,361 :: 		nUniteVitesse = UNITE_VITESSE_MS;
	MOVLW       2
	MOVWF       _nUniteVitesse+0 
;escvit.c,362 :: 		Lcd_Out(2, 14, STR_UNITE_MS);
	MOVLW       2
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       14
	MOVWF       FARG_Lcd_Out_column+0 
	MOVLW       _STR_UNITE_MS+0
	MOVWF       FARG_Lcd_Out_text+0 
	MOVLW       hi_addr(_STR_UNITE_MS+0
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
;escvit.c,363 :: 		}
L_main21:
L_main20:
;escvit.c,364 :: 		}
	GOTO        L_main22
L_main18:
;escvit.c,365 :: 		else if(nMenu == MAINMENU_PARAMETRES_DUREEDECOMPTE)
	MOVF        _nMenu+0, 0 
	XORLW       16
	BTFSS       STATUS+0, 2 
	GOTO        L_main23
;escvit.c,367 :: 		if(nDureeDecompte != 1)
	MOVLW       0
	XORWF       _nDureeDecompte+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__main150
	MOVLW       1
	XORWF       _nDureeDecompte+0, 0 
L__main150:
	BTFSC       STATUS+0, 2 
	GOTO        L_main24
;escvit.c,369 :: 		Bip();
	CALL        _Bip+0, 0
;escvit.c,370 :: 		nDureeDecompte--;
	MOVLW       1
	SUBWF       _nDureeDecompte+0, 1 
	MOVLW       0
	SUBWFB      _nDureeDecompte+1, 1 
;escvit.c,372 :: 		Lcd_Out(2, 8, cDureeDecompte);
	MOVLW       2
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       8
	MOVWF       FARG_Lcd_Out_column+0 
	MOVLW       _cDureeDecompte+0
	MOVWF       FARG_Lcd_Out_text+0 
	MOVLW       hi_addr(_cDureeDecompte+0
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
;escvit.c,373 :: 		}
	GOTO        L_main25
L_main24:
;escvit.c,376 :: 		BipRefus();
	CALL        _BipRefus+0, 0
;escvit.c,377 :: 		}
L_main25:
;escvit.c,378 :: 		}
	GOTO        L_main26
L_main23:
;escvit.c,379 :: 		else if(nMenu == MAINMENU_PARAMETRES_BIPSDECOMPTE)
	MOVF        _nMenu+0, 0 
	XORLW       17
	BTFSS       STATUS+0, 2 
	GOTO        L_main27
;escvit.c,381 :: 		if(nBipsDecompte != 1 && nDureeDecompte>=nBipsDecompte)
	MOVLW       0
	XORWF       _nBipsDecompte+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__main151
	MOVLW       1
	XORWF       _nBipsDecompte+0, 0 
L__main151:
	BTFSC       STATUS+0, 2 
	GOTO        L_main30
	MOVLW       128
	XORWF       _nDureeDecompte+1, 0 
	MOVWF       R0 
	MOVLW       128
	XORWF       _nBipsDecompte+1, 0 
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__main152
	MOVF        _nBipsDecompte+0, 0 
	SUBWF       _nDureeDecompte+0, 0 
L__main152:
	BTFSS       STATUS+0, 0 
	GOTO        L_main30
L__main148:
;escvit.c,383 :: 		Bip();
	CALL        _Bip+0, 0
;escvit.c,384 :: 		nBipsDecompte--;
	MOVLW       1
	SUBWF       _nBipsDecompte+0, 1 
	MOVLW       0
	SUBWFB      _nBipsDecompte+1, 1 
;escvit.c,386 :: 		Lcd_Out(2, 8, cBipsDecompte);
	MOVLW       2
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       8
	MOVWF       FARG_Lcd_Out_column+0 
	MOVLW       _cBipsDecompte+0
	MOVWF       FARG_Lcd_Out_text+0 
	MOVLW       hi_addr(_cBipsDecompte+0
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
;escvit.c,387 :: 		}
	GOTO        L_main31
L_main30:
;escvit.c,390 :: 		BipRefus();
	CALL        _BipRefus+0, 0
;escvit.c,391 :: 		}
L_main31:
;escvit.c,392 :: 		}
	GOTO        L_main32
L_main27:
;escvit.c,396 :: 		else if(nCurPos+1 > nCurLimBas)
	MOVF        _nCurPos+0, 0 
	ADDLW       1
	MOVWF       R1 
	CLRF        R2 
	MOVLW       0
	BTFSC       _nCurPos+0, 7 
	MOVLW       255
	ADDWFC      R2, 1 
	MOVLW       128
	MOVWF       R0 
	MOVLW       128
	XORWF       R2, 0 
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__main153
	MOVF        R1, 0 
	SUBWF       _nCurLimBas+0, 0 
L__main153:
	BTFSC       STATUS+0, 0 
	GOTO        L_main33
;escvit.c,399 :: 		if(nMenu == MAINMENU_PARAMETRES)
	MOVF        _nMenu+0, 0 
	XORLW       10
	BTFSS       STATUS+0, 2 
	GOTO        L_main34
;escvit.c,401 :: 		Bip();
	CALL        _Bip+0, 0
;escvit.c,403 :: 		_MainMenu_Parametres_Bis();
	CALL        __MainMenu_Parametres_Bis+0, 0
;escvit.c,404 :: 		}
	GOTO        L_main35
L_main34:
;escvit.c,407 :: 		BipRefus();
	CALL        _BipRefus+0, 0
;escvit.c,408 :: 		}
L_main35:
;escvit.c,409 :: 		}
	GOTO        L_main36
L_main33:
;escvit.c,412 :: 		Bip();
	CALL        _Bip+0, 0
;escvit.c,414 :: 		Lcd_Out(nCurPos,3," ");
	MOVF        _nCurPos+0, 0 
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       3
	MOVWF       FARG_Lcd_Out_column+0 
	MOVLW       ?lstr1_escvit+0
	MOVWF       FARG_Lcd_Out_text+0 
	MOVLW       hi_addr(?lstr1_escvit+0
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
;escvit.c,416 :: 		nCurPos++;
	INCF        _nCurPos+0, 1 
;escvit.c,417 :: 		Lcd_Out(nCurPos,3,"~");
	MOVF        _nCurPos+0, 0 
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       3
	MOVWF       FARG_Lcd_Out_column+0 
	MOVLW       ?lstr2_escvit+0
	MOVWF       FARG_Lcd_Out_text+0 
	MOVLW       hi_addr(?lstr2_escvit+0
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
;escvit.c,418 :: 		}
L_main36:
L_main32:
L_main26:
L_main22:
L_main17:
L_main10:
;escvit.c,420 :: 		while(pBas){}
L_main37:
	BTFSS       PORTB+0, 2 
	GOTO        L_main38
	GOTO        L_main37
L_main38:
;escvit.c,421 :: 		}
	GOTO        L_main39
L_main5:
;escvit.c,424 :: 		else if(pDroite)
	BTFSS       PORTB+0, 1 
	GOTO        L_main40
;escvit.c,426 :: 		if(nMenu == MAINMENU_SELECT_MODES)
	MOVF        _nMenu+0, 0 
	XORLW       0
	BTFSS       STATUS+0, 2 
	GOTO        L_main41
;escvit.c,428 :: 		Bip();
	CALL        _Bip+0, 0
;escvit.c,429 :: 		_MainMenu_Parametres();
	CALL        __MainMenu_Parametres+0, 0
;escvit.c,430 :: 		}
	GOTO        L_main42
L_main41:
;escvit.c,431 :: 		else if(nMenu == MAINMENU_PARAMETRES || nMenu == MAINMENU_PARAMETRES_BIS)
	MOVF        _nMenu+0, 0 
	XORLW       10
	BTFSC       STATUS+0, 2 
	GOTO        L__main147
	MOVF        _nMenu+0, 0 
	XORLW       15
	BTFSC       STATUS+0, 2 
	GOTO        L__main147
	GOTO        L_main45
L__main147:
;escvit.c,433 :: 		Bip();
	CALL        _Bip+0, 0
;escvit.c,434 :: 		_MainMenu_Programme();
	CALL        __MainMenu_Programme+0, 0
;escvit.c,435 :: 		}
	GOTO        L_main46
L_main45:
;escvit.c,439 :: 		|| nMenu == MAINMENU_PARAMETRES_AFFVIT
	MOVF        _nMenu+0, 0 
	XORLW       11
	BTFSC       STATUS+0, 2 
	GOTO        L__main146
	MOVF        _nMenu+0, 0 
	XORLW       13
	BTFSC       STATUS+0, 2 
	GOTO        L__main146
;escvit.c,440 :: 		|| nMenu == MAINMENU_PROGRAMME
	MOVF        _nMenu+0, 0 
	XORLW       20
	BTFSC       STATUS+0, 2 
	GOTO        L__main146
;escvit.c,441 :: 		|| nMenu == MAINMENU_PROGRAMME_VERSION
	MOVF        _nMenu+0, 0 
	XORLW       21
	BTFSC       STATUS+0, 2 
	GOTO        L__main146
;escvit.c,442 :: 		|| nMenu == MAINMENU_PROGRAMME_INFOS
	MOVF        _nMenu+0, 0 
	XORLW       22
	BTFSC       STATUS+0, 2 
	GOTO        L__main146
;escvit.c,443 :: 		|| nMenu == MAINMENU_PARAMETRES_STAB
	MOVF        _nMenu+0, 0 
	XORLW       12
	BTFSC       STATUS+0, 2 
	GOTO        L__main146
;escvit.c,444 :: 		|| nMenu == MAINMENU_PARAMETRES_DUREEDECOMPTE
	MOVF        _nMenu+0, 0 
	XORLW       16
	BTFSC       STATUS+0, 2 
	GOTO        L__main146
;escvit.c,445 :: 		|| nMenu == MAINMENU_PARAMETRES_BIPSDECOMPTE)
	MOVF        _nMenu+0, 0 
	XORLW       17
	BTFSC       STATUS+0, 2 
	GOTO        L__main146
	GOTO        L_main49
L__main146:
;escvit.c,447 :: 		BipRefus();
	CALL        _BipRefus+0, 0
;escvit.c,448 :: 		}
L_main49:
L_main46:
L_main42:
;escvit.c,450 :: 		while(pDroite){}
L_main50:
	BTFSS       PORTB+0, 1 
	GOTO        L_main51
	GOTO        L_main50
L_main51:
;escvit.c,451 :: 		}
	GOTO        L_main52
L_main40:
;escvit.c,454 :: 		else if(pGauche)
	BTFSS       PORTB+0, 3 
	GOTO        L_main53
;escvit.c,456 :: 		if(nMenu == MAINMENU_PARAMETRES || nMenu == MAINMENU_PARAMETRES_BIS)
	MOVF        _nMenu+0, 0 
	XORLW       10
	BTFSC       STATUS+0, 2 
	GOTO        L__main145
	MOVF        _nMenu+0, 0 
	XORLW       15
	BTFSC       STATUS+0, 2 
	GOTO        L__main145
	GOTO        L_main56
L__main145:
;escvit.c,458 :: 		Bip();
	CALL        _Bip+0, 0
;escvit.c,459 :: 		_MainMenu_SelectModes();
	CALL        __MainMenu_SelectModes+0, 0
;escvit.c,460 :: 		}
	GOTO        L_main57
L_main56:
;escvit.c,461 :: 		else if(nMenu == MAINMENU_PROGRAMME)
	MOVF        _nMenu+0, 0 
	XORLW       20
	BTFSS       STATUS+0, 2 
	GOTO        L_main58
;escvit.c,463 :: 		Bip();
	CALL        _Bip+0, 0
;escvit.c,464 :: 		_MainMenu_Parametres();
	CALL        __MainMenu_Parametres+0, 0
;escvit.c,465 :: 		}
	GOTO        L_main59
L_main58:
;escvit.c,466 :: 		else if(nMenu ==  MAINMENU_PROGRAMME_VERSION || nMenu == MAINMENU_PROGRAMME_INFOS)
	MOVF        _nMenu+0, 0 
	XORLW       21
	BTFSC       STATUS+0, 2 
	GOTO        L__main144
	MOVF        _nMenu+0, 0 
	XORLW       22
	BTFSC       STATUS+0, 2 
	GOTO        L__main144
	GOTO        L_main62
L__main144:
;escvit.c,468 :: 		Bip();
	CALL        _Bip+0, 0
;escvit.c,469 :: 		_MainMenu_Programme();
	CALL        __MainMenu_Programme+0, 0
;escvit.c,470 :: 		}
	GOTO        L_main63
L_main62:
;escvit.c,471 :: 		else if(nMenu == MAINMENU_PARAMETRES_HTEURMUR)
	MOVF        _nMenu+0, 0 
	XORLW       11
	BTFSS       STATUS+0, 2 
	GOTO        L_main64
;escvit.c,473 :: 		Bip();
	CALL        _Bip+0, 0
;escvit.c,476 :: 		_MainMenu_Parametres();
	CALL        __MainMenu_Parametres+0, 0
;escvit.c,477 :: 		}
	GOTO        L_main65
L_main64:
;escvit.c,478 :: 		else if(nMenu == MAINMENU_PARAMETRES_AFFVIT)
	MOVF        _nMenu+0, 0 
	XORLW       13
	BTFSS       STATUS+0, 2 
	GOTO        L_main66
;escvit.c,480 :: 		Bip();
	CALL        _Bip+0, 0
;escvit.c,482 :: 		_MainMenu_Parametres();
	CALL        __MainMenu_Parametres+0, 0
;escvit.c,483 :: 		}
	GOTO        L_main67
L_main66:
;escvit.c,484 :: 		else if(nMenu == MAINMENU_PARAMETRES_DUREEDECOMPTE)
	MOVF        _nMenu+0, 0 
	XORLW       16
	BTFSS       STATUS+0, 2 
	GOTO        L_main68
;escvit.c,486 :: 		Bip();
	CALL        _Bip+0, 0
;escvit.c,488 :: 		_MainMenu_Parametres_Bis();
	CALL        __MainMenu_Parametres_Bis+0, 0
;escvit.c,489 :: 		}
	GOTO        L_main69
L_main68:
;escvit.c,490 :: 		else if(nMenu == MAINMENU_PARAMETRES_BIPSDECOMPTE)
	MOVF        _nMenu+0, 0 
	XORLW       17
	BTFSS       STATUS+0, 2 
	GOTO        L_main70
;escvit.c,492 :: 		Bip();
	CALL        _Bip+0, 0
;escvit.c,494 :: 		_MainMenu_Parametres_Bis();
	CALL        __MainMenu_Parametres_Bis+0, 0
;escvit.c,495 :: 		}
	GOTO        L_main71
L_main70:
;escvit.c,498 :: 		else if(nMenu == MAINMENU_SELECT_MODES)
	MOVF        _nMenu+0, 0 
	XORLW       0
	BTFSS       STATUS+0, 2 
	GOTO        L_main72
;escvit.c,500 :: 		BipRefus();
	CALL        _BipRefus+0, 0
;escvit.c,501 :: 		}
L_main72:
L_main71:
L_main69:
L_main67:
L_main65:
L_main63:
L_main59:
L_main57:
;escvit.c,503 :: 		while(pGauche){}
L_main73:
	BTFSS       PORTB+0, 3 
	GOTO        L_main74
	GOTO        L_main73
L_main74:
;escvit.c,504 :: 		}
	GOTO        L_main75
L_main53:
;escvit.c,507 :: 		else if(pMenu)
	BTFSS       PORTB+0, 5 
	GOTO        L_main76
;escvit.c,509 :: 		if(nMenu == -1)
	MOVLW       0
	MOVWF       R0 
	MOVLW       255
	XORWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__main154
	MOVLW       255
	XORWF       _nMenu+0, 0 
L__main154:
	BTFSS       STATUS+0, 2 
	GOTO        L_main77
;escvit.c,511 :: 		BipRefus();
	CALL        _BipRefus+0, 0
;escvit.c,512 :: 		}
	GOTO        L_main78
L_main77:
;escvit.c,515 :: 		Bip();
	CALL        _Bip+0, 0
;escvit.c,516 :: 		_MainMenu_SelectModes();
	CALL        __MainMenu_SelectModes+0, 0
;escvit.c,517 :: 		}
L_main78:
;escvit.c,519 :: 		while(pMenu){}
L_main79:
	BTFSS       PORTB+0, 5 
	GOTO        L_main80
	GOTO        L_main79
L_main80:
;escvit.c,520 :: 		}
	GOTO        L_main81
L_main76:
;escvit.c,523 :: 		else if(pOK)
	BTFSS       PORTB+0, 4 
	GOTO        L_main82
;escvit.c,525 :: 		switch(nMenu)
	GOTO        L_main83
;escvit.c,528 :: 		case MAINMENU_SELECT_MODES:
L_main85:
;escvit.c,534 :: 		if(nCurPos == 2)
	MOVF        _nCurPos+0, 0 
	XORLW       2
	BTFSS       STATUS+0, 2 
	GOTO        L_main86
;escvit.c,536 :: 		Lcd_Cmd(_LCD_CLEAR);
	MOVLW       1
	MOVWF       FARG_Lcd_Cmd_out_char+0 
	CALL        _Lcd_Cmd+0, 0
;escvit.c,537 :: 		Lcd_Out(1,1,STR_LIGNE_HR_2BLOC);
	MOVLW       1
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       1
	MOVWF       FARG_Lcd_Out_column+0 
	MOVLW       _STR_LIGNE_HR_2BLOC+0
	MOVWF       FARG_Lcd_Out_text+0 
	MOVLW       hi_addr(_STR_LIGNE_HR_2BLOC+0
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
;escvit.c,538 :: 		Lcd_Out(2,1,STR_MODE);
	MOVLW       2
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       1
	MOVWF       FARG_Lcd_Out_column+0 
	MOVLW       _STR_MODE+0
	MOVWF       FARG_Lcd_Out_text+0 
	MOVLW       hi_addr(_STR_MODE+0
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
;escvit.c,539 :: 		Lcd_Out(3,1,"|      Automatique |");
	MOVLW       3
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       1
	MOVWF       FARG_Lcd_Out_column+0 
	MOVLW       ?lstr3_escvit+0
	MOVWF       FARG_Lcd_Out_text+0 
	MOVLW       hi_addr(?lstr3_escvit+0
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
;escvit.c,540 :: 		Lcd_Out(4,1,STR_LIGNE_HR_2BLOC);
	MOVLW       4
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       1
	MOVWF       FARG_Lcd_Out_column+0 
	MOVLW       _STR_LIGNE_HR_2BLOC+0
	MOVWF       FARG_Lcd_Out_text+0 
	MOVLW       hi_addr(_STR_LIGNE_HR_2BLOC+0
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
;escvit.c,542 :: 		}
	GOTO        L_main87
L_main86:
;escvit.c,543 :: 		else if(nCurPos == 3)
	MOVF        _nCurPos+0, 0 
	XORLW       3
	BTFSS       STATUS+0, 2 
	GOTO        L_main88
;escvit.c,545 :: 		Lcd_Cmd(_LCD_CLEAR);
	MOVLW       1
	MOVWF       FARG_Lcd_Cmd_out_char+0 
	CALL        _Lcd_Cmd+0, 0
;escvit.c,546 :: 		Lcd_Out(1,1,STR_LIGNE_HR_2BLOC);
	MOVLW       1
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       1
	MOVWF       FARG_Lcd_Out_column+0 
	MOVLW       _STR_LIGNE_HR_2BLOC+0
	MOVWF       FARG_Lcd_Out_text+0 
	MOVLW       hi_addr(_STR_LIGNE_HR_2BLOC+0
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
;escvit.c,547 :: 		Lcd_Out(2,1,STR_MODE);
	MOVLW       2
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       1
	MOVWF       FARG_Lcd_Out_column+0 
	MOVLW       _STR_MODE+0
	MOVWF       FARG_Lcd_Out_text+0 
	MOVLW       hi_addr(_STR_MODE+0
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
;escvit.c,548 :: 		Lcd_Out(3,1,"|         Manuel   |");
	MOVLW       3
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       1
	MOVWF       FARG_Lcd_Out_column+0 
	MOVLW       ?lstr4_escvit+0
	MOVWF       FARG_Lcd_Out_text+0 
	MOVLW       hi_addr(?lstr4_escvit+0
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
;escvit.c,549 :: 		Lcd_Out(4,1,STR_LIGNE_HR_2BLOC);
	MOVLW       4
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       1
	MOVWF       FARG_Lcd_Out_column+0 
	MOVLW       _STR_LIGNE_HR_2BLOC+0
	MOVWF       FARG_Lcd_Out_text+0 
	MOVLW       hi_addr(_STR_LIGNE_HR_2BLOC+0
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
;escvit.c,551 :: 		}
	GOTO        L_main89
L_main88:
;escvit.c,552 :: 		else if(nCurPos == 4)
	MOVF        _nCurPos+0, 0 
	XORLW       4
	BTFSS       STATUS+0, 2 
	GOTO        L_main90
;escvit.c,554 :: 		Lcd_Out(1,1,STR_LIGNE_HR_2BLOC);
	MOVLW       1
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       1
	MOVWF       FARG_Lcd_Out_column+0 
	MOVLW       _STR_LIGNE_HR_2BLOC+0
	MOVWF       FARG_Lcd_Out_text+0 
	MOVLW       hi_addr(_STR_LIGNE_HR_2BLOC+0
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
;escvit.c,555 :: 		Lcd_Out(2,1,STR_MODE);
	MOVLW       2
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       1
	MOVWF       FARG_Lcd_Out_column+0 
	MOVLW       _STR_MODE+0
	MOVWF       FARG_Lcd_Out_text+0 
	MOVLW       hi_addr(_STR_MODE+0
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
;escvit.c,556 :: 		Lcd_Out(3,1,"|        Asservit  |");
	MOVLW       3
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       1
	MOVWF       FARG_Lcd_Out_column+0 
	MOVLW       ?lstr5_escvit+0
	MOVWF       FARG_Lcd_Out_text+0 
	MOVLW       hi_addr(?lstr5_escvit+0
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
;escvit.c,557 :: 		Lcd_Out(4,1,STR_LIGNE_HR_2BLOC);
	MOVLW       4
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       1
	MOVWF       FARG_Lcd_Out_column+0 
	MOVLW       _STR_LIGNE_HR_2BLOC+0
	MOVWF       FARG_Lcd_Out_text+0 
	MOVLW       hi_addr(_STR_LIGNE_HR_2BLOC+0
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
;escvit.c,559 :: 		}
L_main90:
L_main89:
L_main87:
;escvit.c,560 :: 		break;
	GOTO        L_main84
;escvit.c,563 :: 		case MAINMENU_PARAMETRES:
L_main91:
;escvit.c,569 :: 		if(nCurPos == 2)
	MOVF        _nCurPos+0, 0 
	XORLW       2
	BTFSS       STATUS+0, 2 
	GOTO        L_main92
;escvit.c,571 :: 		Bip();
	CALL        _Bip+0, 0
;escvit.c,572 :: 		_MainMenu_Parametres_HteurMur();
	CALL        __MainMenu_Parametres_HteurMur+0, 0
;escvit.c,573 :: 		}
	GOTO        L_main93
L_main92:
;escvit.c,574 :: 		else if(nCurPos == 3)
	MOVF        _nCurPos+0, 0 
	XORLW       3
	BTFSS       STATUS+0, 2 
	GOTO        L_main94
;escvit.c,576 :: 		Bip();
	CALL        _Bip+0, 0
;escvit.c,577 :: 		_MainMenu_Parametres_Stab();
	CALL        __MainMenu_Parametres_Stab+0, 0
;escvit.c,578 :: 		}
	GOTO        L_main95
L_main94:
;escvit.c,579 :: 		else if(nCurPos == 4)
	MOVF        _nCurPos+0, 0 
	XORLW       4
	BTFSS       STATUS+0, 2 
	GOTO        L_main96
;escvit.c,581 :: 		Bip();
	CALL        _Bip+0, 0
;escvit.c,582 :: 		_MainMenu_Parametres_AffVit();
	CALL        __MainMenu_Parametres_AffVit+0, 0
;escvit.c,583 :: 		}
L_main96:
L_main95:
L_main93:
;escvit.c,584 :: 		break;
	GOTO        L_main84
;escvit.c,587 :: 		case MAINMENU_PARAMETRES_BIS:
L_main97:
;escvit.c,593 :: 		if(nCurPos == 1)
	MOVF        _nCurPos+0, 0 
	XORLW       1
	BTFSS       STATUS+0, 2 
	GOTO        L_main98
;escvit.c,595 :: 		Bip();
	CALL        _Bip+0, 0
;escvit.c,596 :: 		_MainMenu_Parametres_DureeDecompte();
	CALL        __MainMenu_Parametres_DureeDecompte+0, 0
;escvit.c,597 :: 		}
	GOTO        L_main99
L_main98:
;escvit.c,598 :: 		else if(nCurPos == 2)
	MOVF        _nCurPos+0, 0 
	XORLW       2
	BTFSS       STATUS+0, 2 
	GOTO        L_main100
;escvit.c,600 :: 		Bip();
	CALL        _Bip+0, 0
;escvit.c,601 :: 		_MainMenu_Parametres_BipsDecompte();
	CALL        __MainMenu_Parametres_BipsDecompte+0, 0
;escvit.c,602 :: 		}
	GOTO        L_main101
L_main100:
;escvit.c,603 :: 		else if(nCurPos == 3)
	MOVF        _nCurPos+0, 0 
	XORLW       3
	BTFSS       STATUS+0, 2 
	GOTO        L_main102
;escvit.c,607 :: 		}
L_main102:
L_main101:
L_main99:
;escvit.c,608 :: 		break;
	GOTO        L_main84
;escvit.c,611 :: 		case MAINMENU_PARAMETRES_HTEURMUR:
L_main103:
;escvit.c,613 :: 		Bip();
	CALL        _Bip+0, 0
;escvit.c,618 :: 		Lcd_Cmd(_LCD_CLEAR);
	MOVLW       1
	MOVWF       FARG_Lcd_Cmd_out_char+0 
	CALL        _Lcd_Cmd+0, 0
;escvit.c,619 :: 		Lcd_Out(1,1,STR_LIGNE_HR_2BLOC);
	MOVLW       1
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       1
	MOVWF       FARG_Lcd_Out_column+0 
	MOVLW       _STR_LIGNE_HR_2BLOC+0
	MOVWF       FARG_Lcd_Out_text+0 
	MOVLW       hi_addr(_STR_LIGNE_HR_2BLOC+0
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
;escvit.c,620 :: 		Lcd_Out(2,1,"| HAUTEUR DU MUR   |");
	MOVLW       2
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       1
	MOVWF       FARG_Lcd_Out_column+0 
	MOVLW       ?lstr6_escvit+0
	MOVWF       FARG_Lcd_Out_text+0 
	MOVLW       hi_addr(?lstr6_escvit+0
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
;escvit.c,621 :: 		Lcd_Out(3,1,STR_ENREGISTREE);
	MOVLW       3
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       1
	MOVWF       FARG_Lcd_Out_column+0 
	MOVLW       _STR_ENREGISTREE+0
	MOVWF       FARG_Lcd_Out_text+0 
	MOVLW       hi_addr(_STR_ENREGISTREE+0
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
;escvit.c,622 :: 		Lcd_Out(4,1,STR_LIGNE_HR_2BLOC);
	MOVLW       4
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       1
	MOVWF       FARG_Lcd_Out_column+0 
	MOVLW       _STR_LIGNE_HR_2BLOC+0
	MOVWF       FARG_Lcd_Out_text+0 
	MOVLW       hi_addr(_STR_LIGNE_HR_2BLOC+0
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
;escvit.c,623 :: 		Delay_ms(800);
	MOVLW       9
	MOVWF       R11, 0
	MOVLW       30
	MOVWF       R12, 0
	MOVLW       228
	MOVWF       R13, 0
L_main104:
	DECFSZ      R13, 1, 0
	BRA         L_main104
	DECFSZ      R12, 1, 0
	BRA         L_main104
	DECFSZ      R11, 1, 0
	BRA         L_main104
	NOP
;escvit.c,625 :: 		_MainMenu_Parametres();
	CALL        __MainMenu_Parametres+0, 0
;escvit.c,626 :: 		break;
	GOTO        L_main84
;escvit.c,629 :: 		case MAINMENU_PARAMETRES_STAB:
L_main105:
;escvit.c,631 :: 		Bip();
	CALL        _Bip+0, 0
;escvit.c,636 :: 		Lcd_Cmd(_LCD_CLEAR);
	MOVLW       1
	MOVWF       FARG_Lcd_Cmd_out_char+0 
	CALL        _Lcd_Cmd+0, 0
;escvit.c,637 :: 		Lcd_Out(1,1,STR_LIGNE_HR_2BLOC);
	MOVLW       1
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       1
	MOVWF       FARG_Lcd_Out_column+0 
	MOVLW       _STR_LIGNE_HR_2BLOC+0
	MOVWF       FARG_Lcd_Out_text+0 
	MOVLW       hi_addr(_STR_LIGNE_HR_2BLOC+0
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
;escvit.c,638 :: 		Lcd_Out(2,1,"| TYPE DE STAB.    |");
	MOVLW       2
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       1
	MOVWF       FARG_Lcd_Out_column+0 
	MOVLW       ?lstr7_escvit+0
	MOVWF       FARG_Lcd_Out_text+0 
	MOVLW       hi_addr(?lstr7_escvit+0
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
;escvit.c,639 :: 		Lcd_Out(3,1,STR_ENREGISTREE);
	MOVLW       3
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       1
	MOVWF       FARG_Lcd_Out_column+0 
	MOVLW       _STR_ENREGISTREE+0
	MOVWF       FARG_Lcd_Out_text+0 
	MOVLW       hi_addr(_STR_ENREGISTREE+0
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
;escvit.c,640 :: 		Lcd_Out(4,1,STR_LIGNE_HR_2BLOC);
	MOVLW       4
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       1
	MOVWF       FARG_Lcd_Out_column+0 
	MOVLW       _STR_LIGNE_HR_2BLOC+0
	MOVWF       FARG_Lcd_Out_text+0 
	MOVLW       hi_addr(_STR_LIGNE_HR_2BLOC+0
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
;escvit.c,641 :: 		Delay_ms(800);
	MOVLW       9
	MOVWF       R11, 0
	MOVLW       30
	MOVWF       R12, 0
	MOVLW       228
	MOVWF       R13, 0
L_main106:
	DECFSZ      R13, 1, 0
	BRA         L_main106
	DECFSZ      R12, 1, 0
	BRA         L_main106
	DECFSZ      R11, 1, 0
	BRA         L_main106
	NOP
;escvit.c,643 :: 		_MainMenu_Parametres();
	CALL        __MainMenu_Parametres+0, 0
;escvit.c,644 :: 		break;
	GOTO        L_main84
;escvit.c,647 :: 		case MAINMENU_PARAMETRES_AFFVIT:
L_main107:
;escvit.c,649 :: 		Bip();
	CALL        _Bip+0, 0
;escvit.c,653 :: 		Lcd_Cmd(_LCD_CLEAR);
	MOVLW       1
	MOVWF       FARG_Lcd_Cmd_out_char+0 
	CALL        _Lcd_Cmd+0, 0
;escvit.c,654 :: 		Lcd_Out(1,1,STR_LIGNE_HR_2BLOC);
	MOVLW       1
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       1
	MOVWF       FARG_Lcd_Out_column+0 
	MOVLW       _STR_LIGNE_HR_2BLOC+0
	MOVWF       FARG_Lcd_Out_text+0 
	MOVLW       hi_addr(_STR_LIGNE_HR_2BLOC+0
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
;escvit.c,655 :: 		Lcd_Out(2,1,"| UNITE DE VITESSE |");
	MOVLW       2
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       1
	MOVWF       FARG_Lcd_Out_column+0 
	MOVLW       ?lstr8_escvit+0
	MOVWF       FARG_Lcd_Out_text+0 
	MOVLW       hi_addr(?lstr8_escvit+0
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
;escvit.c,656 :: 		Lcd_Out(3,1,STR_ENREGISTREE);
	MOVLW       3
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       1
	MOVWF       FARG_Lcd_Out_column+0 
	MOVLW       _STR_ENREGISTREE+0
	MOVWF       FARG_Lcd_Out_text+0 
	MOVLW       hi_addr(_STR_ENREGISTREE+0
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
;escvit.c,657 :: 		Lcd_Out(4,1,STR_LIGNE_HR_2BLOC);
	MOVLW       4
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       1
	MOVWF       FARG_Lcd_Out_column+0 
	MOVLW       _STR_LIGNE_HR_2BLOC+0
	MOVWF       FARG_Lcd_Out_text+0 
	MOVLW       hi_addr(_STR_LIGNE_HR_2BLOC+0
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
;escvit.c,658 :: 		Delay_ms(800);
	MOVLW       9
	MOVWF       R11, 0
	MOVLW       30
	MOVWF       R12, 0
	MOVLW       228
	MOVWF       R13, 0
L_main108:
	DECFSZ      R13, 1, 0
	BRA         L_main108
	DECFSZ      R12, 1, 0
	BRA         L_main108
	DECFSZ      R11, 1, 0
	BRA         L_main108
	NOP
;escvit.c,660 :: 		_MainMenu_Parametres();
	CALL        __MainMenu_Parametres+0, 0
;escvit.c,661 :: 		break;
	GOTO        L_main84
;escvit.c,664 :: 		case MAINMENU_PARAMETRES_DUREEDECOMPTE:
L_main109:
;escvit.c,666 :: 		Bip();
	CALL        _Bip+0, 0
;escvit.c,670 :: 		Lcd_Cmd(_LCD_CLEAR);
	MOVLW       1
	MOVWF       FARG_Lcd_Cmd_out_char+0 
	CALL        _Lcd_Cmd+0, 0
;escvit.c,671 :: 		Lcd_Out(1,1,STR_LIGNE_HR_2BLOC);
	MOVLW       1
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       1
	MOVWF       FARG_Lcd_Out_column+0 
	MOVLW       _STR_LIGNE_HR_2BLOC+0
	MOVWF       FARG_Lcd_Out_text+0 
	MOVLW       hi_addr(_STR_LIGNE_HR_2BLOC+0
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
;escvit.c,672 :: 		Lcd_Out(2,1,"|DUREE DU DECOMPTE |");
	MOVLW       2
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       1
	MOVWF       FARG_Lcd_Out_column+0 
	MOVLW       ?lstr9_escvit+0
	MOVWF       FARG_Lcd_Out_text+0 
	MOVLW       hi_addr(?lstr9_escvit+0
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
;escvit.c,673 :: 		Lcd_Out(3,1,STR_ENREGISTREE);
	MOVLW       3
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       1
	MOVWF       FARG_Lcd_Out_column+0 
	MOVLW       _STR_ENREGISTREE+0
	MOVWF       FARG_Lcd_Out_text+0 
	MOVLW       hi_addr(_STR_ENREGISTREE+0
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
;escvit.c,674 :: 		Lcd_Out(4,1,STR_LIGNE_HR_2BLOC);
	MOVLW       4
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       1
	MOVWF       FARG_Lcd_Out_column+0 
	MOVLW       _STR_LIGNE_HR_2BLOC+0
	MOVWF       FARG_Lcd_Out_text+0 
	MOVLW       hi_addr(_STR_LIGNE_HR_2BLOC+0
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
;escvit.c,675 :: 		Delay_ms(800);
	MOVLW       9
	MOVWF       R11, 0
	MOVLW       30
	MOVWF       R12, 0
	MOVLW       228
	MOVWF       R13, 0
L_main110:
	DECFSZ      R13, 1, 0
	BRA         L_main110
	DECFSZ      R12, 1, 0
	BRA         L_main110
	DECFSZ      R11, 1, 0
	BRA         L_main110
	NOP
;escvit.c,677 :: 		_MainMenu_Parametres_Bis();
	CALL        __MainMenu_Parametres_Bis+0, 0
;escvit.c,678 :: 		break;
	GOTO        L_main84
;escvit.c,681 :: 		case MAINMENU_PARAMETRES_BIPSDECOMPTE:
L_main111:
;escvit.c,683 :: 		Bip();
	CALL        _Bip+0, 0
;escvit.c,687 :: 		Lcd_Cmd(_LCD_CLEAR);
	MOVLW       1
	MOVWF       FARG_Lcd_Cmd_out_char+0 
	CALL        _Lcd_Cmd+0, 0
;escvit.c,688 :: 		Lcd_Out(1,1,STR_LIGNE_HR_2BLOC);
	MOVLW       1
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       1
	MOVWF       FARG_Lcd_Out_column+0 
	MOVLW       _STR_LIGNE_HR_2BLOC+0
	MOVWF       FARG_Lcd_Out_text+0 
	MOVLW       hi_addr(_STR_LIGNE_HR_2BLOC+0
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
;escvit.c,689 :: 		Lcd_Out(2,1,"| BIPS AVANT DEC   |");
	MOVLW       2
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       1
	MOVWF       FARG_Lcd_Out_column+0 
	MOVLW       ?lstr10_escvit+0
	MOVWF       FARG_Lcd_Out_text+0 
	MOVLW       hi_addr(?lstr10_escvit+0
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
;escvit.c,690 :: 		Lcd_Out(3,1,STR_ENREGISTREE);
	MOVLW       3
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       1
	MOVWF       FARG_Lcd_Out_column+0 
	MOVLW       _STR_ENREGISTREE+0
	MOVWF       FARG_Lcd_Out_text+0 
	MOVLW       hi_addr(_STR_ENREGISTREE+0
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
;escvit.c,691 :: 		Lcd_Out(4,1,STR_LIGNE_HR_2BLOC);
	MOVLW       4
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       1
	MOVWF       FARG_Lcd_Out_column+0 
	MOVLW       _STR_LIGNE_HR_2BLOC+0
	MOVWF       FARG_Lcd_Out_text+0 
	MOVLW       hi_addr(_STR_LIGNE_HR_2BLOC+0
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
;escvit.c,692 :: 		Delay_ms(800);
	MOVLW       9
	MOVWF       R11, 0
	MOVLW       30
	MOVWF       R12, 0
	MOVLW       228
	MOVWF       R13, 0
L_main112:
	DECFSZ      R13, 1, 0
	BRA         L_main112
	DECFSZ      R12, 1, 0
	BRA         L_main112
	DECFSZ      R11, 1, 0
	BRA         L_main112
	NOP
;escvit.c,694 :: 		_MainMenu_Parametres_Bis();
	CALL        __MainMenu_Parametres_Bis+0, 0
;escvit.c,695 :: 		break;
	GOTO        L_main84
;escvit.c,698 :: 		case MAINMENU_PROGRAMME:
L_main113:
;escvit.c,704 :: 		if(nCurPos == 2)
	MOVF        _nCurPos+0, 0 
	XORLW       2
	BTFSS       STATUS+0, 2 
	GOTO        L_main114
;escvit.c,706 :: 		Bip();
	CALL        _Bip+0, 0
;escvit.c,707 :: 		_MainMenu_Programme_Version();
	CALL        __MainMenu_Programme_Version+0, 0
;escvit.c,708 :: 		}
	GOTO        L_main115
L_main114:
;escvit.c,709 :: 		else if(nCurPos == 3)
	MOVF        _nCurPos+0, 0 
	XORLW       3
	BTFSS       STATUS+0, 2 
	GOTO        L_main116
;escvit.c,711 :: 		Bip();
	CALL        _Bip+0, 0
;escvit.c,712 :: 		_MainMenu_Programme_Infos();
	CALL        __MainMenu_Programme_Infos+0, 0
;escvit.c,713 :: 		}
L_main116:
L_main115:
;escvit.c,714 :: 		break;
	GOTO        L_main84
;escvit.c,715 :: 		}
L_main83:
	MOVF        _nMenu+0, 0 
	XORLW       0
	BTFSC       STATUS+0, 2 
	GOTO        L_main85
	MOVF        _nMenu+0, 0 
	XORLW       10
	BTFSC       STATUS+0, 2 
	GOTO        L_main91
	MOVF        _nMenu+0, 0 
	XORLW       15
	BTFSC       STATUS+0, 2 
	GOTO        L_main97
	MOVF        _nMenu+0, 0 
	XORLW       11
	BTFSC       STATUS+0, 2 
	GOTO        L_main103
	MOVF        _nMenu+0, 0 
	XORLW       12
	BTFSC       STATUS+0, 2 
	GOTO        L_main105
	MOVF        _nMenu+0, 0 
	XORLW       13
	BTFSC       STATUS+0, 2 
	GOTO        L_main107
	MOVF        _nMenu+0, 0 
	XORLW       16
	BTFSC       STATUS+0, 2 
	GOTO        L_main109
	MOVF        _nMenu+0, 0 
	XORLW       17
	BTFSC       STATUS+0, 2 
	GOTO        L_main111
	MOVF        _nMenu+0, 0 
	XORLW       20
	BTFSC       STATUS+0, 2 
	GOTO        L_main113
L_main84:
;escvit.c,717 :: 		while(pOK){}
L_main117:
	BTFSS       PORTB+0, 4 
	GOTO        L_main118
	GOTO        L_main117
L_main118:
;escvit.c,718 :: 		}//Fin bouton OK
L_main82:
L_main81:
L_main75:
L_main52:
L_main39:
L_main4:
;escvit.c,719 :: 		}//Fin while(1)
	GOTO        L_main1
;escvit.c,720 :: 		}//Fin main
	GOTO        $+0
; end of _main

__MainMenu_SelectModes:
;escvit.c,729 :: 		void _MainMenu_SelectModes()
;escvit.c,731 :: 		Lcd_Cmd(_LCD_CLEAR);
	MOVLW       1
	MOVWF       FARG_Lcd_Cmd_out_char+0 
	CALL        _Lcd_Cmd+0, 0
;escvit.c,732 :: 		Lcd_Out(1,1,"O--SELECTION MODE-->");
	MOVLW       1
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       1
	MOVWF       FARG_Lcd_Out_column+0 
	MOVLW       ?lstr11_escvit+0
	MOVWF       FARG_Lcd_Out_text+0 
	MOVLW       hi_addr(?lstr11_escvit+0
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
;escvit.c,733 :: 		Lcd_Out(2,1,"| ~AUTOMATIQUE      ");
	MOVLW       2
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       1
	MOVWF       FARG_Lcd_Out_column+0 
	MOVLW       ?lstr12_escvit+0
	MOVWF       FARG_Lcd_Out_text+0 
	MOVLW       hi_addr(?lstr12_escvit+0
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
;escvit.c,734 :: 		Lcd_Out(3,1,"|  MANUEL           ");
	MOVLW       3
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       1
	MOVWF       FARG_Lcd_Out_column+0 
	MOVLW       ?lstr13_escvit+0
	MOVWF       FARG_Lcd_Out_text+0 
	MOVLW       hi_addr(?lstr13_escvit+0
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
;escvit.c,735 :: 		Lcd_Out(4,1,"O  ASSERVIT        >");
	MOVLW       4
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       1
	MOVWF       FARG_Lcd_Out_column+0 
	MOVLW       ?lstr14_escvit+0
	MOVWF       FARG_Lcd_Out_text+0 
	MOVLW       hi_addr(?lstr14_escvit+0
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
;escvit.c,737 :: 		nCurPos = 2;
	MOVLW       2
	MOVWF       _nCurPos+0 
;escvit.c,738 :: 		nMenu = MAINMENU_SELECT_MODES;
	CLRF        _nMenu+0 
;escvit.c,739 :: 		nCurLimHaut = 2;
	MOVLW       2
	MOVWF       _nCurLimHaut+0 
;escvit.c,740 :: 		nCurLimBas = 4;
	MOVLW       4
	MOVWF       _nCurLimBas+0 
;escvit.c,741 :: 		}
	RETURN      0
; end of __MainMenu_SelectModes

__MainMenu_Parametres:
;escvit.c,744 :: 		void _MainMenu_Parametres()
;escvit.c,746 :: 		Lcd_Cmd(_LCD_CLEAR);
	MOVLW       1
	MOVWF       FARG_Lcd_Cmd_out_char+0 
	CALL        _Lcd_Cmd+0, 0
;escvit.c,747 :: 		Lcd_Out(1,1,"<----PARAMETRES---->");
	MOVLW       1
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       1
	MOVWF       FARG_Lcd_Out_column+0 
	MOVLW       ?lstr15_escvit+0
	MOVWF       FARG_Lcd_Out_text+0 
	MOVLW       hi_addr(?lstr15_escvit+0
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
;escvit.c,748 :: 		Lcd_Out(2,1,"  ~HAUTEUR MUR      ");
	MOVLW       2
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       1
	MOVWF       FARG_Lcd_Out_column+0 
	MOVLW       ?lstr16_escvit+0
	MOVWF       FARG_Lcd_Out_text+0 
	MOVLW       hi_addr(?lstr16_escvit+0
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
;escvit.c,749 :: 		Lcd_Out(3,1,"   STABILISATION    ");
	MOVLW       3
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       1
	MOVWF       FARG_Lcd_Out_column+0 
	MOVLW       ?lstr17_escvit+0
	MOVWF       FARG_Lcd_Out_text+0 
	MOVLW       hi_addr(?lstr17_escvit+0
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
;escvit.c,750 :: 		Lcd_Out(4,1,"v  AFF.VITESSE MOY v");
	MOVLW       4
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       1
	MOVWF       FARG_Lcd_Out_column+0 
	MOVLW       ?lstr18_escvit+0
	MOVWF       FARG_Lcd_Out_text+0 
	MOVLW       hi_addr(?lstr18_escvit+0
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
;escvit.c,752 :: 		nCurPos = 2;
	MOVLW       2
	MOVWF       _nCurPos+0 
;escvit.c,753 :: 		nMenu = MAINMENU_PARAMETRES;
	MOVLW       10
	MOVWF       _nMenu+0 
;escvit.c,754 :: 		nCurLimHaut = 2;
	MOVLW       2
	MOVWF       _nCurLimHaut+0 
;escvit.c,755 :: 		nCurLimBas = 4;
	MOVLW       4
	MOVWF       _nCurLimBas+0 
;escvit.c,756 :: 		}
	RETURN      0
; end of __MainMenu_Parametres

__MainMenu_Parametres_Bis:
;escvit.c,759 :: 		void _MainMenu_Parametres_Bis()
;escvit.c,761 :: 		Lcd_Cmd(_LCD_CLEAR);
	MOVLW       1
	MOVWF       FARG_Lcd_Cmd_out_char+0 
	CALL        _Lcd_Cmd+0, 0
;escvit.c,762 :: 		Lcd_Out(1,1,"^ ~DUREE DECOMPTE  ^");
	MOVLW       1
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       1
	MOVWF       FARG_Lcd_Out_column+0 
	MOVLW       ?lstr19_escvit+0
	MOVWF       FARG_Lcd_Out_text+0 
	MOVLW       hi_addr(?lstr19_escvit+0
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
;escvit.c,763 :: 		Lcd_Out(2,1,"   BIPS DECOMPTE    ");
	MOVLW       2
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       1
	MOVWF       FARG_Lcd_Out_column+0 
	MOVLW       ?lstr20_escvit+0
	MOVWF       FARG_Lcd_Out_text+0 
	MOVLW       hi_addr(?lstr20_escvit+0
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
;escvit.c,764 :: 		Lcd_Out(3,1,"                    ");
	MOVLW       3
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       1
	MOVWF       FARG_Lcd_Out_column+0 
	MOVLW       ?lstr21_escvit+0
	MOVWF       FARG_Lcd_Out_text+0 
	MOVLW       hi_addr(?lstr21_escvit+0
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
;escvit.c,765 :: 		Lcd_Out(4,1,"<--PARAMETRES BIS-->");
	MOVLW       4
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       1
	MOVWF       FARG_Lcd_Out_column+0 
	MOVLW       ?lstr22_escvit+0
	MOVWF       FARG_Lcd_Out_text+0 
	MOVLW       hi_addr(?lstr22_escvit+0
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
;escvit.c,767 :: 		nCurPos = 1;
	MOVLW       1
	MOVWF       _nCurPos+0 
;escvit.c,768 :: 		nMenu = MAINMENU_PARAMETRES_BIS;
	MOVLW       15
	MOVWF       _nMenu+0 
;escvit.c,769 :: 		nCurLimHaut = 1;
	MOVLW       1
	MOVWF       _nCurLimHaut+0 
;escvit.c,770 :: 		nCurLimBas = 2;
	MOVLW       2
	MOVWF       _nCurLimBas+0 
;escvit.c,771 :: 		}
	RETURN      0
; end of __MainMenu_Parametres_Bis

__MainMenu_Parametres_HteurMur:
;escvit.c,774 :: 		void _MainMenu_Parametres_HteurMur()
;escvit.c,776 :: 		Lcd_Cmd(_LCD_CLEAR);
	MOVLW       1
	MOVWF       FARG_Lcd_Cmd_out_char+0 
	CALL        _Lcd_Cmd+0, 0
;escvit.c,777 :: 		Lcd_Out(1,1,STR_LIGNE_HR_FLECHE_BLOC);
	MOVLW       1
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       1
	MOVWF       FARG_Lcd_Out_column+0 
	MOVLW       _STR_LIGNE_HR_FLECHE_BLOC+0
	MOVWF       FARG_Lcd_Out_text+0 
	MOVLW       hi_addr(_STR_LIGNE_HR_FLECHE_BLOC+0
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
;escvit.c,778 :: 		Lcd_Out(2,1,"           METRES ^|");
	MOVLW       2
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       1
	MOVWF       FARG_Lcd_Out_column+0 
	MOVLW       ?lstr23_escvit+0
	MOVWF       FARG_Lcd_Out_text+0 
	MOVLW       hi_addr(?lstr23_escvit+0
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
;escvit.c,779 :: 		Lcd_Out(3,19,"v|");
	MOVLW       3
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       19
	MOVWF       FARG_Lcd_Out_column+0 
	MOVLW       ?lstr24_escvit+0
	MOVWF       FARG_Lcd_Out_text+0 
	MOVLW       hi_addr(?lstr24_escvit+0
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
;escvit.c,780 :: 		Lcd_Out(4,1,STR_LIGNE_HR_FLECHE_BLOC);
	MOVLW       4
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       1
	MOVWF       FARG_Lcd_Out_column+0 
	MOVLW       _STR_LIGNE_HR_FLECHE_BLOC+0
	MOVWF       FARG_Lcd_Out_text+0 
	MOVLW       hi_addr(_STR_LIGNE_HR_FLECHE_BLOC+0
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
;escvit.c,782 :: 		nCurPos = 0;
	CLRF        _nCurPos+0 
;escvit.c,783 :: 		nMenu = MAINMENU_PARAMETRES_HTEURMUR;
	MOVLW       11
	MOVWF       _nMenu+0 
;escvit.c,784 :: 		nCurLimHaut = 0;
	CLRF        _nCurLimHaut+0 
;escvit.c,785 :: 		nCurLimBas = 0;
	CLRF        _nCurLimBas+0 
;escvit.c,789 :: 		CustIntToString(nHauteurMurM, cHauteurMurM);
	MOVF        _nHauteurMurM+0, 0 
	MOVWF       FARG_CustIntToString_nNbAConvertir+0 
	MOVLW       0
	BTFSC       _nHauteurMurM+0, 7 
	MOVLW       255
	MOVWF       FARG_CustIntToString_nNbAConvertir+1 
	MOVLW       _cHauteurMurM+0
	MOVWF       FARG_CustIntToString_Var+0 
	MOVLW       hi_addr(_cHauteurMurM+0
	MOVWF       FARG_CustIntToString_Var+1 
	CALL        _CustIntToString+0, 0
;escvit.c,790 :: 		CustIntToString(nHauteurMurCM, cHauteurMurCM);
	MOVF        _nHauteurMurCM+0, 0 
	MOVWF       FARG_CustIntToString_nNbAConvertir+0 
	MOVLW       0
	BTFSC       _nHauteurMurCM+0, 7 
	MOVLW       255
	MOVWF       FARG_CustIntToString_nNbAConvertir+1 
	MOVLW       _cHauteurMurCM+0
	MOVWF       FARG_CustIntToString_Var+0 
	MOVLW       hi_addr(_cHauteurMurCM+0
	MOVWF       FARG_CustIntToString_Var+1 
	CALL        _CustIntToString+0, 0
;escvit.c,791 :: 		Lcd_Out(2, 3, cHauteurMurM);
	MOVLW       2
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       3
	MOVWF       FARG_Lcd_Out_column+0 
	MOVLW       _cHauteurMurM+0
	MOVWF       FARG_Lcd_Out_text+0 
	MOVLW       hi_addr(_cHauteurMurM+0
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
;escvit.c,792 :: 		Lcd_Out(2, 5, ".");
	MOVLW       2
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       5
	MOVWF       FARG_Lcd_Out_column+0 
	MOVLW       ?lstr25_escvit+0
	MOVWF       FARG_Lcd_Out_text+0 
	MOVLW       hi_addr(?lstr25_escvit+0
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
;escvit.c,793 :: 		Lcd_Out(2, 6, cHauteurMurCM);
	MOVLW       2
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       6
	MOVWF       FARG_Lcd_Out_column+0 
	MOVLW       _cHauteurMurCM+0
	MOVWF       FARG_Lcd_Out_text+0 
	MOVLW       hi_addr(_cHauteurMurCM+0
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
;escvit.c,794 :: 		}
	RETURN      0
; end of __MainMenu_Parametres_HteurMur

__MainMenu_Parametres_AffVit:
;escvit.c,797 :: 		void _MainMenu_Parametres_AffVit()
;escvit.c,799 :: 		Lcd_Cmd(_LCD_CLEAR);
	MOVLW       1
	MOVWF       FARG_Lcd_Cmd_out_char+0 
	CALL        _Lcd_Cmd+0, 0
;escvit.c,800 :: 		Lcd_Out(1,1,STR_LIGNE_HR_FLECHE_BLOC);
	MOVLW       1
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       1
	MOVWF       FARG_Lcd_Out_column+0 
	MOVLW       _STR_LIGNE_HR_FLECHE_BLOC+0
	MOVWF       FARG_Lcd_Out_text+0 
	MOVLW       hi_addr(_STR_LIGNE_HR_FLECHE_BLOC+0
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
;escvit.c,801 :: 		Lcd_Out(2,1,"   UNITE :        ^|");
	MOVLW       2
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       1
	MOVWF       FARG_Lcd_Out_column+0 
	MOVLW       ?lstr26_escvit+0
	MOVWF       FARG_Lcd_Out_text+0 
	MOVLW       hi_addr(?lstr26_escvit+0
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
;escvit.c,802 :: 		Lcd_Out(3,19,"v|");
	MOVLW       3
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       19
	MOVWF       FARG_Lcd_Out_column+0 
	MOVLW       ?lstr27_escvit+0
	MOVWF       FARG_Lcd_Out_text+0 
	MOVLW       hi_addr(?lstr27_escvit+0
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
;escvit.c,803 :: 		Lcd_Out(4,1,STR_LIGNE_HR_FLECHE_BLOC);
	MOVLW       4
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       1
	MOVWF       FARG_Lcd_Out_column+0 
	MOVLW       _STR_LIGNE_HR_FLECHE_BLOC+0
	MOVWF       FARG_Lcd_Out_text+0 
	MOVLW       hi_addr(_STR_LIGNE_HR_FLECHE_BLOC+0
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
;escvit.c,805 :: 		nCurPos = 0;
	CLRF        _nCurPos+0 
;escvit.c,806 :: 		nMenu = MAINMENU_PARAMETRES_AFFVIT;
	MOVLW       13
	MOVWF       _nMenu+0 
;escvit.c,807 :: 		nCurLimHaut = 0;
	CLRF        _nCurLimHaut+0 
;escvit.c,808 :: 		nCurLimBas = 0;
	CLRF        _nCurLimBas+0 
;escvit.c,811 :: 		if(nUniteVitesse == UNITE_VITESSE_KMH)
	MOVF        _nUniteVitesse+0, 0 
	XORLW       1
	BTFSS       STATUS+0, 2 
	GOTO        L__MainMenu_Parametres_AffVit119
;escvit.c,813 :: 		Lcd_Out(2, 14, STR_UNITE_KMH);
	MOVLW       2
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       14
	MOVWF       FARG_Lcd_Out_column+0 
	MOVLW       _STR_UNITE_KMH+0
	MOVWF       FARG_Lcd_Out_text+0 
	MOVLW       hi_addr(_STR_UNITE_KMH+0
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
;escvit.c,814 :: 		}
	GOTO        L__MainMenu_Parametres_AffVit120
L__MainMenu_Parametres_AffVit119:
;escvit.c,815 :: 		else if (nUniteVitesse == UNITE_VITESSE_MS)
	MOVF        _nUniteVitesse+0, 0 
	XORLW       2
	BTFSS       STATUS+0, 2 
	GOTO        L__MainMenu_Parametres_AffVit121
;escvit.c,817 :: 		Lcd_Out(2, 14, STR_UNITE_MS);
	MOVLW       2
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       14
	MOVWF       FARG_Lcd_Out_column+0 
	MOVLW       _STR_UNITE_MS+0
	MOVWF       FARG_Lcd_Out_text+0 
	MOVLW       hi_addr(_STR_UNITE_MS+0
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
;escvit.c,818 :: 		}
L__MainMenu_Parametres_AffVit121:
L__MainMenu_Parametres_AffVit120:
;escvit.c,819 :: 		}
	RETURN      0
; end of __MainMenu_Parametres_AffVit

__MainMenu_Parametres_Stab:
;escvit.c,822 :: 		void _MainMenu_Parametres_Stab()
;escvit.c,826 :: 		Lcd_Cmd(_LCD_CLEAR);
	MOVLW       1
	MOVWF       FARG_Lcd_Cmd_out_char+0 
	CALL        _Lcd_Cmd+0, 0
;escvit.c,827 :: 		Lcd_Out(1,1,STR_LIGNE_HR_FLECHE_BLOC);
	MOVLW       1
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       1
	MOVWF       FARG_Lcd_Out_column+0 
	MOVLW       _STR_LIGNE_HR_FLECHE_BLOC+0
	MOVWF       FARG_Lcd_Out_text+0 
	MOVLW       hi_addr(_STR_LIGNE_HR_FLECHE_BLOC+0
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
;escvit.c,828 :: 		Lcd_Out(2,19,"^|");
	MOVLW       2
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       19
	MOVWF       FARG_Lcd_Out_column+0 
	MOVLW       ?lstr28_escvit+0
	MOVWF       FARG_Lcd_Out_text+0 
	MOVLW       hi_addr(?lstr28_escvit+0
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
;escvit.c,829 :: 		Lcd_Out(3,19,"v|");
	MOVLW       3
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       19
	MOVWF       FARG_Lcd_Out_column+0 
	MOVLW       ?lstr29_escvit+0
	MOVWF       FARG_Lcd_Out_text+0 
	MOVLW       hi_addr(?lstr29_escvit+0
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
;escvit.c,830 :: 		Lcd_Out(4,1,STR_LIGNE_HR_FLECHE_BLOC);
	MOVLW       4
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       1
	MOVWF       FARG_Lcd_Out_column+0 
	MOVLW       _STR_LIGNE_HR_FLECHE_BLOC+0
	MOVWF       FARG_Lcd_Out_text+0 
	MOVLW       hi_addr(_STR_LIGNE_HR_FLECHE_BLOC+0
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
;escvit.c,832 :: 		nCurPos = 0;
	CLRF        _nCurPos+0 
;escvit.c,833 :: 		nMenu = MAINMENU_PARAMETRES_STAB;
	MOVLW       12
	MOVWF       _nMenu+0 
;escvit.c,834 :: 		nCurLimHaut = 0;
	CLRF        _nCurLimHaut+0 
;escvit.c,835 :: 		nCurLimBas = 0;
	CLRF        _nCurLimBas+0 
;escvit.c,840 :: 		if(nStab == STAB_AUTO)
	MOVF        _nStab+0, 0 
	XORLW       1
	BTFSS       STATUS+0, 2 
	GOTO        L__MainMenu_Parametres_Stab122
;escvit.c,842 :: 		Lcd_Out(2, 4, STR_STAB_AUTO);
	MOVLW       2
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       4
	MOVWF       FARG_Lcd_Out_column+0 
	MOVLW       _STR_STAB_AUTO+0
	MOVWF       FARG_Lcd_Out_text+0 
	MOVLW       hi_addr(_STR_STAB_AUTO+0
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
;escvit.c,845 :: 		Lcd_Out(3, 6, cStabDelay);
	MOVLW       3
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       6
	MOVWF       FARG_Lcd_Out_column+0 
	MOVLW       _MainMenu_Parametres_Stab_cStabDelay_L0+0
	MOVWF       FARG_Lcd_Out_text+0 
	MOVLW       hi_addr(_MainMenu_Parametres_Stab_cStabDelay_L0+0
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
;escvit.c,846 :: 		Lcd_Out(3, 8, STR_UNITE_SEC);
	MOVLW       3
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       8
	MOVWF       FARG_Lcd_Out_column+0 
	MOVLW       _STR_UNITE_SEC+0
	MOVWF       FARG_Lcd_Out_text+0 
	MOVLW       hi_addr(_STR_UNITE_SEC+0
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
;escvit.c,847 :: 		}
	GOTO        L__MainMenu_Parametres_Stab123
L__MainMenu_Parametres_Stab122:
;escvit.c,848 :: 		else if (nStab == STAB_MANU)
	MOVF        _nStab+0, 0 
	XORLW       2
	BTFSS       STATUS+0, 2 
	GOTO        L__MainMenu_Parametres_Stab124
;escvit.c,850 :: 		Lcd_Out(2, 4, STR_STAB_MANU);
	MOVLW       2
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       4
	MOVWF       FARG_Lcd_Out_column+0 
	MOVLW       _STR_STAB_MANU+0
	MOVWF       FARG_Lcd_Out_text+0 
	MOVLW       hi_addr(_STR_STAB_MANU+0
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
;escvit.c,851 :: 		Lcd_Out(3, 6, STR_VIDE_5);
	MOVLW       3
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       6
	MOVWF       FARG_Lcd_Out_column+0 
	MOVLW       _STR_VIDE_5+0
	MOVWF       FARG_Lcd_Out_text+0 
	MOVLW       hi_addr(_STR_VIDE_5+0
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
;escvit.c,852 :: 		}
	GOTO        L__MainMenu_Parametres_Stab125
L__MainMenu_Parametres_Stab124:
;escvit.c,853 :: 		else if (nStab == STAB_SANS)
	MOVF        _nStab+0, 0 
	XORLW       3
	BTFSS       STATUS+0, 2 
	GOTO        L__MainMenu_Parametres_Stab126
;escvit.c,855 :: 		Lcd_Out(2, 4, STR_STAB_SANS);
	MOVLW       2
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       4
	MOVWF       FARG_Lcd_Out_column+0 
	MOVLW       _STR_STAB_SANS+0
	MOVWF       FARG_Lcd_Out_text+0 
	MOVLW       hi_addr(_STR_STAB_SANS+0
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
;escvit.c,856 :: 		Lcd_Out(3, 6, STR_VIDE_5);
	MOVLW       3
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       6
	MOVWF       FARG_Lcd_Out_column+0 
	MOVLW       _STR_VIDE_5+0
	MOVWF       FARG_Lcd_Out_text+0 
	MOVLW       hi_addr(_STR_VIDE_5+0
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
;escvit.c,857 :: 		}
L__MainMenu_Parametres_Stab126:
L__MainMenu_Parametres_Stab125:
L__MainMenu_Parametres_Stab123:
;escvit.c,858 :: 		}
	RETURN      0
; end of __MainMenu_Parametres_Stab

__MainMenu_Parametres_DureeDecompte:
;escvit.c,861 :: 		void _MainMenu_Parametres_DureeDecompte()
;escvit.c,863 :: 		Lcd_Cmd(_LCD_CLEAR);
	MOVLW       1
	MOVWF       FARG_Lcd_Cmd_out_char+0 
	CALL        _Lcd_Cmd+0, 0
;escvit.c,868 :: 		Lcd_Out(1,1,STR_LIGNE_HR_FLECHE_BLOC);
	MOVLW       1
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       1
	MOVWF       FARG_Lcd_Out_column+0 
	MOVLW       _STR_LIGNE_HR_FLECHE_BLOC+0
	MOVWF       FARG_Lcd_Out_text+0 
	MOVLW       hi_addr(_STR_LIGNE_HR_FLECHE_BLOC+0
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
;escvit.c,869 :: 		Lcd_Out(2,11,"sec     ^|");
	MOVLW       2
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       11
	MOVWF       FARG_Lcd_Out_column+0 
	MOVLW       ?lstr30_escvit+0
	MOVWF       FARG_Lcd_Out_text+0 
	MOVLW       hi_addr(?lstr30_escvit+0
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
;escvit.c,870 :: 		Lcd_Out(3,19,"v|");
	MOVLW       3
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       19
	MOVWF       FARG_Lcd_Out_column+0 
	MOVLW       ?lstr31_escvit+0
	MOVWF       FARG_Lcd_Out_text+0 
	MOVLW       hi_addr(?lstr31_escvit+0
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
;escvit.c,871 :: 		Lcd_Out(4,1,STR_LIGNE_HR_FLECHE_BLOC);
	MOVLW       4
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       1
	MOVWF       FARG_Lcd_Out_column+0 
	MOVLW       _STR_LIGNE_HR_FLECHE_BLOC+0
	MOVWF       FARG_Lcd_Out_text+0 
	MOVLW       hi_addr(_STR_LIGNE_HR_FLECHE_BLOC+0
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
;escvit.c,873 :: 		nCurPos = 0;
	CLRF        _nCurPos+0 
;escvit.c,874 :: 		nMenu = MAINMENU_PARAMETRES_DUREEDECOMPTE;
	MOVLW       16
	MOVWF       _nMenu+0 
;escvit.c,875 :: 		nCurLimHaut = 0;
	CLRF        _nCurLimHaut+0 
;escvit.c,876 :: 		nCurLimBas = 0;
	CLRF        _nCurLimBas+0 
;escvit.c,878 :: 		nDureeDecompte = 12;//A SUPPR
	MOVLW       12
	MOVWF       _nDureeDecompte+0 
	MOVLW       0
	MOVWF       _nDureeDecompte+1 
;escvit.c,881 :: 		Lcd_Out(2, 8, cDureeDecompte);
	MOVLW       2
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       8
	MOVWF       FARG_Lcd_Out_column+0 
	MOVLW       _cDureeDecompte+0
	MOVWF       FARG_Lcd_Out_text+0 
	MOVLW       hi_addr(_cDureeDecompte+0
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
;escvit.c,882 :: 		}
	RETURN      0
; end of __MainMenu_Parametres_DureeDecompte

__MainMenu_Parametres_BipsDecompte:
;escvit.c,885 :: 		void _MainMenu_Parametres_BipsDecompte()
;escvit.c,887 :: 		Lcd_Cmd(_LCD_CLEAR);
	MOVLW       1
	MOVWF       FARG_Lcd_Cmd_out_char+0 
	CALL        _Lcd_Cmd+0, 0
;escvit.c,892 :: 		Lcd_Out(1,1,STR_LIGNE_HR_FLECHE_BLOC);
	MOVLW       1
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       1
	MOVWF       FARG_Lcd_Out_column+0 
	MOVLW       _STR_LIGNE_HR_FLECHE_BLOC+0
	MOVWF       FARG_Lcd_Out_text+0 
	MOVLW       hi_addr(_STR_LIGNE_HR_FLECHE_BLOC+0
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
;escvit.c,893 :: 		Lcd_Out(2,9,"Bip(s)    ^|");
	MOVLW       2
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       9
	MOVWF       FARG_Lcd_Out_column+0 
	MOVLW       ?lstr32_escvit+0
	MOVWF       FARG_Lcd_Out_text+0 
	MOVLW       hi_addr(?lstr32_escvit+0
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
;escvit.c,894 :: 		Lcd_Out(3,19,"v|");
	MOVLW       3
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       19
	MOVWF       FARG_Lcd_Out_column+0 
	MOVLW       ?lstr33_escvit+0
	MOVWF       FARG_Lcd_Out_text+0 
	MOVLW       hi_addr(?lstr33_escvit+0
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
;escvit.c,895 :: 		Lcd_Out(4,1,STR_LIGNE_HR_FLECHE_BLOC);
	MOVLW       4
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       1
	MOVWF       FARG_Lcd_Out_column+0 
	MOVLW       _STR_LIGNE_HR_FLECHE_BLOC+0
	MOVWF       FARG_Lcd_Out_text+0 
	MOVLW       hi_addr(_STR_LIGNE_HR_FLECHE_BLOC+0
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
;escvit.c,897 :: 		nCurPos = 0;
	CLRF        _nCurPos+0 
;escvit.c,898 :: 		nMenu = MAINMENU_PARAMETRES_BIPSDECOMPTE;
	MOVLW       17
	MOVWF       _nMenu+0 
;escvit.c,899 :: 		nCurLimHaut = 0;
	CLRF        _nCurLimHaut+0 
;escvit.c,900 :: 		nCurLimBas = 0;
	CLRF        _nCurLimBas+0 
;escvit.c,902 :: 		nBipsDecompte = 12;//A SUPPR
	MOVLW       12
	MOVWF       _nBipsDecompte+0 
	MOVLW       0
	MOVWF       _nBipsDecompte+1 
;escvit.c,905 :: 		Lcd_Out(2, 6, cBipsDecompte);
	MOVLW       2
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       6
	MOVWF       FARG_Lcd_Out_column+0 
	MOVLW       _cBipsDecompte+0
	MOVWF       FARG_Lcd_Out_text+0 
	MOVLW       hi_addr(_cBipsDecompte+0
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
;escvit.c,906 :: 		}
	RETURN      0
; end of __MainMenu_Parametres_BipsDecompte

__MainMenu_Programme:
;escvit.c,909 :: 		void _MainMenu_Programme()
;escvit.c,911 :: 		Lcd_Cmd(_LCD_CLEAR);
	MOVLW       1
	MOVWF       FARG_Lcd_Cmd_out_char+0 
	CALL        _Lcd_Cmd+0, 0
;escvit.c,916 :: 		Lcd_Out(1,1,"<----PROGRAMME-----O");
	MOVLW       1
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       1
	MOVWF       FARG_Lcd_Out_column+0 
	MOVLW       ?lstr34_escvit+0
	MOVWF       FARG_Lcd_Out_text+0 
	MOVLW       hi_addr(?lstr34_escvit+0
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
;escvit.c,917 :: 		Lcd_Out(2,3,"~VERSION         |");
	MOVLW       2
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       3
	MOVWF       FARG_Lcd_Out_column+0 
	MOVLW       ?lstr35_escvit+0
	MOVWF       FARG_Lcd_Out_text+0 
	MOVLW       hi_addr(?lstr35_escvit+0
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
;escvit.c,918 :: 		Lcd_Out(3,4,"INFORMATIONS    |");
	MOVLW       3
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       4
	MOVWF       FARG_Lcd_Out_column+0 
	MOVLW       ?lstr36_escvit+0
	MOVWF       FARG_Lcd_Out_text+0 
	MOVLW       hi_addr(?lstr36_escvit+0
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
;escvit.c,919 :: 		Lcd_Out(4,1,STR_LIGNE_HR_FLECHE_BLOC);
	MOVLW       4
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       1
	MOVWF       FARG_Lcd_Out_column+0 
	MOVLW       _STR_LIGNE_HR_FLECHE_BLOC+0
	MOVWF       FARG_Lcd_Out_text+0 
	MOVLW       hi_addr(_STR_LIGNE_HR_FLECHE_BLOC+0
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
;escvit.c,921 :: 		nCurPos = 2;
	MOVLW       2
	MOVWF       _nCurPos+0 
;escvit.c,922 :: 		nMenu = MAINMENU_PROGRAMME;
	MOVLW       20
	MOVWF       _nMenu+0 
;escvit.c,923 :: 		nCurLimHaut = 2;
	MOVLW       2
	MOVWF       _nCurLimHaut+0 
;escvit.c,924 :: 		nCurLimBas = 3;
	MOVLW       3
	MOVWF       _nCurLimBas+0 
;escvit.c,925 :: 		}
	RETURN      0
; end of __MainMenu_Programme

__MainMenu_Programme_Version:
;escvit.c,927 :: 		void _MainMenu_Programme_Version()
;escvit.c,929 :: 		Lcd_Cmd(_LCD_CLEAR);
	MOVLW       1
	MOVWF       FARG_Lcd_Cmd_out_char+0 
	CALL        _Lcd_Cmd+0, 0
;escvit.c,934 :: 		Lcd_Out(1,1,STR_LIGNE_HR_FLECHE_BLOC);
	MOVLW       1
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       1
	MOVWF       FARG_Lcd_Out_column+0 
	MOVLW       _STR_LIGNE_HR_FLECHE_BLOC+0
	MOVWF       FARG_Lcd_Out_text+0 
	MOVLW       hi_addr(_STR_LIGNE_HR_FLECHE_BLOC+0
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
;escvit.c,935 :: 		Lcd_Out(2,7,"V 2.2.1      |");
	MOVLW       2
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       7
	MOVWF       FARG_Lcd_Out_column+0 
	MOVLW       ?lstr37_escvit+0
	MOVWF       FARG_Lcd_Out_text+0 
	MOVLW       hi_addr(?lstr37_escvit+0
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
;escvit.c,936 :: 		Lcd_Out(3,3,"Date: 27/01/2011 |");
	MOVLW       3
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       3
	MOVWF       FARG_Lcd_Out_column+0 
	MOVLW       ?lstr38_escvit+0
	MOVWF       FARG_Lcd_Out_text+0 
	MOVLW       hi_addr(?lstr38_escvit+0
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
;escvit.c,937 :: 		Lcd_Out(4,1,STR_LIGNE_HR_FLECHE_BLOC);
	MOVLW       4
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       1
	MOVWF       FARG_Lcd_Out_column+0 
	MOVLW       _STR_LIGNE_HR_FLECHE_BLOC+0
	MOVWF       FARG_Lcd_Out_text+0 
	MOVLW       hi_addr(_STR_LIGNE_HR_FLECHE_BLOC+0
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
;escvit.c,939 :: 		nCurPos = 0;
	CLRF        _nCurPos+0 
;escvit.c,940 :: 		nMenu = MAINMENU_PROGRAMME_VERSION;
	MOVLW       21
	MOVWF       _nMenu+0 
;escvit.c,941 :: 		nCurLimHaut = 0;
	CLRF        _nCurLimHaut+0 
;escvit.c,942 :: 		nCurLimBas = 0;
	CLRF        _nCurLimBas+0 
;escvit.c,943 :: 		}
	RETURN      0
; end of __MainMenu_Programme_Version

__MainMenu_Programme_Infos:
;escvit.c,945 :: 		void _MainMenu_Programme_Infos()
;escvit.c,947 :: 		Lcd_Cmd(_LCD_CLEAR);
	MOVLW       1
	MOVWF       FARG_Lcd_Cmd_out_char+0 
	CALL        _Lcd_Cmd+0, 0
;escvit.c,952 :: 		Lcd_Out(1,1,STR_LIGNE_HR_FLECHE_BLOC);
	MOVLW       1
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       1
	MOVWF       FARG_Lcd_Out_column+0 
	MOVLW       _STR_LIGNE_HR_FLECHE_BLOC+0
	MOVWF       FARG_Lcd_Out_text+0 
	MOVLW       hi_addr(_STR_LIGNE_HR_FLECHE_BLOC+0
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
;escvit.c,953 :: 		Lcd_Out(2,4,"Pour les GDO!   |");
	MOVLW       2
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       4
	MOVWF       FARG_Lcd_Out_column+0 
	MOVLW       ?lstr39_escvit+0
	MOVWF       FARG_Lcd_Out_text+0 
	MOVLW       hi_addr(?lstr39_escvit+0
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
;escvit.c,954 :: 		Lcd_Out(3,3,"Thibaut CHARLES  |");
	MOVLW       3
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       3
	MOVWF       FARG_Lcd_Out_column+0 
	MOVLW       ?lstr40_escvit+0
	MOVWF       FARG_Lcd_Out_text+0 
	MOVLW       hi_addr(?lstr40_escvit+0
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
;escvit.c,955 :: 		Lcd_Out(4,2,"crom29@hotmail.fr |");
	MOVLW       4
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       2
	MOVWF       FARG_Lcd_Out_column+0 
	MOVLW       ?lstr41_escvit+0
	MOVWF       FARG_Lcd_Out_text+0 
	MOVLW       hi_addr(?lstr41_escvit+0
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
;escvit.c,957 :: 		nCurPos = 0;
	CLRF        _nCurPos+0 
;escvit.c,958 :: 		nMenu = MAINMENU_PROGRAMME_INFOS;
	MOVLW       22
	MOVWF       _nMenu+0 
;escvit.c,959 :: 		nCurLimHaut = 0;
	CLRF        _nCurLimHaut+0 
;escvit.c,960 :: 		nCurLimBas = 0;
	CLRF        _nCurLimBas+0 
;escvit.c,961 :: 		}
	RETURN      0
; end of __MainMenu_Programme_Infos

_Bip:
;escvit.c,964 :: 		void Bip()
;escvit.c,967 :: 		pBuzzer = 1;
	BSF         PORTC+0, 0 
;escvit.c,968 :: 		Delay_ms(70);
	MOVLW       182
	MOVWF       R12, 0
	MOVLW       208
	MOVWF       R13, 0
L_Bip127:
	DECFSZ      R13, 1, 0
	BRA         L_Bip127
	DECFSZ      R12, 1, 0
	BRA         L_Bip127
	NOP
;escvit.c,969 :: 		pBuzzer = 0;
	BCF         PORTC+0, 0 
;escvit.c,970 :: 		}
	RETURN      0
; end of _Bip

_BipRefus:
;escvit.c,973 :: 		void BipRefus()
;escvit.c,976 :: 		pBuzzer = 1;
	BSF         PORTC+0, 0 
;escvit.c,977 :: 		Delay_ms(40);
	MOVLW       104
	MOVWF       R12, 0
	MOVLW       228
	MOVWF       R13, 0
L_BipRefus128:
	DECFSZ      R13, 1, 0
	BRA         L_BipRefus128
	DECFSZ      R12, 1, 0
	BRA         L_BipRefus128
	NOP
;escvit.c,978 :: 		pBuzzer = 0;
	BCF         PORTC+0, 0 
;escvit.c,979 :: 		Delay_ms(20);
	MOVLW       52
	MOVWF       R12, 0
	MOVLW       241
	MOVWF       R13, 0
L_BipRefus129:
	DECFSZ      R13, 1, 0
	BRA         L_BipRefus129
	DECFSZ      R12, 1, 0
	BRA         L_BipRefus129
	NOP
	NOP
;escvit.c,980 :: 		pBuzzer = 1;
	BSF         PORTC+0, 0 
;escvit.c,981 :: 		Delay_ms(40);
	MOVLW       104
	MOVWF       R12, 0
	MOVLW       228
	MOVWF       R13, 0
L_BipRefus130:
	DECFSZ      R13, 1, 0
	BRA         L_BipRefus130
	DECFSZ      R12, 1, 0
	BRA         L_BipRefus130
	NOP
;escvit.c,982 :: 		pBuzzer = 0;
	BCF         PORTC+0, 0 
;escvit.c,983 :: 		}
	RETURN      0
; end of _BipRefus

_DeplacerCurseur:
;escvit.c,986 :: 		void DeplacerCurseur(unsigned short nLigne)
;escvit.c,988 :: 		Lcd_Out(nCurPos,3," ");
	MOVF        _nCurPos+0, 0 
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       3
	MOVWF       FARG_Lcd_Out_column+0 
	MOVLW       ?lstr42_escvit+0
	MOVWF       FARG_Lcd_Out_text+0 
	MOVLW       hi_addr(?lstr42_escvit+0
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
;escvit.c,989 :: 		nCurPos = nLigne;
	MOVF        FARG_DeplacerCurseur_nLigne+0, 0 
	MOVWF       _nCurPos+0 
;escvit.c,990 :: 		Lcd_Out(nCurPos,3,"~");
	MOVF        FARG_DeplacerCurseur_nLigne+0, 0 
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       3
	MOVWF       FARG_Lcd_Out_column+0 
	MOVLW       ?lstr43_escvit+0
	MOVWF       FARG_Lcd_Out_text+0 
	MOVLW       hi_addr(?lstr43_escvit+0
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
;escvit.c,991 :: 		}
	RETURN      0
; end of _DeplacerCurseur

_Puissance:
;escvit.c,996 :: 		int Puissance(int x, int n)
;escvit.c,1008 :: 		}
	RETURN      0
; end of _Puissance

_CustIntToString:
	MOVLW       5
	MOVWF       CustIntToString_nChars_L0+0 
	MOVLW       0
	MOVWF       CustIntToString_nChars_L0+1 
	CLRF        CustIntToString_nNegatif_L0+0 
	CLRF        CustIntToString_nNegatif_L0+1 
	MOVLW       10
	MOVWF       CustIntToString_nPow_L0+0 
	MOVLW       0
	MOVWF       CustIntToString_nPow_L0+1 
	MOVLW       1
	MOVWF       CustIntToString_nChiffres_L0+0 
	MOVLW       0
	MOVWF       CustIntToString_nChiffres_L0+1 
;escvit.c,1018 :: 		void CustIntToString(int nNbAConvertir, char *Var)//, int nChars, unsigned short bRemplir)
;escvit.c,1029 :: 		if(nNbAConvertir<0)
	MOVLW       128
	XORWF       FARG_CustIntToString_nNbAConvertir+1, 0 
	MOVWF       R0 
	MOVLW       128
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__CustIntToString155
	MOVLW       0
	SUBWF       FARG_CustIntToString_nNbAConvertir+0, 0 
L__CustIntToString155:
	BTFSC       STATUS+0, 0 
	GOTO        L_CustIntToString131
;escvit.c,1031 :: 		nNegatif = 1;
	MOVLW       1
	MOVWF       CustIntToString_nNegatif_L0+0 
	MOVLW       0
	MOVWF       CustIntToString_nNegatif_L0+1 
;escvit.c,1033 :: 		}
L_CustIntToString131:
;escvit.c,1036 :: 		while(nNbAConvertir >= nPow)
L_CustIntToString132:
	MOVLW       128
	XORWF       FARG_CustIntToString_nNbAConvertir+1, 0 
	MOVWF       R0 
	MOVLW       128
	XORWF       CustIntToString_nPow_L0+1, 0 
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__CustIntToString156
	MOVF        CustIntToString_nPow_L0+0, 0 
	SUBWF       FARG_CustIntToString_nNbAConvertir+0, 0 
L__CustIntToString156:
	BTFSS       STATUS+0, 0 
	GOTO        L_CustIntToString133
;escvit.c,1040 :: 		}
	GOTO        L_CustIntToString132
L_CustIntToString133:
;escvit.c,1059 :: 		for(n=1 ; n<=nChiffres ; n++ )
	MOVLW       1
	MOVWF       CustIntToString_n_L0+0 
	MOVLW       0
	MOVWF       CustIntToString_n_L0+1 
L_CustIntToString134:
	MOVLW       128
	XORWF       CustIntToString_nChiffres_L0+1, 0 
	MOVWF       R0 
	MOVLW       128
	XORWF       CustIntToString_n_L0+1, 0 
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__CustIntToString157
	MOVF        CustIntToString_n_L0+0, 0 
	SUBWF       CustIntToString_nChiffres_L0+0, 0 
L__CustIntToString157:
	BTFSS       STATUS+0, 0 
	GOTO        L_CustIntToString135
;escvit.c,1061 :: 		if(nNegatif && n==1)
	MOVF        CustIntToString_nNegatif_L0+0, 0 
	IORWF       CustIntToString_nNegatif_L0+1, 0 
	BTFSC       STATUS+0, 2 
	GOTO        L_CustIntToString139
	MOVLW       0
	XORWF       CustIntToString_n_L0+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__CustIntToString158
	MOVLW       1
	XORWF       CustIntToString_n_L0+0, 0 
L__CustIntToString158:
	BTFSS       STATUS+0, 2 
	GOTO        L_CustIntToString139
L__CustIntToString149:
;escvit.c,1063 :: 		if(nChars!=0)
	MOVLW       0
	XORWF       CustIntToString_nChars_L0+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__CustIntToString159
	MOVLW       0
	XORWF       CustIntToString_nChars_L0+0, 0 
L__CustIntToString159:
	BTFSC       STATUS+0, 2 
	GOTO        L_CustIntToString140
;escvit.c,1066 :: 		}
	GOTO        L_CustIntToString141
L_CustIntToString140:
;escvit.c,1070 :: 		}
L_CustIntToString141:
;escvit.c,1071 :: 		}
L_CustIntToString139:
;escvit.c,1072 :: 		nChiffreAConvertir = (nNbAConvertir-nVarSoustraction)/( Puissance(10, (nChiffres-n)) );
	MOVLW       10
	MOVWF       FARG_Puissance_x+0 
	MOVLW       0
	MOVWF       FARG_Puissance_x+1 
	MOVF        CustIntToString_n_L0+0, 0 
	SUBWF       CustIntToString_nChiffres_L0+0, 0 
	MOVWF       FARG_Puissance_n+0 
	MOVF        CustIntToString_n_L0+1, 0 
	SUBWFB      CustIntToString_nChiffres_L0+1, 0 
	MOVWF       FARG_Puissance_n+1 
	CALL        _Puissance+0, 0
;escvit.c,1074 :: 		if(nChars!=0)
	MOVLW       0
	XORWF       CustIntToString_nChars_L0+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__CustIntToString160
	MOVLW       0
	XORWF       CustIntToString_nChars_L0+0, 0 
L__CustIntToString160:
	BTFSC       STATUS+0, 2 
	GOTO        L_CustIntToString142
;escvit.c,1077 :: 		}
	GOTO        L_CustIntToString143
L_CustIntToString142:
;escvit.c,1081 :: 		}
L_CustIntToString143:
;escvit.c,1083 :: 		nVarSoustraction += nChiffreAConvertir*( Puissance(10, (nChiffres-n)) );
	MOVLW       10
	MOVWF       FARG_Puissance_x+0 
	MOVLW       0
	MOVWF       FARG_Puissance_x+1 
	MOVF        CustIntToString_n_L0+0, 0 
	SUBWF       CustIntToString_nChiffres_L0+0, 0 
	MOVWF       FARG_Puissance_n+0 
	MOVF        CustIntToString_n_L0+1, 0 
	SUBWFB      CustIntToString_nChiffres_L0+1, 0 
	MOVWF       FARG_Puissance_n+1 
	CALL        _Puissance+0, 0
;escvit.c,1059 :: 		for(n=1 ; n<=nChiffres ; n++ )
	INFSNZ      CustIntToString_n_L0+0, 1 
	INCF        CustIntToString_n_L0+1, 1 
;escvit.c,1084 :: 		}
	GOTO        L_CustIntToString134
L_CustIntToString135:
;escvit.c,1085 :: 		}
	RETURN      0
; end of _CustIntToString

_ReadCan:
;escvit.c,1093 :: 		int ReadCan(unsigned short nPorte, int nDivision)
;escvit.c,1119 :: 		}
	RETURN      0
; end of _ReadCan
