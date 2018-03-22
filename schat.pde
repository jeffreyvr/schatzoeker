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