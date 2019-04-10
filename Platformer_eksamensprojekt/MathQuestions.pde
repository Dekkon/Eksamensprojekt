class MathQuestions {

  String guess1 = "";
  String guess2 = "";
  float testguess[] = {-234, -234};
  int answer[] = new int [2];
  int redbox[] = {0, 0};


  boolean keytogate = false;
  PVector keylocation;
  PImage keyimage;


  int nodoublepress;

  int[] guesscheck = {0, 0};


  int kl1lvl1tal[] = {int(random(2, 9)), int(random(2, 9)), int(random(10, 25)), int(random(10, 30))};

  int kl1lvl3tal[] = {int(random(2, 3)), int(random(2, 9)), int(random(40, 70)), int(random(1, 6))};
  
  int kl1lvl4tal[] = {int(random(1, 9)), int(random(1, 9)), int(random(1,9)), int(random(1, 9)), int(random(1, 9)), int(random(1,9))};

  int kl5lvl1tal[] = {int(random(3, 9)), int(random(10, 19))};
  int kl5lvl2tal[] = {int(random(111, 222)), int(random(111, 222)), int(random(2, 7)), int(random(5, 9)), int(random(2, 9))};  
  int kl5lvl3tal[] = {int(random(2, 4.4)), 12, int(random(3, 6.4)), 60};
  int kl5lvl4tal[] = {int(random(20, 40)), int(random(50, 70)), int(random(2, 9)), int(random(21,44))};

  float whichnum = random(1);
  int kl9lvl1tal[] = {whichnum > 0.5 ? 8 : 5, whichnum>0.5 ? 2 : 4, whichnum>0.5 ? 40 : 10};
  int kl9lvl2tal[] = {whichnum > 0.5 ? 6 : 5, whichnum > 0.5 ? 3 : 2, whichnum > 0.5 ? 8 : 4, whichnum > 0.5 ? 16 : 8, random(1)>0.5 ? 4 : 16, random(1)>0.5 ? 9 : 25 };
  int kl9lvl3tal[] = {whichnum > 0.5 ? 3 : 4, whichnum > 0.5 ? 3 : 1, whichnum > 0.5 ? 2 : 2, whichnum > 0.5 ? 4 : 5, random(1) > 0.5 ? 25 : 16, random(1) > 0.5 ? 36 : 9};
  int kl9lvl4tal[] = {int(random(222, 999)), int(random(222, 999)), int(random(11, 19)), int(random(31, 59))};

  int klassetrin;

  MathQuestions() {
    keyimage = loadImage("key.png");
    keyimage.resize(30, 15);
  }


  void display() {
    //the key
    noStroke();
    fill(255);
    imageMode(CENTER);
    noTint();
    image(keyimage, keylocation.x, keylocation.y);
  }

  void seekKeyhole(PVector target) {
    PVector distance = PVector.sub(target, keylocation);
    PVector desired = PVector.sub(target, keylocation);

    desired.setMag(2);

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
        if (wq == 1) testguess[0] = Float.parseFloat(guess1);
        if (wq == 2) testguess[1] = Float.parseFloat(guess2);
      }
    } 
    catch (Exception e) { // so the game doesn't crash if a non integer is written. i.e. '2-2'
      guesscheck[0] = 2;
      guess1 = guess1.substring(0, 0);
      
      guesscheck[1] = 2;
      guess2 = guess2.substring(0, 0);
    }
  }
  
  void wronganswerbox(int x, int y, int answernumber) {
    redbox[answernumber]--;
    if (guesscheck[answernumber] == 2) {
     // numberofwrongguesses ++;
      testguess[answernumber] = -234;
      guesscheck[answernumber] = 0;

      redbox[answernumber] = 30;
    }
    if (redbox[answernumber] > 0) {
      fill(255, 0, 0);
      noStroke();
      rectMode(CENTER);
      rect(x, y, 60, 20);
    }
    
  }

  void questions(int klasse, int currentlevel) {

    klassetrin = klasse;
    
    // question 1
    
    // 1. klasse
    if (klassetrin == 1) {
      if (currentlevel == 1) answer[0] = kl1lvl1tal[0] + kl1lvl1tal[1];
      if (currentlevel == 2) answer[0] = kl1lvl1tal[0] - kl1lvl1tal[1];
      if (currentlevel == 3) answer[0] = kl1lvl3tal[0] * kl1lvl3tal[1];
      if (currentlevel == 4) answer[0] = kl1lvl4tal[0] + kl1lvl4tal[1] + kl1lvl4tal[2];
    }
    // 5. klasse
    if (klassetrin == 5) {
      if (currentlevel == 1) answer[0] = kl5lvl1tal[0] * kl5lvl1tal[1];
      if (currentlevel == 2) answer[0] = kl5lvl2tal[0] + kl5lvl2tal[1];
      if (currentlevel == 3) answer[0] = kl5lvl3tal[1] / kl5lvl3tal[0];
      if (currentlevel == 4) answer[0] = kl5lvl4tal[0] - kl5lvl4tal[1];
    }
    // 9. klasse
    if (klassetrin == 9) {
      if (currentlevel == 1) answer[0] = (kl9lvl1tal[2] - kl9lvl1tal[0] * kl9lvl1tal[1]) / kl9lvl1tal[0];
      if (currentlevel == 2) answer[0] = (kl9lvl2tal[2] + kl9lvl2tal[3]) / (kl9lvl2tal[0] - kl9lvl2tal[1]);
      if (currentlevel == 3) answer[0] = (kl9lvl3tal[2] * kl9lvl3tal[3] - kl9lvl3tal[0] * kl9lvl3tal[1]) / (kl9lvl3tal[0] - kl9lvl3tal[2]) ;
      if (currentlevel == 4) answer[0] = kl9lvl4tal[0] + kl9lvl4tal[1];
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
      if (currentlevel == 1);
      if (currentlevel == 2) answer[1] = kl1lvl1tal[2] + kl1lvl1tal[3];
      if (currentlevel == 3) answer[1] = kl1lvl3tal[2] + kl1lvl3tal[3];
      if (currentlevel == 4) answer[1] = kl1lvl4tal[3] + kl1lvl4tal[4] - kl1lvl4tal[5];
    }
    // 5. klasse
    if (klassetrin == 5) {
      if (currentlevel == 1);
      if (currentlevel == 2) answer[1] = kl5lvl2tal[2] + kl5lvl2tal[3] * kl5lvl2tal[4];
      if (currentlevel == 3) answer[1] = kl5lvl3tal[3] / kl5lvl3tal[2];
      if (currentlevel == 4) answer[1] = kl5lvl4tal[2] * kl5lvl4tal[3];
    }
    // 9. klasse
    if (klassetrin == 9) {
      if (currentlevel == 2) answer[1] = int(sqrt(kl9lvl2tal[4])) + int(sqrt(kl9lvl2tal[5]));
      if (currentlevel == 3) answer[1] = int(sqrt(kl9lvl3tal[4])) - int(sqrt(kl9lvl3tal[5]));
      if (currentlevel == 4) answer[1] = kl9lvl4tal[2] * kl9lvl4tal[3];
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
