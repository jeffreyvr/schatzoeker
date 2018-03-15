final int AANTALRIJEN           = 10;
final int VAKDIMENSIE           = 50;
final int SCOREBORDHOOGTE       = 100;  
final int AANTALSCHATTENPROCENT = 15;
final int ACHTERGRONDKLEUR      = #ffeead;
final int VAKKLEUR              = ACHTERGRONDKLEUR;
final int VAKGEMARKEERDKLEUR    = #ffcc5b;
final int VAKSCHATKLEUR         = #ff6f69;
final int VAKGEOPENDKLEUR       = #96ceb5; //<>//
final int VAKRANDKLEUR          = #fffbeb;
final int SCOREBORDKLEUR        = #88bbd9;
final int SUCCESSKLEUR          = #88d8b0;
final int FOUTKLEUR             = #ff6f69;

int speeltijd;
int[] vakken, vakPositiesX, vakPositiesY;
String[] vakStatussen;
int aantalMarkeringen, aantalKliks, aantalSchattenGemarkeerd;
boolean gameOver = false;

/**
 * Settings 
 *
 * Bepaal de grote van het spelvenster. 
 */
void settings() {
  int desktopBreedte = (VAKDIMENSIE * AANTALRIJEN) + 1; // breedte op basis van aantal vakken
  int desktopHoogte = desktopBreedte; // rooster is vierkant, dus gelijk aan breedte
  
  size(desktopBreedte, desktopHoogte+SCOREBORDHOOGTE); // hoogte nu plus hoogte van scorenbord
}

/**
 * Setup
 *
 * Initieer de game.
 */
void setup() {
  textAlign(LEFT);
     
  background(ACHTERGRONDKLEUR);
  
  initieerGame();
}

/**
 * initieerGame
 */
void initieerGame() {
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

/**
 * KeyPressed
 *
 * Bij willekeurig keypress in game over -mode spel weer starten.
 */
void keyPressed() {
  if (gameOver && keyPressed == true) {
     gameStart();
  }
  
  // game gewonnen toevoegen
}

/**
 * Teken scorebord
 */
void tekenScorebord() {
  stroke(#5c8aa0);
  fill(SCOREBORDKLEUR);
  rect(0, height, width, -SCOREBORDHOOGTE); 
  
  fill(255);
  textSize(14);
  text("Markingen over: " + (aantalSchatten() - aantalMarkeringen), 10, height-(SCOREBORDHOOGTE-56));
  text("Aantal kliks: " + aantalKliks, 10, height-(SCOREBORDHOOGTE-40));  
  text("Seconden gespeeld: " + ((int) millis() - speeltijd) / 1000, 10, height-(SCOREBORDHOOGTE-72)); // minus speeltijd bij reset
}

/**
 * TekenRooster
 */
void tekenRooster() {
 int[] vakPositiesX = maakVakPosities("x");
 int[] vakPositiesY = maakVakPosities("y"); 
 
 for (int vakTeller = 0; vakTeller < vakken.length; vakTeller++ ) {
   
   int clr                  = VAKKLEUR;
   int aangrenzendeVakjes   = 0;
   boolean toonNummer       = false;
   
   if ( vakken[vakTeller] != 1 ) aangrenzendeVakjes = aangrezendeVakjes(vakPositiesX[vakTeller], vakPositiesY[vakTeller]); // aangrenzendevakjes
   
   if ( vakStatussen[vakTeller] == "open" ) toonNummer = true;
   
   if ( vakStatussen[vakTeller] == "gemarkeerd" && aantalMarkeringen < aantalSchatten() ) {
     clr = VAKGEMARKEERDKLEUR;
   }
   
   tekenVak(clr, vakPositiesX[vakTeller], vakPositiesY[vakTeller], VAKDIMENSIE, VAKDIMENSIE);  
   
   if ( toonNummer ) {
     textSize(14);
     fill(SCOREBORDKLEUR);
     text(aangrenzendeVakjes, vakPositiesX[vakTeller]+(VAKDIMENSIE/2), vakPositiesY[vakTeller]+(VAKDIMENSIE/2));
   }
  }
}

/**
 * AangrenzendeVakjes
 *
 * Bekijk of een vakje grenst aan een schat. 
 * Retourneert het aantal aangrenzende schatten.
 */
int aangrezendeVakjes(int x, int y) {
  int aangrenzend = 0;
  
  for ( int vakTeller = 0; vakTeller < vakken.length; vakTeller++ ) {
      
    if ( vakken[vakTeller] != 1 ) continue; // is geen schat, ga verder
    
    if ( vakPositiesX[vakTeller] == (x - VAKDIMENSIE) && vakPositiesY[vakTeller] == y ) aangrenzend++; // links
    if ( vakPositiesX[vakTeller] == (x + VAKDIMENSIE) && vakPositiesY[vakTeller] == y ) aangrenzend++; // rechts
    if ( vakPositiesX[vakTeller] == x && vakPositiesY[vakTeller] == ( y - VAKDIMENSIE ) ) aangrenzend++; // boven
    if ( vakPositiesX[vakTeller] == x && vakPositiesY[vakTeller] == ( y + VAKDIMENSIE ) ) aangrenzend++; // onder
    if ( vakPositiesX[vakTeller] == (x - VAKDIMENSIE) && vakPositiesY[vakTeller] == (y-VAKDIMENSIE) ) aangrenzend++; // links hoek boven
    if ( vakPositiesX[vakTeller] == (x - VAKDIMENSIE) && vakPositiesY[vakTeller] == (y+VAKDIMENSIE) ) aangrenzend++; // links hoek onder
    if ( vakPositiesX[vakTeller] == (x + VAKDIMENSIE) && vakPositiesY[vakTeller] == (y-VAKDIMENSIE) ) aangrenzend++; // rechts hoek boven
    if ( vakPositiesX[vakTeller] == (x + VAKDIMENSIE) && vakPositiesY[vakTeller] == (y+VAKDIMENSIE) ) aangrenzend++; // rechts hoek onder
  }
  
  return aangrenzend;
}

/**
 * MaakVakPosities
 *
 * Bepaal de x en y waarden van de vakken en zet deze in arrays. Hiermee kun
 * je in andere spelmomenten bepalen welk vakje wordt aangeklikt.
 */
int[] maakVakPosities(String cor) {
  
   int vakTeller = 0;
 
   int[] vakPositiesX = new int[AANTALRIJEN*AANTALRIJEN];
   int[] vakPositiesY = new int[AANTALRIJEN*AANTALRIJEN];
 
   for ( int tellerY = 0; tellerY < AANTALRIJEN; tellerY++ ) {
     
     for ( int tellerX = 0; tellerX < AANTALRIJEN; tellerX++ ) {
       vakPositiesX[vakTeller] = tellerX * VAKDIMENSIE;
       vakPositiesY[vakTeller] = tellerY * VAKDIMENSIE;
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
 *
 * Retourneer het aantal schatten die in het spel nodig zijn.
 */
int aantalSchatten() {
  return ( AANTALRIJEN * AANTALRIJEN ) / 100 * AANTALSCHATTENPROCENT;
}

/**
 * TekenVak
 */
void tekenVak(int clr, int x, int y, int w, int h) {
  fill(clr);
  stroke(VAKRANDKLEUR);
  rect(x, y, w, h);
}

/**
 * Definier vakken
 *
 * Loop door vakken en stel willekeurig het aantal benodigde
 * schatten vast.
 */
int[] definieerVakken() {
  int[] vakken = new int[AANTALRIJEN*AANTALRIJEN]; // maak array met aantal benodigde vakken
  
  for( int i = 0; i < aantalSchatten(); i++ ){
    
    // blijf loopen tot het aantal benodigde schatten willekeurig zijn gedefinieerd
    while ( aantalSchattenVastgesteld(vakken) < aantalSchatten() ) {
      
      int random = (int) random(0, vakken.length); // bepaal random nummer als schat
      
      vakken[random] = 1; // zet waarde op 1 om als vak als schat aan te merken
      
    }
    
  }
  
  return vakken;
}

/**
 * Aantal schatten vastgesteld
 *
 * Bereken hoeveel schatten er inmiddels zijn vastgesteld.
 */
int aantalSchattenVastgesteld(int[] vakken) {
  int teller = 0;
  
  for ( int vak : vakken ) {
    if ( vak == 1 ) { // als waarde 1 is, is het vak een schat
      teller++; // hoog totaal aantal schatten op
    } 
    
  }
  
  return teller;
}

/**
 * Initieren vakStatussen
 *
 * Retourneert een array met vakstatussen. Deze zijn eerst altijd dicht.
 * Op specifieke moment in het spel kan dit opgeroepen en gewijzigd worden.
 */
String[] initVakstatussen() {
  String[] vakStatussen = new String[AANTALRIJEN*AANTALRIJEN];
  
  for( int i = 0; i < vakStatussen.length; i++){
    
    vakStatussen[i] = "dicht";
    
  }
  
  return vakStatussen;
}