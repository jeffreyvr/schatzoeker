/**
 * OpenVak
 *
 * Open een vakje. Controleert de status en past indien 
 * nodig de status in vakStatussen array aan.
 */
void openVak() {
  
  for (int vakTeller = 0; vakTeller < vakken.length; vakTeller++ ) {
    
    int x = vakPositiesX[vakTeller];
    int y = vakPositiesY[vakTeller];
    
    if ( isTussen(x, x+VAKDIMENSIE, mouseX ) && isTussen(y, y+VAKDIMENSIE, mouseY) ) { // aangeklikte vakje gevonden
      
      if ( vakken[vakTeller] == 1 ) {
        gameOver = true;
        
      } else if ( vakStatussen[vakTeller] == "gemarkeerd" ) {
        break; // is gemarkeerd, dus kan niet open
        
      } else if ( vakStatussen[vakTeller] == "open" ) {
        break; // is al open, kan niet dicht
        
      } else {
        vakStatussen[vakTeller] = "open";
        
      }
      
      break; // vakje is gevonden, dus stoppen met de loop
      
    }
    
  }
  
}

/**
 * MarkeerVak
 *
 * Markeer een vakje. Controleert de status van het vakje en past
 * de status in de vakStatussen array aan.
 * Hoogt ook het aantal gemarkeerde schatten (indien van toepassing) aan.
 */
void markeerVak(){ 
  
  for ( int vakTeller = 0; vakTeller < vakken.length; vakTeller++ ) {
    
    int x = vakPositiesX[vakTeller];
    int y = vakPositiesY[vakTeller];
    
    if ( isTussen(x, x+VAKDIMENSIE, mouseX ) && isTussen(y, y+VAKDIMENSIE, mouseY) ) { // vakje gevonden
      
      if ( vakStatussen[vakTeller] == "gemarkeerd" ) { // vak is gemarkeerd, dus weer dicht zetten
        aantalMarkeringen--;
        vakStatussen[vakTeller] = "dicht";
        
         if ( vakken[vakTeller] == 1 ) aantalSchattenGemarkeerd--; // schat was gemarkeerd, nu niet meer
         
      } else {
        aantalMarkeringen++;
        vakStatussen[vakTeller] = "gemarkeerd";
        
        if ( vakken[vakTeller] == 1 )  aantalSchattenGemarkeerd++; // gemarkeerde vak is een schat (waarde = 1), dus aantal schatmarkeringen ophogen
        
      }
      
      break; // vakje gevonden, dus stoppen met loop
      
    }
    
  }
  
}

/**
 * Game over
 *
 * Laat een game over -scherm zien als gameOver (true) retourneert.
 * Wordt steeds gecontroleerd in draw() functie.
 */
void gameOver() {
  if (gameOver) {
    fill(FOUTKLEUR);
    rect(0, 0, width, height);
    
    fill(255);
    textSize(32);
    text("GAME OVER!", (width/2)-50, height/2);
    textSize(16);
    text("Druk op een toets om opnieuw te beginnen.", (width/2)-200, (height/2)+20);
  }
}

/**
 * Game start
 *
 * Functie om game opnieuw op te zetten.
 */
void gameStart() {
  if ( gameOver ) {
    gameOver = false;
    initieerGame();
  }
}

/**
 * GameGewonnen
 *
 * Als alle schatten zijn gemarkeerd, heb je het spel gewonnen.
 * Hieruit volgt een game win -scherm.
 */
void gameGewonnen() {
 if ( aantalSchattenGemarkeerd == aantalSchatten() ) {
   fill(SUCCESSKLEUR);
   rect(0, 0, width, height);
    
   fill(255);
   textSize(32);
   text("Je hebt alle schatten gevonden!", (width/2)-50, height/2);
   textSize(16);
   text("Druk op een toets om opnieuw te beginnen.", (width/2)-200, (height/2)+20);
 }
}