class MainMenu extends Menu {

  Button[] b = new Button[3]; //danner array med knaper

  MainMenu() {
    //danner knapperne, deres lokation-størrelse og hvad der står på dem.
    b[0] = new Button(width/2, 180, 400, 120, "Levels");
    b[1] = new Button(width/2, 360, 400, 120, "Settings");
    b[2] = new Button(width/2, 540, 400, 120, "Data");
    buttoncolor = color(150, 200); //farven af knapperne
  }

  void run() {
    background(25);     
    mouselistener();
    buttons();
  }

  void buttons() {
    noStroke();
    textSize(90); //størrelsen af teksten

    for (int i = 0; i < b.length; i++) {
      if (b[i].mouseOverButton()) {
        buttoncolor = color(150, 150); //når musen holdes over knappen ændres farven
        if (mousePressed && mousecheck == 1) { // når man klikker knappen
          if (i == 0) menu = 2; //klikkes på knap 1, føres man til LevelSelect
          if (i == 1) menu = 3; //på kan 2, føres man til settings
          if (i == 2) menu = 4; //på knap 3 føres man til data.
        }
      } else {
        buttoncolor = color(150, 200);
      }
      b[i].drawbutton(buttoncolor); //tegner knapperne
    }
  }
}
