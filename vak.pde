/**
 * Definier vakken
 *
 * Loop door vakken en stel willekeurig het aantal benodigde
 * schatten vast.
 */
int[] definieerVakken() {
  int[] vakken = new int[aantalrijen*aantalrijen]; // maak array met aantal benodigde vakken
  
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
 * Initieren vakStatussen
 *
 * Retourneert een array met vakstatussen. Deze zijn eerst altijd dicht.
 * Op specifieke moment in het spel kan dit opgeroepen en gewijzigd worden.
 */
String[] initVakstatussen() {
  String[] vakStatussen = new String[aantalrijen*aantalrijen];
  
  for( int i = 0; i < vakStatussen.length; i++){
    
    vakStatussen[i] = "dicht";
    
  }
  
  return vakStatussen;
}

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
    
    if ( isTussen(x, x+vakDimensie, mouseX ) && isTussen(y, y+vakDimensie, mouseY) ) { // aangeklikte vakje gevonden
      
      if ( vakStatussen[vakTeller] == "gemarkeerd" ) {
        break; // is gemarkeerd, dus kan niet open
        
      } else if ( vakStatussen[vakTeller] == "open" ) {
        break; // is al open, kan niet dicht
        
      } else {
        vakStatussen[vakTeller] = "open";
        aantalKliks++; // hoog aantal kliks op
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
    
    if ( isTussen(x, x+vakDimensie, mouseX ) && isTussen(y, y+vakDimensie, mouseY) ) { // vakje gevonden
      
      if ( vakStatussen[vakTeller] == "open" ) break; // vak is al open, dus kan niet markeren
      
      if ( vakStatussen[vakTeller] == "gemarkeerd" ) { // vak is gemarkeerd, dus weer dicht zetten
        aantalMarkeringen--;
        vakStatussen[vakTeller] = "dicht";
        
         if ( vakken[vakTeller] == 1 ) aantalSchattenGemarkeerd--; // schat was gemarkeerd, nu niet meer
         
      } else {
        aantalMarkeringen++;
        vakStatussen[vakTeller] = "gemarkeerd";
        aantalKliks++; // hoog aantal kliks op
        
        if ( vakken[vakTeller] == 1 )  aantalSchattenGemarkeerd++; // gemarkeerde vak is een schat (waarde = 1), dus aantal schatmarkeringen ophogen
        
        if ( aantalSchattenGemarkeerd == aantalSchatten() ) gameGewonnen = true; // als alle schatten zijn gemarkeerd, trigger gameGewonnen
        
      }
      
      break; // vakje gevonden, dus stoppen met loop
      
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