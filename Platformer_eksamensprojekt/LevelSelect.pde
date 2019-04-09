class LevelSelect extends Menu {
  Button[] b = new Button[5];

  color buttoncolor;

  LevelSelect() {
    menu = 0;

    b[0] = new Button(1100, 100, 240, 90, "Menu");
    b[1] = new Button(140, 120, 100, 100, "1");
    b[2] = new Button(320, 120, 100, 100, "2");
    b[3] = new Button(500, 120, 100, 100, "3");
    b[4] = new Button(680, 120, 100, 100, "4");
  }

  void run() {
    println(levelsCompleted);
    buttons();
  }

  void buttons() {
    textSize(60);
    noStroke();

    for (int i = 0; i < b.length; i++) {

      if (i == 0)buttoncolor = color(150, 200);
      if (i > 0 && i-1 <= levelsCompleted) buttoncolor = color(0, 255, 0, 160);
      if (i-1 > levelsCompleted) buttoncolor = color(255, 0, 0, 160);

      if (b[i].overbutton()) {
        if (i == 0) buttoncolor = color(150, 150);
        if (i > 0 && i-1 <= levelsCompleted) buttoncolor = color(0, 255, 0, 110);

        if (mousePressed) {
          if (i == 0) menu = 1;
          if (i > 0 && i-1 <= levelsCompleted) level = i;
        }
      } 

      b[i].drawbutton(buttoncolor);
    }
  }
}
