class MainMenu extends Menu {

  Button[] b = new Button[2];

  color buttoncolor = color(150, 200);

  MainMenu() {
    b[0] = new Button(width/2, 180, 400, 120, "Levels");
    b[1] = new Button(width/2, 360, 400, 120, "Settings");
  }

  void run() {
    background(25); 

    buttons();
  }


  void buttons() {

    noStroke();
    textSize(90);

    for (int i = 0; i < b.length; i++) {
      if (b[i].overbutton()) {
        buttoncolor = color(150, 150);
        if (mousePressed) {
          if (i == 0) menu = 2;
          if (i == 1) menu = 3;
        }
      } else {
        buttoncolor = color(150, 200);
      }
      b[i].drawbutton(buttoncolor);
    }
  }
}
