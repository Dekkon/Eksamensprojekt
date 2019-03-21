class Settings extends Menu {


  Settings() {
  }

  void run() {

    buttons();

    wait --;
  }


  void buttons() {
    textSize(60);
    rectMode(CENTER);
    textAlign(CENTER, CENTER);

    // vælg klasse button
    fill(150);
    if (mouseX > 920 && mouseX < 1280 && mouseY < 145 && mouseY > 55) fill(150, 150);
    rect(1100, 100, 300, 90);
    fill(255);
    text("klasse: " + klassetrin, 1100, 95);
    if (mousePressed && mouseX > 920 && mouseX < 1280 && mouseY < 145 && mouseY > 55 && wait < 0) {
      if (klassetrin == 1)  klassetrin = 5;
      else if (klassetrin == 5) klassetrin = 9;
      else if (klassetrin == 9) klassetrin = 1;

      wait = 15;
    }


    //return to menu button


    fill(150);
    if (mouseX > 60 && mouseX < 300 && mouseY < 145 && mouseY > 55) fill(150, 150);
    rect(180, 100, 240, 90);
    fill(255);
    text("Menu", 180, 95);
    if (mousePressed && mouseX > 60 && mouseX < 300 && mouseY < 145 && mouseY > 55) menu = 1;
  }
}
