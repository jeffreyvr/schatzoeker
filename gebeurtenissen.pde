/**
 * Open vak
 */
void openVak() {
  
  for (int vakTeller = 0; vakTeller < vakken.length; vakTeller++ ) {
    
    int x = vakPositiesX[vakTeller];
    int y = vakPositiesY[vakTeller];
    
    if ( isTussen(x, x+vakDimensie, mouseX ) && isTussen(y, y+vakDimensie, mouseY) ) {
      
      if ( vakken[vakTeller] == 1 ) {
        gameOver = true;
      } else if ( vakStatussen[vakTeller] == "gemarkeerd" ) {
        break;
      } else if ( vakStatussen[vakTeller] == "open" ) {
        //vakStatussen[vakTeller] = "dicht";
      } else {
        vakStatussen[vakTeller] = "open";
      }
      
      break;
      
    }
    
  }
  
}

/**
 * markeer vak
 */
void markeerVak(){ 
  
  for (int vakTeller = 0; vakTeller < vakken.length; vakTeller++ ) {
    
    int x = vakPositiesX[vakTeller];
    int y = vakPositiesY[vakTeller];
    
    if ( isTussen(x, x+vakDimensie, mouseX ) && isTussen(y, y+vakDimensie, mouseY) ) {
      
      if ( vakStatussen[vakTeller] == "gemarkeerd" ) {
        aantalMarkeringen--;
        vakStatussen[vakTeller] = "dicht";
        
         if ( vakken[vakTeller] == 1 ) {
           aantalSchattenGemarkeerd--; 
         }
      } else {
        aantalMarkeringen++;
        vakStatussen[vakTeller] = "gemarkeerd";
        
        if ( vakken[vakTeller] == 1 ) {
         aantalSchattenGemarkeerd++; 
        }
        
      }
      
      break;
      
    }
    
  }
  
}

/**
 * Game over 
 */
void gameOver() {
  if (gameOver) {
    fill(foutKleur);
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
 */
void gameStart() {
  if ( gameOver ) {
    gameOver = false;
    setGame();
  }
}

void gameGewonnen() {
 if ( aantalSchattenGemarkeerd == aantalSchatten() ) {
   fill(succesKleur);
   rect(0, 0, width, height);
    
   fill(255);
   textSize(32);
   text("Je hebt alle schatten gevonden!", (width/2)-50, height/2);
   textSize(16);
   text("Druk op een toets om opnieuw te beginnen.", (width/2)-200, (height/2)+20);
 }
}

/**
 * isTussen
 */
boolean isTussen( int x1, int x2, int pos ){
  return ( pos >= x1 && pos <= x2 ) ? true :  false;
}