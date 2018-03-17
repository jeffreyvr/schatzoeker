/**
 * MousePressed 
 */
void mousePressed() {
  if ( gameGestart && mouseButton == LEFT ) {
    openVak();
  }
  
  if ( gameGestart && mouseButton == RIGHT ) {
    markeerVak();
  }
  
  // rij keuze
  if ( gameGestart == false && isTussen( 0, SCOREBORDBREEDTE, mouseX ) ) {
   
    if ( isTussen( (height / 2), (height / 2) + 30, mouseY ) ) {
      aantalrijen = 10;
      initieerGame();
    } else if ( isTussen( (height / 2), (height / 2) + 30*2, mouseY ) ) {
      aantalrijen = 20;
      initieerGame();
    } else if ( isTussen( (height / 2), (height / 2) + 30*3, mouseY ) ) {
      aantalrijen = 30;
      initieerGame();
    }
    
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
  if (gameOver || gameGewonnen && keyPressed == true) {
     gameStart();
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