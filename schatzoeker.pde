final int AANTALRIJEN = 10;
final int vakDimensie = 50;
final int sBordHeight = 100;

int startTime;
int[] vakken;
int[] vakPositiesX;
int[] vakPositiesY;
String[] vakStatussen;
int aantalMarkeringen, aantalKliks, aantalSchattenGemarkeerd;
  
final int achtergrondKleur   = #ffeead;
final int vakKleur           = achtergrondKleur;
final int vakGemarkeerdKleur = #ffcc5b;
final int vakSchatKleur      = #ff6f69;
final int vakGeopendKleur    = #96ceb5; //<>//
final int vakRandKleur       = #fffbeb;
final int scoreBordKleur     = #88bbd9;
final int succesKleur        = #88d8b0;
final int foutKleur          = #ff6f69;

boolean gameOver = false;

/**
 * Settings 
 */
void settings() {
  int dWidth = (vakDimensie * AANTALRIJEN) + 1;
  int dHeigt = dWidth;
  
  size(dWidth, dHeigt+sBordHeight);
}

/**
 * Setup
 */
void setup() {
  textAlign(LEFT);
     
  background(achtergrondKleur);
  
  setGame();
}

/**
 * setGame
 */
void setGame() {
  startTime          = millis();
  vakken             = definierSchatten();
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
  
  if ( gameOver ) {
    gameOver();
  
  } else {
    tekenRooster();
    tekenScorebord();
    
  }
  
}

/**
 * MousePressed 
 */
void mousePressed() {
  if ( mouseButton == LEFT ) {
    openVak();
  }
  
  if ( mouseButton == RIGHT ) {
    markeerVak();
  }
  
  if (! gameOver ) {
    aantalKliks++;
  }
}

void keyPressed() {
  if (gameOver && keyPressed == true) {
     gameStart();
  }
}

/**
 * Teken scorebord
 */
void tekenScorebord() {
  stroke(#5c8aa0);
  fill(scoreBordKleur);
  rect(0, height, width, -sBordHeight); 
  
  fill(255);
  textSize(14);
  text("Markingen over: " + (aantalSchatten() - aantalMarkeringen), 10, height-(sBordHeight-56));
  text("Aantal kliks: " + aantalKliks, 10, height-(sBordHeight-40));
  
  int elapsed = millis() - startTime;
  
  text("Seconden gespeeld: " + int(elapsed) / 1000, 10, height-(sBordHeight-72));
}

/**
 * TekenRooster
 */
void tekenRooster() {
 int[] vakPositiesX = maakVakPosities("x");
 int[] vakPositiesY = maakVakPosities("y"); 
 
 for (int vakTeller = 0; vakTeller < vakken.length; vakTeller++ ) {
   
   int clr                  = vakKleur;
   int aangrenzendeVakjes   = 0;
   boolean toonNummer       = false;
   
   if ( vakken[vakTeller] != 1 ) { // schat
     aangrenzendeVakjes = aangrezendeVakjes(vakPositiesX[vakTeller], vakPositiesY[vakTeller]);
   }
   
   if ( vakStatussen[vakTeller] == "open" ) {
     if ( vakken[vakTeller] == 1 ) {
       clr = vakSchatKleur;
     } else {
       toonNummer = true;
      }
   }
   
   if ( vakStatussen[vakTeller] == "gemarkeerd" && aantalMarkeringen < aantalSchatten() ) {
     clr = vakGemarkeerdKleur;
   }
   
   tekenVak(clr, vakPositiesX[vakTeller], vakPositiesY[vakTeller], vakDimensie, vakDimensie);  
   
   if ( toonNummer ) {
     textSize(14);
     fill(scoreBordKleur);
     text(aangrenzendeVakjes, vakPositiesX[vakTeller]+(vakDimensie/2), vakPositiesY[vakTeller]+(vakDimensie/2));
   }
  }
}

/**
 * Aangezende vakjes
 */
int aangrezendeVakjes(int x, int y) {
  int aangrenzend = 0;
  
  for (int vakTeller = 0; vakTeller < vakken.length; vakTeller++ ) {
      
    if ( vakken[vakTeller] != 1 ) continue;
    
    if ( vakPositiesX[vakTeller] == (x - vakDimensie) && vakPositiesY[vakTeller] == y ) aangrenzend++; // links
    if ( vakPositiesX[vakTeller] == (x + vakDimensie) && vakPositiesY[vakTeller] == y ) aangrenzend++; // rechts
    if ( vakPositiesX[vakTeller] == x && vakPositiesY[vakTeller] == ( y - vakDimensie ) ) aangrenzend++; // boven
    if ( vakPositiesX[vakTeller] == x && vakPositiesY[vakTeller] == ( y + vakDimensie ) ) aangrenzend++; // onder
    if ( vakPositiesX[vakTeller] == (x - vakDimensie) && vakPositiesY[vakTeller] == (y-vakDimensie) ) aangrenzend++; // links hoek boven
    if ( vakPositiesX[vakTeller] == (x - vakDimensie) && vakPositiesY[vakTeller] == (y+vakDimensie) ) aangrenzend++; // links hoek onder
    if ( vakPositiesX[vakTeller] == (x + vakDimensie) && vakPositiesY[vakTeller] == (y-vakDimensie) ) aangrenzend++; // rechts hoek boven
    if ( vakPositiesX[vakTeller] == (x + vakDimensie) && vakPositiesY[vakTeller] == (y+vakDimensie) ) aangrenzend++; // rechts hoek onder
  }
  
  return aangrenzend;
}

/**
 * Maak Vak posities
 */
int[] maakVakPosities(String cor) {
  
   int vakTeller = 0;
 
   int[] vakPositiesX = new int[AANTALRIJEN*AANTALRIJEN];
   int[] vakPositiesY = new int[AANTALRIJEN*AANTALRIJEN];
 
   for ( int tellerY = 0; tellerY < AANTALRIJEN; tellerY++ ) {
     
     for ( int tellerX = 0; tellerX < AANTALRIJEN; tellerX++ ) {
       vakPositiesX[vakTeller] = tellerX * vakDimensie;
       vakPositiesY[vakTeller] = tellerY * vakDimensie;
       vakTeller++;
     }
     
   }
  
  if ( cor == "x" ) {
    return vakPositiesX;
  }
  
  return vakPositiesY;
}

/**
 * AantalSchatten
 */
int aantalSchatten() {
  return ( AANTALRIJEN * AANTALRIJEN ) / 100 * 15; // 15 procent
}

/**
 * TekenVak
 */
void tekenVak(int clr, int x, int y, int w, int h) {
  fill(clr);
  stroke(vakRandKleur);
  rect(x, y, w, h);
}

/**
 * Definier schatten
 */
int[] definierSchatten() {
  int[] vakken = new int[AANTALRIJEN*AANTALRIJEN];
  
  for( int i = 0; i < aantalSchatten(); i++){
    
    while ( aantalSchattenVastgesteld(vakken) < aantalSchatten() ) {
      int random = (int) random(0, vakken.length);
      vakken[random] = 1;
    }
  }
  
  return vakken;
}

/**
 * Aantal schatten vastgesteld
 */
int aantalSchattenVastgesteld(int[] schatten) {
  int teller = 0;
  
  for ( int schat : schatten ) {
    if ( schat == 1 ) {
      teller++;
    } 
    
  }
  
  return teller;
}

/**
 * Initieren vakStatussen
 */
String[] initVakstatussen() {
  String[] vakStatussen = new String[AANTALRIJEN*AANTALRIJEN];
  
  for( int i = 0; i < vakStatussen.length; i++){
    vakStatussen[i] = "dicht";
  }
  
  return vakStatussen;
}