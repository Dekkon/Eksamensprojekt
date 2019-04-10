class Level3 extends Level {

  ArrayList<Shot> shots = new ArrayList<Shot>();
  PImage stickman, spikes;
  int shotfq;

  Level3() { 
    currentlevel = 3;
    spawnlocation = new PVector(30, 120);
    p = new Player(spawnlocation.x, spawnlocation.y, radius);

    stickman = loadImage("Stickman.png");
    stickman.resize(50, 50);
    spikes = loadImage("spikes.png");
    spikes.resize(100, 40);   
    
    switch(klassetrin) {
    case 1:
      question1 = mq.kl1lvl3tal[0] + " * " + mq.kl1lvl3tal[1];
      question2 = mq.kl1lvl3tal[2] + " + " + mq.kl1lvl3tal[3];
      writeguess1 = "= ";
      writeguess2 = "= ";
      break;
    case 5:
      question1 = mq.kl5lvl3tal[0] + " * x = " + mq.kl5lvl3tal[1];
      question2 = mq.kl5lvl3tal[2] + "x = " + mq.kl5lvl3tal[3];
      writeguess1 = "x = ";
      writeguess2 = "x = ";
      break;
    case 9:
      question1 = mq.kl9lvl3tal[0] + "(x + " + mq.kl9lvl3tal[1] + ") = " + mq.kl9lvl3tal[2] + "(" + mq.kl9lvl3tal[3] + " + x)";
      question2 = "√" + mq.kl9lvl3tal[4] + " - √" + mq.kl9lvl3tal[5];
      writeguess1 = "x = ";
      writeguess2 = "= ";
      break;
    }

    lines();
  }

  void run() {

    stage();
    elevator();
    movingFloors();
    enemy();
    pit();
    finishline(1180, 545);

    blueBox(50, 40, 150, 100);
    mathQuestion(170, 30, 1);
    blueBox(800, 250, 150, 100);
    mathQuestion(860, 190, 2);


    if (p.location.x < 200) canType[0] = true;
    else canType[0] = false;
    if (p.location.x > 800 && p.location.x < 1050 && p.location.y > 200 && p.location.y < 400) canType[1] = true;
    else canType[1] = false;
    mq.questions(klassetrin, currentlevel);

    playermovement();
    if (!pause) p.update();
    collision();
    p.display();

    respawn();

    pauseGame();
    if (pause) inGameMenu();

    if (p.location.x > width) levelisComplete = true;
    if (levelisComplete)levelComplete();
  }

  void enemy() {

    shotfq ++;
    int nuoshots = 2;

    if (mq.guesscheck[0] != 1) nuoshots = 15;
    if (mq.guesscheck[0] == 1) nuoshots = 55;

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
      noTint();
      image(spikes, 250 + i * 75, 460);
    }
    // image(spikes, 330, 460);
  }

  void elevator() {

    for (Line l : lines) {
      if (l.wallType == "elevator") {
        if (l.y1 > 350 && l.elespeed > 0) l.elespeed *= -1;
        if (l.y1 < 140 && l.elespeed < 0) l.elespeed *= -1;

        l.y1 += l.elespeed;
        l.y2 += l.elespeed;
      }
    }
  }
  void movingFloors() {

    for (Line l : lines) {
      if (l.wallType == "movingfloor") {


        if (l.x1 < 240 && l.mfspeed < 0) l.mfspeed *= -1;
        if (l.x1 > 550 && l.mfspeed > 0) l.mfspeed *= -1;

        if (mq.guesscheck[1] == 1) {
          l.x1 += l.mfspeed;
          l.x2 += l.mfspeed;
        }
      }
    }
  }

  void lines() {
    //floors
    lines.add(new Line(0, 140, 200, 140, "floor"));
    lines.add(new Line(200, 190, 750, 190, "floor"));
    lines.add(new Line(750, 140, 1050, 140, "floor"));
    lines.add(new Line(800, 350, width, 350, "floor"));
    lines.add(new Line(250, 500, 800, 500, "floor"));
    lines.add(new Line(80, 420, 230, 420, "floor"));
    lines.add(new Line(0, 540, 130, 540, "floor"));
    lines.add(new Line(220, 660, width, 660, "floor"));

    //roofs
    lines.add(new Line(80, 420, 230, 420, "roof"));

    // walls to the left of the player
    lines.add(new Line(0, height, 0, 0, "leftwall"));
    lines.add(new Line(200, 190, 200, 140, "leftwall"));
    lines.add(new Line(250, 500, 250, 350, "leftwall"));

    // walls to the right of the player
    lines.add(new Line(750, 190, 750, 140, "rightwall"));
    lines.add(new Line(width-1, 600, width-1, 0, "rightwall"));
    lines.add(new Line(800, 500, 800, 350, "rightwall"));
    lines.add(new Line(250, 500, 250, 350, "rightwall"));

    // moving floors
    lines.add(new Line(280, 330, 480, 330, "movingfloor"));

    // elevatores
    lines.add(new Line(1050, 140, width, 140, "elevator"));
  }
}
