class Data extends Menu {
  Button[] b = new Button[1]; // en knap

  int numberofwrongguesses[] = new int[7]; // int array, hvori antal forkete svar hentet fra datasæt, gemmes i.

  Data() {
    answerData= loadTable("answerData.csv", "header"); // loader table med data for forkerte svar
    b[0] = new Button(180, 100, 240, 90, "Menu"); // knap tilbage til menuen
    
    //gemmer dataen fra csv filen, i int-arrayet,
    for (TableRow row : answerData.rows()) {
      numberofwrongguesses[0] = row.getInt("question1");
      numberofwrongguesses[1] = row.getInt("question2");
      numberofwrongguesses[2] = row.getInt("question3");
      numberofwrongguesses[3] = row.getInt("question4");
      numberofwrongguesses[4] = row.getInt("question5");
      numberofwrongguesses[5] = row.getInt("question6");
      numberofwrongguesses[6] = row.getInt("question7");
  
    }
  }
  // Data-klassens run funktion, som kører i drawloopet.
  void run() {
    showData();
    
    mouselistener();
    buttons();
  }
  
  // funktion for knappen
  void buttons() {
    textSize(60); // størrelse af tekst på knappen.
    for (int i = 0; i < b.length; i++) {
      if (b[i].mouseOverButton()) {
        buttoncolor = color(150, 150); // knappernes farve hvis musen er over dem
        if (mousePressed && mousecheck == 1) {
          if (i == 0) menu = 1; // fører en tilbage til menuen
        }
      } else {
        buttoncolor = color(150, 200); // farven hvis musen ikke er over den
      }
      b[i].drawbutton(buttoncolor); // tegner knapperne
    }
  }
  
  //funktion til at vise daten.
  void showData() {
    textAlign(CENTER, CENTER);
    textSize(50);
    text("antal forkerte svar", width/2, 100);
    
    // for loop hvori, der skrives hvor mange gange der er svaret forkert på hvert spørgsmål.
    for (int i = 0; i < 7; i++) {
      fill(255);
      textSize(20);
      text("Spørgsmål " + (i+1), 150+i*150, height/2 - 100);
      textSize(50);
      if (numberofwrongguesses[i] == 0) fill(0, 255, 0); // hvis der er svaret 0 gange forkert på et spørgsmål skrives dette med grønt
      else if (numberofwrongguesses[i] < 3) fill(255, 255, 0); // hvis det er 1-3 gange, skrives det med gult
      else fill(255, 0, 0); // hvis der er over 3 gange skrives det med rødt
      text(numberofwrongguesses[i], 150+i*150, height/2); // skriver hvor mange gange der er svaret forkert på spørgsmålene.
    }
  }
}
