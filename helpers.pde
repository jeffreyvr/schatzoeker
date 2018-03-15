/**
 * IsTussen
 *
 * Kijkt of een positie tussen een eerste en tweede positie valt en routourneert boolean.
 */
boolean isTussen( int x1, int x2, int pos ){
  return ( pos >= x1 && pos <= x2 ) ? true :  false;
}