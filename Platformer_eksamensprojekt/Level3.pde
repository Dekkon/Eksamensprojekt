class Level3 extends Level {
  MathQuestions mq;

  ArrayList<Shot> shots = new ArrayList<Shot>();
  PImage stickman, spikes;
  int shotfq;

  Level3() { 
    currentlevel = 3;
    spawnlocation = new PVector(30, 120);
    mq = new MathQuestions();
    p = new Player(spawnlocation.x, spawnlocation.y, radius);

    stickman = loadImage("Stickman.png");
    stickman.resize(50, 50);
    spikes = loadImage("spikes.png");
    spikes.resize(100, 40);   

    lines();
  }

  void run() {

    if (mousePressed) p.location = new PVector(mouseX, mouseY);

    p.update();
    stage();
    respawn();
    playermovement();
    collision();
    mathQuestion();
    if (p.location.x < 200) mq.typeanswer(1);
    mq.level2Question(klassetrin);
    elevator();
    movingFloors();

    enemy();
    pit();

    p.display();


    pauseGame();
    if (pause) inGameMenu();

    if (p.location.x > width) levelisComplete = true;
    if (levelisComplete)levelComplete();
  }

  void enemy() {

    shotfq ++;
    int nuoshots = 2;

    if (mq.guesscheck[0] != 1) nuoshots = 15;
    if (mq.guesscheck[0] == 1) nuoshots = 50;

    if (shotfq == nuoshots) {
      shots.add(new Shot(700, 155));
      shotfq = 0;
    }

    image(stickman, 720, 170);

    for (int i = shots.size()-1; i >= 0; i--) {
      Shot s = shots.get(i);
      s.display();
      s.movement();
      if (PVector.dist(p.location, s.location) < radius+2) {
        dead = true;
      }

      if (s.lifespan <= 0) shots.remove(i);
    }
  }

  void pit() {

    // makes the player die if the player falls into the pit
    if (p.location.x > 250 && p.location.x < 800 && p.location.y > 480 && p.location.y < 520) dead = true;

    //draw spikes
    imageMode(CORNER);
    for (int i = 0; i < 7; i++) {
      image(spikes, 250 + i * 75, 460);
    }
    // image(spikes, 330, 460);
  }

  void mathQuestion() {
    fill(0, 0, 255);
    stroke(0, 0, 255);
    rectMode(CORNER);

    //question 1
    rect(100, 0, 140, 50);

    textSize(20);
    textAlign(CENTER);
    fill(255);
    if (klassetrin == 1) text(mq.kl1tal[0] + " - " + mq.kl1tal[1], 170, 30);
    if (klassetrin == 5) text(mq.kl5lvl2tal[0] + " + " + mq.kl5lvl2tal[1], 170, 30);
    if (klassetrin == 9) text(mq.kl9lvl2tal[0] + "min, " + mq.kl9lvl2tal[1] + " sek.", 170, 30);

    if (mq.guesscheck[0] == 1) fill(0, 255, 0);
    if (klassetrin == 1 || klassetrin == 5) text("= " +mq.guess1, 170, 75);
    if (klassetrin == 9) text("= " + mq.guess1 + "  sek.", 170, 75);

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
      rect(170, 72, 80, 30);
    }
  }

  void elevator() {
    if (elevator1s.y > 350 && el1speed > 0) el1speed *= -1;
    if (elevator1s.y < 140 && el1speed < 0) el1speed *= -1;

    elevator1s.y += el1speed;
    elevator1e.y += el1speed;
  }
  void movingFloors() {
 
    if (mvfloor1s.x < 270 && mvf1speed < 0) mvf1speed *= -1;
    if (mvfloor1s.x > 700 && mvf1speed > 0) mvf1speed *= -1;
    
    if (mq.guesscheck[1] != 1) mvf1speed = 0;
    println(mvf1speed);
  }

  void lines() {
    floor1s = new PVector(0, 140); //floor 1 starting point
    floor1e = new PVector(200, 140); // floor 1 ending point

    floor2s = new PVector(200, 190);
    floor2e = new PVector(750, 190);

    floor3s = new PVector(750, 140);
    floor3e = new PVector(1050, 140);

    floor4s = new PVector(800, 350);
    floor4e = new PVector(1050, 350);

    floor5s = new PVector(250, 500);
    floor5e = new PVector(800, 500);

    floor6s = new PVector(0, 0);
    floor6e = new PVector(0, 0);

    roof1s = new PVector(0, 0); // roof 1 starting point
    roof1e = new PVector(0, 0); // roof 1 ending point

    rwall1s = new PVector(750, 190); // right wall 1 starting point
    rwall1e = new PVector(750, 140); // right wall 1 ending point

    rwall2s = new PVector(width-1, 600);
    rwall2e = new PVector(width-1, 0);

    rwall3s = new PVector(800, 500);
    rwall3e = new PVector(800, 350);

    elevator1s = new PVector(1050, 140);
    elevator1e = new PVector(width, 140);
    el1speed = 1;

    mvfloor1s = new PVector(280, 330); // moving floor 1 starting point
    mvfloor1e = new PVector(380, 330); // moving floor 1 ending point
    mvf1speed = 2; 

    lwall1s = new PVector(0, height); // left wall 1 starting point
    lwall1e = new PVector(0, 0);      // left wall 1 ending point

    lwall2s = new PVector(200, 190);
    lwall2e = new PVector(200, 140);

    lwall3s = new PVector(250, 500);
    lwall3e = new PVector(250, 350);
  }
}
