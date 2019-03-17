class MathQuestions {

  String guess1 = "";
  String guess2 = "";
  int testguess[] = {-234, -234};
  int answer[] = new int [2];
  int redbox = 0;


  boolean keytogate = false;

  int nodoublepress;

  PVector keylocation;

  int[] guesscheck = {0, 0};


  int kl1tal[] = {int(random(2, 9)), int(random(2, 9)), int(random(10, 25)), int(random(10, 30))};

  int kl5tal[] = {int(random(3, 9)), int(random(10, 19))};

  float whichnumber = random(1);
  int kl9tal[] = {whichnumber>0.5 ? 8 : 5, whichnumber>0.5 ? 2 : 4, whichnumber>0.5 ? 40 : 10};


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


  void typeanswer(int wq) {

    nodoublepress --;


    if (keyPressed && nodoublepress < 0) {
      if (key == '1' || key == '2' || key == '3' || key == '4' || key == '5' || key == '6' || key == '7' || key == '8' || key == '9' || key == '0' || key == '-') {
        if (wq == 1 && guesscheck[0] != 1) guess1 = guess1 + key;
        if (wq == 2 && guesscheck[1] != 1) guess2 = guess2 + key;
      } 
      nodoublepress = 13; 
      if (keys[3]) {
        if (guess1.length() > 0 && wq == 1 && guesscheck[0] != 1) guess1 = guess1.substring(0, guess1.length()-1);
        if (guess2.length() > 0 && wq == 2 && guesscheck[1] != 1) guess2 = guess2.substring(0, guess2.length()-1);
      }
    }


    try {
      if (keyCode == ENTER) {
        if (wq == 1) testguess[0] = Integer.parseInt(guess1);
        if (wq == 2) testguess[1] = Integer.parseInt(guess2);
      }
    } 
    catch (Exception e) { // so the game doesn't crash if a non integer is written. i.e. '2-2'
      guesscheck[0] = 2;
      guess1 = guess1.substring(0, 0);
    }
  }

  void level1Question(int klasse) {

    klassetrin = klasse;

    // 1. klasse
    if (klassetrin == 1) {
      answer[0] = kl1tal[0] + kl1tal[1];
    }
    // 5. klasse
    if (klassetrin == 5) {
      answer[0] = kl5tal[0] * kl5tal[1];
    }
    // 9. klasse
    if (klassetrin == 9) {
      answer[0] = (kl9tal[2]-(kl9tal[0]*kl9tal[1]))/kl9tal[0];
    }


    if (testguess[0] == -234) guesscheck[0] = 0;
    if (testguess[0] != -234 && testguess[0] == answer[0]) {
      guesscheck[0] = 1;
    }
    if (testguess[0] != -234 && testguess[0] != answer[0]) {
      guesscheck[0] = 2;
      guess1 = guess1.substring(0, 0);
    }
  }
  void level2Question(int klasse) {

    klassetrin = klasse;
    // 1. klasse
    if (klassetrin == 1) {
      answer[0] = kl1tal[0] - kl1tal[1];
    }
    // 5. klasse
    if (klassetrin == 5) {
      answer[0] = kl5tal[0] * kl5tal[1];
    }
    // 9. klasse
    if (klassetrin == 9) {
      answer[0] = 0;
    }

    if (testguess[0] == -234) guesscheck[0] = 0;
    if (testguess[0] != -234 && testguess[0] == answer[0]) {
      guesscheck[0] = 1;
    }
    if (testguess[0] != -234 && testguess[0] != answer[0]) {
      guesscheck[0] = 2;
      guess1 = guess1.substring(0, 0);
    }


    /// question 2 
    if (klassetrin == 1) {
      answer[1] = kl1tal[2] + kl1tal[3];
    }
    // 5. klasse
    if (klassetrin == 5) {
      answer[1] = kl5tal[0] * kl5tal[1];
    }
    // 9. klasse
    if (klassetrin == 9) {
      answer[1] = (kl9tal[2]-(kl9tal[0]*kl9tal[1]))/kl9tal[0];
    }

     if (testguess[1] == -234) guesscheck[1] = 0;
     if (testguess[1] != -234 && testguess[1] == answer[1]) {
     guesscheck[1] = 1;
     }
     if (testguess[1] != -234 && testguess[1] != answer[1]) {
     guesscheck[1] = 2;
     guess2 = guess2.substring(0, 0);
     } 
  }
}
