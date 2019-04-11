class Level extends Game {
  Player p;
  PVector spawnlocation;
  MathQuestions mq;

  ArrayList<Line> lines = new ArrayList<Line>();

  PImage pausebutton; //pauseknappen billede
  PImage startbutton; //startknappens billede
  PImage finishline;  //finishline billede

  PImage baggrundsbillede;

  int currentlevel;

  boolean levelisComplete = false;
  boolean pause = false;
  boolean dead = false;

  String question1;
  String question2;

  String writeguess1;
  String writeguess2;

  float radius = 17.5;
  boolean onPlatform = false; //boolean to check whether or not player is currently on a platform

  Button[] b = new Button[3];
  color buttoncolor;

  Level() {
    mq = new MathQuestions();
    pausebutton = loadImage("pauseButton.png");
    startbutton = loadImage("startButton.png");
    finishline = loadImage("finishicon.png");
    finishline.resize(100, 55);

    baggrundsbillede = loadImage("baggrundsbillede2.png");
    baggrundsbillede.resize(width, height);


    b[0] = new Button(width/2, 245, 200, 70, "resume");
    b[1] = new Button(width/2, 365, 200, 70, "settings");
    b[2] = new Button(width/2, 485, 200, 70, "exit");
  }

  void backgroundimage() {
    imageMode(CORNER);
    image(baggrundsbillede, 0, 0);
  }

  void stage() {

    strokeWeight(3);
    for (Line l : lines) {
      stroke(0, 255, 0);

      if (currentlevel == 1 && l.wallType == "gate") stroke(0, 0, 255);
      if (currentlevel == 2 && l.wallType == "elevator") stroke(0, 0, 255);
      if (currentlevel == 3 && l.wallType == "movingfloor") stroke(0, 0, 255);

      if (l.wallType == "activatefloor") {
        if (mq.guesscheck[1] != 1) stroke(0, 0, 255, 50);
        if (mq.guesscheck[1] == 1) stroke(0, 0, 255);
      }

      line(l.x1, l.y1, l.x2, l.y2);
    }
  }

  void collision() {

    for (Line l : lines) {
      // collision with floors
      if (l.wallType == "floor" || l.wallType == "elevator" || l.wallType == "movingfloor" || l.wallType == "activatefloor" && mq.guesscheck[1] == 1) {
        if (p.location.x > l.x1 - radius+1 && p.location.x < l.x2 + radius && p.location.y >= l.y1 -radius && p.location.y <= l.y1 -radius+30 && p.speed.y > 0) {
          p.location.y = l.y1-radius;
          onPlatform = true; 
          if (l.wallType == "movingfloor") p.location.x += l.mfspeed;
        }
      }
      // collision with roofs
      if (l.wallType == "roof" && p.location.x > l.x1 - radius+1 && p.location.x < l.x2 + radius-1 && p.location.y < l.y1 + radius && p.location.y > l.y1 + radius - 20 && p.speed.y < 0) {
        p.location.y = l.y1 + radius; 
        p.speed.y = 0;
      }
      // collision with walls to the left of the player
      if (l.wallType == "leftwall" && p.location.x < l.x1 + radius && p.location.x > l.x1 + radius - 30 && p.location.y > l.y2 && p.location.y < l.y1) p.location.x = l.x1 + radius;
      // collision with walls to the right of the player
      if (l.wallType == "rightwall" || l.wallType == "gate") { 
        if (p.location.x > l.x2-radius && p.location.x < l.x1-radius+30 && p.location.y > l.y2 && p.location.y < l.y1) p.location.x = l.x1 - radius;
      }
      // collision with tilted lines
      if (l.wallType == "tline" && p.location.x > l.x1  - radius+1 && p.location.x < l.x2 + radius-1 && p.location.y >= 500 - radius + (p.location.x-l.x1) * l.angle && p.location.y <= 15 + 500 - radius + (p.location.x-l.x1) * l.angle) {
        p.location.y = 500 - radius + (p.location.x-l.x1) * l.angle;
        onPlatform = true;
        p.speed.x +=1;
      }
    }

    if (onPlatform) p.speed.y = 0;
  }

  void blueBox(int x, int y, int wx, int wy) {
    rectMode(CORNER);  
    noStroke();
    fill(0, 0, 255, 120);
    rect(x, y, wx, wy);
  }

  void mathQuestion(int x1, int y1, int questionnum) {
    rectMode(CENTER);
    fill(0, 0, 255);
    stroke(0, 0, 255);
    rect(x1, y1, 155, 50);

    textSize(17);
    textAlign(CENTER);
    fill(255);

    if (questionnum == 1) text(question1, x1, y1+5);
    if (questionnum == 2) text(question2, x1, y1+5);

    if (mq.guesscheck[questionnum-1] == 1) fill(0, 255, 0);

    if (questionnum == 1) text(writeguess1 + mq.guess1, x1, y1+45);
    if (questionnum == 2) text(writeguess2 + mq.guess2, x1, y1+45);

    mq.wronganswerbox(x1, y1+43, questionnum-1);
  }

  void typeanswer(int wq) {
    mq.typeanswer(wq);
  }

  void playermovement() {

    // key presses
    if (keyPressed) {
      if (keys[0]) p.speed.x -= 4;
    }
    if (keyPressed) {
      if (keys[1]) p.speed.x += 4;
    }
    if (keyPressed) { //can only jump while on a platform
      if (keys[2] && onPlatform) {   
        p.speed.y = -12;
      }
    }

    onPlatform = false;
  }

  void levelComplete() {
    background(0, 255, 0);

    textSize(50);
    textAlign(CENTER, CENTER);
    fill(25);

    text("Level " + currentlevel + " Complete", width/2, height/2);

    textSize(35);
    text("Press space to continue", width/2, height/2+50);

    if (key == ' ') level = currentlevel + 1;

    if (currentlevel > levelsCompleted) {
      levelsCompleted = currentlevel;
      newRow.setInt("levelsCompleted", levelsCompleted);
      saveTable(levelsCompletedtable, "data/levelsCompleted.csv");
    }
    
    newDataRow.setInt("id", 0);
    
    switch(currentlevel) {
    case 1:
      newDataRow.setInt("question1", mq.numberofwrongguesses[0]);
      break;
    case 2:
      newDataRow.setInt("question2", mq.numberofwrongguesses[0]);
      newDataRow.setInt("question3", mq.numberofwrongguesses[1]);
      break;
    case 3:
      newDataRow.setInt("question4", mq.numberofwrongguesses[0]);
      newDataRow.setInt("question5", mq.numberofwrongguesses[1]);
      break;
    case 4:
      newDataRow.setInt("question6", mq.numberofwrongguesses[0]);
      newDataRow.setInt("question7", mq.numberofwrongguesses[1]);
      break;
    }

    saveTable(answerData, "data/answerData.csv");
  }

  void respawn() {

    if (dead) {
      p.location.x = spawnlocation.x;
      p.location.y = spawnlocation.y;
      p.speed.y = 0;
      dead = false;
    }

    if (p.location.y > height) {
      dead = true;
    }
  }

  void pauseGame() {

    if (keyPressed && key == 'p' || key == 'P') pause = true;

    if (mouseX < 1220 + 24 && mouseX > 1220 - 24 && mouseY < 70 + 39 && mouseY > 70 - 39) {
      ellipse(1220, 70, 35, 35);
    }
    wait --;
    if (mousePressed && mouseX < 1220 + 24 && mouseX > 1220 - 24 && mouseY < 70 + 39 && mouseY > 70 - 39 && wait < 0) {
      pause = !pause;
      wait = 15;
    }

    imageMode(CENTER);
    if (!pause) image(pausebutton, 1220, 70);

    if (pause) image(startbutton, 1220, 70);
  }

  void inGameMenu() {
    textSize(40);
    noStroke();

    rectMode(CENTER);
    fill(0, 230);
    noStroke();
    rect(width/2, height/2, 300, 380);

    for (int i = 0; i < b.length; i++) {
      if (b[i].overbutton()) {
        buttoncolor = color(150, 150);
        if (mousePressed) {
          if (i == 0) pause = false;
          if (i == 1);
          if (i == 2) menu = 1;
        }
      } else {
        buttoncolor = color(150, 200);
      }
      b[i].drawbutton(buttoncolor);
    }
  }

  void finishline(int x, int y) {
    imageMode(CORNER);
    noTint();
    image(finishline, x, y);
  }
}
