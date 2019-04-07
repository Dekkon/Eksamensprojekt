class Level2 extends Level {


  Level2() {
    currentlevel = 2;
    spawnlocation = new PVector(30, 600);
    p = new Player(spawnlocation.x, spawnlocation.y, radius);

    lines();
  }

  void run() {

    collision();
    stage();
    elevator();
    movingFloors();

    mathQuestion();
    if (p.location.x > 1100) mq.typeanswer(1);
    if (p.location.x < 200 && p.location.y < 550) mq.typeanswer(2);
    mq.level2Question(klassetrin);

    playermovement();
    p.update();
    p.display();

    respawn();

    pauseGame();
    if (pause) inGameMenu();

    if (p.location.x > width) levelisComplete = true;
    if (levelisComplete)levelComplete();
  } 


  void mathQuestion() {
    fill(0, 0, 255);
    stroke(0, 0, 255);
    rectMode(CORNER);

    //question 1
    rect(1140, 360, 140, 50);

    textSize(20);
    textAlign(CENTER);
    fill(255);
    if (klassetrin == 1) text(mq.kl1lvl1tal[0] + " - " + mq.kl1lvl1tal[1], 1210, 390);
    if (klassetrin == 5) text(mq.kl5lvl2tal[0] + " + " + mq.kl5lvl2tal[1], 1210, 390);
    if (klassetrin == 9) text(mq.kl9lvl2tal[0] + "min, " + mq.kl9lvl2tal[1] + " sek.", 1210, 390);

    if (mq.guesscheck[0] == 1) fill(0, 255, 0);
    if (klassetrin == 1 || klassetrin == 5) text("= " +mq.guess1, 1210, 435);
    if (klassetrin == 9) text("= " + mq.guess1 + "  sek.", 1210, 435);

    mq.redbox--;
    if (mq.guesscheck[0] == 2) {
      // numberofwrongguesses ++;
      mq.testguess[0] = -234;
      mq.guesscheck[0] = 0;

      mq.redbox = 30;
    }
    if (mq.redbox > 0) {
      fill(255, 0, 0);
      noStroke();
      rectMode(CENTER);
      rect(1210, 435, 60, 20);
    }

    //question 2
    rectMode(CORNER);
    fill(0, 0, 255);
    rect(2, 200, 140, 50);

    textSize(20);
    textAlign(CENTER);
    fill(255);
    if (klassetrin == 1) text(mq.kl1lvl1tal[2] + " + " + mq.kl1lvl1tal[3], 72, 230);
    if (klassetrin == 5) text(mq.kl5lvl2tal[2] + " + " + mq.kl5lvl2tal[3] + " * " + mq.kl5lvl2tal[4], 72, 230);
    if (klassetrin == 9) text("√" + mq.kl9lvl2tal[2] + " + √" + mq.kl9lvl2tal[3], 72, 230);

    if (mq.guesscheck[1] == 1) fill(0, 255, 0);
    if (klassetrin == 1 || klassetrin == 5) text("= " +mq.guess2, 72, 285);
    if (klassetrin == 9) text("= " +mq.guess2, 72, 285);

    mq.redbox--;
    if (mq.guesscheck[1] == 2) {
      // numberofwrongguesses ++;
      mq.testguess[1] = -234;
      mq.guesscheck[1] = 0;

      mq.redbox = 30;
    }
    if (mq.redbox > 0) {
      fill(255, 0, 0);
      noStroke();
      rectMode(CENTER);
      rect(72, 285, 60, 20);
    }
  }

  void movingFloors() {

    for (Line l : lines) {
      if (l.wallType == "movingfloor") {

        if (l.x1 > 250 && l.x1 < 390) {
          if (l.x1 < 260 && l.mfspeed < 0) l.mfspeed *= -1;
          if (l.x1 > 380 && l.mfspeed > 0) l.mfspeed *= -1;
        }
        if (l.x1 > 550 && l.x1 < 690) {
          if (l.x1 < 560 && l.mfspeed < 0) l.mfspeed *= -1;
          if (l.x1 > 680 && l.mfspeed > 0) l.mfspeed *= -1;
        }

        l.x1 += l.mfspeed;
        l.x2 += l.mfspeed;
      }
    }
  }


  void elevator() {

    for (Line l : lines) {
      if (l.wallType == "elevator") {

        if (l.x1 == 1100) {
          if (l.y1 > 630 && l.elespeed > 0) l.elespeed *= -1;
          if (l.y1 < 450 && l.elespeed < 0) l.elespeed *= -1;

          if (mq.guesscheck[0] == 1) {
            l.y1 += l.elespeed;
            l.y2 += l.elespeed;
          }
        }
        if (l.x1 == 0) {
          if (l.y1 > 450 && l.elespeed > 0) l.elespeed *= -1;
          if (l.y1 < 270 && l.elespeed < 0) l.elespeed *= -1;

          if (mq.guesscheck[1] == 1) {
            l.y1 += l.elespeed;
            l.y2 += l.elespeed;
          }
        }
      }
    }
  }

  void lines() {

    //floors
    lines.add(new Line(0, 630, 200, 630, "floor"));
    lines.add(new Line(900, 630, 1100, 630, "floor"));
    lines.add(new Line(900, 450, 1100, 450, "floor"));
    lines.add(new Line(600, 450, 800, 450, "floor"));
    lines.add(new Line(300, 450, 500, 450, "floor"));
    lines.add(new Line(200, 450, 250, 450, "floor"));
    lines.add(new Line(200, 270, width, 270, "floor"));

    //walls to the left of the player
    lines.add(new Line(0, height, 0, 0, "leftwall"));
    lines.add(new Line(1100, 560, 1100, 450, "leftwall"));
    lines.add(new Line(200, 380, 200, 270, "leftwall"));

    //walls to the right of the player
    lines.add(new Line(1100, 560, 1100, 450, "rightwall"));
    lines.add(new Line(width-1, height, width-1, 270, "rightwall"));
    lines.add(new Line(200, 380, 200, 270, "rightwall"));
    lines.add(new Line(width-1, 180, width-1, 0, "rightwall"));

    //moving floors
    lines.add(new Line(380, 600, 480, 600, "movingfloor"));
    lines.add(new Line(560, 600, 660, 600, "movingfloor"));

    //elevators
    lines.add(new Line(1100, 630, width, 630, "elevator"));
    lines.add(new Line(0, 450, 200, 450, "elevator"));
  }
}
