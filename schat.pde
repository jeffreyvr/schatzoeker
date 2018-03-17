/**
 * AantalSchatten
 *
 * Retourneer het aantal schatten die in het spel nodig zijn.
 */
int aantalSchatten() {
  return ( aantalrijen * aantalrijen ) / 100 * AANTALSCHATTENPROCENT;
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
 * MaakVakPosities
 *
 * Bepaal de x en y waarden van de vakken en zet deze in arrays. Hiermee kun
 * je in andere spelmomenten bepalen welk vakje wordt aangeklikt.
 */
int[] maakVakPosities(String cor) {
  
   int vakTeller = 0;
 
   int[] vakPositiesX = new int[aantalrijen*aantalrijen];
   int[] vakPositiesY = new int[aantalrijen*aantalrijen];
 
   for ( int tellerY = 0; tellerY < aantalrijen; tellerY++ ) {
     
     for ( int tellerX = 0; tellerX < aantalrijen; tellerX++ ) {
       vakPositiesX[vakTeller] = ( tellerX * vakDimensie ) + SCOREBORDBREEDTE;
       vakPositiesY[vakTeller] = tellerY * vakDimensie;
       vakTeller++;
     }
     
   }
  
  if ( cor == "x" ) {
    return vakPositiesX;
  }
  
  return vakPositiesY;
}