class MathQuestions {

  String guess = "";
  int testguess;
  int answer;
  
  boolean keytogate = false;

  int nodoublepress;

  PVector keylocation;

  int guesscheck = 0;

  MathQuestions() {
    keylocation = new PVector(130, 50);
  }


  void display() {

    fill(150);
    stroke(150);
    rect(20, 20, 100, 50);

    textSize(20);
    textAlign(CENTER);
    fill(255);
    text("2+2", 70, 50);

    text("= " +guess, 70, 95);



    //the key
    ellipse(keylocation.x, keylocation.y, 10, 10);
  }

  void seekKeyhole(PVector target) {
    PVector distance = PVector.sub(target, keylocation);
    PVector desired = PVector.sub(target, keylocation);


    desired.setMag(1);

    if (distance.mag() > 3) {
      keylocation.add(desired);
    }
    if (distance.mag() < 3) keytogate = true;
  }


  void typeanswer() {

    nodoublepress --;


    if (keyPressed && nodoublepress < 0) {
      if (key == '1' || key == '2' || key == '3' || key == '4' || key == '5' || key == '6' || key == '7' || key == '8' || key == '9' || key == '0') {
        guess = guess + key;
      } 
      nodoublepress = 13; 
      if (keys[3] && guess.length() > 0) {
        guess = guess.substring(0, guess.length()-1);
      }
    }


    if (keyCode == ENTER) {

      testguess = Integer.parseInt(guess);
    }
  }

  void question() {

    answer = 4;

    if (testguess != 0 && testguess == answer) {
      guesscheck = 1;
    }
    if (testguess != 0 && testguess != answer) {
      guesscheck = 2;
    }
  }
}
