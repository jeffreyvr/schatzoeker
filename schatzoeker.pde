final int LINKERBALKBREEDTE      = 200;
final int AANTALSCHATTENPROCENT  = 15;
final int ACHTERGRONDKLEUR       = #efd894;
final int VAKKLEUR               = #efd894;
final int VAKGEMARKEERDKLEUR     = #ffcc5b;
final int VAKSCHATKLEUR          = #ff6f69;
final int VAKGEOPENDKLEUR        = #96ceb5; //<>//
final int VAKRANDKLEUR           = #d3bf83;
final int SUCCESKLEUR            = #88d8b0;
final int FOUTKLEUR              = #ff6f69;

int speeltijd, vakDimensie, aantalrijen, eindTijd;
int[] vakken, vakPositiesX, vakPositiesY;
String[] vakStatussen;
int aantalMarkeringen, aantalKliks, aantalSchattenGemarkeerd;
boolean gameOver, gameGewonnen, gameGestart = false;

/**
 * Settings 
 *
 * Bepaal de grote van het spelvenster. 
 */
void settings() {
  int spelDimensie = displayWidth / 2 ; // breedte is de helft van de beeldscherm
  
  size(spelDimensie + LINKERBALKBREEDTE, spelDimensie); // breedte nu plus breedte van scorebord
}

/**
 * Setup
 *
 * Initieer de game.
 */
void setup() {
  background(ACHTERGRONDKLEUR);
  
  textAlign(LEFT);
}

/**
 * initieerGame
 */
void initieerGame() {
  gameGestart        = true;
  vakDimensie        = (width-LINKERBALKBREEDTE) / aantalrijen; // bepaal dimensie van een vak
  speeltijd          = millis();
  vakken             = definieerVakken();
  vakStatussen       = initVakstatussen();
  vakPositiesX       = maakVakPosities("x");
  vakPositiesY       = maakVakPosities("y");
  aantalMarkeringen  = 0;
  aantalKliks        = 0;
}

/**
 * Draw
 */
void draw() {
  tekenLinkerBalk();
  tekenSpelTitel();
  
  if ( gameOver ) {
    tekenGameOver();
    tekenScorebord();
  
  } else if ( gameGewonnen ) {
    tekenGameGewonnen();
    
  } else if ( gameGestart ) {
    tekenScorebord();
    tekenRooster();
    
  } else {
    tekenStartMenu();
    
  }
}