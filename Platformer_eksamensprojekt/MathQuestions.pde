class MathQuestions {

  //strings hvori, ens gæt skrives ind
  String userGuess1s = ""; //userGuess1 String
  String userGuess2s = ""; //userGuess2 String
  int userGuessI[] = new int[2]; //userGuess 1&2 int
  int answer[] = new int [2]; //array hvori svarene gemmes i
  int guesscheck[] = {0, 0}; //bruges til at gemme og der er svaret rigtigt eller forkert.
  int redbox[] = {0, 0}; //til de røde bokse der kommer når der svares forkert.

  int numberofwrongguesses[] = {0, 0}; //til hvormange gange man svarer forkert på hvert spørgsmål.

  //til nøglen
  boolean keytogate = false;
  PVector keylocation;
  PImage keyimage;


  //tal der skal bruges til spørgsmålene til de forskellige levels.
  int lvl1tal[] = new int[4];
  int lvl2tal[] = new int[6];
  int lvl3tal[] = new int[6];
  int lvl4tal[] = new int[6];


  MathQuestions() {
    keyimage = loadImage("key.png");
    keyimage.resize(30, 15);

    //sætter tallene til forskellige værdier baseret på hvad klassetrinnet er.
    switch(klassetrin) {
    case 1:
      //level 1
      lvl1tal[0] = int(random(2, 9)); 
      lvl1tal[1] = int(random(2, 9)); 
      //level 2
      lvl2tal[0] = int(random(2, 9)); 
      lvl2tal[1] = int(random(2, lvl2tal[0])); //gør at lvl2tal1, ikke kan blive højere end lvl2tal0, for 1-klasse casen, så der ikke kommer et minus stykke der giver et minus tal. 
      lvl2tal[2] = int(random(10, 20)); 
      lvl2tal[3] = int(random(10, 30));
      //level 3
      lvl3tal[0] = int(random(2, 3));
      lvl3tal[1] = int(random(2, 9));
      lvl3tal[2] = int(random(40, 70));
      lvl3tal[3] = int(random(1, 6));
      //level 4
      lvl4tal[0] = int(random(1, 9));
      lvl4tal[1] = int(random(1, 9));
      lvl4tal[2] = int(random(1, 9));
      lvl4tal[3] = int(random(1, 9));
      lvl4tal[4] = int(random(1, 9));
      lvl4tal[5] = int(random(1, 9));
      break;
    case 5:
      //level 1
      lvl1tal[0]= int(random(3, 9)); 
      lvl1tal[1] = int(random(10, 19));
      //level 2
      lvl2tal[0] = int(random(111, 222)); 
      lvl2tal[1] = int(random(111, 222)); 
      lvl2tal[2] = int(random(2, 7)); 
      lvl2tal[3] = int(random(5, 9)); 
      lvl2tal[4] = int(random(2, 9));
      //level 3
      lvl3tal[0] = int(random(2, 4.4));
      lvl3tal[1] = 12;
      lvl3tal[2] = int(random(3, 6.4));
      lvl3tal[3] = 60;
      //level 4
      lvl4tal[0] = int(random(20, 40));
      lvl4tal[1] = int(random(50, 70));
      lvl4tal[2] = int(random(2, 9));
      lvl4tal[3] = int(random(21, 44));
      break;
    case 9:
      float whichnum = random(1); //bruges for at der kan vælges mellem to numre, hvor det er vigtigt at der i de forskellige vælges de tal der passer sammen,
      // da tallene bruges til ligninger, og meningen er at ligningerne skal løses i et heltal.
      //level 1
      lvl1tal[0] = whichnum > 0.5 ? 8 : 5; 
      lvl1tal[1] = whichnum>0.5 ? 2 : 4 ; 
      lvl1tal[2] = whichnum>0.5 ? 40 : 10;
      //level 2
      lvl2tal[0] = whichnum > 0.5 ? 6 : 5;
      lvl2tal[1] = whichnum > 0.5 ? 3 : 2;
      lvl2tal[2] = whichnum > 0.5 ? 8 : 4;
      lvl2tal[3] = whichnum > 0.5 ? 16 : 8;
      lvl2tal[4] = random(1)>0.5 ? 4 : 16;
      lvl2tal[5] = random(1)>0.5 ? 9 : 25;
      //level 3
      lvl3tal[0] = whichnum > 0.5 ? 3 : 4;
      lvl3tal[1] = whichnum > 0.5 ? 3 : 1;
      lvl3tal[2] = 2;
      lvl3tal[3] = whichnum > 0.5 ? 4 : 5;
      lvl3tal[4] = random(1) > 0.5 ? 25 : 16;
      lvl3tal[5] = random(1) > 0.5 ? 36 : 9;
      //level 4
      lvl4tal[0] = int(random(222, 999));
      lvl4tal[1] = int(random(222, 999));
      lvl4tal[2] = int(random(11, 19));
      lvl4tal[3] = int(random(31, 59));      
      break;
    }
  }

  //viser nøglen, 
  void displayKey() {
    //the key
    noStroke();
    fill(255);
    imageMode(CENTER);
    noTint();
    image(keyimage, keylocation.x, keylocation.y);
  }
  // funktion hvor nøglen fås til at bevæge sig
  void keySeekLocation(PVector target) {
    PVector distance = PVector.sub(target, keylocation); // bruges til hvor langt nøglen er fra dens ønskede lokation.
    PVector desired = PVector.sub(target, keylocation); // bruges til den retning nøglen skal bevæge sig

    desired.setMag(2); // sætter længden af vektoren til 2

    if (distance.mag() > 3) {
      keylocation.add(desired); //er nøglen mere end 3 fra sin destination, bevæger den sig med 'desired'
    }
    if (distance.mag() < 3) keytogate = true; //når den når sen destination sættes booleanen sand.
  }

  //funktion hvorfra der kan skrives svar
  void typeanswer(int wq) { //parameteren bruges for at vide hvilket sprørgsmål der svares på når funktionen kaldes.
   // if (keyPressed) { 
      // gjort så kun tal og minus tegn kan skrives.
      if (key == '1' || key == '2' || key == '3' || key == '4' || key == '5' || key == '6' || key == '7' || key == '8' || key == '9' || key == '0' || key == '-') {
        if (wq == 1 && guesscheck[0] != 1) userGuess1s = userGuess1s + key;
        if (wq == 2 && guesscheck[1] != 1) userGuess2s = userGuess2s + key;
      } 
      if (keys[3]) { //backspace funktion, brugte booleanen keys, da det ikke gad at virke med  keyCoden
        if (userGuess1s.length() > 0 && wq == 1 && guesscheck[0] != 1) userGuess1s = userGuess1s.substring(0, userGuess1s.length()-1);
        if (userGuess2s.length() > 0 && wq == 2 && guesscheck[1] != 1) userGuess2s = userGuess2s.substring(0, userGuess2s.length()-1);
      }
   // }
    // so the game doesn't crash if a non integer is written. i.e. '2-2'
    try { 
      if (keyCode == ENTER) {
        if (wq == 1) userGuessI[0] = Integer.parseInt(userGuess1s);
        if (wq == 2) userGuessI[1] = Integer.parseInt(userGuess2s);
        
        //tests if the questions was answered correctly or not
        //checks specificly on the question which is currently being answered
        if (userGuessI[wq-1] == answer[wq-1]) { //if question is asnwered correctly
          guesscheck[wq-1] = 1; //sets the guesscheck to 1, which is used as the question being answered correctly
        }
        if (userGuessI[wq-1] != answer[wq-1]) { // if question is answered incorrectly
          guesscheck[wq-1] = 2; //sets the guesscheck to 2, which to the program understsands as the question being answered incorrectly
          if (wq == 1) userGuess1s = userGuess1s.substring(0, 0); //empties the string which stores the users guess,
          if (wq == 2)userGuess2s = userGuess2s.substring(0, 0); // -||-
        }
      }
    } 
    catch (Exception e) { // still records an asnwer which can't be parsed into an integer as an incorrect answer
      if (wq == 1) {
        guesscheck[0] = 2;
        userGuess1s = userGuess1s.substring(0, 0);
      }
      if (wq == 2) {
        guesscheck[1] = 2;
        userGuess2s = userGuess2s.substring(0, 0);
      }
    }
  }
  //box som der vises når man svarer forkert
  //variablerne styrer lokationen af boksen, samt hvilket spørgsmål den passer til.
  void wronganswerbox(int x, int y, int answernumber) {
    
    //når der er svaret forkert på et spørgsmål
    if (guesscheck[answernumber] == 2) { 
      //svares der forkert tæller numberofwrongguesses, op, baseret på hvilket spørgsmål det passer til.
      numberofwrongguesses[answernumber] ++;      
      redbox[answernumber] = 30; // svares der forkert sættes redbox til tredve      
      guesscheck[answernumber] = 0; //sætter guesscheck til 0, så koden der sker når der er svaret forkert ikke bliver ved med at ske, for bl.a. at forhindre at 'numberofwrongguesses' tælles op konstant.      
    }
    // er redbox variablen større end nul, så tegnes den røde boks
    if (redbox[answernumber] > 0) {
      fill(255, 0, 0);
      noStroke();
      rectMode(CENTER);
      rect(x, y, 60, 20);
      
     redbox[answernumber]--; //tæller variablen ned, få at fo boksen som tegnes til at forsvinde efter et kort stykke tid
    }
  }
  //funktion for svarene til spørgsmålene regnes af programmet
  //svaret findes baseret på hvilket level det er, og hvilket klassetrin det er
  void questions(int currentlevel) {
    //svaret på spørgsmålene udregnes, da tallene er randomiserede, og svarene er derfor nødt til at blive regnet.

    // question 1

    // 1. klasse
    if (klassetrin == 1) {
      if (currentlevel == 1) answer[0] = lvl1tal[0] + lvl1tal[1];
      if (currentlevel == 2) answer[0] = lvl2tal[0] - lvl2tal[1];
      if (currentlevel == 3) answer[0] = lvl3tal[0] * lvl3tal[1];
      if (currentlevel == 4) answer[0] = lvl4tal[0] + lvl4tal[1] + lvl4tal[2];
    }
    // 5. klasse
    if (klassetrin == 5) {
      if (currentlevel == 1) answer[0] = lvl1tal[0] * lvl1tal[1];
      if (currentlevel == 2) answer[0] = lvl2tal[0] + lvl2tal[1];
      if (currentlevel == 3) answer[0] = lvl3tal[1] / lvl3tal[0];
      if (currentlevel == 4) answer[0] = lvl4tal[0] - lvl4tal[1];
    }
    // 9. klasse
    if (klassetrin == 9) {
      if (currentlevel == 1) answer[0] = (lvl1tal[2] - lvl1tal[0] * lvl1tal[1]) / lvl1tal[0];
      if (currentlevel == 2) answer[0] = (lvl2tal[2] + lvl2tal[3]) / (lvl2tal[0] - lvl2tal[1]);
      if (currentlevel == 3) answer[0] = (lvl3tal[2] * lvl3tal[3] - lvl3tal[0] * lvl3tal[1]) / (lvl3tal[0] - lvl3tal[2]) ;
      if (currentlevel == 4) answer[0] = lvl4tal[0] + lvl4tal[1];
    }

    /// question 2 

    // 1. klasse
    if (klassetrin == 1) {
      if (currentlevel == 1);
      if (currentlevel == 2) answer[1] = lvl2tal[2] + lvl2tal[3];
      if (currentlevel == 3) answer[1] = lvl3tal[2] + lvl3tal[3];
      if (currentlevel == 4) answer[1] = lvl4tal[3] + lvl4tal[4] - lvl4tal[5];
    }
    // 5. klasse
    if (klassetrin == 5) {
      if (currentlevel == 1);
      if (currentlevel == 2) answer[1] = lvl2tal[2] + lvl2tal[3] * lvl2tal[4];
      if (currentlevel == 3) answer[1] = lvl3tal[3] / lvl3tal[2];
      if (currentlevel == 4) answer[1] = lvl4tal[2] * lvl4tal[3];
    }
    // 9. klasse
    if (klassetrin == 9) {
      if (currentlevel == 2) answer[1] = int(sqrt(lvl2tal[4])) + int(sqrt(lvl2tal[5]));
      if (currentlevel == 3) answer[1] = int(sqrt(lvl3tal[4])) - int(sqrt(lvl3tal[5]));
      if (currentlevel == 4) answer[1] = lvl4tal[2] * lvl4tal[3];
    }
  }
}
