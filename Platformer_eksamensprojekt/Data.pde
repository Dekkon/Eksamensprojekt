class Data extends Menu {
  Button[] b = new Button[1];
  Table loadAnswerData;

  int numberofwrongguesses[] = new int[7];

  Data() {
    loadlevelsCompleted= loadTable("answerData.csv", "header");
    b[0] = new Button(180, 100, 240, 90, "Menu");

    for (TableRow row : loadlevelsCompleted.rows()) {
      numberofwrongguesses[0] = row.getInt("question1");
      numberofwrongguesses[1] = row.getInt("question2");
      numberofwrongguesses[2] = row.getInt("question3");
      numberofwrongguesses[3] = row.getInt("question4");
      numberofwrongguesses[4] = row.getInt("question5");
      numberofwrongguesses[5] = row.getInt("question6");
      numberofwrongguesses[6] = row.getInt("question7");
  
    }
  }

  void run() {
    showData();
    
    buttons();
  }

  void buttons() {
    textSize(60);
    for (int i = 0; i < b.length; i++) {
      if (b[i].overbutton()) {
        buttoncolor = color(150, 150);
        if (mousePressed) {
          if (i == 0) menu = 1;
        }
      } else {
        buttoncolor = color(150, 200);
      }
      b[i].drawbutton(buttoncolor);
    }
  }

  void showData() {
    textAlign(CENTER, CENTER);
    textSize(50);
    text("antal forkerte svar", width/2, 100);

    for (int i = 0; i < 7; i++) {
      fill(255);
      textSize(20);
      text("Spørgsmål " + (i+1), 150+i*150, height/2 - 100);
      textSize(50);
      if (numberofwrongguesses[i] == 0) fill(0, 255, 0);
      else if (numberofwrongguesses[i] < 3) fill(255, 255, 0);
      else fill(255, 0, 0);
      text(numberofwrongguesses[i], 150+i*150, height/2);
    }
  }
}
