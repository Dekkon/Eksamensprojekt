class MathQuestions {

  String guess1 = "";
  String guess2 = "";
  int testguess[] = {-234, -234};
  int answer[] = new int [2];
  int guesscheck[] = {0, 0};
  int redbox[] = {0, 0};

  int numberofwrongguesses[] = {0, 0};

  boolean keytogate = false;
  PVector keylocation;
  PImage keyimage;



  int lvl1tal[] = new int[4];
  int lvl2tal[] = new int[6];
  int lvl3tal[] = new int[6];
  int lvl4tal[] = new int[6];


  MathQuestions() {
    keyimage = loadImage("key.png");
    keyimage.resize(30, 15);

    switch(klassetrin) {
    case 1:
      //level 1
      lvl1tal[0] = int(random(2, 9)); 
      lvl1tal[1] = int(random(2, 9)); 
      lvl1tal[2] = int(random(10, 20)); 
      lvl1tal[3] = int(random(10, 30));
      //level 3
      lvl3tal[0] = int(random(2, 3));
      lvl3tal[1] = int(random(2, 9));
      lvl3tal[2] = int(random(40, 70));
      lvl3tal[3] = int(random(1, 6));
      //level 4
      lvl4tal[0] = int(random(1, 9));
      lvl4tal[1] = int(random(1, 9));
      lvl4tal[2] = int(random(1, 9));
      lvl4tal[3] = int(random(1, 9));
      lvl4tal[4] = int(random(1, 9));
      lvl4tal[5] = int(random(1, 9));
      break;
    case 5:
      //level 1
      lvl1tal[0]= int(random(3, 9)); 
      lvl1tal[1] = int(random(10, 19));
      //level 2
      lvl2tal[0] = int(random(111, 222)); 
      lvl2tal[1] = int(random(111, 222)); 
      lvl2tal[2] = int(random(2, 7)); 
      lvl2tal[3] = int(random(5, 9)); 
      lvl2tal[4] = int(random(2, 9));
      //level 3
      lvl3tal[0] = int(random(2, 4.4));
      lvl3tal[1] = 12;
      lvl3tal[2] = int(random(3, 6.4));
      lvl3tal[3] = 60;
      //level 4
      lvl4tal[0] = int(random(20, 40));
      lvl4tal[1] = int(random(50, 70));
      lvl4tal[2] = int(random(2, 9));
      lvl4tal[3] = int(random(21, 44));
      break;
    case 9:
      float whichnum = random(1);
      //level 1
      lvl1tal[0] = whichnum > 0.5 ? 8 : 5; 
      lvl1tal[1] = whichnum>0.5 ? 2 : 4 ; 
      lvl1tal[2] = whichnum>0.5 ? 40 : 10;
      //level 2
      lvl2tal[0] = whichnum > 0.5 ? 6 : 5;
      lvl2tal[1] = whichnum > 0.5 ? 3 : 2;
      lvl2tal[2] = whichnum > 0.5 ? 8 : 4;
      lvl2tal[3] = whichnum > 0.5 ? 16 : 8;
      lvl2tal[4] = random(1)>0.5 ? 4 : 16;
      lvl2tal[5] = random(1)>0.5 ? 9 : 25;
      //level 3
      lvl3tal[0] = whichnum > 0.5 ? 3 : 4;
      lvl3tal[1] = whichnum > 0.5 ? 3 : 1;
      lvl3tal[2] = 2;
      lvl3tal[3] = whichnum > 0.5 ? 4 : 5;
      lvl3tal[4] = random(1) > 0.5 ? 25 : 16;
      lvl3tal[5] = random(1) > 0.5 ? 36 : 9;
      //level 4
      lvl4tal[0] = int(random(222, 999));
      lvl4tal[1] = int(random(222, 999));
      lvl4tal[2] = int(random(11, 19));
      lvl4tal[3] = int(random(31, 59));      
      break;
    }
  }


  void display() {
    //the key
    noStroke();
    fill(255);
    imageMode(CENTER);
    noTint();
    image(keyimage, keylocation.x, keylocation.y);
  }

  void keySeekLocation(PVector target) {
    PVector distance = PVector.sub(target, keylocation);
    PVector desired = PVector.sub(target, keylocation);

    desired.setMag(2);

    if (distance.mag() > 3) {
      keylocation.add(desired);
    }
    if (distance.mag() < 3) keytogate = true;
  }


  void typeanswer(int wq) {
    if (keyPressed) {
      if (key == '1' || key == '2' || key == '3' || key == '4' || key == '5' || key == '6' || key == '7' || key == '8' || key == '9' || key == '0' || key == '-') {
        if (wq == 1 && guesscheck[0] != 1) guess1 = guess1 + key;
        if (wq == 2 && guesscheck[1] != 1) guess2 = guess2 + key;
      } 
      if (keys[3]) {
        if (guess1.length() > 0 && wq == 1 && guesscheck[0] != 1) guess1 = guess1.substring(0, guess1.length()-1);
        if (guess2.length() > 0 && wq == 2 && guesscheck[1] != 1) guess2 = guess2.substring(0, guess2.length()-1);
      }
    }

    // so the game doesn't crash if a non integer is written. i.e. '2-2'
    try { 
      if (keyCode == ENTER) {
        if (wq == 1) testguess[0] = Integer.parseInt(guess1);
        if (wq == 2) testguess[1] = Integer.parseInt(guess2);
      }
    } 
    catch (Exception e) { // still records such an answer as an incorrect answer
      if (wq == 1) {
        guesscheck[0] = 2;
        guess1 = guess1.substring(0, 0);
      }
      if (wq == 2) {
        guesscheck[1] = 2;
        guess2 = guess2.substring(0, 0);
      }
    }
  }

  void wronganswerbox(int x, int y, int answernumber) {
    redbox[answernumber]--;
    if (guesscheck[answernumber] == 2) {


      if (answernumber == 0) numberofwrongguesses[0] ++;
      if (answernumber == 1) numberofwrongguesses[1] ++;



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

  void questions(int currentlevel) {

    // question 1

    // 1. klasse
    if (klassetrin == 1) {
      if (currentlevel == 1) answer[0] = lvl1tal[0] + lvl1tal[1];
      if (currentlevel == 2) answer[0] = lvl1tal[0] - lvl1tal[1];
      if (currentlevel == 3) answer[0] = lvl3tal[0] * lvl3tal[1];
      if (currentlevel == 4) answer[0] = lvl4tal[0] + lvl4tal[1] + lvl4tal[2];
    }
    // 5. klasse
    if (klassetrin == 5) {
      if (currentlevel == 1) answer[0] = lvl1tal[0] * lvl1tal[1];
      if (currentlevel == 2) answer[0] = lvl2tal[0] + lvl2tal[1];
      if (currentlevel == 3) answer[0] = lvl3tal[1] / lvl3tal[0];
      if (currentlevel == 4) answer[0] = lvl4tal[0] - lvl4tal[1];
    }
    // 9. klasse
    if (klassetrin == 9) {
      if (currentlevel == 1) answer[0] = (lvl1tal[2] - lvl1tal[0] * lvl1tal[1]) / lvl1tal[0];
      if (currentlevel == 2) answer[0] = (lvl2tal[2] + lvl2tal[3]) / (lvl2tal[0] - lvl2tal[1]);
      if (currentlevel == 3) answer[0] = (lvl3tal[2] * lvl3tal[3] - lvl3tal[0] * lvl3tal[1]) / (lvl3tal[0] - lvl3tal[2]) ;
      if (currentlevel == 4) answer[0] = lvl4tal[0] + lvl4tal[1];
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
      if (currentlevel == 2) answer[1] = lvl1tal[2] + lvl1tal[3];
      if (currentlevel == 3) answer[1] = lvl3tal[2] + lvl3tal[3];
      if (currentlevel == 4) answer[1] = lvl4tal[3] + lvl4tal[4] - lvl4tal[5];
    }
    // 5. klasse
    if (klassetrin == 5) {
      if (currentlevel == 1);
      if (currentlevel == 2) answer[1] = lvl2tal[2] + lvl2tal[3] * lvl2tal[4];
      if (currentlevel == 3) answer[1] = lvl3tal[3] / lvl3tal[2];
      if (currentlevel == 4) answer[1] = lvl4tal[2] * lvl4tal[3];
    }
    // 9. klasse
    if (klassetrin == 9) {
      if (currentlevel == 2) answer[1] = int(sqrt(lvl2tal[4])) + int(sqrt(lvl2tal[5]));
      if (currentlevel == 3) answer[1] = int(sqrt(lvl3tal[4])) - int(sqrt(lvl3tal[5]));
      if (currentlevel == 4) answer[1] = lvl4tal[2] * lvl4tal[3];
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
