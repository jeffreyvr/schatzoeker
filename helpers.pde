int[] vakkenTot(int tot) {
  println(tot);
  
  int[] resultaat = new int[0];
  
  for (int i = 0; i < resultaat.length; i++){
    
    resultaat[i] = i;
    
    if ( i == tot ) break;
    
  }
  
  
  return resultaat;
}