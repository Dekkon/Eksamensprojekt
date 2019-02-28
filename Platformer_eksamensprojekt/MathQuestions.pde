class MathQuestions {

  String guess = "";
  int testguess = -234;
  int answer;
  int redbox = 0;


  boolean keytogate = false;

  int nodoublepress;

  PVector keylocation;

  int guesscheck;

  int kl1tal1 = int(random(2, 9));
  int kl1tal2 = int(random(2, 9));

  int kl5tal1 = int(random(3, 9));
  int kl5tal2 = int(random(10, 19));

  float whichnumber = random(1);
  int kl9tal1 =  whichnumber>0.5 ? 8 : 5 ;
  int kl9tal2 = whichnumber>0.5 ? 2 : 4;
  int kl9tal3 = whichnumber>0.5 ? 40 : 10;

  int klassetrin;

  MathQuestions() {
  }


  void display() {


    //the key
    noStroke();
    fill(255);
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

    if (guesscheck != 1) {
      if (keyPressed && nodoublepress < 0) {
        if (key == '1' || key == '2' || key == '3' || key == '4' || key == '5' || key == '6' || key == '7' || key == '8' || key == '9' || key == '0' || key == '-') {
          guess = guess + key;
        } 
        nodoublepress = 13; 
        if (keys[3] && guess.length() > 0) {
          guess = guess.substring(0, guess.length()-1);
        }
      }
    }

    try {
      // Code here
      if (keyCode == ENTER) {
        testguess = Integer.parseInt(guess);
      }
    } 
    catch (Exception e) { // so the game doesn't crash if a non integer is written. i.e. '2-2'
    }
  }

  void level1Question(int klasse) {

    klassetrin = klasse;

    // 1. klasse
    if (klassetrin == 1) {
      answer = kl1tal1 + kl1tal2;
    }
    // 5. klasse
    if (klassetrin == 5) {
      answer = kl5tal1 * kl5tal2;
    }
    // 9. klasse
    if (klassetrin == 9) {
      answer = (kl9tal3-(kl9tal1*kl9tal2))/kl9tal1;
    }


    if (testguess == -234) guesscheck = 0;
    if (testguess != -234 && testguess == answer) {
      guesscheck = 1;
    }
    if (testguess != -234 && testguess != answer) {
      guesscheck = 2;
      guess = guess.substring(0, 0);
    }
  }
}
