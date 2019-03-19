class MainMenu extends Menu {

  MainMenu() {
  }

  void run() {
    background(25); 

    buttons();
  }


  void buttons() {

    rectMode(CENTER);
    textAlign(CENTER, CENTER);
    textSize(90);


    fill(150, 200);
    if (mouseX > width/2-100*2 && mouseX < width/2+100*2 && mouseY < 120*2 && mouseY > 60*2) fill(150, 150);
    rect(width/2, 90*2, 200*2, 60*2);
    fill(0, 255, 0);
    text("Levels", width/2, 90*2);
    if (mousePressed && mouseX > width/2-100*2 && mouseX < width/2+100*2 && mouseY < 120*2 && mouseY > 60*2) menu = 2;

    // tegner firkant, og skriver tekst, hvor man kan klikke hvilket fører en til  menuen
    fill(150, 200);
    if (mouseX > width/2-100*2 && mouseX < width/2+100*2 && mouseY < 210*2 && mouseY > 150*2) fill(150, 150);
    rect(width/2, 180*2, 200*2, 60*2);
    fill(0, 255, 0);
    //   text("", width/2, 180*2);
    // if (mousePressed && mouseX > width/2-100*2 && mouseX < width/2+100*2 && mouseY < 210*2 && mouseY > 150*2) ;

    // fill(150, 200);
    // if (mouseX > width/2-100*2 && mouseX < width/2+100*2 && mouseY < 300*2 && mouseY > 240*2) fill(150, 150);
    // rect(width/2, 270*2, 200*2, 60*2);
    // fill(0, 255, 0);
    // text("", width/2, 270*2);
    // if (mousePressed && mouseX > width/2-100*2 && mouseX < width/2+100*2 && mouseY < 300*2 && mouseY > 240*2 && holdon == 0) ;
  }
}
