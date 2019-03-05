class LevelSelect extends Menu {

  LevelSelect() {
    menu = 0;
  }

  void run() {

    buttons();
  }

  void buttons() {

    rectMode(CORNER);
    textSize(60);

    // level 1 button
    fill(0, 255, 0, 160);
    if (mouseX > 90 && mouseX < 190 && mouseY < 170 && mouseY > 70) fill(0, 210, 0, 110);
    rect(90, 70, 100, 100);
    fill(255);
    text("1", 140, 120); 
    if (mousePressed && mouseX > 90 && mouseX < 190 && mouseY < 170 && mouseY > 70) level = 1;

    // level 2 button
    if (levelsCompleted >= 1) fill(0, 255, 0, 160);
    if (levelsCompleted < 1) fill(255, 0, 0, 160);
    if (levelsCompleted >= 1 && mouseX > 280 && mouseX < 380 && mouseY < 170 && mouseY > 70) fill(0, 210, 0, 110);
    rect(280, 70, 100, 100);
    fill(255);
    text("2", 330, 120); 
    if (levelsCompleted >= 1 && mousePressed && mouseX > 280 && mouseX < 380 && mouseY < 170 && mouseY > 70) level = 2;
  }
}
