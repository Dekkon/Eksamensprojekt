class Level3 extends Level {
  MathQuestions mq;

  ArrayList<Shot> shots = new ArrayList<Shot>();
  PImage stickman;
  int shotfq;

  Level3() { 
    currentlevel = 3;
    spawnlocation = new PVector(30, 120);
    mq = new MathQuestions();
    p = new Player(spawnlocation.x, spawnlocation.y, radius);

    stickman = loadImage("Stickman.png");
    stickman.resize(50, 50);

    lines();
  }

  void run() {

    p.update();
    stage();
    respawn();
    playermovement();
    collision();

    enemy();
    for (Shot s : shots) {
      s.display();
      s.movement();
    }

    p.display();


    pauseGame();
    if (pause) inGameMenu();

    if (p.location.x > width) levelisComplete = true;
    if (levelisComplete)levelComplete();
  }

  void enemy() {

    shotfq ++;

    if (shotfq == 20) {
      shots.add(new Shot(700, 155));
      shotfq = 0;
    }

    image(stickman, 720, 170);

    for (int i = shots.size()-1; i >= 0; i--) {
      Shot s = shots.get(i);
      if (PVector.dist(p.location, s.location) < radius+2) {
        dead = true;
      }

      if (s.lifespan <= 0) shots.remove(i);
    }
  }


  void lines() {
    floor1s = new PVector(0, 140); //floor 1 starting point
    floor1e = new PVector(200, 140); // floor 1 ending point

    floor2s = new PVector(200, 190);
    floor2e = new PVector(750, 190);

    floor3s = new PVector(750, 140);
    floor3e = new PVector(1050, 140);

    floor4s = new PVector(0, 0);
    floor4e = new PVector(0, 0);

    floor5s = new PVector(0, 0);
    floor5e = new PVector(0, 0);

    floor6s = new PVector(0, 0);
    floor6e = new PVector(0, 0);

    roof1s = new PVector(0, 0); // roof 1 starting point
    roof1e = new PVector(0, 0); // roof 1 ending point

    rwall1s = new PVector(750, 190); // right wall 1 starting point
    rwall1e = new PVector(750, 140); // right wall 1 ending point

    rwall2s = new PVector(0, 0);
    rwall2e = new PVector(0, 0);

    rwall3s = new PVector(0, 0);
    rwall3e = new PVector(0, 0);

    gate1s = new PVector(0, 0);
    gate1e = new PVector(0, 0);

    lwall1s = new PVector(0, height); // left wall 1 starting point
    lwall1e = new PVector(0, 0);      // left wall 1 ending point

    lwall2s = new PVector(200, 190);
    lwall2e = new PVector(200, 140);
  }
}
