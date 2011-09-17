/*

        si erreurs de lancement, regarder les executions de EffacementBandes dans le void main !
        Arrêté de programmé a cause d'un bug ISIS, réinstaller?

*/

//LCD
sbit LCD_RS at RD4_bit;
sbit LCD_EN at RD5_bit;
sbit LCD_D4 at RD0_bit;
sbit LCD_D5 at RD1_bit;
sbit LCD_D6 at RD2_bit;
sbit LCD_D7 at RD3_bit;

sbit LCD_RS_Direction at TRISD4_bit;
sbit LCD_EN_Direction at TRISD5_bit;
sbit LCD_D4_Direction at TRISD0_bit;
sbit LCD_D5_Direction at TRISD1_bit;
sbit LCD_D6_Direction at TRISD2_bit;
sbit LCD_D7_Direction at TRISD3_bit;



#pragma XINST=1

//Entrees
#define pHaut PORTB.F0
#define pDroite PORTB.F1
#define pBas PORTB.F2
#define pGauche PORTB.F3
#define pOK PORTB.F4
#define pMenu PORTB.F5

#define pBumper PORTB.F6

#define pSignalGroupe PORTB.F7

//Sorties
#define pBuzzer PORTC.F0
#define pHP PORTB.F5
#define pLed1 PORTC.F6
#define pLed2 PORTC.F7

//#pragma config WRDT = OFF

//Variables liées aux menus
unsigned short nMenu;
short nCurPos;
unsigned short nCurLimHaut;
unsigned short nCurLimBas;

//Parametres de configuration du PIC (eeprom) :
short nHauteurMurM=10;           //Adresse : 0x0
short nHauteurMurCM;          //Adresse : 0x1
char cHauteurMurM[3] = "00";
char cHauteurMurCM[3] = "00";
unsigned short nStab;         //Adresse : 0x2
unsigned short nStabDelay;    //Adresse : 0x3
unsigned short nUniteVitesse=1; //Adresse : 0x4
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


//MENUS ET LEURS CONSTANTES

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

//Stabilisation
char STR_STAB_AUTO[] = "AUTOMATIQUE";
char STR_STAB_MANU[] = "MANUELLE   ";
char STR_STAB_SANS[] = "PAS DE STAB";
char STR_VIDE_5[] = "     ";

//Unité vitesse
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

void CustIntToString(int nNbAConvertir, char *Var);//, int nChars, unsigned short bRemplir);

int ReadCan(unsigned short nPorte, int nDivision);

int Puissance(int x, int n);



//==================================================================================================================================================================================================================
//==VOID=MAIN===VOID=MAIN===VOID=MAIN===VOID=MAIN===VOID=MAIN===VOID=MAIN===VOID=MAIN===VOID=MAIN===VOID=MAIN===VOID=MAIN===VOID=MAIN===VOID=MAIN===VOID=MAIN===VOID=MAIN===VOID=MAIN===VOID=MAIN===VOID=MAIN===VOID
//==================================================================================================================================================================================================================
void main()
{
char cStabDelay[3]="00";

//Initialisation
ADCON1 = 0b11001110;

//Toute la porte B en entrée ( /!\ signal de groupe )
TRISB = 0x00;
PORTB = 0x00;
TRISB = 0xFF;

TRISC = 0x00;    //Porte C = sorties
PORTC = 0x00;

Lcd_Init();
Lcd_Cmd(_LCD_CLEAR);
Lcd_Cmd(_LCD_CURSOR_OFF);

ADC_Init();

//Sound_Init(&PORTA, 3);
//Sound_Play(440, 100);

//Récupération de la config persistante sur l'EEPROM
//nHauteurMurM = EEPROM_Read(0x0);
//nHauteurMurCM = EEPROM_Read(0x1);
//nStab = EEPROM_Read(0x2);
//nStabDelay = EEPROM_Read(0x3);
//nUniteVitesse = EEPROM_Read(0x4);

pBuzzer = 1;
Delay_ms(150);
pBuzzer = 0;

_MainMenu_SelectModes();

while(1)
     {
     //=========================================================================================================================================================
     //Action sur le bouton de Haut ============================================================================================================================
     if(pHaut)
          {/*
          //Menus spéciaux
          if(nMenu == MAINMENU_PARAMETRES_HTEURMUR)
               {
               //Hauteur maximale : 30m
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
                    //conversion & lcd out de nHauteurMurM et nHauteurMurCM
                    }
               }
          //Menus spéciaux
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
                    //CustIntToString(nStabDelay, cStabDelay);
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
                    //CustIntToString(nDureeDecompte, cDureeDecompte, 2, 0);
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
                    //CustIntToString(nBipsDecompte, cBipsDecompte, 2, 0);
                    Lcd_Out(2, 8, cBipsDecompte);
                    }
               else
                    {
                    BipRefus();
                    }
               }

          //Menus habituels : déplacement du curseur
          else if(nCurPos-1 < nCurLimHaut)
               {
               if(nMenu == MAINMENU_PARAMETRES_BIS)
                    {
                    Bip();

                    //Changement de menu
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

               //Efface l'ancien curseur
               Lcd_Out(nCurPos,3," ");
               //Déplace le cur
               nCurPos--;
               Lcd_Out(nCurPos,3,"~");
               }

          while(pHaut){}*/
          }
     //=========================================================================================================================================================
     //Action sur le bouton de Bas =============================================================================================================================
     else if(pBas)
          {
          //Menus spéciaux
          if(nMenu == MAINMENU_PARAMETRES_HTEURMUR)
               {
               //Hauteur minimale : 1m
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
                    //conversion & lcd out de nHauteurMurM et nHauteurMurCM
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
                    //CustIntToString(nStabDelay, cStabDelay);
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
                    //CustIntToString(nDureeDecompte, cDureeDecompte, 2, 0);
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
                    //CustIntToString(nBipsDecompte, cBipsDecompte, 2, 0);
                    Lcd_Out(2, 8, cBipsDecompte);
                    }
               else
                    {
                    BipRefus();
                    }
               }


          //Menus habituels : déplacement du curseur
          else if(nCurPos+1 > nCurLimBas)
               {

               if(nMenu == MAINMENU_PARAMETRES)
                    {
                    Bip();
                    //Changement de menu
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
               //Efface l'ancien curseur
               Lcd_Out(nCurPos,3," ");
               //Déplace le cur
               nCurPos++;
               Lcd_Out(nCurPos,3,"~");
               }

          while(pBas){}
          }
     //=========================================================================================================================================================
     //Action sur le bouton de Droite ==========================================================================================================================
     else if(pDroite)
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

          //Bouton bloqué pour les menus suivants :
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

          while(pDroite){}
          }

     //Action sur le bouton de Gauche ==========================================================================================================================
     else if(pGauche)
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
          else if(nMenu ==  MAINMENU_PROGRAMME_VERSION || nMenu == MAINMENU_PROGRAMME_INFOS)
               {
               Bip();
               _MainMenu_Programme();
               }
          else if(nMenu == MAINMENU_PARAMETRES_HTEURMUR)
               {
               Bip();
               //nHauteurMurM = Read_EEPROM(...
               //nHauteurMurCM = Read_EEPROM(...
               _MainMenu_Parametres();
               }
          else if(nMenu == MAINMENU_PARAMETRES_AFFVIT)
               {
               Bip();
               //nUniteVitesse = Read_EEPROM(...
               _MainMenu_Parametres();
               }
          else if(nMenu == MAINMENU_PARAMETRES_DUREEDECOMPTE)
               {
               Bip();
               //nDureeDecompte = Read_EEPROM(...
               _MainMenu_Parametres_Bis();
               }
          else if(nMenu == MAINMENU_PARAMETRES_BIPSDECOMPTE)
               {
               Bip();
               //nBipsDecompte = Read_EEPROM(...
               _MainMenu_Parametres_Bis();
               }

          //Bouton bloqué pour les menus suivants :
          else if(nMenu == MAINMENU_SELECT_MODES)
               {
               BipRefus();
               }

          while(pGauche){}
          }
     //=========================================================================================================================================================
     //Action sur le bouton Menu ===============================================================================================================================
     else if(pMenu)
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

          while(pMenu){}
          }
     //=========================================================================================================================================================
     //Action sur le bouton OK =================================================================================================================================
     else if(pOK)
          {
          switch(nMenu)
               {

               case MAINMENU_SELECT_MODES:
               //------------------------------------------------------------------------------------------------------------------------
               //1: O--SELECTION MODE-->
               //2: | ~AUTOMATIQUE
               //3: |  MANUEL
               //4: O  ASSERVIT        >
                    if(nCurPos == 2)
                         {
                         Lcd_Cmd(_LCD_CLEAR);
                         Lcd_Out(1,1,STR_LIGNE_HR_2BLOC);
                         Lcd_Out(2,1,STR_MODE);
                         Lcd_Out(3,1,"|      Automatique |");
                         Lcd_Out(4,1,STR_LIGNE_HR_2BLOC);
                         // ...
                         }
                    else if(nCurPos == 3)
                         {
                         Lcd_Cmd(_LCD_CLEAR);
                         Lcd_Out(1,1,STR_LIGNE_HR_2BLOC);
                         Lcd_Out(2,1,STR_MODE);
                         Lcd_Out(3,1,"|         Manuel   |");
                         Lcd_Out(4,1,STR_LIGNE_HR_2BLOC);
                         // ...
                         }
                    else if(nCurPos == 4)
                         {
                         Lcd_Out(1,1,STR_LIGNE_HR_2BLOC);
                         Lcd_Out(2,1,STR_MODE);
                         Lcd_Out(3,1,"|        Asservit  |");
                         Lcd_Out(4,1,STR_LIGNE_HR_2BLOC);
                         // ...
                         }
               break;


               case MAINMENU_PARAMETRES:
               //------------------------------------------------------------------------------------------------------------------------
                    //1: <----PARAMETRES---->
                    //2:   ~HAUTEUR MUR
                    //3:    STABILISATION
                    //4: v  AFF.VITESSE MOY v
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
                    //------------------------------------------------------------------------------------------------------------------------
                    //1: ^ ~DUREE DECOMPTE  ^
                    //2:    BIPS DECOMPTE
                    //3:
                    //4: <--PARAMETRES BIS-->
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
                         //Bip();
                         //_MainMenu_Parametres_HteurMur();
                         }
               break;


               case MAINMENU_PARAMETRES_HTEURMUR:
               //------------------------------------------------------------------------------------------------------------------------
                    Bip();

                    //EEPROM_Write(0x10, nHauteurMurM);
                    //EEPROM_Write(0x11, nHauteurMurCM);

                    Lcd_Cmd(_LCD_CLEAR);
                    Lcd_Out(1,1,STR_LIGNE_HR_2BLOC);
                    Lcd_Out(2,1,"| HAUTEUR DU MUR   |");
                    Lcd_Out(3,1,STR_ENREGISTREE);
                    Lcd_Out(4,1,STR_LIGNE_HR_2BLOC);
                    Delay_ms(800);

                    _MainMenu_Parametres();
               break;


               case MAINMENU_PARAMETRES_STAB:
               //------------------------------------------------------------------------------------------------------------------------
                    Bip();

                    //EEPROM_Write(0x10, nStab);
                    //EEPROM_Write(0x11, nStabDelay);

                    Lcd_Cmd(_LCD_CLEAR);
                    Lcd_Out(1,1,STR_LIGNE_HR_2BLOC);
                    Lcd_Out(2,1,"| TYPE DE STAB.    |");
                    Lcd_Out(3,1,STR_ENREGISTREE);
                    Lcd_Out(4,1,STR_LIGNE_HR_2BLOC);
                    Delay_ms(800);

                    _MainMenu_Parametres();
               break;


               case MAINMENU_PARAMETRES_AFFVIT:
               //------------------------------------------------------------------------------------------------------------------------
                    Bip();

                    //EEPROM_Write(0x15, nUniteVitesse);

                    Lcd_Cmd(_LCD_CLEAR);
                    Lcd_Out(1,1,STR_LIGNE_HR_2BLOC);
                    Lcd_Out(2,1,"| UNITE DE VITESSE |");
                    Lcd_Out(3,1,STR_ENREGISTREE);
                    Lcd_Out(4,1,STR_LIGNE_HR_2BLOC);
                    Delay_ms(800);

                    _MainMenu_Parametres();
               break;


               case MAINMENU_PARAMETRES_DUREEDECOMPTE:
               //------------------------------------------------------------------------------------------------------------------------
                    Bip();

                    //EEPROM_Write(0x15, nUniteVitesse);

                    Lcd_Cmd(_LCD_CLEAR);
                    Lcd_Out(1,1,STR_LIGNE_HR_2BLOC);
                    Lcd_Out(2,1,"|DUREE DU DECOMPTE |");
                    Lcd_Out(3,1,STR_ENREGISTREE);
                    Lcd_Out(4,1,STR_LIGNE_HR_2BLOC);
                    Delay_ms(800);

                    _MainMenu_Parametres_Bis();
               break;


               case MAINMENU_PARAMETRES_BIPSDECOMPTE:
               //------------------------------------------------------------------------------------------------------------------------
                    Bip();

                    //EEPROM_Write(0x15, nUniteVitesse);

                    Lcd_Cmd(_LCD_CLEAR);
                    Lcd_Out(1,1,STR_LIGNE_HR_2BLOC);
                    Lcd_Out(2,1,"| BIPS AVANT DEC   |");
                    Lcd_Out(3,1,STR_ENREGISTREE);
                    Lcd_Out(4,1,STR_LIGNE_HR_2BLOC);
                    Delay_ms(800);

                    _MainMenu_Parametres_Bis();
               break;


               case MAINMENU_PROGRAMME:
               //------------------------------------------------------------------------------------------------------------------------
                    //1: <----PROGRAMME-----O
                    //2:   ~VERSION         |
                    //3:    INFORMATIONS    |
                    //4: <------------------O
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

          while(pOK){}
          }//Fin bouton OK
     }//Fin while(1)
}//Fin main








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

//nHauteurMurM = EEPROM_Read(0x0);
//nHauteurMurCM = EEPROM_Read(0x1);
CustIntToString(nHauteurMurM, cHauteurMurM);
CustIntToString(nHauteurMurCM, cHauteurMurCM);
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

//nUniteVitesse = EEPROM_Read(0x3);
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

//nStab = EEPROM_Read(0x2);
//nStabDelay = EEPROM_Read(0x3);

if(nStab == STAB_AUTO)
     {
     Lcd_Out(2, 4, STR_STAB_AUTO);

     //CustIntToString(nStabDelay, *cStabDelay);
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
//<------------------O
//       00 sec     ^|
//   ~ENREGISTRER   v|
//<------------------O
Lcd_Out(1,1,STR_LIGNE_HR_FLECHE_BLOC);
Lcd_Out(2,11,"sec     ^|");
Lcd_Out(3,19,"v|");
Lcd_Out(4,1,STR_LIGNE_HR_FLECHE_BLOC);

nCurPos = 0;
nMenu = MAINMENU_PARAMETRES_DUREEDECOMPTE;
nCurLimHaut = 0;
nCurLimBas = 0;

nDureeDecompte = 12;//A SUPPR
//nDureeDecompte = EEPROM_Read(0x5);
//CustIntToString(nDureeDecompte, cDureeDecompte, 3, 0);
Lcd_Out(2, 8, cDureeDecompte);
}


void _MainMenu_Parametres_BipsDecompte()
{
Lcd_Cmd(_LCD_CLEAR);
//<------------------O
//      0 Bip(s)    ^|
//   ~ENREGISTRER   v|
//<------------------O
Lcd_Out(1,1,STR_LIGNE_HR_FLECHE_BLOC);
Lcd_Out(2,9,"Bip(s)    ^|");
Lcd_Out(3,19,"v|");
Lcd_Out(4,1,STR_LIGNE_HR_FLECHE_BLOC);

nCurPos = 0;
nMenu = MAINMENU_PARAMETRES_BIPSDECOMPTE;
nCurLimHaut = 0;
nCurLimBas = 0;

nBipsDecompte = 12;//A SUPPR
//nDureeDecompte = EEPROM_Read(0x5);
//CustIntToString(nBipsDecompte, cBipsDecompte, 3, 0);
Lcd_Out(2, 6, cBipsDecompte);
}


void _MainMenu_Programme()
{
Lcd_Cmd(_LCD_CLEAR);
//<----PROGRAMME-----O
//  ~VERSION         |
//   INFORMATIONS    |
//<------------------O
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
//<------------------O
//      v x.x.x      |
//  Date: xx/xx/xxxx |
//<------------------O
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
//<------------------O
//   Pour les GDO!   |
//  Thibaut CHARLES  |
// crom29@hotmail.fr |
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
//Bip sonore
pBuzzer = 1;
Delay_ms(70);
pBuzzer = 0;
}


void BipRefus()
{
//Bip sonore
pBuzzer = 1;
Delay_ms(40);
pBuzzer = 0;
Delay_ms(20);
pBuzzer = 1;
Delay_ms(40);
pBuzzer = 0;
}


void DeplacerCurseur(unsigned short nLigne)
{
Lcd_Out(nCurPos,3," ");
nCurPos = nLigne;
Lcd_Out(nCurPos,3,"~");
}




int Puissance(int x, int n)
{/*
int i;
int nReturn = 1;

if(n == 0){return 1;}

for(i=1 ; i<=n ; i++ )
     {
     nReturn = nReturn * x;
     }
return nReturn;*/
}


//==================================================================================================================================================================================================================
//==CUST_INTTOSTRING===CUST_INTTOSTRING===CUST_INTTOSTRING===CUST_INTTOSTRING===CUST_INTTOSTRING===CUST_INTTOSTRING===CUST_INTTOSTRING===CUST_INTTOSTRING===CUST_INTTOSTRING===CUST_INTTOSTRING===CUST_INTTOSTRING==
//==================================================================================================================================================================================================================
// nNbAConvertir = entier à convertir
// Var : Variable dans laquelle sera placée la conversion
// nChars : 0 => chiffres alignés à gauche, Sinon les chiffres seront alignés à gauche et nChars = nombre max de chiffres à afficher
// bRemplir : FALSE => les caractères inutilisés seront ignorés, TRUE => seront remplis de "0" (inutile si nChars==0)
void CustIntToString(int nNbAConvertir, char *Var)//, int nChars, unsigned short bRemplir)
{
unsigned int nVarSoustraction = 0;
unsigned int nChiffreAConvertir = 0;
int nChiffres = 1;
int nPow = 10;
int n;
int nNegatif = 0;

int nChars=5;

if(nNbAConvertir<0)
     {
     nNegatif = 1;
     //nNbAConvertir = abs(nNbAConvertir);
     }

//Determination du nb de chiffres dans nNbAConvertir
while(nNbAConvertir >= nPow)
     {
     //nChiffres++;
     //nPow = 10*nPow;
     }

//Remplissage
/*if(bRemplir)
     {
     for(n=1 ; nChars-nChiffres-(n-1)>=0 ; n++)
          {
          //Var[nChars-nChiffres-(n-1)] = 0x30;
          }
     }
else
     {
     for(n=1 ; nChars-nChiffres-(n-1)>=0 ; n++)
          {
          //Var[nChars-nChiffres-(n-1)] = 0x20;
          }
     }  */

//Conversion
for(n=1 ; n<=nChiffres ; n++ )
     {
     if(nNegatif && n==1)
          {
          if(nChars!=0)
               {
               //Var[nChars-nChiffres-1] = 0x2D;
               }
          else
               {
               //Var[0] = 0x2D;
               }
          }
     nChiffreAConvertir = (nNbAConvertir-nVarSoustraction)/( Puissance(10, (nChiffres-n)) );

     if(nChars!=0)
          {
          //Var[nChars-nChiffres+(n-1)] = 0x30+nChiffreAConvertir;
          }
     else
          {
          //Var[nNegatif+n-1] = 0x30+nChiffreAConvertir;
          }

     nVarSoustraction += nChiffreAConvertir*( Puissance(10, (nChiffres-n)) );
     }
}







int ReadCan(unsigned short nPorte, int nDivision)
{/*
//nPorte = 0 ==> Potar menus
//nPorte = 1 ==> Plaque Dep
int nValLue;
int nPlage;
int n;

nValLue = ADC_Read(nPorte);

if(nDivision!=0)
     {
     nPlage = 1023/nDivision;

     for(n=1 ; n<=nDivision ; n++)
          {
          if(nValLue > nPlage*(n-1) && nValLue <= nPlage*n)
               {
               return n;
               }
          }
     }
else
     {
     return nValLue;
     }*/
}