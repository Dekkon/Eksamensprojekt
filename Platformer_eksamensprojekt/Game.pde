class Game {

  int level; // variabel til skift mellem levels
  int menu; // variabel til skift mellem menuer
  color buttoncolor; // farve af knapper
  
  
  
  boolean canType[] = new boolean[2]; // til spørgsmål; om man kan skrive til sprg 1/2. 

  //int levelsCompleted;

  Game() {
    
  }

  // run funktionen, hovedfunktion som kører i draw loopet, lavet her da sub-klasserne i main er fra denne, så funktionen er nød til at eksisterer i suberklassen for at programmet kan kører.
  void run() {
  }
  
  // funktionen er lavet her af samme grund som runfunktionen.
  void typeanswer(int wq) {
    
  }
  
  //for at forindre to klik i et, da booleanen 'mousePressed' altid er sand når musen holdes inde kan man ende med at klikke to knapper med et klik
  // forhindre dette ved at få variablen 'mousecheck = 1', så fungere kode med musen kun når den er 1, variablen fortsætter med at stige, og mus klik kode virke altså ikke længere så dobbelt klik sker ikke.
  // når man slipper musen, bliver 'mousecheck' 0 igen, og man kan klikke igen.
  void mouselistener() {
    if (mousePressed) mousecheck ++;
    else mousecheck = 0;
    
  }
}
