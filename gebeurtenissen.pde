/**
 * MousePressed 
 */
void mousePressed() {
  if ( gameGestart && ! gameOver ) {
    
    if ( mouseButton == LEFT ) {
      openVak();
    } else if ( mouseButton == RIGHT ) {
      markeerVak();
    }
    
  }
  
  // rij keuze
  if ( ! gameGestart && isTussen( 0, LINKERBALKBREEDTE, mouseX ) ) {
   
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
}

/**
 * KeyPressed
 *
 * Bij willekeurig keypress in game over -mode spel weer starten.
 */
void keyPressed() {
  if ( gameOver || gameGewonnen ) {
    if ( keyCode == ENTER) {
       gameStart();
    } else if ( keyCode == 32 ) { // spacebar
      gameGestart = false;
      gameOver = false;
    }
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