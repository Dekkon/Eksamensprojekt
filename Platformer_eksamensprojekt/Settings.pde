class Settings extends Menu {
  Button[] b = new Button[2]; //danner array med knaper

  PImage instruktion; // billede med instruktioner

  Settings() {
    //initialisere knapperne, deres lokation-størrelse og hvad der står på dem.
    b[0] = new Button(1100, 100, 300, 90, "Klasse: " + klassetrin);
    b[1] = new Button(180, 100, 240, 90, "Menu");

    instruktion = loadImage("instruktion.PNG");
    instruktion.resize(1085, 615);
  }  
  //runfunktion for settingsklassen
  void run() {
    imageMode(CENTER);
    image(instruktion, width/2, height/2); //viser instruktionsbillede

    buttons();
    mouselistener();
  }

  void buttons() {
    textSize(60); //størelsen af teksten

    for (int i = 0; i < b.length; i++) {
      if (b[i].mouseOverButton()) {
        buttoncolor = color(150, 150); //farven når musen er over knapperne
        if (mousePressed  && mousecheck == 1) {  //klik på knapperne
          if (i == 0) { // ved knap en, sp kan man ændre klassetrin
            if (klassetrin == 1)  klassetrin = 5;
            else if (klassetrin == 5) klassetrin = 9;
            else if (klassetrin == 9) klassetrin = 1;

            b[i].buttontext = "Klasse: " + klassetrin;
          }
          if (i == 1) menu = 1; //knap 2 fører en til hovedmenuen.
        }
      } else {
        buttoncolor = color(150, 200); //farven når musen ikke er over knapperne
      }
      b[i].drawbutton(buttoncolor); //tegner knap
    }
     
  }
 
}
