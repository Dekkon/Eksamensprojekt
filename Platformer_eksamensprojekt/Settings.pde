class Settings extends Menu {
  Button[] b = new Button[2];

  PImage instruktion;

  Settings() {
    b[0] = new Button(1100, 100, 300, 90, "Klasse: " + klassetrin);
    b[1] = new Button(180, 100, 240, 90, "Menu");


    instruktion = loadImage("instruktion.PNG");
    instruktion.resize(1085, 615);
  }

  void run() {

    imageMode(CENTER);
    image(instruktion, width/2, height/2);

    buttons();
    mouselistener();
  }


  void buttons() {
    textSize(60);

    for (int i = 0; i < b.length; i++) {
      if (b[i].mouseOverButton()) {
        buttoncolor = color(150, 150);
        if (mousePressed) {
          if (i == 0 && mousecheck == 1) {
            if (klassetrin == 1)  klassetrin = 5;
            else if (klassetrin == 5) klassetrin = 9;
            else if (klassetrin == 9) klassetrin = 1;

            b[i].buttontext = "Klasse: " + klassetrin;
          }
          if (i == 1) menu = 1;
        }
      } else {
        buttoncolor = color(150, 200);
      }
      b[i].drawbutton(buttoncolor);
    }
     
  }
 
}
