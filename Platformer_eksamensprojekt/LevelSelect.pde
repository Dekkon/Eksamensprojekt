class LevelSelect extends Menu {
  Button[] b = new Button[6]; //danner array med knapper

  LevelSelect() {
    //danner knapperne, deres lokation-størrelse og hvad der står på dem.
    b[0] = new Button(1100, 100, 240, 90, "Menu");
    b[1] = new Button(1100, 240, 240, 90, "Restart");
    b[2] = new Button(140, 120, 100, 100, "1");
    b[3] = new Button(320, 120, 100, 100, "2");
    b[4] = new Button(500, 120, 100, 100, "3");
    b[5] = new Button(680, 120, 100, 100, "4");
  }
  //run funktionen for LevelSelect
  void run() {
    mouselistener();
    buttons();
  }
  //knapperne
  void buttons() {
    textSize(60); //størrelsen af teksten i knapperne
    noStroke();

    for (int i = 0; i < b.length; i++) {

      if (i == 0 || i == 1)buttoncolor = color(150, 200); //gør menuknappen normal farve

      //for 'levelselect' knapperne til at være grønne, hvis man er nået så langt, og røde er man det ikke.
      if (i > 1 && i-2 <= levelsCompleted) buttoncolor = color(0, 255, 0, 160);
      if (i > levelsCompleted + 2) buttoncolor = color(255, 0, 0, 160);

      //highlighter knapperne når musen er over dem
      if (b[i].mouseOverButton()) {
        if (i == 0 || i == 1) buttoncolor = color(150, 150);        
        if (i > 1 && i-2 <= levelsCompleted) buttoncolor = color(0, 255, 0, 110);

        //klik på kanpperne.
        if (mousePressed  && mousecheck == 1) {
          if (i == 0) menu = 1;
          if (i == 1) {
            levelsCompleted = 0;
            levelsCompletedData.setInt(0, "levelsCompleted", levelsCompleted);
            saveTable(levelsCompletedData, "data/levelsCompleted.csv");
          }
          if (i > 1 && i-2 <= levelsCompleted) level = i-1;
        }
      } 

      b[i].drawbutton(buttoncolor); // tegner knapperne
    }
  }
}
