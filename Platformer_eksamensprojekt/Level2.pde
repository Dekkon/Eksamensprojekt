class Level2 extends Level {
  MathQuestions mq;


  Level2() {
    spawnlocation = new PVector(30, 600);
    mq = new MathQuestions();
    p = new Player(spawnlocation.x, spawnlocation.y, radius);

    floor1s = new PVector(0, 630); //floor 1 starting point
    floor1e = new PVector(200, 630); // floor 1 ending point

    floor2s = new PVector(900, 630);
    floor2e = new PVector(1100, 630);

    floor3s = new PVector(900, 450);
    floor3e = new PVector(1100, 450);

    floor4s = new PVector(600, 450);
    floor4e = new PVector(800, 450);

    floor5s = new PVector(300, 450);
    floor5e = new PVector(500, 450);

    floor6s = new PVector(200, 450);
    floor6e = new PVector(250, 450);

    elevator1s = new PVector(1100, 630);
    elevator1e = new PVector(width, 630);
    el1speed = -1;

    elevator2s = new PVector(0, 450);
    elevator2e = new PVector(200, 450);
    el2speed = -1;

    mvfloor1s = new PVector(380, 600); // moving floor 1 starting point
    mvfloor1e = new PVector(480, 600); // moving floor 1 ending point
    mvf1speed = 2;                     // moving floor 1 speed

    mvfloor2s = new PVector(560, 600);
    mvfloor2e = new PVector(660, 600);
    mvf2speed = 2;


    tline1s = new PVector(0, 0);
    tline1e = new PVector(0, 0);
    tangle1 = 0.2857;

    roof1s = new PVector(0, 0); // roof 1 starting point
    roof1e = new PVector(0, 0); // roof 1 ending point

    rwall1s = new PVector(1100, 560); // right wall 1 starting point
    rwall1e = new PVector(1100, 450); // right wall 1 ending point

    rwall2s = new PVector(width, height);
    rwall2e = new PVector(width, 0);

    rwall3s = new PVector(200, 380);
    rwall3e = new PVector(200, 270);

    lwall1s = new PVector(0, height); // left wall 1 starting point
    lwall1e = new PVector(0, 0);      // left wall 1 ending point

    lwall2s = new PVector(1100, 560);
    lwall2e = new PVector(1100, 450);

    lwall3s = new PVector(200, 380);
    lwall3e = new PVector(200, 270);

  }

  void run() {



    movingFloors();

    p.update();
    stage();
    elevator();
    respawn();
    playermovement();
    collision();

    mathQuestion();
    if (p.location.x > 1100) mq.typeanswer();
    mq.level2Question(klassetrin);

    p.display();
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
    if (klassetrin == 1) text(mq.kl1tal[0] + " - " + mq.kl1tal[1], 1210, 390);
    if (klassetrin == 5) text(mq.kl5tal[0] + " * " + mq.kl5tal[1], 100, 50);
    if (klassetrin == 9) text(mq.kl9tal[0] + "(x + " + mq.kl9tal[1] + ") = " + mq.kl9tal[2], 100, 50);

    if (mq.guesscheck[0] == 1) fill(0, 255, 0);
    if (klassetrin == 1 || klassetrin == 5) text("= " +mq.guess1, 1210, 435);
    if (klassetrin == 9) text("x = " +mq.guess1, 100, 95);

    mq.redbox--;
    if (mq.guesscheck[0] == 2) {
      // numberofwrongguesses ++;
      mq.testguess = -234;
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
    if (klassetrin == 1) text(mq.kl1tal[2] + " + " + mq.kl1tal[3], 72, 230);
    if (klassetrin == 5) text(mq.kl5tal[0] + " * " + mq.kl5tal[1], 72, 230);
    if (klassetrin == 9) text(mq.kl9tal[0] + "(x + " + mq.kl9tal[1] + ") = " + mq.kl9tal[2], 72, 230);

    if (mq.guesscheck[1] == 1) fill(0, 255, 0);
    if (klassetrin == 1 || klassetrin == 5) text("= " +mq.guess1, 72, 285);
    if (klassetrin == 9) text("x = " +mq.guess1, 72, 285);

    mq.redbox--;
    if (mq.guesscheck[1] == 2) {
      // numberofwrongguesses ++;
      mq.testguess = -234;
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
    if (mvfloor1s.x < 260 && mvf1speed < 0 ) {
      mvf1speed *= -1;
    } 
    if (mvfloor1s.x > 380 && mvf1speed > 0) {
      mvf1speed *= -1;
    } 

    if (mvfloor2s.x < 560 && mvf2speed < 0 ) {
      mvf2speed *= -1;
    } 
    if (mvfloor2s.x > 680 && mvf2speed > 0) {
      mvf2speed *= -1;
    }
  }

  void elevator() {
    // draw the elevator
    stroke(0, 0, 255);
    line(elevator1s.x, elevator1s.y, elevator1e.x, elevator1e.y);
    line(elevator2s.x, elevator2s.y, elevator2e.x, elevator2e.y);


    // unit collision with the elevators
    if (p.location.x > elevator1s.x  - radius+1 && p.location.x < elevator1e.x + radius-1 && p.location.y >= elevator1s.y-radius && p.location.y <= elevator1s.y-radius+30 && p.speed.y > 0) {
      p.location.y = elevator1s.y-radius;
      onPlatform = true;
      p.speed.y = 0;
    }
    if (p.location.x > elevator2s.x  - radius+1 && p.location.x < elevator2e.x + radius-1 && p.location.y >= elevator2s.y-radius && p.location.y <= elevator2s.y-radius+30 && p.speed.y > 0) {
      p.location.y = elevator2s.y-radius;
      onPlatform = true;
      p.speed.y = 0;
    }

    // elevator movement
    if (elevator1s.y > 630 && el1speed > 0) el1speed *= -1;
    if (elevator1s.y < 450 && el1speed < 0) el1speed *= -1;

    if (elevator2s.y > 450 && el2speed > 0) el2speed *= -1;
    if (elevator2s.y < 270 && el2speed < 0) el2speed *= -1;

    if (mq.guesscheck[0] == 1) {
      elevator1s.y += el1speed;
      elevator1e.y += el1speed;
    }
    if (mq.guesscheck[1] == 1) {
      elevator2s.y += el2speed;
      elevator2e.y += el2speed;
    }
  }
}
