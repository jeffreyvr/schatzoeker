/**
 * TekenVak
 */
void tekenVak(int clr, int x, int y, int w, int h) {
  fill(clr);
  stroke(VAKRANDKLEUR);
  rect(x, y, w, h);
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
   
   if ( vakken[vakTeller] == 1 && vakStatussen[vakTeller] == "open" ) { // schat wordt geopend, dus game over
     clr = FOUTKLEUR;
     gameOver = true;
   }
   if ( vakken[vakTeller] != 1 && vakStatussen[vakTeller] == "open" ) toonNummer = true;
   
   if ( vakStatussen[vakTeller] == "gemarkeerd" && aantalMarkeringen < aantalSchatten() ) clr = VAKGEMARKEERDKLEUR;
   
   tekenVak(clr, vakPositiesX[vakTeller], vakPositiesY[vakTeller], vakDimensie, vakDimensie);  
   
   if ( toonNummer ) {
     textAlign(CENTER);
     textSize(14);
     fill(255);
     text(aangrenzendeVakjes, vakPositiesX[vakTeller]+(vakDimensie/2), vakPositiesY[vakTeller]+(vakDimensie/2));
   }
  }
}

/**
 * Teken scorebord
 */
void tekenScorebord() {
  fill(255);
  textAlign(CENTER);
  
  textSize(14);
  text("Markingen over:", SCOREBORDBREEDTE / 2 , (height / 2) - 70);
  textSize(28);
  text((aantalSchatten() - aantalMarkeringen), SCOREBORDBREEDTE / 2, (height / 2) - 42 );
  
  textSize(14);
  text("Aantal kliks: ", SCOREBORDBREEDTE / 2, (height / 2) );
  textSize(28);
  text(aantalKliks, SCOREBORDBREEDTE / 2, (height / 2) + 28 );
  
  textSize(14);
  text("Seconden gespeeld: ", SCOREBORDBREEDTE / 2, (height / 2) + 56 );
  textSize(28);
  text(((int) millis() - speeltijd) / 1000, SCOREBORDBREEDTE / 2, (height / 2) + 84 ); // minus speeltijd bij reset
}

/**
 * Teken linker balk
 */ 
void tekenLinkerBalk() {
  PImage achtergrondAfbeelding = loadImage("links.jpg");
  
  stroke(#5c8aa0);
  achtergrondAfbeelding.resize(SCOREBORDBREEDTE, height);
  image(achtergrondAfbeelding, 0, 0);
}

/**
 * Teken scorebord
 */
void tekenStartMenu() {
  fill(255);
  textAlign(CENTER);
  
  textSize(14);
  text("Kies het aantal rijen:", SCOREBORDBREEDTE / 2 , (height / 2) );
  
  textSize(28);
  text("10 x 10", SCOREBORDBREEDTE / 2, (height / 2) + 30 );
  
  textSize(28);
  text("20 x 20", SCOREBORDBREEDTE / 2, (height / 2) + 30*2 );
  
  textSize(28);
  text("30 x 30", SCOREBORDBREEDTE / 2, (height / 2) + 30*3 );
}

/**
 * Teken spel titel
 */
void tekenSpelTitel() {
  fill(255);
  textSize(28);
  textAlign(CENTER);
  text("Schatzoeker", SCOREBORDBREEDTE / 2, 28 );
}

/**
 * TekenGameOver
 *
 * Laat een game over -scherm zien.
 */
void tekenGameOver() {
  fill(FOUTKLEUR);
  textSize(28);
  textAlign(CENTER);
  text("Verloren :(", SCOREBORDBREEDTE / 2, height - 100 );
  //textSize(16);
  //text("Druk op een toets om opnieuw te beginnen.", SCOREBORDBREEDTE / 2, height - 72);
}

/**
 * TekenGameGewonnen
 *
 * Als alle schatten zijn gemarkeerd, heb je het spel gewonnen.
 * Hieruit volgt een game win -scherm.
 */
void tekenGameGewonnen() {
  fill(SUCCESSKLEUR);
  textSize(28);
  textAlign(CENTER);
  text("Gewonnen! :)", SCOREBORDBREEDTE / 2, height - 100 );
}