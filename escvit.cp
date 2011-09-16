#line 1 "K:/Escvit/v3.0/escvit.c"
#line 9 "K:/Escvit/v3.0/escvit.c"
sbit LCD_D4 at RB10_bit;
sbit LCD_D5 at RB11_bit;
sbit LCD_D6 at RB12_bit;
sbit LCD_D7 at RB13_bit;
sbit LCD_RS at RB14_bit;
sbit LCD_EN at RB15_bit;

sbit LCD_D4_Direction at TRISB10_bit;
sbit LCD_D5_Direction at TRISB11_bit;
sbit LCD_D6_Direction at TRISB12_bit;
sbit LCD_D7_Direction at TRISB13_bit;
sbit LCD_RS_Direction at TRISB14_bit;
sbit LCD_EN_Direction at TRISB15_bit;
#pragma XINST=1
#line 43 "K:/Escvit/v3.0/escvit.c"
unsigned short nMenu;
short nCurPos;
unsigned short nCurLimHaut;
unsigned short nCurLimBas;


short nHauteurMurM=10;
short nHauteurMurCM;
char cHauteurMurM[3] = "00";
char cHauteurMurCM[3] = "00";
unsigned short nStab;
unsigned short nStabDelay;
unsigned short nUniteVitesse=1;
int nDureeDecompte;
char cDureeDecompte[3] = "00";
int nBipsDecompte;
char cBipsDecompte[2] = "0";

const code unsigned short TRUE = 1;
const code unsigned short FALSE = 0;

const code unsigned short UNITE_VITESSE_KMH = 1;
const code unsigned short UNITE_VITESSE_MS = 2;

const code unsigned short STAB_AUTO = 1;
const code unsigned short STAB_MANU = 2;
const code unsigned short STAB_SANS = 3;




void _MainMenu_SelectModes();
 const code unsigned short MAINMENU_SELECT_MODES = 0;

void _MainMenu_Parametres();
 const code unsigned short MAINMENU_PARAMETRES = 10;
 void _MainMenu_Parametres_HteurMur();
 const code unsigned short MAINMENU_PARAMETRES_HTEURMUR = 11;
 void _MainMenu_Parametres_Stab();
 const code unsigned short MAINMENU_PARAMETRES_STAB = 12;
 void _MainMenu_Parametres_AffVit();
 const code unsigned short MAINMENU_PARAMETRES_AFFVIT = 13;

void _MainMenu_Parametres_Bis();
 const code unsigned short MAINMENU_PARAMETRES_BIS = 15;
 void _MainMenu_Parametres_DureeDecompte();
 const code unsigned short MAINMENU_PARAMETRES_DUREEDECOMPTE = 16;
 void _MainMenu_Parametres_BipsDecompte();
 const code unsigned short MAINMENU_PARAMETRES_BIPSDECOMPTE = 17;

void _MainMenu_Programme();
 const code unsigned short MAINMENU_PROGRAMME = 20;
 void _MainMenu_Programme_Version();
 const code unsigned short MAINMENU_PROGRAMME_VERSION = 21;
 void _MainMenu_Programme_Infos();
 const code unsigned short MAINMENU_PROGRAMME_INFOS = 22;


char STR_STAB_AUTO[] = "AUTOMATIQUE";
char STR_STAB_MANU[] = "MANUELLE   ";
char STR_STAB_SANS[] = "PAS DE STAB";
char STR_VIDE_5[] = "     ";


char STR_UNITE_KMH[] = "Km/h";
char STR_UNITE_MS[] = "m/s ";
char STR_UNITE_SEC[] = "sec";

char STR_LIGNE_HR_2BLOC[] = "O------------------O";
char STR_LIGNE_HR_FLECHE_BLOC[] = "<------------------O";
char STR_MODE[] = "|  Mode            |";
char STR_ENREGISTREE[] = "|       ENREGISTRE |";


void Bip();
void BipRefus();

void DeplacerCurseur(unsigned short nLigne);

void CustIntToString(int nNbAConvertir, char *Var, int nChars, unsigned short bRemplir);

int ReadCan(unsigned short nPorte, int nDivision);

int Puissance(int x, int n);







void main()
{
char cStabDelay[3]="00";



ADPCFG = 0xFFFF;


TRISB = 0x000;
PORTB = 0x000;
TRISB = 0xFF;

TRISA = 0x00;
PORTA = 0x00;

Lcd_Init();
Lcd_Cmd(_LCD_CLEAR);
Lcd_Cmd(_LCD_CURSOR_OFF);
#line 164 "K:/Escvit/v3.0/escvit.c"
 PORTA.F0  = 1;
Delay_ms(150);
 PORTA.F0  = 0;

_MainMenu_SelectModes();

while(1)
 {


 if( PORTB.F0 )
 {

 if(nMenu == MAINMENU_PARAMETRES_HTEURMUR)
 {

 if(nHauteurMurM>=30)
 {
 BipRefus();
 }
 else
 {
 Bip();

 nHauteurMurCM++;
 if(nHauteurMurCM == 100)
 {
 nHauteurMurCM = 0;
 nHauteurMurM++;
 }

 }
 }

 else if(nMenu == MAINMENU_PARAMETRES_STAB)
 {
 Bip();

 if(nStab == STAB_AUTO)
 {
 nStab = STAB_SANS;
 Lcd_Out(2, 4, STR_STAB_SANS);
 Lcd_Out(3, 6, "     ");
 }
 else if(nStab == STAB_MANU)
 {
 nStab = STAB_AUTO;
 Lcd_Out(2, 4, STR_STAB_AUTO);

 Lcd_Out(3, 6, cStabDelay);
 Lcd_Out(3, 8, STR_UNITE_SEC);
 }
 else if(nStab == STAB_SANS)
 {
 nStab = STAB_MANU;
 Lcd_Out(2, 4, STR_STAB_MANU);
 }
 }
 else if(nMenu == MAINMENU_PARAMETRES_AFFVIT)
 {
 if(nUniteVitesse == UNITE_VITESSE_MS)
 {
 Bip();
 nUniteVitesse = UNITE_VITESSE_KMH;
 Lcd_Out(2, 14, STR_UNITE_KMH);
 }
 else if(nUniteVitesse == UNITE_VITESSE_KMH)
 {
 Bip();
 nUniteVitesse = UNITE_VITESSE_MS;
 Lcd_Out(2, 14, STR_UNITE_MS);
 }
 }
 else if(nMenu == MAINMENU_PARAMETRES_DUREEDECOMPTE)
 {
 if(nDureeDecompte != 10)
 {
 Bip();
 nDureeDecompte++;

 Lcd_Out(2, 8, cDureeDecompte);
 }
 else
 {
 BipRefus();
 }
 }
 else if(nMenu == MAINMENU_PARAMETRES_BIPSDECOMPTE)
 {
 if(nBipsDecompte != 5 && nDureeDecompte<=nBipsDecompte)
 {
 Bip();
 nBipsDecompte++;

 Lcd_Out(2, 8, cBipsDecompte);
 }
 else
 {
 BipRefus();
 }
 }


 else if(nCurPos-1 < nCurLimHaut)
 {
 if(nMenu == MAINMENU_PARAMETRES_BIS)
 {
 Bip();


 _MainMenu_Parametres();

 DeplacerCurseur(4);
 }
 else
 {
 BipRefus();
 }
 }
 else
 {
 Bip();


 Lcd_Out(nCurPos,3," ");

 nCurPos--;
 Lcd_Out(nCurPos,3,"~");
 }

 while( PORTB.F0 ){}
 }


 else if( PORTB.F2 )
 {

 if(nMenu == MAINMENU_PARAMETRES_HTEURMUR)
 {

 if(nHauteurMurM<=1)
 {
 BipRefus();
 }
 else
 {
 Bip();

 nHauteurMurCM--;
 if(nHauteurMurCM == -1)
 {
 nHauteurMurCM = 99;
 nHauteurMurM--;
 }

 }
 }
 else if(nMenu == MAINMENU_PARAMETRES_STAB)
 {
 Bip();

 if(nStab == STAB_AUTO)
 {
 nStab = STAB_MANU;
 Lcd_Out(2, 4, STR_STAB_MANU);
 }
 else if(nStab == STAB_MANU)
 {
 nStab = STAB_SANS;
 Lcd_Out(2, 4, STR_STAB_SANS);
 Lcd_Out(3, 6, STR_VIDE_5);
 }
 else if(nStab == STAB_SANS)
 {
 nStab = STAB_AUTO;
 Lcd_Out(2, 4, STR_STAB_AUTO);

 Lcd_Out(3, 6, cStabDelay);
 Lcd_Out(3, 8, STR_UNITE_SEC);
 }
 }
 else if(nMenu == MAINMENU_PARAMETRES_AFFVIT)
 {
 if(nUniteVitesse == UNITE_VITESSE_MS)
 {
 Bip();
 nUniteVitesse = UNITE_VITESSE_KMH;
 Lcd_Out(2, 14, STR_UNITE_KMH);
 }
 else if(nUniteVitesse == UNITE_VITESSE_KMH)
 {
 Bip();
 nUniteVitesse = UNITE_VITESSE_MS;
 Lcd_Out(2, 14, STR_UNITE_MS);
 }
 }
 else if(nMenu == MAINMENU_PARAMETRES_DUREEDECOMPTE)
 {
 if(nDureeDecompte != 1)
 {
 Bip();
 nDureeDecompte--;

 Lcd_Out(2, 8, cDureeDecompte);
 }
 else
 {
 BipRefus();
 }
 }
 else if(nMenu == MAINMENU_PARAMETRES_BIPSDECOMPTE)
 {
 if(nBipsDecompte != 1 && nDureeDecompte>=nBipsDecompte)
 {
 Bip();
 nBipsDecompte--;

 Lcd_Out(2, 8, cBipsDecompte);
 }
 else
 {
 BipRefus();
 }
 }



 else if(nCurPos+1 > nCurLimBas)
 {

 if(nMenu == MAINMENU_PARAMETRES)
 {
 Bip();

 _MainMenu_Parametres_Bis();
 }
 else
 {
 BipRefus();
 }
 }
 else
 {
 Bip();

 Lcd_Out(nCurPos,3," ");

 nCurPos++;
 Lcd_Out(nCurPos,3,"~");
 }

 while( PORTB.F2 ){}
 }


 else if( PORTB.F1 )
 {
 if(nMenu == MAINMENU_SELECT_MODES)
 {
 Bip();
 _MainMenu_Parametres();
 }
 else if(nMenu == MAINMENU_PARAMETRES || nMenu == MAINMENU_PARAMETRES_BIS)
 {
 Bip();
 _MainMenu_Programme();
 }


 else if(nMenu == MAINMENU_PARAMETRES_HTEURMUR
 || nMenu == MAINMENU_PARAMETRES_AFFVIT
 || nMenu == MAINMENU_PROGRAMME
 || nMenu == MAINMENU_PROGRAMME_VERSION
 || nMenu == MAINMENU_PROGRAMME_INFOS
 || nMenu == MAINMENU_PARAMETRES_STAB
 || nMenu == MAINMENU_PARAMETRES_DUREEDECOMPTE
 || nMenu == MAINMENU_PARAMETRES_BIPSDECOMPTE)
 {
 BipRefus();
 }

 while( PORTB.F1 ){}
 }


 else if( PORTB.F3 )
 {
 if(nMenu == MAINMENU_PARAMETRES || nMenu == MAINMENU_PARAMETRES_BIS)
 {
 Bip();
 _MainMenu_SelectModes();
 }
 else if(nMenu == MAINMENU_PROGRAMME)
 {
 Bip();
 _MainMenu_Parametres();
 }
 else if(nMenu == MAINMENU_PROGRAMME_VERSION || nMenu == MAINMENU_PROGRAMME_INFOS)
 {
 Bip();
 _MainMenu_Programme();
 }
 else if(nMenu == MAINMENU_PARAMETRES_HTEURMUR)
 {
 Bip();


 _MainMenu_Parametres();
 }
 else if(nMenu == MAINMENU_PARAMETRES_AFFVIT)
 {
 Bip();

 _MainMenu_Parametres();
 }
 else if(nMenu == MAINMENU_PARAMETRES_DUREEDECOMPTE)
 {
 Bip();

 _MainMenu_Parametres_Bis();
 }
 else if(nMenu == MAINMENU_PARAMETRES_BIPSDECOMPTE)
 {
 Bip();

 _MainMenu_Parametres_Bis();
 }


 else if(nMenu == MAINMENU_SELECT_MODES)
 {
 BipRefus();
 }

 while( PORTB.F3 ){}
 }


 else if( PORTB.F5 )
 {
 if(nMenu == -1)
 {
 BipRefus();
 }
 else
 {
 Bip();
 _MainMenu_SelectModes();
 }

 while( PORTB.F5 ){}
 }


 else if( PORTB.F4 )
 {
 switch(nMenu)
 {

 case MAINMENU_SELECT_MODES:





 if(nCurPos == 2)
 {
 Lcd_Cmd(_LCD_CLEAR);
 Lcd_Out(1,1,STR_LIGNE_HR_2BLOC);
 Lcd_Out(2,1,STR_MODE);
 Lcd_Out(3,1,"|      Automatique |");
 Lcd_Out(4,1,STR_LIGNE_HR_2BLOC);

 }
 else if(nCurPos == 3)
 {
 Lcd_Cmd(_LCD_CLEAR);
 Lcd_Out(1,1,STR_LIGNE_HR_2BLOC);
 Lcd_Out(2,1,STR_MODE);
 Lcd_Out(3,1,"|         Manuel   |");
 Lcd_Out(4,1,STR_LIGNE_HR_2BLOC);

 }
 else if(nCurPos == 4)
 {
 Lcd_Out(1,1,STR_LIGNE_HR_2BLOC);
 Lcd_Out(2,1,STR_MODE);
 Lcd_Out(3,1,"|        Asservit  |");
 Lcd_Out(4,1,STR_LIGNE_HR_2BLOC);

 }
 break;


 case MAINMENU_PARAMETRES:





 if(nCurPos == 2)
 {
 Bip();
 _MainMenu_Parametres_HteurMur();
 }
 else if(nCurPos == 3)
 {
 Bip();
 _MainMenu_Parametres_Stab();
 }
 else if(nCurPos == 4)
 {
 Bip();
 _MainMenu_Parametres_AffVit();
 }
 break;


 case MAINMENU_PARAMETRES_BIS:





 if(nCurPos == 1)
 {
 Bip();
 _MainMenu_Parametres_DureeDecompte();
 }
 else if(nCurPos == 2)
 {
 Bip();
 _MainMenu_Parametres_BipsDecompte();
 }
 else if(nCurPos == 3)
 {


 }
 break;


 case MAINMENU_PARAMETRES_HTEURMUR:

 Bip();




 Lcd_Cmd(_LCD_CLEAR);
 Lcd_Out(1,1,STR_LIGNE_HR_2BLOC);
 Lcd_Out(2,1,"| HAUTEUR DU MUR   |");
 Lcd_Out(3,1,STR_ENREGISTREE);
 Lcd_Out(4,1,STR_LIGNE_HR_2BLOC);
 Delay_ms(800);

 _MainMenu_Parametres();
 break;


 case MAINMENU_PARAMETRES_STAB:

 Bip();




 Lcd_Cmd(_LCD_CLEAR);
 Lcd_Out(1,1,STR_LIGNE_HR_2BLOC);
 Lcd_Out(2,1,"| TYPE DE STAB.    |");
 Lcd_Out(3,1,STR_ENREGISTREE);
 Lcd_Out(4,1,STR_LIGNE_HR_2BLOC);
 Delay_ms(800);

 _MainMenu_Parametres();
 break;


 case MAINMENU_PARAMETRES_AFFVIT:

 Bip();



 Lcd_Cmd(_LCD_CLEAR);
 Lcd_Out(1,1,STR_LIGNE_HR_2BLOC);
 Lcd_Out(2,1,"| UNITE DE VITESSE |");
 Lcd_Out(3,1,STR_ENREGISTREE);
 Lcd_Out(4,1,STR_LIGNE_HR_2BLOC);
 Delay_ms(800);

 _MainMenu_Parametres();
 break;


 case MAINMENU_PARAMETRES_DUREEDECOMPTE:

 Bip();



 Lcd_Cmd(_LCD_CLEAR);
 Lcd_Out(1,1,STR_LIGNE_HR_2BLOC);
 Lcd_Out(2,1,"|DUREE DU DECOMPTE |");
 Lcd_Out(3,1,STR_ENREGISTREE);
 Lcd_Out(4,1,STR_LIGNE_HR_2BLOC);
 Delay_ms(800);

 _MainMenu_Parametres_Bis();
 break;


 case MAINMENU_PARAMETRES_BIPSDECOMPTE:

 Bip();



 Lcd_Cmd(_LCD_CLEAR);
 Lcd_Out(1,1,STR_LIGNE_HR_2BLOC);
 Lcd_Out(2,1,"| BIPS AVANT DEC   |");
 Lcd_Out(3,1,STR_ENREGISTREE);
 Lcd_Out(4,1,STR_LIGNE_HR_2BLOC);
 Delay_ms(800);

 _MainMenu_Parametres_Bis();
 break;


 case MAINMENU_PROGRAMME:





 if(nCurPos == 2)
 {
 Bip();
 _MainMenu_Programme_Version();
 }
 else if(nCurPos == 3)
 {
 Bip();
 _MainMenu_Programme_Infos();
 }
 break;
 }

 while( PORTB.F4 ){}
 }
 }
}








void _MainMenu_SelectModes()
{
Lcd_Cmd(_LCD_CLEAR);
Lcd_Out(1,1,"O--SELECTION MODE-->");
Lcd_Out(2,1,"| ~AUTOMATIQUE      ");
Lcd_Out(3,1,"|  MANUEL           ");
Lcd_Out(4,1,"O  ASSERVIT        >");

nCurPos = 2;
nMenu = MAINMENU_SELECT_MODES;
nCurLimHaut = 2;
nCurLimBas = 4;
}


void _MainMenu_Parametres()
{
Lcd_Cmd(_LCD_CLEAR);
Lcd_Out(1,1,"<----PARAMETRES---->");
Lcd_Out(2,1,"  ~HAUTEUR MUR      ");
Lcd_Out(3,1,"   STABILISATION    ");
Lcd_Out(4,1,"v  AFF.VITESSE MOY v");

nCurPos = 2;
nMenu = MAINMENU_PARAMETRES;
nCurLimHaut = 2;
nCurLimBas = 4;
}


void _MainMenu_Parametres_Bis()
{
Lcd_Cmd(_LCD_CLEAR);
Lcd_Out(1,1,"^ ~DUREE DECOMPTE  ^");
Lcd_Out(2,1,"   BIPS DECOMPTE    ");
Lcd_Out(3,1,"                    ");
Lcd_Out(4,1,"<--PARAMETRES BIS-->");

nCurPos = 1;
nMenu = MAINMENU_PARAMETRES_BIS;
nCurLimHaut = 1;
nCurLimBas = 2;
}


void _MainMenu_Parametres_HteurMur()
{
Lcd_Cmd(_LCD_CLEAR);
Lcd_Out(1,1,STR_LIGNE_HR_FLECHE_BLOC);
Lcd_Out(2,1,"           METRES ^|");
Lcd_Out(3,19,"v|");
Lcd_Out(4,1,STR_LIGNE_HR_FLECHE_BLOC);

nCurPos = 0;
nMenu = MAINMENU_PARAMETRES_HTEURMUR;
nCurLimHaut = 0;
nCurLimBas = 0;





Lcd_Out(2, 3, cHauteurMurM);
Lcd_Out(2, 5, ".");
Lcd_Out(2, 6, cHauteurMurCM);
}


void _MainMenu_Parametres_AffVit()
{
Lcd_Cmd(_LCD_CLEAR);
Lcd_Out(1,1,STR_LIGNE_HR_FLECHE_BLOC);
Lcd_Out(2,1,"   UNITE :        ^|");
Lcd_Out(3,19,"v|");
Lcd_Out(4,1,STR_LIGNE_HR_FLECHE_BLOC);

nCurPos = 0;
nMenu = MAINMENU_PARAMETRES_AFFVIT;
nCurLimHaut = 0;
nCurLimBas = 0;


if(nUniteVitesse == UNITE_VITESSE_KMH)
 {
 Lcd_Out(2, 14, STR_UNITE_KMH);
 }
else if (nUniteVitesse == UNITE_VITESSE_MS)
 {
 Lcd_Out(2, 14, STR_UNITE_MS);
 }
}


void _MainMenu_Parametres_Stab()
{
char cStabDelay[4];

Lcd_Cmd(_LCD_CLEAR);
Lcd_Out(1,1,STR_LIGNE_HR_FLECHE_BLOC);
Lcd_Out(2,19,"^|");
Lcd_Out(3,19,"v|");
Lcd_Out(4,1,STR_LIGNE_HR_FLECHE_BLOC);

nCurPos = 0;
nMenu = MAINMENU_PARAMETRES_STAB;
nCurLimHaut = 0;
nCurLimBas = 0;




if(nStab == STAB_AUTO)
 {
 Lcd_Out(2, 4, STR_STAB_AUTO);


 Lcd_Out(3, 6, cStabDelay);
 Lcd_Out(3, 8, STR_UNITE_SEC);
 }
else if (nStab == STAB_MANU)
 {
 Lcd_Out(2, 4, STR_STAB_MANU);
 Lcd_Out(3, 6, STR_VIDE_5);
 }
else if (nStab == STAB_SANS)
 {
 Lcd_Out(2, 4, STR_STAB_SANS);
 Lcd_Out(3, 6, STR_VIDE_5);
 }
}


void _MainMenu_Parametres_DureeDecompte()
{
Lcd_Cmd(_LCD_CLEAR);




Lcd_Out(1,1,STR_LIGNE_HR_FLECHE_BLOC);
Lcd_Out(2,11,"sec     ^|");
Lcd_Out(3,19,"v|");
Lcd_Out(4,1,STR_LIGNE_HR_FLECHE_BLOC);

nCurPos = 0;
nMenu = MAINMENU_PARAMETRES_DUREEDECOMPTE;
nCurLimHaut = 0;
nCurLimBas = 0;

nDureeDecompte = 12;


Lcd_Out(2, 8, cDureeDecompte);
}


void _MainMenu_Parametres_BipsDecompte()
{
Lcd_Cmd(_LCD_CLEAR);




Lcd_Out(1,1,STR_LIGNE_HR_FLECHE_BLOC);
Lcd_Out(2,9,"Bip(s)    ^|");
Lcd_Out(3,19,"v|");
Lcd_Out(4,1,STR_LIGNE_HR_FLECHE_BLOC);

nCurPos = 0;
nMenu = MAINMENU_PARAMETRES_BIPSDECOMPTE;
nCurLimHaut = 0;
nCurLimBas = 0;

nBipsDecompte = 12;


Lcd_Out(2, 6, cBipsDecompte);
}


void _MainMenu_Programme()
{
Lcd_Cmd(_LCD_CLEAR);




Lcd_Out(1,1,"<----PROGRAMME-----O");
Lcd_Out(2,3,"~VERSION         |");
Lcd_Out(3,4,"INFORMATIONS    |");
Lcd_Out(4,1,STR_LIGNE_HR_FLECHE_BLOC);

nCurPos = 2;
nMenu = MAINMENU_PROGRAMME;
nCurLimHaut = 2;
nCurLimBas = 3;
}

void _MainMenu_Programme_Version()
{
Lcd_Cmd(_LCD_CLEAR);




Lcd_Out(1,1,STR_LIGNE_HR_FLECHE_BLOC);
Lcd_Out(2,7,"V 2.2.1      |");
Lcd_Out(3,3,"Date: 27/01/2011 |");
Lcd_Out(4,1,STR_LIGNE_HR_FLECHE_BLOC);

nCurPos = 0;
nMenu = MAINMENU_PROGRAMME_VERSION;
nCurLimHaut = 0;
nCurLimBas = 0;
}

void _MainMenu_Programme_Infos()
{
Lcd_Cmd(_LCD_CLEAR);




Lcd_Out(1,1,STR_LIGNE_HR_FLECHE_BLOC);
Lcd_Out(2,4,"Pour les GDO!   |");
Lcd_Out(3,3,"Thibaut CHARLES  |");
Lcd_Out(4,2,"crom29@hotmail.fr |");

nCurPos = 0;
nMenu = MAINMENU_PROGRAMME_INFOS;
nCurLimHaut = 0;
nCurLimBas = 0;
}


void Bip()
{

 PORTA.F0  = 1;
Delay_ms(70);
 PORTA.F0  = 0;
}


void BipRefus()
{

 PORTA.F0  = 1;
Delay_ms(60);
 PORTA.F0  = 0;
Delay_ms(40);
 PORTA.F0  = 1;
Delay_ms(60);
 PORTA.F0  = 0;
}


void DeplacerCurseur(unsigned short nLigne)
{
Lcd_Out(nCurPos,3," ");
nCurPos = nLigne;
Lcd_Out(nCurPos,3,"~");
}




int Puissance(int x, int n)
#line 1002 "K:/Escvit/v3.0/escvit.c"
{
}









void CustIntToString(int nNbAConvertir, char *Var, int nChars, unsigned short bRemplir)
#line 1077 "K:/Escvit/v3.0/escvit.c"
{
}
